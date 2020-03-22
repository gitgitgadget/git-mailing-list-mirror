Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52173C54EEB
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 21:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6E920735
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 21:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le57rheI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCVVOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:14:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44100 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVVOf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 17:14:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so5501535wrw.11
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdIrclzkw6LEtJPS4Vo7h7V0UtpkhQQZl7/54MPCBJQ=;
        b=le57rheIuawEQ8k2EUlB3r/PFbLE/CYPWguXCk61y8PJMMRgt4H+2uNrvxEmMOaXgb
         sljUqPO9VxnNvc6a98U6wa3TCnANwwJEWekai98FOMdlktwQTFJyd6MV04M77sA6M9UV
         M0bmiAt7Yz9Ay2kdjCjLBCNEzAd7exqrmBOZtHqB+LC6GKr9LJbXvEoDbz+yZeH2BoMn
         BVMKN3TTWfe0tmDCgY1/9DP0ZCmmLd3fwXhfSkAuXNk7dorDNml5L6kWoS/Hqzmrypbw
         jI4Eaypz0AyF58imruW12NeXeUYjHntAeiWB7EZ+Smfx2VQh8H+tayk3ISHXQOy2b3/e
         CsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdIrclzkw6LEtJPS4Vo7h7V0UtpkhQQZl7/54MPCBJQ=;
        b=e3YiXdtcNJc20QtJjW7lmBUAPG9jaJj/EtmvKwbHdkleHCJEZc6gACJF5rMZdZr0MG
         fhrjIivdNj5tGfE4A8eL7Wc8jje3nWnytWu/vBped5D8/Qo59HWhHu+fG7A46FpEEgO5
         YetDRniAkvAe/8/sZoqu+26/dHHXm5P9w6k1TByrcg7y3NPFrpGnsBumKqQz5FGbCHUD
         Zi+Oe+j1DLq6KiFG+d8Ud2DsfxRzipLgC38fQUJi2+iB5nogzNAx3l1u8xa27W1kUMhV
         n041v6vycyZPPIDDkPxLicQH0Q4qLD3WktOyxOY6m/DDmjtFXiu1K72jRe1HrXZG4Zew
         mS3g==
X-Gm-Message-State: ANhLgQ2Qf4yMCCaJtGvT2iRPP2Xz5vTlV9ncAGIju2RCYFueYudd4237
        1oWv0E1GnY0+/KZ9wZk/WksEdpnRCXY=
X-Google-Smtp-Source: ADFU+vvnfny3m6KURCgTuPTXdc2mQ2nHXTQYQWSLmAQ8C6ug8mSrbvM9+Y3OtGvhHqh3ZvfpjIiDJQ==
X-Received: by 2002:a5d:5451:: with SMTP id w17mr25527446wrv.142.1584911674104;
        Sun, 22 Mar 2020 14:14:34 -0700 (PDT)
Received: from localhost.localdomain ([185.216.34.227])
        by smtp.gmail.com with ESMTPSA id a82sm2400256wmh.0.2020.03.22.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 14:14:33 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org, sunshine@sunshineco.com
Cc:     Andrei Rybak <rybak.a.v@gmail.com>
Subject: [PATCH v2 2/2] t: fix whitespace around &&
Date:   Sun, 22 Mar 2020 22:14:22 +0100
Message-Id: <20200322211422.15129-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200322211422.15129-1-rybak.a.v@gmail.com>
References: <20200315180902.13750-1-rybak.a.v@gmail.com>
 <20200322211422.15129-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing spaces before '&&' and switch tabs around '&&' to spaces.
Also fix the space after redirection operator in t3701 while we're here.

These issues were found using `git grep '[^ ]&&$'` and
`git grep -P '&&\t' t/`.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Changes since v1:
  Added two more fixes for tabs after &&, updated commit message
  correspondingly.  One new fix is in t3417-rebase-whitespace-fix.sh and
  another in t5604-clone-reference.sh.

 t/t2402-worktree-list.sh               | 2 +-
 t/t3417-rebase-whitespace-fix.sh       | 4 ++--
 t/t3700-add.sh                         | 2 +-
 t/t3701-add-interactive.sh             | 2 +-
 t/t4057-diff-combined-paths.sh         | 2 +-
 t/t4150-am.sh                          | 2 +-
 t/t5537-fetch-shallow.sh               | 2 +-
 t/t5604-clone-reference.sh             | 2 +-
 t/t7400-submodule-basic.sh             | 4 ++--
 t/t7609-merge-co-error-msgs.sh         | 2 +-
 t/t9010-svn-fe.sh                      | 2 +-
 t/t9500-gitweb-standalone-no-errors.sh | 4 ++--
 t/t9831-git-p4-triggers.sh             | 2 +-
 13 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 69ffe865b4..52585ec2aa 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -152,7 +152,7 @@ test_expect_success 'linked worktrees are sorted' '
 '
 
 test_expect_success 'worktree path when called in .git directory' '
-	git worktree list >list1&&
+	git worktree list >list1 &&
 	git -C .git worktree list >list2 &&
 	test_cmp list1 list2
 '
diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespace-fix.sh
index e85cdc7037..946e92f8da 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -52,7 +52,7 @@ test_expect_success 'blank line at end of file; extend at end of file' '
 	git commit --allow-empty -m "Initial empty commit" &&
 	git add file && git commit -m first &&
 	mv second file &&
-	git add file &&	git commit -m second &&
+	git add file && git commit -m second &&
 	git rebase --whitespace=fix HEAD^^ &&
 	git diff --exit-code HEAD^:file expect-first &&
 	test_cmp expect-second file
@@ -118,7 +118,7 @@ test_expect_success 'at beginning of file' '
 	for i in 1 2 3 4 5; do
 		echo $i
 	done >> file &&
-	git commit -m more file	&&
+	git commit -m more file &&
 	git rebase --whitespace=fix HEAD^^ &&
 	test_cmp expect-beginning file
 '
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 88bc799807..b7d4ba608c 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -192,7 +192,7 @@ test_expect_success 'git add --refresh with pathspec' '
 	test_must_be_empty actual &&
 
 	git diff-files --name-only >actual &&
-	! grep bar actual&&
+	! grep bar actual &&
 	grep baz actual
 '
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5bae6e50f1..b3d8bb7577 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -780,7 +780,7 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 test_expect_success 'checkout -p works with pathological context lines' '
 	test_write_lines a a a a a a >a &&
 	git add a &&
-	test_write_lines a b a b a b a b a b a > a&&
+	test_write_lines a b a b a b a b a b a >a &&
 	test_write_lines s n n y q | git checkout -p &&
 	test_write_lines a b a b a a b a b a >expect &&
 	test_cmp expect a
diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
index 4f4b541658..0b78573733 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -14,7 +14,7 @@ diffc_verify () {
 test_expect_success 'trivial merge - combine-diff empty' '
 	for i in $(test_seq 1 9)
 	do
-		echo $i >$i.txt	&&
+		echo $i >$i.txt &&
 		git add $i.txt
 	done &&
 	git commit -m "init" &&
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index cb45271457..bda4586a79 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -166,7 +166,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m third &&
 
-	git format-patch --stdout first >patch2	&&
+	git format-patch --stdout first >patch2 &&
 
 	git checkout -b lorem &&
 	sed -n -e "11,\$p" msg >file &&
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 4f681dbbe1..b57209c84f 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -131,7 +131,7 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 	git init notshallow &&
 	(
 	cd notshallow &&
-	git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/*&&
+	git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
 	git for-each-ref --format="%(refname)" >actual.refs &&
 	cat <<EOF >expect.refs &&
 refs/remotes/shallow/no-shallow
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 0c74b4e21a..2f7be23044 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -175,7 +175,7 @@ test_expect_success 'clone using repo pointed at by gitfile as reference' '
 test_expect_success 'clone and dissociate from reference' '
 	git init P &&
 	(
-		cd P &&	test_commit one
+		cd P && test_commit one
 	) &&
 	git clone P Q &&
 	(
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e3e2aab3b0..956e17abb3 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -938,7 +938,7 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 		echo "repo" >expect &&
 		test_must_fail git config -f .gitmodules submodule.repo.path &&
 		git config -f .gitmodules submodule.repo_new.path >actual &&
-		test_cmp expect actual&&
+		test_cmp expect actual &&
 		echo "$submodurl/repo" >expect &&
 		test_must_fail git config -f .gitmodules submodule.repo.url &&
 		echo "$submodurl/bare.git" >expect &&
@@ -1010,7 +1010,7 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
 		test -d repo &&
 		echo "repo" >expect &&
 		git config -f .gitmodules submodule.repo_new.path >actual &&
-		test_cmp expect actual&&
+		test_cmp expect actual &&
 		echo "$submodurl/repo.git" >expect &&
 		git config -f .gitmodules submodule.repo_new.url >actual &&
 		test_cmp expect actual &&
diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index e90413204e..5c8894d94f 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -126,7 +126,7 @@ test_expect_success 'not_uptodate_dir porcelain checkout error' '
 	git rm rep2 -r &&
 	>rep &&
 	>rep2 &&
-	git add rep rep2&&
+	git add rep rep2 &&
 	git commit -m "added test as a file" &&
 	git checkout master &&
 	>rep/untracked-file &&
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index c90fdc5c89..83f8f5cacb 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -486,7 +486,7 @@ test_expect_success 'NUL in property value' '
 	{
 		properties \
 			unimportant "something with a NUL (Q)" \
-			svn:log "commit message"&&
+			svn:log "commit message" &&
 		echo PROPS-END
 	} |
 	q_to_nul >props &&
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 784df80858..267ddc997d 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -348,7 +348,7 @@ test_expect_success \
 	 echo "To be renamed and changed" >04-rename-from &&
 	 echo "To have mode changed" >05-mode-change &&
 	 echo "File to symlink" >06-file-or-symlink &&
-	 echo "To be changed and have mode changed" >07-change-mode-change	&&
+	 echo "To be changed and have mode changed" >07-change-mode-change &&
 	 git add 0* &&
 	 git commit -a -m "Prepare large commit" &&
 	 echo "Changed" >01-change &&
@@ -361,7 +361,7 @@ test_expect_success \
 	 test_chmod +x 05-mode-change &&
 	 rm -f 06-file-or-symlink &&
 	 test_ln_s_add 01-change 06-file-or-symlink &&
-	 echo "Changed and have mode changed" >07-change-mode-change	&&
+	 echo "Changed and have mode changed" >07-change-mode-change &&
 	 test_chmod +x 07-change-mode-change &&
 	 git commit -a -m "Large commit" &&
 	 git checkout master'
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index d743ca33ee..ff6c0352e6 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -58,7 +58,7 @@ test_expect_success 'import with extra info lines from verbose p4 trigger' '
 	(
 		cd "$git" &&
 		git p4 sync
-	)&&
+	) &&
 	(
 		p4 triggers -i <<-EOF
 		Triggers:
-- 
2.25.1

