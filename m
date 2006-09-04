From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATCH 1/4] gitweb: Add GIT favicon, assuming image/png type
Date: Mon, 4 Sep 2006 10:15:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609041010540.27779@g5.osdl.org>
References: <200609041810.09838.jnareb@gmail.com> <200609041813.49103.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 19:15:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKI2c-0000sB-NW
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 19:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWIDRPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWIDRPT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 13:15:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964949AbWIDRPR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 13:15:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k84HFAnW004015
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Sep 2006 10:15:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k84HF9bK029697;
	Mon, 4 Sep 2006 10:15:10 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609041813.49103.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.487 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26427>



On Mon, 4 Sep 2006, Jakub Narebski wrote:
>
> This is my first post with binary patch. I'd rather not send file
> git-favicon.png as an attachement due to filtering.

You forgot the "--binary" flag, so it didn't actually create a binary 
patch, it just did the "Binary files .. differ" thing:

> diff --git a/gitweb/git-favicon.png b/gitweb/git-favicon.png
> new file mode 100644
> index 0000000..de637c0
> Binary files /dev/null and b/gitweb/git-favicon.png differ

See diff.c: builtin_diff() for the logic:

	...
                if (o->binary)
                        emit_binary_diff(&mf1, &mf2);
                else
                        printf("Binary files %s and %s differ\n",
                               lbl[0], lbl[1]);
	...

ie the default is to act like a regular "diff", and we do the extended git 
binary diffs only if you ask for them explicitly.

(Of course, since we do the _other_ extended git diff headers regardless, 
maybe that doesn't make much sense. On the other hand, the normal extended 
git diff headers are compatible with normal patches, so there is a real 
difference, and so arguably the "--binary" flag makes tons of sense).

		Linus
