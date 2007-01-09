From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] Test for failing pread() on cygwin.
Date: Tue,  9 Jan 2007 19:51:55 +0100
Message-ID: <48882.0957871669$1168368739@news.gmane.org>
References: <11683687161816-git-send-email->
X-From: git-owner@vger.kernel.org Tue Jan 09 19:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4M4u-0002jp-2L
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 19:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbXAISwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 13:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbXAISwG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 13:52:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:56872 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbXAISwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 13:52:03 -0500
Received: from [84.134.14.63] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu1) with ESMTP (Nemesis),
	id 0MKwpI-1H4M4j3gy4-0000Op; Tue, 09 Jan 2007 19:51:58 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l09Iputp017463
	for <git@vger.kernel.org>; Tue, 9 Jan 2007 19:51:56 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l09Ipu4I017460
	for git@vger.kernel.org; Tue, 9 Jan 2007 19:51:56 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.4.g46aa
In-Reply-To: <11683687161816-git-send-email->
In-Reply-To: <20070107163637.GE9909@scotty.home>
References: <20070107163637.GE9909@scotty.home>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED,INVALID_MSGID 
	autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36387>

From: Stefan-W. Hahn <stefan.hahn@s-hahn.de>


Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 t/t5610-clone-fail.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/t/t5610-clone-fail.sh b/t/t5610-clone-fail.sh
new file mode 100755
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
1.4.4.4.g46aa
