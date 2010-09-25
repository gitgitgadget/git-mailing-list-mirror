From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 16/16] Replace "unset VAR" with "unset VAR;" in testsuite as per t/README
Date: Sat, 25 Sep 2010 13:07:07 -0600
Message-ID: <1285441627-28233-17-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4w-0005Xq-I3
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801Ab0IYTGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:06:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39899 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756786Ab0IYTGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:06:02 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so880409pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MRlCihgcNYtxSKXAnNSCRMZhsyINlmf/Indbvki4rtY=;
        b=XB13+19IQaglaNPHL1GUqSYrXoYfIlotW4ViLg/ChGeQucyJi/Fb+iHxjT2bG8gsGn
         l/2Inp//HZPsGeif6JElA/8zjk0WorYwB3vqlVndIidYq7coGfXfD3Hs9hcObYls4cSq
         shSZz5+9L/VttcrBe3FFNQVshUlLx1nUuyNyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VsFDC5V6lKseh1aSvGpWbR0nHK+rXz61hAp4gx6tlcLpwUx7mzRxO6Xj9bxfSFMtrx
         f89boa+ugOyjZRHY8hL9VTFF691DPS/29TKpfmx0KttczmUw0sfuvI4dVkD6sOuxW5OF
         dTbm3Gol802hTc8u5udWm3YPHXxkNxB+YlZKs=
Received: by 10.114.89.16 with SMTP id m16mr5583100wab.150.1285441562655;
        Sat, 25 Sep 2010 12:06:02 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.06.00
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:06:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157177>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
t/README states that the return value of unset is undefined when the
variable is already unset.  Would it make sense to add a
  portable_unset () {
    unset $* || true
  }
helper function to test-lib, and just use it instead of unset?  That
would allow proper chaining everywhere.

 t/t0001-init.sh   |   28 ++++++++++++++--------------
 t/t7502-commit.sh |    4 ++--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9d4539f..3c2afb3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -25,7 +25,7 @@ check_config () {
 
 test_expect_success 'plain' '
 	(
-		unset GIT_DIR GIT_WORK_TREE
+		unset GIT_DIR GIT_WORK_TREE;
 		mkdir plain &&
 		cd plain &&
 		git init
@@ -35,7 +35,7 @@ test_expect_success 'plain' '
 
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR
+		unset GIT_DIR;
 		mkdir plain-wt &&
 		cd plain-wt &&
 		GIT_WORK_TREE=$(pwd) git init
@@ -48,7 +48,7 @@ test_expect_success 'plain with GIT_WORK_TREE' '
 
 test_expect_success 'plain bare' '
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG;
 		mkdir plain-bare-1 &&
 		cd plain-bare-1 &&
 		git --bare init
@@ -58,7 +58,7 @@ test_expect_success 'plain bare' '
 
 test_expect_success 'plain bare with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR GIT_CONFIG
+		unset GIT_DIR GIT_CONFIG;
 		mkdir plain-bare-2 &&
 		cd plain-bare-2 &&
 		GIT_WORK_TREE=$(pwd) git --bare init
@@ -72,7 +72,7 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '
 test_expect_success 'GIT_DIR bare' '
 
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG;
 		mkdir git-dir-bare.git &&
 		GIT_DIR=git-dir-bare.git git init
 	) &&
@@ -82,7 +82,7 @@ test_expect_success 'GIT_DIR bare' '
 test_expect_success 'init --bare' '
 
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG;
 		mkdir init-bare.git &&
 		cd init-bare.git &&
 		git init --bare
@@ -93,7 +93,7 @@ test_expect_success 'init --bare' '
 test_expect_success 'GIT_DIR non-bare' '
 
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG;
 		mkdir non-bare &&
 		cd non-bare &&
 		GIT_DIR=.git git init
@@ -104,7 +104,7 @@ test_expect_success 'GIT_DIR non-bare' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG;
 		mkdir git-dir-wt-1.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
 	) &&
@@ -114,7 +114,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 
 	if (
-		unset GIT_CONFIG
+		unset GIT_CONFIG;
 		mkdir git-dir-wt-2.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
 	)
@@ -127,7 +127,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 test_expect_success 'reinit' '
 
 	(
-		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
+		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG;
 
 		mkdir again &&
 		cd again &&
@@ -175,8 +175,8 @@ test_expect_success 'init with init.templatedir set' '
 		git config -f "$test_config"  init.templatedir "${HOME}/templatedir-source" &&
 		mkdir templatedir-set &&
 		cd templatedir-set &&
-		unset GIT_CONFIG_NOGLOBAL &&
-		unset GIT_TEMPLATE_DIR &&
+		unset GIT_CONFIG_NOGLOBAL;
+		unset GIT_TEMPLATE_DIR;
 		NO_SET_GIT_TEMPLATE_DIR=t &&
 		export NO_SET_GIT_TEMPLATE_DIR &&
 		git init
@@ -187,7 +187,7 @@ test_expect_success 'init with init.templatedir set' '
 test_expect_success 'init --bare/--shared overrides system/global config' '
 	(
 		test_config="$HOME"/.gitconfig &&
-		unset GIT_CONFIG_NOGLOBAL &&
+		unset GIT_CONFIG_NOGLOBAL;
 		git config -f "$test_config" core.bare false &&
 		git config -f "$test_config" core.sharedRepository 0640 &&
 		mkdir init-bare-shared-override &&
@@ -202,7 +202,7 @@ test_expect_success 'init --bare/--shared overrides system/global config' '
 test_expect_success 'init honors global core.sharedRepository' '
 	(
 		test_config="$HOME"/.gitconfig &&
-		unset GIT_CONFIG_NOGLOBAL &&
+		unset GIT_CONFIG_NOGLOBAL;
 		git config -f "$test_config" core.sharedRepository 0666 &&
 		mkdir shared-honor-global &&
 		cd shared-honor-global &&
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index b6b9802..129ac15 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -252,8 +252,8 @@ test_expect_success 'committer is automatic' '
 
 	echo >>negative &&
 	(
-		unset GIT_COMMITTER_EMAIL
-		unset GIT_COMMITTER_NAME
+		unset GIT_COMMITTER_EMAIL;
+		unset GIT_COMMITTER_NAME;
 		# must fail because there is no change
 		test_must_fail git commit -e -m "sample"
 	) &&
-- 
1.7.3.95.g14291
