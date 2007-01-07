From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] Test for failing pread() on cygwin.
Date: Sun, 7 Jan 2007 12:18:42 +0100
Organization: -no organization-
Message-ID: <20070107111841.GC9909@scotty.home>
References: <20070106170330.GA8041@scotty.home> <20070107060007.GA10351@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 12:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3W36-0001dC-Sr
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbXAGLSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbXAGLSq
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:18:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:61054 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503AbXAGLSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:18:45 -0500
Received: from [84.134.15.225] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis),
	id 0ML25U-1H3W313Waf-0001V0; Sun, 07 Jan 2007 12:18:44 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l07BIgVk015655;
	Sun, 7 Jan 2007 12:18:42 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l07BIghl015652;
	Sun, 7 Jan 2007 12:18:42 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070107060007.GA10351@spearce.org>
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-0.0 required=5.0 tests=ALL_TRUSTED,
	UNWANTED_LANGUAGE_BODY autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.88.7/2418/Sun Jan  7 10:42:41 2007 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36157>

Test for failing pread() on cygwin.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---

And the test which fails on cygwin with 1.5.21 and original pread().

 t/t5610-clone-fail.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/t/t5610-clone-fail.sh b/t/t5610-clone-fail.sh
new file mode 100644
index 0000000..d30b25e
--- /dev/null
+++ b/t/t5610-clone-fail.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# Copyright (C) 2007 Stefan-W. Hahn <stefan.hahn@s-hahn.de>
+#
+
+test_description='test git-clone failure on cygwin using pread()
+
+This test covers the fact that git-clone fails, if pread() does not
+work properly, because the size of objects makes it neccessary to
+read data from a not zero offset.'
+
+. ./test-lib.sh
+
+# Need a repo to clone
+test_create_repo foo2
+
+GIT_AUTHOR_EMAIL=xxxxxxxx@yyyyyyyy.yyyyy.yyyyyyy.yyy
+GIT_COMMITTER_EMAIL=xxxxxxxx@yyyyyyyy.yyyyy.yyyyyyy.yyy
+export GIT_AUTHOR_EMAIL
+export GIT_COMMITTER_EMAIL
+
+(cd foo2 && echo "Hello" > file && git add file && git commit -m 'add file' >/dev/null 2>&1)
+(cd foo2 && echo "Hello2" >> file && git commit -a -m 'test' >/dev/null 2>&1)
+
+test_expect_success \
+    'clone with resolving' \
+    'git-clone foo2 bar2'
+
+test_done
-- 
1.5.0.rc0.g244a7
