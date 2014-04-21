From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/3] remote-helpers: move tests out of contrib
Date: Mon, 21 Apr 2014 15:37:13 -0500
Message-ID: <1398112633-23604-4-git-send-email-felipe.contreras@gmail.com>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 22:47:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcL88-00011i-Uw
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 22:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbaDUUrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 16:47:47 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:33918 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbaDUUrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 16:47:45 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so3962770yhl.20
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SJwdGE7tUfBWZvsVd5J06lU4iHGEAOV/S3I1KnDnXrQ=;
        b=a6Ag0UOgQXucGn9xTgRSiCwI6nupr6g5bTkNakbYsevpOWMyG5M3SPy4mOuUGePsHQ
         63UxADEFtujXMViLLa5zJTLLAjXWI+KfHvY6OVsD1FBfY73jsTrcqkyr6LS+frMU3YsE
         NSAj7d77eO8LVMjJ1M5+F4Gv6sUl+9O5UgyY3Gpiy4bp9rPIlGsfCwKHGslcrffIqIke
         wXYQH8OJ2BcvuQXS70lY5pSMOLGW/0vqA+ReQYNx/7/Ui6vpC0v7znBSLRt1O8MO/AKw
         snZhqzZRZHLEL1+mD7gloV+e8LamLX2xMRWwEfPSz/EYKSSJ12WGCxvmNZcOTQdlKwwA
         x2Zg==
X-Received: by 10.236.170.37 with SMTP id o25mr3015713yhl.145.1398113264726;
        Mon, 21 Apr 2014 13:47:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id x4sm72946472yhh.0.2014.04.21.13.47.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 13:47:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
In-Reply-To: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246636>

They should be tested by default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile                            | 14 --------------
 contrib/remote-helpers/test-hg.sh => t/t5810-remote-hg.sh  |  3 +--
 .../test-hg-bidi.sh => t/t5811-remote-hg-bidi.sh           |  3 +--
 .../test-hg-hg-git.sh => t/t5812-remote-hg-hg-git.sh       |  3 +--
 .../remote-helpers/test-bzr.sh => t/t5820-remote-bzr.sh    |  3 +--
 5 files changed, 4 insertions(+), 22 deletions(-)
 delete mode 100644 contrib/remote-helpers/Makefile
 rename contrib/remote-helpers/test-hg.sh => t/t5810-remote-hg.sh (99%)
 rename contrib/remote-helpers/test-hg-bidi.sh => t/t5811-remote-hg-bidi.sh (98%)
 rename contrib/remote-helpers/test-hg-hg-git.sh => t/t5812-remote-hg-hg-git.sh (99%)
 rename contrib/remote-helpers/test-bzr.sh => t/t5820-remote-bzr.sh (98%)

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
diff --git a/contrib/remote-helpers/test-hg.sh b/t/t5810-remote-hg.sh
similarity index 99%
rename from contrib/remote-helpers/test-hg.sh
rename to t/t5810-remote-hg.sh
index 214c548..594a0a1 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/t/t5810-remote-hg.sh
@@ -8,8 +8,7 @@
 
 test_description='Test remote-hg'
 
-test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
-. "$TEST_DIRECTORY"/test-lib.sh
+. ./test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/t/t5811-remote-hg-bidi.sh
similarity index 98%
rename from contrib/remote-helpers/test-hg-bidi.sh
rename to t/t5811-remote-hg-bidi.sh
index d44ec92..d738ed4 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/t/t5811-remote-hg-bidi.sh
@@ -8,8 +8,7 @@
 
 test_description='Test bidirectionality of remote-hg'
 
-test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
-. "$TEST_DIRECTORY"/test-lib.sh
+. ./test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/t/t5812-remote-hg-hg-git.sh
similarity index 99%
rename from contrib/remote-helpers/test-hg-hg-git.sh
rename to t/t5812-remote-hg-hg-git.sh
index d0d186c..50c216f 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/t/t5812-remote-hg-hg-git.sh
@@ -8,8 +8,7 @@
 
 test_description='Test remote-hg output compared to hg-git'
 
-test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
-. "$TEST_DIRECTORY"/test-lib.sh
+. ./test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
diff --git a/contrib/remote-helpers/test-bzr.sh b/t/t5820-remote-bzr.sh
similarity index 98%
rename from contrib/remote-helpers/test-bzr.sh
rename to t/t5820-remote-bzr.sh
index a656571..8f0719a 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/t/t5820-remote-bzr.sh
@@ -5,8 +5,7 @@
 
 test_description='Test remote-bzr'
 
-test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
-. "$TEST_DIRECTORY"/test-lib.sh
+. ./test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
-- 
1.9.2+fc1.1.g5c924db
