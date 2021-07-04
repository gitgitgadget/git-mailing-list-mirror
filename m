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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DECEC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070AB61380
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhGDFs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 01:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDFsz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 01:48:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50819C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 22:46:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s13so5207332plg.12
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 22:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vQLId2s7qMuL38Cfwnv6bXRpy/iBFvd1V9Gu3CdE0s=;
        b=psrvoVK6/ycCgG7y77VCKrxSJ7pSx1ZIS+liNSEWDsN2KjuYdh71YJ3RqlpjDIqKn0
         LTfbtN8VcRAYfam0vVXlOL1NhY7zdLUbb9OsindzMncgmyW6cLJurETj4mJvE/Hd712m
         gw2zKALXdbYtgouWtY7Ss/ZCUksHKIX6nH1oEn2qFdp3D1Oaz+n9tMWjwxwhrrq2nE4x
         UdOvEL9yISNvjw2QlvRlLX/lYmZQHjOtFlv45xX4G0lRbyX+g7OKDD67grTAjYMwVG+n
         qosme/wXOoIB0B/y69VZfKs9W/j0b+qHMw2K39JGQbAnLqdnKK+WmT9XDeX8U/FUMxna
         N6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vQLId2s7qMuL38Cfwnv6bXRpy/iBFvd1V9Gu3CdE0s=;
        b=fPOlmJpRju2kIyH5Wmzq1aDCORQINv+0u9MZWVJ91WyS1ZArFMhhUL2gX50H+maR34
         uMazgq9zC1/I6JL+olP3zaSnkNtM5cE8Cbigs1hM8Ra8dN9eMpQsy2eeRiz7kIR1q/LT
         jSdS31xDnXym0EZ96zUa7z3wHwI1aZ0ApmMFRBaoAVsGuBOHCX3Mmgdy2b50esDkW5Qn
         mcimvWZuk6cQu+4x/eh8t72DG4QV81SEvwYOcFuJCnpPZ4kQdVcVeGYzLVl58jV6rdcZ
         nZ2w0q004UeLPDtvF9nGVjK5DTf+qW/H4TlcBNdRCzFPOHd0qQqstTz/WJAAFuu6v9n/
         XWZQ==
X-Gm-Message-State: AOAM532WYQF2xp4TTQA/TL3snepgfwGfZLlEnyw35Pg1rP8/9CENieTN
        27GE1lP3gOwFtHKSHRJOamYuDcJ+kjg=
X-Google-Smtp-Source: ABdhPJzcL05zjmmKfVVfDz0iWFNzLyCOX7rj8XZruzdTK3OgUNgxwpv2WZs4CDttWRKo5O0rS1dkcQ==
X-Received: by 2002:a17:90a:d102:: with SMTP id l2mr8014714pju.225.1625377578719;
        Sat, 03 Jul 2021 22:46:18 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:ac70:88b3:9959:84e3:df13])
        by smtp.gmail.com with ESMTPSA id i8sm8182379pfo.154.2021.07.03.22.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 22:46:18 -0700 (PDT)
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
Subject: [PATCH v5 0/3] new test-libs-function: test_stdout_line_count
Date:   Sun,  4 Jul 2021 12:46:09 +0700
Message-Id: <cover.1625362488.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.172.g7674896d58
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series was started to clear false positive when applying
Junio's suggestion to to a series written by Ævar [1].

Despite, we don't have much interest in that direction.
I think it's still an improvement with this series, namely,
we're able to always check Git's exit status code.

A naive: "git grep -l  'git.* | wc -l' t????-* |wc -l" reveals
38 other tests also have that pattern.
Those tests could be cleaned up later on

Change in v5:
- restore (albeit with new name and simplified) test_stdout_line_count
- trash files will be written in $(git rev-parse --git-dir)/trash

In v4, I dropped the test_line_count_cmd completely.
A local to t640{0,2} helper was written instead.

Đoàn Trần Công Danh (3):
  test-lib-functions: introduce test_stdout_line_count
  t6400: preserve git ls-files exit status code
  t6402: preserve git exit status code

 t/t6400-merge-df.sh     |  16 ++---
 t/t6402-merge-rename.sh | 132 +++++++++++++++++++---------------------
 t/test-lib-functions.sh |  26 ++++++++
 3 files changed, 98 insertions(+), 76 deletions(-)

Range-diff against v4:
1:  49104273b8 < -:  ---------- t6400: preserve git ls-files exit status code
-:  ---------- > 1:  ab542ae9aa test-lib-functions: introduce test_stdout_line_count
-:  ---------- > 2:  f7a06994cd t6400: preserve git ls-files exit status code
2:  6d3ebcb255 ! 3:  f8ed19f858 t6402: preserve git exit status code
    @@ Commit message
         t6402: preserve git exit status code
     
         In t6402, we're checking number of files in the index and the working
    -    tree by piping the output of "git ls-files" to "wc -l", thus losing the
    +    tree by piping the output of Git's command to "wc -l", thus losing the
         exit status code of git.
     
    -    Let's write the output of "git ls-files" to a temporary file, in order
    -    to check exit status code of "git ls-files" properly.
    -
    -    While we're at it, also check exit status code of an invocation of
    -    git-rev-parse, too.
    +    Let's use the new helper test_stdout_line_count in order to preserve
    +    Git's exit status code.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## t/t6402-merge-rename.sh ##
    -@@ t/t6402-merge-rename.sh: modify () {
    - 	mv "$2.x" "$2"
    - }
    - 
    -+check_ls_files_count() {
    -+	local ops val
    -+	if test "$#" -le 2
    -+	then
    -+		BUG "Expect 2 or more arguments"
    -+	fi &&
    -+	ops="$1" &&
    -+	val="$2" &&
    -+	shift 2 &&
    -+	mkdir -p .git/trash &&
    -+	git ls-files "$@" >.git/trash/output &&
    -+	test_line_count "$ops" "$val" .git/trash/output
    -+}
    -+
    - test_expect_success 'setup' '
    - 	cat >A <<-\EOF &&
    - 	a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
     @@ t/t6402-merge-rename.sh: test_expect_success 'pull renaming branch into unrenaming one' \
      	git show-branch &&
      	test_expect_code 1 git pull . white &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'pull renaming branch into unrenami
     -	test_line_count = 3 b.stages &&
     -	git ls-files -s N >n.stages &&
     -	test_line_count = 1 n.stages &&
    -+	check_ls_files_count = 3 -u B &&
    -+	check_ls_files_count = 1 -s N &&
    ++	test_stdout_line_count = 3 git ls-files -u B &&
    ++	test_stdout_line_count = 1 git ls-files -s N &&
      	sed -ne "/^g/{
      	p
      	q
    @@ t/t6402-merge-rename.sh: test_expect_success 'pull renaming branch into another
     -	test_line_count = 3 b.stages &&
     -	git ls-files -s N >n.stages &&
     -	test_line_count = 1 n.stages &&
    -+	check_ls_files_count = 3 -u B &&
    -+	check_ls_files_count = 1 -s N &&
    ++	test_stdout_line_count = 3 git ls-files -u B &&
    ++	test_stdout_line_count = 1 git ls-files -s N &&
      	sed -ne "/^g/{
      	p
      	q
    @@ t/t6402-merge-rename.sh: test_expect_success 'pull unrenaming branch into renami
     -	test_line_count = 3 b.stages &&
     -	git ls-files -s N >n.stages &&
     -	test_line_count = 1 n.stages &&
    -+	check_ls_files_count = 3 -u B &&
    -+	check_ls_files_count = 1 -s N &&
    ++	test_stdout_line_count = 3 git ls-files -u B &&
    ++	test_stdout_line_count = 1 git ls-files -s N &&
      	sed -ne "/^g/{
      	p
      	q
    @@ t/t6402-merge-rename.sh: test_expect_success 'pull conflicting renames' \
     -	test_line_count = 1 c.stages &&
     -	git ls-files -s N >n.stages &&
     -	test_line_count = 1 n.stages &&
    -+	check_ls_files_count = 1 -u A &&
    -+	check_ls_files_count = 1 -u B &&
    -+	check_ls_files_count = 1 -u C &&
    -+	check_ls_files_count = 1 -s N &&
    ++	test_stdout_line_count = 1 git ls-files -u A &&
    ++	test_stdout_line_count = 1 git ls-files -u B &&
    ++	test_stdout_line_count = 1 git ls-files -u C &&
    ++	test_stdout_line_count = 1 git ls-files -s N &&
      	sed -ne "/^g/{
      	p
      	q
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	check_ls_files_count = 3 -u &&
    -+	check_ls_files_count = 2 -u dir/file-in-the-way &&
    ++	test_stdout_line_count = 3 git ls-files -u &&
    ++	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Same as previous, but merged other
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	check_ls_files_count = 3 -u &&
    -+	check_ls_files_count = 2 -u dir/file-in-the-way &&
    ++	test_stdout_line_count = 3 git ls-files -u &&
    ++	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
    -+	check_ls_files_count = 3 -u &&
    -+	check_ls_files_count = 3 -u dir &&
    ++	test_stdout_line_count = 3 git ls-files -u &&
    ++	test_stdout_line_count = 3 git ls-files -u dir &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      	test_must_fail git merge --strategy=recursive dir-in-way &&
      
     -	test 5 -eq "$(git ls-files -u | wc -l)" &&
    -+	check_ls_files_count = 5 -u &&
    ++	test_stdout_line_count = 5 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
    -+		check_ls_files_count = 3 -u dir~HEAD
    ++		test_stdout_line_count = 3 git ls-files -u dir~HEAD
      	else
     -		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
     +		git ls-files -u dir >out &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
     +		rm -f out
      	fi &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	check_ls_files_count = 2 -u dir/file-in-the-way &&
    ++	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Same as previous, but merged other
      	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
      
     -	test 5 -eq "$(git ls-files -u | wc -l)" &&
    -+	check_ls_files_count = 5 -u &&
    ++	test_stdout_line_count = 5 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
    -+		check_ls_files_count = 3 -u dir~renamed-file-has-conflicts
    ++		test_stdout_line_count = 3 git ls-files -u dir~renamed-file-has-conflicts
      	else
     -		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
     +		git ls-files -u dir >out &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Same as previous, but merged other
     +		rm -f out
      	fi &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	check_ls_files_count = 2 -u dir/file-in-the-way &&
    ++	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'both rename source and destination
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 2 -eq "$(git ls-files -u | wc -l)"
    -+		check_ls_files_count = 2 -u
    ++		test_stdout_line_count = 2 git ls-files -u
      	else
     -		test 1 -eq "$(git ls-files -u | wc -l)"
    -+		check_ls_files_count = 1 -u
    ++		test_stdout_line_count = 1 git ls-files -u
      	fi &&
      
      	test_must_fail git diff --quiet &&
    @@ t/t6402-merge-rename.sh: then
     -		test 4 -eq "$(git ls-files -u | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u two | wc -l)" &&
    -+		check_ls_files_count = 4 -u &&
    -+		check_ls_files_count = 2 -u one &&
    -+		check_ls_files_count = 2 -u two &&
    ++		test_stdout_line_count = 4 git ls-files -u &&
    ++		test_stdout_line_count = 2 git ls-files -u one &&
    ++		test_stdout_line_count = 2 git ls-files -u two &&
      
      		test_must_fail git diff --quiet &&
      
    @@ t/t6402-merge-rename.sh: else
     -		test 2 -eq "$(git ls-files -u | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u two | wc -l)" &&
    -+		check_ls_files_count = 2 -u &&
    -+		check_ls_files_count = 1 -u one &&
    -+		check_ls_files_count = 1 -u two &&
    ++		test_stdout_line_count = 2 git ls-files -u &&
    ++		test_stdout_line_count = 1 git ls-files -u one &&
    ++		test_stdout_line_count = 1 git ls-files -u two &&
      
      		test_must_fail git diff --quiet &&
      
    @@ t/t6402-merge-rename.sh: test_expect_success 'pair rename to parent of other (D/
     -		test 4 -eq "$(git ls-files -u | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u two | wc -l)"
    -+		check_ls_files_count = 4 -u &&
    -+		check_ls_files_count = 2 -u one &&
    -+		check_ls_files_count = 2 -u two
    ++		test_stdout_line_count = 4 git ls-files -u &&
    ++		test_stdout_line_count = 2 git ls-files -u one &&
    ++		test_stdout_line_count = 2 git ls-files -u two
      	else
     -		test 2 -eq "$(git ls-files -u | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u two | wc -l)"
    -+		check_ls_files_count = 2 -u &&
    -+		check_ls_files_count = 1 -u one &&
    -+		check_ls_files_count = 1 -u two
    ++		test_stdout_line_count = 2 git ls-files -u &&
    ++		test_stdout_line_count = 1 git ls-files -u one &&
    ++		test_stdout_line_count = 1 git ls-files -u two
      	fi &&
      
      	test_must_fail git diff --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -		test 1 -eq "$(git ls-files -u two~second-rename | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -		test 0 -eq "$(git ls-files -o | wc -l)"
    -+		check_ls_files_count = 5 -s &&
    -+		check_ls_files_count = 3 -u &&
    -+		check_ls_files_count = 1 -u one~HEAD &&
    -+		check_ls_files_count = 1 -u two~second-rename &&
    -+		check_ls_files_count = 1 -u original &&
    -+		check_ls_files_count = 0 -o
    ++		test_stdout_line_count = 5 git ls-files -s &&
    ++		test_stdout_line_count = 3 git ls-files -u &&
    ++		test_stdout_line_count = 1 git ls-files -u one~HEAD &&
    ++		test_stdout_line_count = 1 git ls-files -u two~second-rename &&
    ++		test_stdout_line_count = 1 git ls-files -u original &&
    ++		test_stdout_line_count = 0 git ls-files -o
      	else
     -		test 5 -eq "$(git ls-files -s | wc -l)" &&
     -		test 3 -eq "$(git ls-files -u | wc -l)" &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -		test 1 -eq "$(git ls-files -u two | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -		test 2 -eq "$(git ls-files -o | wc -l)"
    -+		check_ls_files_count = 5 -s &&
    -+		check_ls_files_count = 3 -u &&
    -+		check_ls_files_count = 1 -u one &&
    -+		check_ls_files_count = 1 -u two &&
    -+		check_ls_files_count = 1 -u original &&
    -+		check_ls_files_count = 2 -o
    ++		test_stdout_line_count = 5 git ls-files -s &&
    ++		test_stdout_line_count = 3 git ls-files -u &&
    ++		test_stdout_line_count = 1 git ls-files -u one &&
    ++		test_stdout_line_count = 1 git ls-files -u two &&
    ++		test_stdout_line_count = 1 git ls-files -u original &&
    ++		test_stdout_line_count = 2 git ls-files -o
      	fi &&
      
      	test_path_is_file one/file &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -	test 1 -eq "$(git ls-files -u two | wc -l)" &&
     -	test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -	test 0 -eq "$(git ls-files -o | wc -l)" &&
    -+	check_ls_files_count = 3 -u &&
    -+	check_ls_files_count = 1 -u one &&
    -+	check_ls_files_count = 1 -u two &&
    -+	check_ls_files_count = 1 -u original &&
    -+	check_ls_files_count = 0 -o &&
    ++	test_stdout_line_count = 3 git ls-files -u &&
    ++	test_stdout_line_count = 1 git ls-files -u one &&
    ++	test_stdout_line_count = 1 git ls-files -u two &&
    ++	test_stdout_line_count = 1 git ls-files -u original &&
    ++	test_stdout_line_count = 0 git ls-files -o &&
      
      	test_path_is_file one &&
      	test_path_is_file two &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'setup merge of rename + small chan
     -	test 1 -eq $(git ls-files -s | wc -l) &&
     -	test 0 -eq $(git ls-files -o | wc -l) &&
     -	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
    -+	check_ls_files_count = 1 -s &&
    -+	check_ls_files_count = 0 -o &&
    ++	test_stdout_line_count = 1 git ls-files -s &&
    ++	test_stdout_line_count = 0 git ls-files -o &&
     +	newhash=$(git rev-parse HEAD:renamed_file) &&
     +	oldhash=$(git rev-parse HEAD~1:file) &&
     +	test $newhash = $oldhash
-- 
2.32.0.278.gd42b80f139

