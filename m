From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] uml: remove elf.h
Date: Tue, 17 May 2005 14:21:13 -0700
Message-ID: <20050517142113.59097a3d.akpm@osdl.org>
References: <200505171704.j4HH4Ne8002532@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261956AbVEQVWR@vger.kernel.org Tue May 17 23:24:31 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261956AbVEQVWR@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9Xm-0001U8-AA
	for glk-linux-kernel@gmane.org; Tue, 17 May 2005 23:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVEQVWR (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Tue, 17 May 2005 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVEQVWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:22:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:7078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261956AbVEQVV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:21:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HLLrU3000362
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 14:21:53 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j4HLLrm7023756;
	Tue, 17 May 2005 14:21:53 -0700
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200505171704.j4HH4Ne8002532@hera.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
>
> tree a3d85d9f43f64bbd8437c973caf98f79d95b5f3e
> parent a123edab03ac39e08c2f9cb4fc1af07e099c68bc
> author Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> Tue, 17 May 2005 11:53:14 -0700
> committer Linus Torvalds <torvalds@ppc970.osdl.org> Tue, 17 May 2005 21:59:11 -0700
> 
> [PATCH] uml: remove elf.h
> 
> Actually remove elf.h in the tree.  The previous patch, due to a quilt
> bug/misuse, left it in the tree as a 0-length file, preventing the build to
> see it as missing and to generate a symlink in its place.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  asm-um/elf.h |    0 
>  1 files changed
> 
> Index: include/asm-um/elf.h

Hot damn, this zero-length file is hard to get rid of.  I pulled Linus's
tree this morning with this bizarre concoction:

	cd $GIT_TREE
	cg-pull origin
	tagsha1=$(cat .git/refs/tags/v$(kversion))
	t=$(cat-file tag $tagsha1 | head -n 1 | sed -e 's/object //')
	cg-diff -r $t -r $(cat .git/refs/heads/origin) > $PULL/linus.patch

and the resulting diff has:

Index: include/asm-ia64/ioctl32.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/asm-ia64/ioctl32.h  (mode:100644 sha1:d0d227f45e05d23705ac849f4bd5c06a28288b58)
+++ 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/include/asm-ia64/ioctl32.h  (mode:100644 sha1:e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
@@ -1 +0,0 @@
-#include <linux/ioctl32.h>
Index: include/asm-um/elf.h
===================================================================
Index: include/asm-x86_64/apicdef.h
===================================================================

which of course doesn't remove that file at all.

And I bet that when Linus releases patch-2.6.12-rc5.gz and patch-2.6.12.gz,
they will have the same construct.  AFAICT, the patch-based people will
need to download a full new tarball to get rid of this dang file.

It all wouldn't really matter much, except apparently the mere presence of
this file breaks the UML build.

Frazzle.  Paolo, I'm almost wondering if we should change that test to also
check for a zero-length file.
