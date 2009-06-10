From: Nicolas Pitre <nico@cam.org>
Subject: Re: EasyGit Integration
Date: Tue, 09 Jun 2009 23:27:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906092252210.31536@xanadu.home>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
 <4A2F0B8A.9010203@vilain.net> <7vws7khlvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 05:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEEYq-0001If-Vi
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 05:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZFJD2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 23:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZFJD2A
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 23:28:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64814 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZFJD2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 23:28:00 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KL0009UJ6XNFXQ0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jun 2009 23:27:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vws7khlvj.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121247>

On Tue, 9 Jun 2009, Junio C Hamano wrote:

> Some changes in "eg" may port well as a new command to git-core, and some
> change (like this "revert" thing that has different semantics and breaks
> established workflow) will never be in git-core.  People may think that it
> would not cause many problems if we picked only the non-conflicting bits,
> but I actually have some reservations about that.
> 
> It will bloat the total number of subcommands you can give git, with the
> end result being
> 
>  (1) old timers won't use "revert-commit" and "revert-file" at all but use
>      "revert" and "checkout -- path"; while
> 
>  (2) new people will behave the other way; and
> 
>  (3) the documentation will list all of commands from these two disjoint
>     sets under "git".

Nah.  This doesn't have to be so extreme.  Your example above is 
relevant, and I agree with you that this is unnecessary bloat.

However there are many other examples, such as "git branch -s" being 
equivalent to "git checkout -b" which I think are rather nice to have.

The 'git resolved' command for staging resolved conflicts is also nice.

Also does the streamlining of --abort/--continue for a couple commands.

This is why I said that such additions should be proposed piecemeal and 
judged separately.

> When a "eg" minded person teaches git, the students may have to be told to
> ignore "revert" and "checkout -- path", because there are other ways to do
> the same thing in the lingo they are being taught, which is a subset of
> git commands.  The manual pages will be littered with descriptions like
> "this command, when used this way, is synonymous to using that other
> command with this option", leaving the reader wondering why there are so
> many ways to do the same thing.

This is not necessarily a good strategy to always list all equivalences.  
If someone learns from the git-branch man page that -s also switches to 
the newly created branch, then that person won't gain anything nor care 
to know that 'git checkout -b' does the same.

> If "eg" (I do not have _anything_ against it; the discussion applies to
> other Porcelains as well) were kept independent _and_ offered complete set
> of features that users need without resorting to git-core, on the other
> hand, the students do not have to know about "revert", and the manuals
> they need to consult will not have to talk about "if you are using
> git-core, this is done differently in this way".  The learning curve will
> get a lot smoother for new people.

On the other hand, having multiple porcelains simply divide the user 
base which is not always a good thing.  Look at what happened to cogito 
for example: some people were using it, some people didn't and those two 
groups couldn't help each other efficiently.  Yet git used to do things 
badly that cogito did well, and the other way around too, which gave the 
impression that each system was suboptimal.  When git picked up the good 
things in cogito and cogito finally died then everybody was focusing on 
a single command-line-based porcelain for the better health of git which 
really gained momentum at that point.

In that sense, an alternative (command line) porcelain is effectively a 
fork.  Forks are good for experimental stuff and the like, but 
eventually it is always best for everyone involved if the better parts 
of the fork are merged back.  Any project with a fork that grew big and 
didn't merge back made the whole community weaker in the long run.

> If new and useful features (e.g. "creating a remote repository over SSH in
> one shot") are supported by another Porcelain (e.g.  "eg") they may be
> worth porting over to git-core, in order to make git-core more usable.
> There is a precedent for that kind of side port (e.g. "filter-branch" that
> came from Cogito).
> 
> But aliases for doing essentially the same thing in slightly different
> syntax?  I'd rather not to see them called "git foo".  In the end, I think
> it will harm the users, both new and old.

Again this should be evaluated on a case by case basis.  I think this is 
clear already that re-targeting commands like revert is _not_ a good 
idea.  But some other examples are not so controversial.

> If you go back to the list archive, you will find me suggesting a new set
> of commands with "gh" prefix, back in 1.3.X days, I think.
> 
> I was not joking.  The reasoning was exactly the same, and it remains so.

And my opinion as explained above is that it is not a good idea.  Your 
suggestion didn't take off for a good reason.


Nicolas
