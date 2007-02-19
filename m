From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Mon, 19 Feb 2007 14:57:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 23:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJHRw-0000V9-0N
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 23:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbXBSW5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 17:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbXBSW5a
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 17:57:30 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41627 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965144AbXBSW53 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 17:57:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1JMvOhB014398
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Feb 2007 14:57:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1JMvNjV023057;
	Mon, 19 Feb 2007 14:57:24 -0800
In-Reply-To: <20070217233203.GA6014@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.448 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40156>



On Sat, 17 Feb 2007, Jeff King wrote:
>
> On Sat, Feb 17, 2007 at 03:31:18PM -0800, Junio C Hamano wrote:
> 
> > I thought about that, but decided against it.  If you are truly
> > operating outside a git managed repository, it does not feel
> > right to apply configuration user has for git.
> 
> Then why are they using git-apply, and not patch?

I don't know about others, but I use "git apply" even outside git (*) 
simply because the defaults for it are a lot better than "patch".

I've always hated how patch has some _really_ unsafe default behaviour:

 - it will guess at filenames. As in *totally* guess. If you have a patch 
   that touches a Makefile in a subdirectory, but that subdirectory had 
   been renamed or removed, it's entirely possible that "patch" will 
   actually find *another* file called "Makefile" (most likely your 
   top-most one) and apply the patch to that.

   And yes, this has actually happened to me.

 - it defaults to various unsafe options, like allowing a big fuzz factor 
   (I think it defaults to --fuzz=2), which means that if you've already 
   applied the patch, but there was _another_ place that looks a bit like 
   the original place, "patch" will happily apply it *again* because the 
   default fuzz-factor is so permissive.

git-apply has much saner defaults (it defaults to something pretty safe, 
and you can then make it less safe if the patch doesn't apply).

It also knows about renames. I hope that some day people will start 
sending rename-patches around, just because they are *so* much more 
readable than delete/create patches.

		Linus

(*) Although I have also noticed that even more often than using "git 
apply" outside a git thing, I just import everything into git these days. 
So I may not have actually used git-apply outside of a git project in a 
long time any more. But I did, a few times.
