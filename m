Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F85C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21CC613AA
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhGDFtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 01:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDFtC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 01:49:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE16C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 22:46:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c15so8284196pls.13
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7T3htjnAatzqzKhe/MTTH80q/MJ4JqqE4hP4MDtAsmk=;
        b=Ka9dUoEN7VGvAFsrR7aPUvo3yXRB8rKEz+5TVRq3z0TiPaIYSSskWvwcKvroXsjkgJ
         fRmIDiTjC6W8NkC30vkbiLw6NlsdHDeXV83/VlmAJltrYhRu72+NwKRHKHpqRPOc+2v+
         e2Fkh9giI78Axti8oxLFclj07zgOscpBhvon+h8d5HG/APRSlzKvwmlmV6Za+5FLGmiU
         t5bHTUqbYR7ufPd14bKL+iNzlMx4mQq53WpBfKJ9ajImQxBvnSp2sUi53AzPgUXbOARM
         bEHI6zu2IHrM6Kndk1KET0zx04JoQLkBkeMNfDEwiJqhTmh+lp0SYqviQ+SCdClKOdBO
         URRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7T3htjnAatzqzKhe/MTTH80q/MJ4JqqE4hP4MDtAsmk=;
        b=W5OjqDr5x92Oy6t5hZycCPtfYgqFO6D3DH1MHOOmbq+A4VTHQk5XobPBh/XvQiVrpF
         pq5SdtLXJdRBWxKdo7I/Zp7W/TWQNkdf9gRiRLqAkuBpDgFrFjBPtvTko6Y96xMBlKjg
         9xDczNNDQybO3joMGG7aZ6dwp9NOEKAYIQuJj/snbowBb74Hqf76git+I6ziU27wrGGy
         FiKgGBZy0u3H+HHH+xzDUgvAdp4d3xEC1ECCPOvsCcKlx2/ahhfh5mvPzow6oLzYBSC9
         JXujgPe2h3REWSlByPs7KX5xR6kFSc48q2EiU2l2DjK/whZu4eyac5W9bqZocXHHyaDs
         dV8A==
X-Gm-Message-State: AOAM53091D39yvqE/pKypqOANJFW/01opKqX02b7SeSW0Zc5VPkbsfBx
        OOfgRjWbR/yo35Z1JavK5fVmHZDmJL4=
X-Google-Smtp-Source: ABdhPJwSSfYQjYo+dyBfeNqkQ7rYWbxQV5i+p41S7mUeswRR0zCH9p0uFfscFVCFWNIp29crQIOLcw==
X-Received: by 2002:a17:902:d916:b029:11e:3249:4a17 with SMTP id c22-20020a170902d916b029011e32494a17mr6854386plz.0.1625377586702;
        Sat, 03 Jul 2021 22:46:26 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:ac70:88b3:9959:84e3:df13])
        by smtp.gmail.com with ESMTPSA id i8sm8182379pfo.154.2021.07.03.22.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 22:46:26 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 3/3] t6402: preserve git exit status code
Date:   Sun,  4 Jul 2021 12:46:12 +0700
Message-Id: <f8ed19f858283e18ff4ae2d6ece199c82b624c30.1625362489.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.172.g7674896d58
In-Reply-To: <cover.1625362488.git.congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com> <cover.1625362488.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t6402, we're checking number of files in the index and the working
tree by piping the output of Git's command to "wc -l", thus losing the
exit status code of git.

Let's use the new helper test_stdout_line_count in order to preserve
Git's exit status code.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6402-merge-rename.sh | 132 +++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 68 deletions(-)

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 425dad97d5..3da2896e3b 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -105,10 +105,8 @@ test_expect_success 'pull renaming branch into unrenaming one' \
 	git show-branch &&
 	test_expect_code 1 git pull . white &&
 	git ls-files -s &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	test_stdout_line_count = 3 git ls-files -u B &&
+	test_stdout_line_count = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -122,10 +120,8 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	git reset --hard &&
 	git checkout red &&
 	test_expect_code 1 git pull . white &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	test_stdout_line_count = 3 git ls-files -u B &&
+	test_stdout_line_count = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -138,10 +134,8 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 	git reset --hard &&
 	git show-branch &&
 	test_expect_code 1 git pull . main &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 3 b.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	test_stdout_line_count = 3 git ls-files -u B &&
+	test_stdout_line_count = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -154,14 +148,10 @@ test_expect_success 'pull conflicting renames' \
 	git reset --hard &&
 	git show-branch &&
 	test_expect_code 1 git pull . blue &&
-	git ls-files -u A >a.stages &&
-	test_line_count = 1 a.stages &&
-	git ls-files -u B >b.stages &&
-	test_line_count = 1 b.stages &&
-	git ls-files -u C >c.stages &&
-	test_line_count = 1 c.stages &&
-	git ls-files -s N >n.stages &&
-	test_line_count = 1 n.stages &&
+	test_stdout_line_count = 1 git ls-files -u A &&
+	test_stdout_line_count = 1 git ls-files -u B &&
+	test_stdout_line_count = 1 git ls-files -u C &&
+	test_stdout_line_count = 1 git ls-files -s N &&
 	sed -ne "/^g/{
 	p
 	q
@@ -330,8 +320,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 		test_i18ngrep "Adding as dir~HEAD instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_stdout_line_count = 3 git ls-files -u &&
+	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -357,8 +347,8 @@ test_expect_success 'Same as previous, but merged other way' '
 		test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output
 	fi &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_stdout_line_count = 3 git ls-files -u &&
+	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -374,8 +364,8 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-not-in-way &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
+	test_stdout_line_count = 3 git ls-files -u &&
+	test_stdout_line_count = 3 git ls-files -u dir &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -409,14 +399,16 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	test_stdout_line_count = 5 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
+		test_stdout_line_count = 3 git ls-files -u dir~HEAD
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >out &&
+		test 3 -eq $(grep -v file-in-the-way out | wc -l) &&
+		rm -f out
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -432,14 +424,16 @@ test_expect_success 'Same as previous, but merged other way' '
 	git checkout -q dir-in-way^0 &&
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
-	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	test_stdout_line_count = 5 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
+		test_stdout_line_count = 3 git ls-files -u dir~renamed-file-has-conflicts
 	else
-		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
+		git ls-files -u dir >out &&
+		test 3 -eq $(grep -v file-in-the-way out | wc -l) &&
+		rm -f out
 	fi &&
-	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -496,9 +490,9 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 2 -eq "$(git ls-files -u | wc -l)"
+		test_stdout_line_count = 2 git ls-files -u
 	else
-		test 1 -eq "$(git ls-files -u | wc -l)"
+		test_stdout_line_count = 1 git ls-files -u
 	fi &&
 
 	test_must_fail git diff --quiet &&
@@ -540,9 +534,9 @@ then
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)" &&
+		test_stdout_line_count = 4 git ls-files -u &&
+		test_stdout_line_count = 2 git ls-files -u one &&
+		test_stdout_line_count = 2 git ls-files -u two &&
 
 		test_must_fail git diff --quiet &&
 
@@ -559,9 +553,9 @@ else
 		mkdir one &&
 		test_must_fail git merge --strategy=recursive rename-two &&
 
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
+		test_stdout_line_count = 2 git ls-files -u &&
+		test_stdout_line_count = 1 git ls-files -u one &&
+		test_stdout_line_count = 1 git ls-files -u two &&
 
 		test_must_fail git diff --quiet &&
 
@@ -582,13 +576,13 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 4 -eq "$(git ls-files -u | wc -l)" &&
-		test 2 -eq "$(git ls-files -u one | wc -l)" &&
-		test 2 -eq "$(git ls-files -u two | wc -l)"
+		test_stdout_line_count = 4 git ls-files -u &&
+		test_stdout_line_count = 2 git ls-files -u one &&
+		test_stdout_line_count = 2 git ls-files -u two
 	else
-		test 2 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)"
+		test_stdout_line_count = 2 git ls-files -u &&
+		test_stdout_line_count = 1 git ls-files -u one &&
+		test_stdout_line_count = 1 git ls-files -u two
 	fi &&
 
 	test_must_fail git diff --quiet &&
@@ -631,19 +625,19 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one~HEAD | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two~second-rename | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 0 -eq "$(git ls-files -o | wc -l)"
+		test_stdout_line_count = 5 git ls-files -s &&
+		test_stdout_line_count = 3 git ls-files -u &&
+		test_stdout_line_count = 1 git ls-files -u one~HEAD &&
+		test_stdout_line_count = 1 git ls-files -u two~second-rename &&
+		test_stdout_line_count = 1 git ls-files -u original &&
+		test_stdout_line_count = 0 git ls-files -o
 	else
-		test 5 -eq "$(git ls-files -s | wc -l)" &&
-		test 3 -eq "$(git ls-files -u | wc -l)" &&
-		test 1 -eq "$(git ls-files -u one | wc -l)" &&
-		test 1 -eq "$(git ls-files -u two | wc -l)" &&
-		test 1 -eq "$(git ls-files -u original | wc -l)" &&
-		test 2 -eq "$(git ls-files -o | wc -l)"
+		test_stdout_line_count = 5 git ls-files -s &&
+		test_stdout_line_count = 3 git ls-files -u &&
+		test_stdout_line_count = 1 git ls-files -u one &&
+		test_stdout_line_count = 1 git ls-files -u two &&
+		test_stdout_line_count = 1 git ls-files -u original &&
+		test_stdout_line_count = 2 git ls-files -o
 	fi &&
 
 	test_path_is_file one/file &&
@@ -679,11 +673,11 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename-redo^0 &&
 	test_must_fail git merge --strategy=recursive second-rename-redo &&
 
-	test 3 -eq "$(git ls-files -u | wc -l)" &&
-	test 1 -eq "$(git ls-files -u one | wc -l)" &&
-	test 1 -eq "$(git ls-files -u two | wc -l)" &&
-	test 1 -eq "$(git ls-files -u original | wc -l)" &&
-	test 0 -eq "$(git ls-files -o | wc -l)" &&
+	test_stdout_line_count = 3 git ls-files -u &&
+	test_stdout_line_count = 1 git ls-files -u one &&
+	test_stdout_line_count = 1 git ls-files -u two &&
+	test_stdout_line_count = 1 git ls-files -u original &&
+	test_stdout_line_count = 0 git ls-files -o &&
 
 	test_path_is_file one &&
 	test_path_is_file two &&
@@ -861,9 +855,11 @@ test_expect_success 'setup merge of rename + small change' '
 test_expect_success 'merge rename + small change' '
 	git merge rename_branch &&
 
-	test 1 -eq $(git ls-files -s | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
-	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
+	test_stdout_line_count = 1 git ls-files -s &&
+	test_stdout_line_count = 0 git ls-files -o &&
+	newhash=$(git rev-parse HEAD:renamed_file) &&
+	oldhash=$(git rev-parse HEAD~1:file) &&
+	test $newhash = $oldhash
 '
 
 test_expect_success 'setup for use of extended merge markers' '
-- 
2.32.0.278.gd42b80f139

