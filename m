From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Mon, 19 Feb 2007 15:14:59 -0800
Message-ID: <7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:15:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJHiq-0000bp-If
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965526AbXBSXPB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 18:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965529AbXBSXPB
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:15:01 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47897 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965526AbXBSXPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 18:15:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219231500.PTTL21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 18:15:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RbEz1W00C1kojtg0000000; Mon, 19 Feb 2007 18:14:59 -0500
In-Reply-To: <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 19 Feb 2007 14:57:23 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40160>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I don't know about others, but I use "git apply" even outside git (*) 
> simply because the defaults for it are a lot better than "patch".
>
> I've always hated how patch has some _really_ unsafe default behaviour:
> ...
> git-apply has much saner defaults (it defaults to something pretty safe, 
> and you can then make it less safe if the patch doesn't apply).

All true.

> It also knows about renames. I hope that some day people will start 
> sending rename-patches around, just because they are *so* much more 
> readable than delete/create patches.

I've seen a few on git list and I think I saw a couple on kernel
list as well in the past.

By the way, do you want to veto a related change that makes
git-apply behave consistently between:

	$ cd sub/directory
        $ git apply patch.file

and

	$ cd sub/directory
        $ git apply --index patch.file

The issue is, that "patch.file" (typically) starts with:

	diff a/sub/directory/Makefile b/sub/directory/Makefile
	--- a/sub/directory/Makefile
	+++ b/sub/directory/Makefile

and the form without --index would say "What are you talking
about? I do not see sub/directory/Makefile".

I consider this is a bugfix, but it does change the behaviour,
so I am a bit worried about possible fallout.
