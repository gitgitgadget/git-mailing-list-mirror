From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] remote-helpers: allow direct test execution
Date: Fri, 24 May 2013 21:38:26 -0500
Message-ID: <1369449507-18269-4-git-send-email-felipe.contreras@gmail.com>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:40:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4PC-0007A9-Mx
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab3EYCkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:40:19 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:47630 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab3EYCkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:40:16 -0400
Received: by mail-ob0-f178.google.com with SMTP id v19so6125066obq.23
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E/9XX6djT+DRgHlhK6KUO8PBPrbFpnwfqSUZTtV9OK4=;
        b=Xqh3UMtvCM7V+FPWaAHppzfwqF2V6onhnkWOTu1fsfcdAyQFJC8BJ2Nk63wSL84Gwe
         kpwY9kqAvPAp9bAMSU2YnYXP4lncZ4ZKUaHnG4hcpgey3hx0TPZXOeLjHwe1e686Gl0a
         rJKdFFfRws02ix+eXOncd7N+ZzcpQtGuS060Zu0CfCn4dz61p5/6JFZ9buMz6IKgZ9xq
         b1+yZdPKRAFHO82mCpoFDE1WJr199Z/uKOlNLHQp4gZs2J2hZsES/Jbne0oeaG+zD5bR
         JabfllzoYuINIXb4DylkW/cdp6xOEKlUqrxzJ6IGQ2qMiAgRw3HvsW478cYum8gzz8zL
         +fHg==
X-Received: by 10.60.179.42 with SMTP id dd10mr13506294oec.124.1369449615571;
        Fri, 24 May 2013 19:40:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm9168693oeo.8.2013.05.24.19.40.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:40:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225465>

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
index 2c91ec6..55abf0b 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -5,6 +5,7 @@ export T := $(addprefix $(CURDIR)/,$(TESTS))
 export MAKE := $(MAKE) -e
 export PATH := $(CURDIR):$(PATH)
 export TEST_LINT := test-lint-executable test-lint-shell-syntax
+export TEST_DIRECTORY := $(CURDIR)/../../t
 
 export SCRIPT_PYTHON := $(addprefix $(CURDIR)/,$(SCRIPTS))
 
diff --git a/contrib/remote-helpers/test-bzr.t b/contrib/remote-helpers/test-bzr.t
index 5dfa070..0f24c48 100755
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
index f569697..8707eb9 100755
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
index 7f579c8..ac1de96 100755
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
index 8de2aa7..a362867 100755
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
1.8.3.rc3.312.g47657de
