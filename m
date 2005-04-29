From: Steve Hoelzer <shoelzer@gmail.com>
Subject: [PATCH] Add cg-tag-ls command
Date: Fri, 29 Apr 2005 10:55:29 -0500
Message-ID: <5881929705042908554ccc6529@mail.gmail.com>
Reply-To: Steve Hoelzer <shoelzer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 29 17:51:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRXki-0005L3-GG
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 17:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVD2Pzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVD2Pzk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 11:55:40 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:47197 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262189AbVD2Pz3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 11:55:29 -0400
Received: by wproxy.gmail.com with SMTP id 68so1136240wra
        for <git@vger.kernel.org>; Fri, 29 Apr 2005 08:55:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qeVEHqJ0lCF/xic5zLroNAybEp2hROt73Dr4823S1SZC8jYE9nIm7c/FahbdHFHzhL5GmOyowFvbzd6x02/SOt5f/G4x/VCEz/pCnhy9+8aOALhO4HhV8OEP1LvnJ+jWxEfCAlbf8jvUg994hBFQNjJ9/fINQYHzJj6rbWJ6ID0=
Received: by 10.54.125.4 with SMTP id x4mr1427931wrc;
        Fri, 29 Apr 2005 08:55:29 -0700 (PDT)
Received: by 10.54.150.17 with HTTP; Fri, 29 Apr 2005 08:55:29 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-tag-ls lists all tags in a GIT repository.

Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>

Index: Makefile
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/Makefile  (mode:100644
sha1:d73bea1cbb9451a89b03d6066bf2ed7fec32fd31)
+++ uncommitted/Makefile  (mode:100644)
@@ -44,7 +44,7 @@
        cg-add cg-admin-lsobj cg-cancel cg-clone cg-commit cg-diff \
        cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch \
        cg-patch cg-pull cg-branch-add cg-branch-ls cg-rm cg-seek cg-status \
-       cg-tag cg-update cg-Xlib
+       cg-tag cg-tag-ls cg-update cg-Xlib

 COMMON=        read-cache.o

Index: cg-help
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-help  (mode:100755
sha1:d16446c005c4698f408bf651afd718d95f5a9cfe)
+++ uncommitted/cg-help  (mode:100755
sha1:31ea484f757fc4bf5de25acb621e219f4bfb0f52)
@@ -42,6 +42,7 @@
        cg-seek         [COMMIT_ID]
        cg-status
        cg-tag          TNAME [COMMIT_ID]
+       cg-tag-ls
        cg-update       [BNAME]
        cg-version

Index: cg-tag-ls
===================================================================
--- /dev/null  (tree:c3aa1e6b53cc59d5fbe261f3f859584904ae3a63)
+++ uncommitted/cg-tag-ls  (mode:100755
sha1:15b5db0cd2a023a078f467d1bcd3bc0c5eb833dc)
@@ -0,0 +1,19 @@
+#!/usr/bin/env bash
+#
+# List stored GIT tags.
+# Copyright (c) Steve Hoelzer 2005
+#
+# Takes no parameters.
+
+. cg-Xlib
+
+mkdir -p .git/refs/tags
+[ "$(find .git/refs/tags -follow -type f)" ] \
+       || die "List of tags is empty. See cg-tag."
+
+cd .git/refs/tags
+for tag in *; do
+       echo -n $tag
+       echo -ne "\t"
+       cat $tag
+done
