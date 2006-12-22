From: Junio C Hamano <junkio@cox.net>
Subject: Re: Separating "add path to index" from "update content in index"
Date: Thu, 21 Dec 2006 21:10:51 -0800
Message-ID: <7vfyb87bxg.fsf@assigned-by-dhcp.cox.net>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
	<7v64c7pmlw.fsf@assigned-by-dhcp.cox.net>
	<87wt4m2o99.wl%cworth@cworth.org>
	<7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net>
	<87vek62n1k.wl%cworth@cworth.org>
	<7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net>
	<87tzzp3fgh.wl%cworth@cworth.org>
	<slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx>
	<7vbqlw92fw.fsf@assigned-by-dhcp.cox.net>
	<87d56cirs8.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 06:10:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxcgK-00064q-Nd
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 06:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945941AbWLVFKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 00:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945942AbWLVFKy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 00:10:54 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:47512 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945941AbWLVFKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 00:10:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222051052.CUQN15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 00:10:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1hA91W00Q1kojtg0000000; Fri, 22 Dec 2006 00:10:10 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87d56cirs8.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	21 Dec 2006 18:32:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35130>

Carl Worth <cworth@cworth.org> writes:

> I complained about this when I first encountered git, and back then I
> said what I thought I wanted was "git diff HEAD" by default. I was
> totally wrong, since diff from the index is so obviously correct for
> resolving a conflict. Junio even responded to my complaints by
> providing a new "git status -v -a" but frankly I've never used
> it.

I guess my responding to whatever you said was wasted effort,
and if you do not like "git add" this time, I should not be
surprised.  That's kind of sad ;-).

Jokes aside.

I do not remember who advocated for making "git status" the
preview of "git commit" to happen.  Was that also you?  I wonder
how many people use this form:

	git status -v path1 path2...

Because if even somebody who wanted to have "commit preview" in
"git status" does not use it for that intended purpose, I think
we can reuse the good command name for something more useful,
such as "git explain".

> I'd really like "git diff" to be what I want more often.

Running diff with index is what I do almost all the time.  I
think "more often" is different from person to person, but if
"git diff" says nothing on a file that I know I added (and you
cannot argue you do not remember it was a new file here --- you
know you added it and that is why you are complaining about not
seeing it), I'd be happy that I did not accidentally edited it
to munge what I added -- because I add a file only when it is in
a presentable, good state, in a good enough shape to take a
snapshot (not necessarily good enough to commit, though).

And it is not just limited to adding the contents of a path that
happened to be told git for the first time.  Adding the contents
of a path that was known to git also happens only when it is in
a presentable good state.  So running "git diff" and not seeing
what I added before is a GOOD THING.

> So I suppose I could implement the "add path without updating content"
> I want by doing something like:
>
> 	mv file file.tmp
> 	touch file
> 	git update-index --add file
> 	mv file.tmp file
>
> There. That gives me the result I want without breaking any git
> internals, (since I'm just building a new operation on top of existing
> git primitives).

Sure, what you want is "git add --no-add newfile", and I can
understand that mode of operation if you are always going to
commit with "git commit -a".  Maybe we can have a config
variable that makes "commit -a" and "add --no-add" the default
for these two commands, and we do not have to change anything
else.

One minor detail I wonder about is what mode bits would you give
to that placeholder entry.

> I think the best would be:
>
> 	git update-index --all
>
> which would still allow room for:
>
> 	git add --all

Wasn't it you who said "all" is ambiguous (all known to git vs
all in this directory)?  
