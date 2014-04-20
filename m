From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote-helpers: move tests out of contrib
Date: Sun, 20 Apr 2014 16:39:31 -0500
Message-ID: <1398029971-1396-3-git-send-email-felipe.contreras@gmail.com>
References: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 23:50:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbzdS-0008AP-MM
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaDTVuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:50:44 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:54248 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaDTVt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:49:58 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so2911978ykp.1
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+PnAfvo8gMB5xRUmnh8ggSzClGvnTMtQWwI+jmonf5o=;
        b=H6Kbf9yz/LVAnyXyBQ6/bAiQXioeLaGKWDtDn3J1FVvGdfuF7bDp1qGo1rprLwBiI1
         jc6Y4YJcTlKjQN8A2LtG1dlDxj0Om6o9MWsxJIeMdCRf5yB9wvGhnknRSWfRam0RXuXh
         7E9wSwvwS60qrVmMHGb1/R9e59EQjsi5snTE4dfjh8OKCDyTAZDxA5nioO0BoNZDMMtZ
         giLVlmh4duVmNRnou1vwn+y9Zb5KHORV+zwP/80CpYKqcwHv0mIyOLr9J/fqBmh82QIe
         S2NxShu68gVJIPDrcyq8E8dDpu53K9ZAVr4vskJ8br1wbdLXp2xqWHWYL7PbExmeqezw
         IDtw==
X-Received: by 10.236.160.196 with SMTP id u44mr48057068yhk.39.1398030598085;
        Sun, 20 Apr 2014 14:49:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 63sm66017539yhi.13.2014.04.20.14.49.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 14:49:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246590>

They should be tested by default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile                            | 14 --------------
 t/Makefile                                                 |  8 +++++++-
 .../remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t   |  2 +-
 .../test-hg-bidi.sh => t/remote-helpers/hg-bidi.t          |  2 +-
 .../test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t      |  2 +-
 contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t |  2 +-
 6 files changed, 11 insertions(+), 19 deletions(-)
 delete mode 100644 contrib/remote-helpers/Makefile
 rename contrib/remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t (99%)
 rename contrib/remote-helpers/test-hg-bidi.sh => t/remote-helpers/hg-bidi.t (98%)
 rename contrib/remote-helpers/test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t (99%)
 rename contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t (99%)

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
deleted file mode 100644
index 239161d..0000000
--- a/contrib/remote-helpers/Makefile
+++ /dev/null
@@ -1,14 +0,0 @@
-TESTS := $(wildcard test*.sh)
-
-export T := $(addprefix $(CURDIR)/,$(TESTS))
-export MAKE := $(MAKE) -e
-export PATH := $(CURDIR):$(PATH)
-export TEST_LINT := test-lint-executable test-lint-shell-syntax
-
-test:
-	$(MAKE) -C ../../t $@
-
-$(TESTS):
-	$(MAKE) -C ../../t $(CURDIR)/$@
-
-.PHONY: $(TESTS)
diff --git a/t/Makefile b/t/Makefile
index 8fd1a72..818f4ed 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -14,6 +14,7 @@ RM ?= rm -f
 PROVE ?= prove
 DEFAULT_TEST_TARGET ?= test
 TEST_LINT ?= test-lint-duplicates test-lint-executable
+export TEST_DIRECTORY = $(CURDIR)
 
 ifdef TEST_OUTPUT_DIRECTORY
 TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
@@ -29,6 +30,9 @@ TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
+TREMOTE = $(wildcard remote-helpers/*.t)
+
+T += $(TREMOTE)
 
 all: $(DEFAULT_TEST_TARGET)
 
@@ -55,7 +59,7 @@ clean: clean-except-prove-cache
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
 
 test-lint-duplicates:
-	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
+	@dups=`echo $(filter-out $(TREMOTE),$(T)) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
 		test -z "$$dups" || { \
 		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
 
@@ -84,6 +88,8 @@ full-svn-test:
 gitweb-test:
 	$(MAKE) $(TGITWEB)
 
+remote-helpers-test: $(TREMOTE)
+
 valgrind:
 	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
 
diff --git a/contrib/remote-helpers/test-bzr.sh b/t/remote-helpers/bzr.t
similarity index 99%
rename from contrib/remote-helpers/test-bzr.sh
rename to t/remote-helpers/bzr.t
index 330b147..066e326 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/t/remote-helpers/bzr.t
@@ -5,7 +5,7 @@
 
 test_description='Test remote-bzr'
 
-test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/..
 . "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/t/remote-helpers/hg-bidi.t
similarity index 98%
rename from contrib/remote-helpers/test-hg-bidi.sh
rename to t/remote-helpers/hg-bidi.t
index e963745..f6c51b0 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/t/remote-helpers/hg-bidi.t
@@ -8,7 +8,7 @@
 
 test_description='Test bidirectionality of remote-hg'
 
-test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/..
 . "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/t/remote-helpers/hg-hg-git.t
similarity index 99%
rename from contrib/remote-helpers/test-hg-hg-git.sh
rename to t/remote-helpers/hg-hg-git.t
index c6b4541..12e2d51 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/t/remote-helpers/hg-hg-git.t
@@ -8,7 +8,7 @@
 
 test_description='Test remote-hg output compared to hg-git'
 
-test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/..
 . "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
diff --git a/contrib/remote-helpers/test-hg.sh b/t/remote-helpers/hg.t
similarity index 99%
rename from contrib/remote-helpers/test-hg.sh
rename to t/remote-helpers/hg.t
index 00b7dde..b4f26e7 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/t/remote-helpers/hg.t
@@ -8,7 +8,7 @@
 
 test_description='Test remote-hg'
 
-test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/..
 . "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
-- 
1.9.1+fc3.9.gc73078e
