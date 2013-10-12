From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/5] remote-helpers: allow direct test execution
Date: Sat, 12 Oct 2013 02:04:22 -0500
Message-ID: <1381561465-20147-3-git-send-email-felipe.contreras@gmail.com>
References: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:10:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLQ-0003bR-Gy
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab3JLHKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:10:33 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:59066 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab3JLHKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:31 -0400
Received: by mail-ob0-f179.google.com with SMTP id wp18so3466522obc.10
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QZZQcwbXmlkIgd4w7zXz1+Feb49fTHzpAHmueLgY54=;
        b=FrPY+1SFE4++4mfKA8wXYcudy4XheYkxErHTskoAVaDYUE2bSn3wgf42/G8XdNmxvR
         IZs6sLQmElOfrvAx1F+JKJGd+Uyiz1gpQYS01wcn2LTH+gPa9yCX6FqRRIV+dpypLR9m
         oy78d5oT5VZgTePG/LIC2bUV71ZAFUhbFz1YEvPb5pHN8HcHmlYVIks5IGBr6yasBhV9
         TDKKCt2BxpwKdHKPLViQHOTf4SMyhYZOt9dEjoGuYKjhX2ysDyBwUKNjXskIj32wvE47
         PcKoChawyTp7vwpI1bZR5aG9VMR7PSePJbG+g3YeM0zN4xmEjQxxIyvEKs5q4rPcauQw
         BpOA==
X-Received: by 10.60.51.7 with SMTP id g7mr18179205oeo.6.1381561831379;
        Sat, 12 Oct 2013 00:10:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm101380091oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235957>

Previously 'make' was the only option, or manually specifying the
'TEST_DIRECTORY'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile         | 1 +
 contrib/remote-helpers/test-bzr.t       | 3 ++-
 contrib/remote-helpers/test-hg-bidi.t   | 3 ++-
 contrib/remote-helpers/test-hg-hg-git.t | 3 ++-
 contrib/remote-helpers/test-hg.t        | 3 ++-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
index 8d5e9be..8799c77 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -5,6 +5,7 @@ export T := $(addprefix $(CURDIR)/,$(TESTS))
 export MAKE := $(MAKE) -e
 export PATH := $(CURDIR):$(PATH)
 export TEST_LINT := test-lint-executable test-lint-shell-syntax
+export TEST_DIRECTORY := $(CURDIR)/../../t
 
 export SCRIPT_PYTHON := $(addprefix $(CURDIR)/,$(SCRIPTS))
 
diff --git a/contrib/remote-helpers/test-bzr.t b/contrib/remote-helpers/test-bzr.t
index 435b280..7ca4a9c 100755
--- a/contrib/remote-helpers/test-bzr.t
+++ b/contrib/remote-helpers/test-bzr.t
@@ -5,7 +5,8 @@
 
 test_description='Test remote-bzr'
 
-. ./test-lib.sh
+test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$PWD/../../t"
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON; then
 	skip_all='skipping remote-bzr tests; python not available'
diff --git a/contrib/remote-helpers/test-hg-bidi.t b/contrib/remote-helpers/test-hg-bidi.t
index 86a3f10..e978932 100755
--- a/contrib/remote-helpers/test-hg-bidi.t
+++ b/contrib/remote-helpers/test-hg-bidi.t
@@ -8,7 +8,8 @@
 
 test_description='Test bidirectionality of remote-hg'
 
-. ./test-lib.sh
+test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$PWD/../../t"
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON; then
 	skip_all='skipping remote-hg tests; python not available'
diff --git a/contrib/remote-helpers/test-hg-hg-git.t b/contrib/remote-helpers/test-hg-hg-git.t
index 0217860..0caa493 100755
--- a/contrib/remote-helpers/test-hg-hg-git.t
+++ b/contrib/remote-helpers/test-hg-hg-git.t
@@ -8,7 +8,8 @@
 
 test_description='Test remote-hg output compared to hg-git'
 
-. ./test-lib.sh
+test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$PWD/../../t"
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON; then
 	skip_all='skipping remote-hg tests; python not available'
diff --git a/contrib/remote-helpers/test-hg.t b/contrib/remote-helpers/test-hg.t
index 30f4ff6..9b6dd95 100755
--- a/contrib/remote-helpers/test-hg.t
+++ b/contrib/remote-helpers/test-hg.t
@@ -8,7 +8,8 @@
 
 test_description='Test remote-hg'
 
-. ./test-lib.sh
+test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$PWD/../../t"
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON; then
 	skip_all='skipping remote-hg tests; python not available'
-- 
1.8.4-fc
