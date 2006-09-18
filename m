From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Mon, 18 Sep 2006 09:31:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609180926590.4388@g5.osdl.org>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 18:32:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPM24-00026C-RB
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 18:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWIRQbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 12:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWIRQbg
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 12:31:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40115 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750967AbWIRQbf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 12:31:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8IGVMnW031903
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Sep 2006 09:31:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8IGVLUf012844;
	Mon, 18 Sep 2006 09:31:22 -0700
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
X-Spam-Status: No, hits=-2.503 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27249>



On Mon, 18 Sep 2006, Christian Couder wrote:
>
> With the new packed ref file format from Linus, this should be
> the new way to remove a branch.

Well, it's not really sufficient.

Somebody should add this test-case

	git branch test
	git branch -d test
	git branch test/first

which should work.

It's entirely possible that the proper way to do branch deletion with 
packed branches is to simply re-pack without the old branch, rather than 
the negative branch model. I couldn't really decide.

However: this part is definitely correct, considering that we allow the 
null sha1 in other places.

> "refs.c" is fixed so that a null sha1 for a deleted branch does
> not result in "refs/head/deleted does not point to a valid
> commit object!" messages.

And this last part is conceptually ok, but I think the implementaion is 
wrong:

> "t/t3200-branch.sh" is fixed so that it uses git-show-ref
> instead of checking that the ref does not exist when a branch
> is deleted.

I think you should change the

	! git-show-ref --verify --quiet -- "refs/heads/d/e/f" &&

into

	git-show-ref --verify --quiet -- "refs/heads/d/e/f" ||

instead, no?

		Linus
