From: Petr Baudis <pasky@suse.cz>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 22:28:04 +0100
Message-ID: <20051128212804.GV22159@pasky.or.cz>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us> <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz> <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 22:30:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgqXR-0000lj-9n
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 22:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVK1V1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 16:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVK1V1u
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 16:27:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2524 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750884AbVK1V1t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 16:27:49 -0500
Received: (qmail 7329 invoked by uid 2001); 28 Nov 2005 22:28:04 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12905>

Dear diary, on Mon, Nov 28, 2005 at 08:35:23PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Both of us are right and talking about the same thing.  You are
> right that as long as hooks/post-update is done correctly the
> one who works on the server should not have to worry.  I am
> right that the hooks/post-update for that setup needs to be done
> very carefully ;-).

Aha, then I misunderstood what you wrote before - sorry. Obviously,
you are right. ;-)

> Here are the things whoever is doing the hooks/post-update for
> this particular setup needs to think about.
> 
>  - is it safe to assume that the guy working on the server
>    working tree never switch branches?  otherwise, what to do if
>    the working tree has different branch checked out when push
>    called post-update?

I wouldn't do anything. Working copy reflects the HEAD; if you don't
update HEAD, you needn't touch the working copy.

>  - should it allow forced-push that sets HEAD to non descendant
>    of the current HEAD?  In a shared repository setup,
>    disallowing forced-push is a good discipline.  OTOH, if this
>    is primarily used as an installation mechanism to a remote
>    hosting site, allowing forced-push may be ok.

I would just leave this on the particular head policy.

>  - should it do 'git-checkout', 'git-reset --hard HEAD', or
>    'git-pull . branch_to_push_into'?  The former two pretty much
>    assumes no development happens on the server repository and
>    git push is used primarily as an installation mechanism.

Files should be removed properly, which pretty much excludes the former
two, I think.

>    The latter is to keep a branch, other than "master" that is
>    always checked out on the server machine, and have people
>    push into a different branch and merge with it automatically
>    when a push happens.  what would you do when a merge conflict
>    happens?

This seems weird and overcomplicated, and it seems to mirror that GIT
does not want to deal with trees containing local modifications - which
is fine, but I don't think you should go over huge hoops in the workflow
to adjust to that. Just verify in the pre-update hook that the tree
contains no local modifications, and disallow the push otherwise. Cogito
can then use own update hooks which will enable it to handle local
changes more gracefully (albeit still not ideally).

> On a tangent, the last point brings up an interesting
> shared-repo usage pattern.  When you have a shared central
> repository like CVS, you could arrange things this way:
..snip..
> I am not sure if people would find this useful, though.

It is certainly quite interesting idea. I'm not sure how useful in
practice is it either, though. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
