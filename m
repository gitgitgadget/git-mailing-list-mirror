From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 7/8] rebase: move resolvemsg to rebase--* scripts
Date: Wed, 18 Mar 2015 16:55:46 +0700
Message-ID: <1426672547-11369-8-git-send-email-pclouds@gmail.com>
References: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAid-0002vN-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216AbbCRJ4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:56:49 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35423 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933181AbbCRJ4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:56:45 -0400
Received: by pdbop1 with SMTP id op1so38432065pdb.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tajllcXe/rGTkmGwxRicL14sj5EqP19BcHTn6eNX05o=;
        b=kmYH2b4foxC+OzQErQaoo8yWmbIgtN/wD3/RRlbQQCxi4rc3LVGbFCDDUiI01Buu03
         z51vt1X7FKjGXBKlNl4eV32+3AMaYfw2rodTSG9CMoKCbr5rNIM+BjsOAFWMrFfy5Ah7
         O3aI1QqpAMFGwepWgGrXiraqdJj/oxqxVMibQJQlabxTC1FUk0vwYtb5dhaVXiL1fQRd
         /pGWSflI2PWVSlL5OdjW/h8ZZ7l/QPbxpysqQDrDaSQ40g7e6jDOSV8KRPBTD3fGnN4D
         3CIZiZaZkQSA0gYu50Blb3W3WBoDUa2mTjGG+HccNnjNWNu8rOMSAsvJZ/7LLbl58hbF
         svXw==
X-Received: by 10.70.138.42 with SMTP id qn10mr70507212pdb.157.1426672604677;
        Wed, 18 Mar 2015 02:56:44 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id k9sm1992610pdp.24.2015.03.18.02.56.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:41 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265709>

---
 git-rebase--am.sh          | 5 +++++
 git-rebase--interactive.sh | 5 +++++
 git-rebase--merge.sh       | 5 +++++
 git-rebase.sh              | 7 +------
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index ab84330..399956b 100755
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -9,6 +9,11 @@ set_reflog_action rebase
 require_work_tree_exists
 
 GIT_QUIET=$git_quiet
+resolvemsg="
+$(gettext 'When you have resolved this problem, run "git rebase --continue".
+If you prefer to skip this patch, run "git rebase --skip" instead.
+To check out the original branch and stop rebasing, run "git rebase --abort".')
+"
 
 write_basic_state () {
 	echo "$head_name" > "$state_dir"/head-name &&
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b1c71a9..337dec3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -16,6 +16,11 @@ set_reflog_action "rebase -i ($action)"
 require_work_tree_exists
 
 GIT_QUIET=$git_quiet
+resolvemsg="
+$(gettext 'When you have resolved this problem, run "git rebase --continue".
+If you prefer to skip this patch, run "git rebase --skip" instead.
+To check out the original branch and stop rebasing, run "git rebase --abort".')
+"
 
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index baaef41..7e240be 100755
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -9,6 +9,11 @@ set_reflog_action rebase
 require_work_tree_exists
 
 GIT_QUIET=$git_quiet
+resolvemsg="
+$(gettext 'When you have resolved this problem, run "git rebase --continue".
+If you prefer to skip this patch, run "git rebase --skip" instead.
+To check out the original branch and stop rebasing, run "git rebase --abort".')
+"
 
 prec=4
 
diff --git a/git-rebase.sh b/git-rebase.sh
index d941239..38530e8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -49,11 +49,6 @@ cd_to_toplevel
 LF='
 '
 ok_to_skip_pre_rebase=
-resolvemsg="
-$(gettext 'When you have resolved this problem, run "git rebase --continue".
-If you prefer to skip this patch, run "git rebase --skip" instead.
-To check out the original branch and stop rebasing, run "git rebase --abort".')
-"
 unset onto
 cmd=
 strategy=
@@ -139,7 +134,7 @@ run_specific_rebase () {
 	git_quiet=$GIT_QUIET
 	export GIT_PAGER
 	export action allow_rerere_autoupdate git_am_opt git_quiet head_name keep_empty
-	export onto orig_head rebase_root resolvemsg revisions
+	export onto orig_head rebase_root revisions
 	export state_dir verbose strategy strategy_opts
 	export autosquash cmd force_rebase preserve_merges squash_onto switch_to upstream
 	exec git-rebase--$type
-- 
2.3.0.rc1.137.g477eb31
