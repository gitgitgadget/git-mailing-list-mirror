From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/3] test-lib: allow setting the index format version
Date: Sun, 23 Feb 2014 21:49:58 +0100
Message-ID: <1393188599-5391-3-git-send-email-t.gummerer@gmail.com>
References: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, sunshine@sunshineco.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 23 21:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHg05-0007Rr-H7
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 21:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbaBWUuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 15:50:06 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:39628 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbaBWUuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 15:50:04 -0500
Received: by mail-la0-f43.google.com with SMTP id pv20so4600916lab.2
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bv2cr22jsdyIvVYoC250Gx5nVMrJV0km53UHEAQ64bc=;
        b=CGEDx7LyxRhopCDUnG5KEUhPB1tAaj4pkSe8ITZJHM1z0Kdz9jdf1vbpN2Q+oIQk5g
         RizqDAgoVlrf3lpwAo6lUlTt3nV5Ov059FRcJm1MIu/AJjinLMZLDMIIl1HnjFi3/L/M
         uUN3RsqBgezZntk/zsorVaMWzwwQFSQSQ2m51AfiJipu5uFaCGt9t+q1G6yR+dOb3Ijo
         nyvsnUMa9nFFO9mLVDILO+nFv3wsZ62b/zlXtuOkfH7mrVvB1XWTU7XxyuRPnQb/1SLp
         +xBR/dAZmHC4fRTP68PVJc2XMoWx54quHeYTjRVzm1V8tbcR5Ok4ciDidxF+dwhL4b80
         Grxw==
X-Received: by 10.112.158.131 with SMTP id wu3mr9594975lbb.6.1393188603050;
        Sun, 23 Feb 2014 12:50:03 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id h7sm16107475lbj.1.2014.02.23.12.50.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2014 12:50:02 -0800 (PST)
X-Mailer: git-send-email 1.9.0.1.ge0caaa8.dirty
In-Reply-To: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242548>

Allow adding a TEST_GIT_INDEX_VERSION variable to config.mak to set the
index version with which the test suite should be run.

If it isn't set, the default version given in the source code is
used (currently version 3).

To avoid breakages with index versions other than [23], also set the
index version under which t2104 is run to 3.  This test only tests
functionality specific to version 2 and 3 of the index file and would
fail if the test suite is run with any other version.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Makefile                              | 7 +++++++
 t/t2104-update-index-skip-worktree.sh | 2 ++
 t/test-lib-functions.sh               | 5 +++++
 t/test-lib.sh                         | 3 +++
 4 files changed, 17 insertions(+)

diff --git a/Makefile b/Makefile
index dddaf4f..5caa3b2 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,10 @@ all::
 # Define DEFAULT_HELP_FORMAT to "man", "info" or "html"
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
+#
+# Define TEST_GIT_INDEX_VERSION to 2, 3 or 4 to run the test suite
+# with a different indexfile format version.  If it isn't set the index
+# file format used is index-v[23].
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -2222,6 +2226,9 @@ endif
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
index 1531c24..492f81f 100644
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
1.9.0.1.ge0caaa8.dirty
