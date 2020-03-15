Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12325C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC26C20658
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko6cJ+RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgCOSJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:09:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33991 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgCOSJb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 14:09:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id x3so11694405wmj.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pefFpAu2fCOQSiDah6//KVLMPX93fAtWAizzyAwVcHQ=;
        b=ko6cJ+RKo9gp+Bl1G6eLDxM7xExnidT2ifNlywE6YL93K2j2XxL2mAja3WdtbQWEN+
         AvIu0XyxJOiogl0pKOXGLQV9mRoUK8qSJOyQw0L08W6VlNVYTSpbvXSAHh1phFm2DIrN
         V/zqY700QAkR52w8lWH2Qsls3nmyE2tDJdvKsTvbyBwzH3IkDxgOJhtGqo9O+wNOEefR
         8cXctyB7nl75nN0KfVkMJG4X4BGu6fzerviI37UiQCqJ3VDvSWKCumX/AU5HH6OToiVT
         R7OfJymVyneq9o/j2r93IiWiAGzKZNjsUf8fvZn1h+r/koV1pHtBjyUEJEoGI9BT4acd
         iv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pefFpAu2fCOQSiDah6//KVLMPX93fAtWAizzyAwVcHQ=;
        b=LIe1XyuIsrUcI5WCTu2UbleJ3YvswDmB7BqIX4cX1BX9YV4S3ZLAoqVffgIZ3Q31tR
         WykaYnTtlL3PwKB1NCaakg7M8j+YVK/3gKx8hWnlpq+ISGy/WgYpcxLW6Z3OIRB2m4jE
         DH2VaDKiKt8ejfDzX8QV1Ao2teydOjh/h3t+lKIzkC4sqeudmpQV6KBgGHWC5kOexol8
         VFONtYfHpnLlowvm+GDfmY7JRdO0BU31IOu6AeaS/So97VPX8ox2wb73ybSjF4MYjNE5
         sUOS2eQdSJE/DALAFSLGahXSLbF5zg5lwSNpAFA3t1IJ5UzaEqXiERUA4nzlvWT8B1A+
         JiwQ==
X-Gm-Message-State: ANhLgQ1i0UxjKDMDkHmvU4m4mNa2FQn0+KCY2QHEeFBXhDlQpVn+72mL
        8iz3smv2FXkwesKkJ9XW6zIkugqxBl4=
X-Google-Smtp-Source: ADFU+vuIVJAaxBlTl1sOnrQ1CAK4JFnEgqhELCfZ62h48sTWg58IetwQMjFko54fqhQbln2lugD1qA==
X-Received: by 2002:a1c:1d4d:: with SMTP id d74mr22623192wmd.123.1584295768830;
        Sun, 15 Mar 2020 11:09:28 -0700 (PDT)
Received: from localhost.localdomain ([185.220.70.167])
        by smtp.gmail.com with ESMTPSA id r28sm94086757wra.16.2020.03.15.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 11:09:28 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Andrei Rybak <rybak.a.v@gmail.com>
Subject: [PATCH] t: fix whitespace around &&
Date:   Sun, 15 Mar 2020 19:09:03 +0100
Message-Id: <20200315180902.13750-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing spaces before '&&' and switch tabs to spaces.  Also fix the
space after redirection operator in t3701-add-interactive.sh while we're
here.  These issues were found using `git grep '[^ ]&&$'`.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t2402-worktree-list.sh               | 2 +-
 t/t3417-rebase-whitespace-fix.sh       | 2 +-
 t/t3700-add.sh                         | 2 +-
 t/t3701-add-interactive.sh             | 2 +-
 t/t4057-diff-combined-paths.sh         | 2 +-
 t/t4150-am.sh                          | 2 +-
 t/t5537-fetch-shallow.sh               | 2 +-
 t/t7400-submodule-basic.sh             | 4 ++--
 t/t7609-merge-co-error-msgs.sh         | 2 +-
 t/t9010-svn-fe.sh                      | 2 +-
 t/t9500-gitweb-standalone-no-errors.sh | 4 ++--
 t/t9831-git-p4-triggers.sh             | 2 +-
 12 files changed, 14 insertions(+), 14 deletions(-)

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
index e85cdc7037..14df183fa5 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
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
index cc8d463e01..a3cbf20ae7 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -348,7 +348,7 @@ test_expect_success \
 	 echo "To be renamed and changed" > 04-rename-from &&
 	 echo "To have mode changed" > 05-mode-change &&
 	 echo "File to symlink" > 06-file-or-symlink &&
-	 echo "To be changed and have mode changed" > 07-change-mode-change	&&
+	 echo "To be changed and have mode changed" > 07-change-mode-change &&
 	 git add 0* &&
 	 git commit -a -m "Prepare large commit" &&
 	 echo "Changed" > 01-change &&
@@ -361,7 +361,7 @@ test_expect_success \
 	 test_chmod +x 05-mode-change &&
 	 rm -f 06-file-or-symlink &&
 	 test_ln_s_add 01-change 06-file-or-symlink &&
-	 echo "Changed and have mode changed" > 07-change-mode-change	&&
+	 echo "Changed and have mode changed" > 07-change-mode-change &&
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

