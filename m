From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two ideas for improving git's user interface
Date: Wed, 01 Feb 2006 16:38:45 -0800
Message-ID: <7v1wym4msq.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
	<7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
	<7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
	<7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011433290.21884@g5.osdl.org>
	<87lkwupsbr.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:38:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4SUt-0005Ms-JO
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 01:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWBBAis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 19:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWBBAis
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 19:38:48 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23458 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751491AbWBBAis (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 19:38:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202003852.VHMF25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 19:38:52 -0500
To: Carl Worth <cworth@cworth.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15470>

Carl Worth <cworth@cworth.org> writes:

> To explain this, "just use -a" isn't enough, it would have to be
> something like, "always use -a or else 'git commit' just won't work
> and you can end up committing stale garbage". And perhaps "unless you
> also add the filename to the commit line, then it will start working
> again."

I do not think you have to make it sound *that* negative.  I
agree it may be counterintuitive until the user groks the index.

Let's assume that we will fix things to (1) require "--also" (or
"--incremental") to get the current "git commit paths..."
behaviour, (2) without any arguments we commit the index as is,
(3) with explicit paths we commit clean HEAD plus only specified
paths using a temporary index.  I think a fairer way to say what
you said would be:

        Always use -a, or explicit paths.  With -a all of your
        changes in the working tree are committed.  With paths,
        only changes to those paths are committed.

        Once you are comfortable with making commits this way,
        you might want to learn about index file and then start
        using 'git commit' without any argument.  This works in
        a way that cannot be understood until you learn how the
        index file works, so stick to "-a or explicit paths"
        rule for now.  That rule is good enough for everyday
        use.

And you can probably go a long way without ever knowing about
index.  Initially when I wrote the above two paragraphs, I said
"appreciated" instead of "understood".  But depending on your
workflow, you may not even need what "git commit" without
arguments would give you, in which case there is nothing to
appreciate about, so I changed the wording.

Old-timer git people seem to like what it gives them but that
does not mean everybody should marvel at what it does and adopt
the workflow to take advantage of the index file.

> Here's a fundamental question I have, (and thanks to Keith Packard for
> helping me to phrase it):
>
> 	Is it ever useful (reasonable, desirable) to commit file
> 	contents that differ from the contents of the working
> 	directory?

What that means is people should always do "git commit -a".  Not
even "git commit paths...".  It matches _my_ sense of developer
discipline, especially for individual developers, but it is a
rather cumbersome straightjacket if enforced upon you in
practice.  It is a useful timesaver to be able to leave
unrelated changes around in the working tree.

> I don't think it is, (but please let me know if I've missed some
> useful case).

I think I've already done this a couple of times today.

Your "git diff" is interesting, but I'd rather make them
completely separate command from "git diff".  Perhaps "git
ndiff" and "git ncommit", that assumes there is nothing but "git
commit -a" kind of commits.
