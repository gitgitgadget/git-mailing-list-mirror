From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/3] test-lib: allow setting the index format version
Date: Sat, 15 Feb 2014 20:23:14 +0100
Message-ID: <1392492197-7724-3-git-send-email-t.gummerer@gmail.com>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 20:24:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEkqY-0006N8-2o
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 20:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbaBOTYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 14:24:15 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:48517 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbaBOTYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 14:24:12 -0500
Received: by mail-la0-f51.google.com with SMTP id c6so10119244lan.38
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 11:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TnpUmA8k1BBo2stG+17oILrEg273llNi+vzHsGYjIEo=;
        b=vvX4ixZZJTah3mcNxE9lysh01ZtS69eXsktkc1VqZelwralMVAiPIymYhBJNNZiuYr
         ZBE53AOIXPWrM0PcKzezTHN04Ky+ZzPGyKL409nGoQNcLq50HZhCbuuiZhIYvG+h+wBL
         Q42wuF4NBZn21rWvWnN8Z4/UpuKNiCviq/FTM1uvOZCgvSW75NF4iLgVdx4cwBGWgrpJ
         KDwbmwhRKyZXTzwQBySPZMPNvKO910Nbs/jddmDpMzEl4u1/l/cN1faDVFMzO7wni8JU
         DRKMZdrWPVm5YX+Iau9xYzO5rAXyPWyTZzEmdVBn2q7PYccKhjtPx8tlad78PMxdoBGF
         Oupw==
X-Received: by 10.112.151.146 with SMTP id uq18mr10297416lbb.38.1392492250961;
        Sat, 15 Feb 2014 11:24:10 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id cl5sm11022371lbb.14.2014.02.15.11.24.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2014 11:24:10 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.300.gb39ba80
In-Reply-To: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242199>

Allow adding a TEST_GIT_INDEX_VERSION variable to config.mak to set the
index version with which the test suite should be run.

If it isn't set, the default version given in the source code is
used (currently version 3).

To avoid breakages with index versions other than [23], also set the
index version under which t2104 is run to 3.  This test only tests
functionality specific to version 2 and 3 of the index file and would
fail if the test suite is run with any other version.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Makefile                              | 7 +++++++
 t/t2104-update-index-skip-worktree.sh | 2 ++
 t/test-lib-functions.sh               | 5 +++++
 t/test-lib.sh                         | 3 +++
 4 files changed, 17 insertions(+)

diff --git a/Makefile b/Makefile
index 287e6f8..c98d28f 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,10 @@ all::
 # Define DEFAULT_HELP_FORMAT to "man", "info" or "html"
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
+#
+# Define TEST_GIT_INDEX_FORMAT to 2, 3 or 4 to run the test suite
+# with a different indexfile format.  If it isn't set the index file
+# format used is index-v[23].
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -2223,6 +2227,9 @@ endif
 ifdef GIT_PERF_MAKE_OPTS
 	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@
 endif
+ifdef TEST_GIT_INDEX_VERSION
+	@echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@
+endif
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 1d0879b..29c1fb1 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -7,6 +7,8 @@ test_description='skip-worktree bit test'
 
 . ./test-lib.sh
 
+test_set_index_version 3
+
 cat >expect.full <<EOF
 H 1
 H 2
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index aeae3ca..0bf1e63 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -32,6 +32,11 @@ test_set_editor () {
 	export EDITOR
 }
 
+test_set_index_version () {
+    GIT_INDEX_VERSION="$1"
+    export GIT_INDEX_VERSION
+}
+
 test_decode_color () {
 	awk '
 		function name(n) {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1cf78d5..e6cf5b0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -108,6 +108,9 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
+export GIT_INDEX_VERSION
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
-- 
1.8.5.2.300.ge613be6.dirty
