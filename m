From: Junio C Hamano <junkio@cox.net>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 09:30:52 -0800
Message-ID: <7vbqy9xx2r.fsf@assigned-by-dhcp.cox.net>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
	<20060118125158.GN28365@pasky.or.cz>
	<20060118140917.GA15438@mythryan2.michonline.com>
	<Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:32:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzH99-0005uQ-M1
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWARRaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWARRaz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:30:55 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:23957 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751394AbWARRay (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 12:30:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118172857.KQZZ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 12:28:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Jan 2006 08:23:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14843>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 18 Jan 2006, Ryan Anderson wrote:
>>
>> Assuming both repositories are clean, no extraneous files, and without
>> testing, of course:
>>
>> ... "coolest merge ever" recipe here ... 
>> 
>> No history rewritten,
>
> Right.

>> merging with the old repositories should, at least theoretically, work, 
>> etc.
>
> No. This - and the history rewriting - both have a fundamental problem: it 
> becomes totally impossible to merge back any changes of the subprojects, 
> at least automatically.

Right.

> In the "gitk" case, we could actually continue to merge stuff after a 
> join, but that was largaly because there was no renaming. That's a very 
> special case, and it also became impossible to merge back.

Correct.

> Now, let's see what Junio comes up with,...

Well, since the reason the original RFI came was "somehow we
forgot these things are together but ended up having to and need
a way to rectify the situation", in this particular case,
merging back the changes to subprojects (which is very awkward
if not impossible after a "coolest merge ever") is a non issue.

Tracking history across renames is something we have only half
of the needed support.  We can notice rename points but there is
no way to tell our usability tools to automatically follow it.
IOW "whatchanged r1/hello.c" will stop at the point the
original project renamed hello.c to r1/hello.c in preparation
for the coolest merge and you have to restart whatchanged at
that commit with "whatchanged $that_commit hello.c" to go
further back; but that is true when no project merge is involved
so it may be an issue but it is not a new issue.

So for this case, I think the "coolest merge" is the right thing
to do.

> suggest just something like
>
> 	git clone oldrepo r1
> 	cd r1
> 	git checkout -b join-branch
> 	cd ..
> 	git add r1/.git/refs/heads/join-branch
> 	git commit -m "Join repo 'oldrepo' at 'r1'"
>
> which should actually work except for the fact that we don't like the 
> ".git" component even as part of a sub-component (ie small hack to git 
> required to make it not ignore that path).

Sorry you lost me with this.  The "join-branch" is a file with
commit object name in it, so is this "recording the revision of
the other project this particular version of the project is
linked to" idea?
