From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-status too verbose?
Date: Mon, 06 Mar 2006 16:21:52 -0800
Message-ID: <7vacc36r4v.fsf@assigned-by-dhcp.cox.net>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 01:22:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGPxf-0004dW-GE
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 01:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbWCGAV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 19:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbWCGAV4
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 19:21:56 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52676 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932520AbWCGAVy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 19:21:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307002033.OHLX15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Mar 2006 19:20:33 -0500
To: "Eric Jaffe" <jaffe.eric@gmail.com>, Carl Worth <cworth@cworth.org>
In-Reply-To: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com>
	(Eric Jaffe's message of "Sat, 4 Mar 2006 12:52:17 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17311>

"Eric Jaffe" <jaffe.eric@gmail.com> writes:

> I was wondering if anyone else thinks that git-status should be more
> like "git-diff --name-status". That is,
>   # A a/newfile.c
>   # M a/oldfile.c
>
> instead of
>   # new file: a/newfile.c
>   # modified: a/oldfile.c

Why do people think mysterious single letter abbreviation is
better than spelled out words in an output meant for human
consumption?

The tag letters you get from "ls-files -t" are inconsistent with
what you would get from all the other git tools for historical
reasons, so if you want to do a single-letter abbreviation, you
first need to come up with a set of letters and translate the
output from ls-files -t into that.

Although I personally like Carl's suggestion a lot, I am still
ambivalent about it a bit.

I agree that it would be useful if we had a tool that showed the
two status that matter for each file, grouped together on one
line, e.g.

			HEAD->index	index->files
	------------------------------------------------
	hello.c		unmodified      modified
        world.c		modified	unmodified
	frotz.c		new		unmodified
        ...
	garbage.c~	???		n/a

for the current index file and the current HEAD commit.

You obviously need to learn how to read it though.  The first
column means what you _would_ commit if you just said "git
commit" without doing anything else now; the second column is
what you _could_ commit if you did some update-index and then
said "git commit" (or ran "git commit" with paths arguments).

I think it is a valid view for people who know how internally
git barebone porcelain works using git lowlevel, and to them
(including me), the above is more concise and appear useful.

But I am not sure if it is appropriate for "git status", which
is the tool for commit-preview.  The index "git status" is
showing is the index you would get if you were to run "git
commit" with the same set of parameters, exactly for that reason
(e.g. "git status -a -v" would see "unmodified" for all tracked
paths in index->files column in the above output). 
