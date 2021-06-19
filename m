Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C616C48BDF
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DA4611CC
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhFSBdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 21:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhFSBdR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 21:33:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC8C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u18so3699118pfk.11
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UX6cElt3LwoPyQPVCi+/Z4vCm8KhkmJXwocQbOafF8=;
        b=t0E0xxixBTBg6zcoNt4c0xhN56bhQ2TphSO6YsarPcmkWBVfmaDmQarcxLYGUGrE8y
         uluGA5H7V/6PC0B75TE3GnreHvW423dI38H2XXosEgW2pUmRQ9C0L80ZPKNCPsAJbsqL
         OoShjcd7McFfTHpe22djHVwN0jmLq88hq7FHWQCTe5DRkkKRhesSKiL7OrN0Z6WFAQr6
         1DbjdAut5HGB6zYRL8EK6tpRL1QjdH8ActyMbQwDkUTex/SyDDsmfRYY42yTDw450c0q
         STGidp9/5XAsqz5elhW16wl9ez9Y+l6j04ujKk4NRbz6J/IEAjNMExU2DGqNVeDyA2yJ
         wUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UX6cElt3LwoPyQPVCi+/Z4vCm8KhkmJXwocQbOafF8=;
        b=l/EGcjHTvsItVAC/9uPkRh0+ap5xzldU5dbjstl8EgqqjkVgboQ9cEj1IoHcGWO8Nf
         g9Yoai1aStY29+wctrbytG3YlXau8dFZ+88/pI4Ss6ylEL9jN/Js3A6csbjlxPyUxFvB
         r1tz7O/MJIrq4oKtsE2FPc7yxGU37xjW00uHAlFJ2KJFUSW5arBeOGoo91feyAt+No0g
         8JEnp58CWOmW7HDxZaBbF57PPfQHGIQJJt7Fx8DI4h8wptP80Aary53Yfuz62j/kof+N
         7GFe22x4ZKON+fucJqhMnQuIGY0NG3HrnPaYfuVNcmKfNKXaytGpApJWt92knDM3Dux+
         vgGg==
X-Gm-Message-State: AOAM531J1k+PpDPPunfwuH0ZxqEjy3c+deLmHSlv8X23l7qBEQo+6cu+
        /AzC6nQ8hjkQd0Bf2DjDlrNOHonkiNc=
X-Google-Smtp-Source: ABdhPJwSK8SIh3jCIOa5ZQYIE+8LlGxOFw/X4X+BjfdxuT1c7h5eroTAyXVKIE/LIJYatBHIY0hhJQ==
X-Received: by 2002:a62:53c4:0:b029:2f1:8ddb:5918 with SMTP id h187-20020a6253c40000b02902f18ddb5918mr7865924pfb.80.1624066264159;
        Fri, 18 Jun 2021 18:31:04 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id s123sm8733427pfb.78.2021.06.18.18.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 18:31:03 -0700 (PDT)
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
Subject: [PATCH v3 0/4] t: new helper test_line_count_cmd
Date:   Sat, 19 Jun 2021 08:30:31 +0700
Message-Id: <20210619013035.26313-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series to clear false positive when applying Junio's suggestion to
to a series written by Ævar [1].

Change in v3 since v2:
* --err was dropped entirely
* --out is not an option anymore, <binops> and <value> is the first two
  arguments that fed into test_line_count_cmd

Change in v2 since v1:
* Documentation for test_line_count_cmd has been written in more detail
  with examples
* The outfile and errfile will be created only if --out and/or --err was
  specified for better "-v"
* outfile and errfile will be created in $TRASH_DIRECTORY/.git/trash
  iff $TRASH_DIRECTORY/.git is a directory, otherwise $TRASH_DIRECTORY,
  avoid "git rev-parse --git-dir" because we may want to test it, too.
* Use test_when_finished to clean those files instead of manual "rm -f",
  also for better "-v"
* Merge multiple instance of "$@" run into one, for better auditing
* t0041 is also converted to use new helper
* With the change to location of outfile and errfile,
  output of "git ls-files -o" has been restored.
* Fix double space before "&&" in the end of test command.

1: https://lore.kernel.org/git/87r1j42ffz.fsf@evledraar.gmail.com/


Đoàn Trần Công Danh (4):
  test-lib-functions: introduce test_line_count_cmd
  t6402: use find(1) builtin to filter instead of grep
  t6400: use test_line_count_cmd to count # of lines in stdout
  t6402: use test_line_count_cmd to count # of lines in stdout

 t/t6400-merge-df.sh     |  16 ++---
 t/t6402-merge-rename.sh | 132 +++++++++++++++++++---------------------
 t/test-lib-functions.sh |  80 ++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 78 deletions(-)

Range-diff against v2:
1:  a823312b19 < -:  ---------- test-lib-functions: introduce test_line_count_cmd
-:  ---------- > 1:  255ba9b067 test-lib-functions: introduce test_line_count_cmd
2:  6e8f2d4289 = 2:  38cd3f93a0 t6402: use find(1) builtin to filter instead of grep
3:  33daa5ee2f < -:  ---------- t0041: use test_line_count_cmd to check std{out,err}
4:  729ebb8f50 ! 3:  efb0905dd3 t6400: use test_line_count_cmd to count # of lines in stdout
    @@ t/t6400-merge-df.sh: test_expect_success 'modify/delete + directory/file conflic
      
     -	test 5 -eq $(git ls-files -s | wc -l) &&
     -	test 4 -eq $(git ls-files -u | wc -l) &&
    -+	test_line_count_cmd --out = 5 git ls-files -s &&
    -+	test_line_count_cmd --out = 4 git ls-files -u &&
    ++	test_line_count_cmd = 5 git ls-files -s &&
    ++	test_line_count_cmd = 4 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 0 -eq $(git ls-files -o | wc -l)
    -+		test_line_count_cmd --out = 0 git ls-files -o
    ++		test_line_count_cmd = 0 git ls-files -o
      	else
     -		test 1 -eq $(git ls-files -o | wc -l)
    -+		test_line_count_cmd --out = 1 git ls-files -o
    ++		test_line_count_cmd = 1 git ls-files -o
      	fi &&
      
      	test_path_is_file letters/file &&
    @@ t/t6400-merge-df.sh: test_expect_success 'modify/delete + directory/file conflic
      
     -	test 5 -eq $(git ls-files -s | wc -l) &&
     -	test 4 -eq $(git ls-files -u | wc -l) &&
    -+	test_line_count_cmd --out = 5 git ls-files -s &&
    -+	test_line_count_cmd --out = 4 git ls-files -u &&
    ++	test_line_count_cmd = 5 git ls-files -s &&
    ++	test_line_count_cmd = 4 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 0 -eq $(git ls-files -o | wc -l)
    -+		test_line_count_cmd --out = 0 git ls-files -o
    ++		test_line_count_cmd = 0 git ls-files -o
      	else
     -		test 1 -eq $(git ls-files -o | wc -l)
    -+		test_line_count_cmd --out = 1 git ls-files -o
    ++		test_line_count_cmd = 1 git ls-files -o
      	fi &&
      
      	test_path_is_file letters/file &&
5:  1b450e4148 ! 4:  8fc0f3ffd2 t6402: use test_line_count_cmd to count # of lines in stdout
    @@ t/t6402-merge-rename.sh: test_expect_success 'pull renaming branch into unrenami
     -	test_line_count = 3 b.stages &&
     -	git ls-files -s N >n.stages &&
     -	test_line_count = 1 n.stages &&
    -+	test_line_count_cmd --out = 3 git ls-files -u B &&
    -+	test_line_count_cmd --out = 1 git ls-files -s N &&
    ++	test_line_count_cmd = 3 git ls-files -u B &&
    ++	test_line_count_cmd = 1 git ls-files -s N &&
      	sed -ne "/^g/{
      	p
      	q
    @@ t/t6402-merge-rename.sh: test_expect_success 'pull renaming branch into another
     -	test_line_count = 3 b.stages &&
     -	git ls-files -s N >n.stages &&
     -	test_line_count = 1 n.stages &&
    -+	test_line_count_cmd --out = 3 git ls-files -u B &&
    -+	test_line_count_cmd --out = 1 git ls-files -s N &&
    ++	test_line_count_cmd = 3 git ls-files -u B &&
    ++	test_line_count_cmd = 1 git ls-files -s N &&
      	sed -ne "/^g/{
      	p
      	q
    @@ t/t6402-merge-rename.sh: test_expect_success 'pull unrenaming branch into renami
     -	test_line_count = 3 b.stages &&
     -	git ls-files -s N >n.stages &&
     -	test_line_count = 1 n.stages &&
    -+	test_line_count_cmd --out = 3 git ls-files -u B &&
    -+	test_line_count_cmd --out = 1 git ls-files -s N &&
    ++	test_line_count_cmd = 3 git ls-files -u B &&
    ++	test_line_count_cmd = 1 git ls-files -s N &&
      	sed -ne "/^g/{
      	p
      	q
    @@ t/t6402-merge-rename.sh: test_expect_success 'pull conflicting renames' \
     -	test_line_count = 1 c.stages &&
     -	git ls-files -s N >n.stages &&
     -	test_line_count = 1 n.stages &&
    -+	test_line_count_cmd --out = 1 git ls-files -u A &&
    -+	test_line_count_cmd --out = 1 git ls-files -u B &&
    -+	test_line_count_cmd --out = 1 git ls-files -u C &&
    -+	test_line_count_cmd --out = 1 git ls-files -s N &&
    ++	test_line_count_cmd = 1 git ls-files -u A &&
    ++	test_line_count_cmd = 1 git ls-files -u B &&
    ++	test_line_count_cmd = 1 git ls-files -u C &&
    ++	test_line_count_cmd = 1 git ls-files -s N &&
      	sed -ne "/^g/{
      	p
      	q
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	test_line_count_cmd --out = 3 git ls-files -u &&
    -+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
    ++	test_line_count_cmd = 3 git ls-files -u &&
    ++	test_line_count_cmd = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Same as previous, but merged other
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	test_line_count_cmd --out = 3 git ls-files -u &&
    -+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
    ++	test_line_count_cmd = 3 git ls-files -u &&
    ++	test_line_count_cmd = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
    -+	test_line_count_cmd --out = 3 git ls-files -u &&
    -+	test_line_count_cmd --out = 3 git ls-files -u dir &&
    ++	test_line_count_cmd = 3 git ls-files -u &&
    ++	test_line_count_cmd = 3 git ls-files -u dir &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      	test_must_fail git merge --strategy=recursive dir-in-way &&
      
     -	test 5 -eq "$(git ls-files -u | wc -l)" &&
    -+	test_line_count_cmd --out = 5 git ls-files -u &&
    ++	test_line_count_cmd = 5 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
    -+		test_line_count_cmd --out = 3 git ls-files -u dir~HEAD
    ++		test_line_count_cmd = 3 git ls-files -u dir~HEAD
      	else
     -		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
     +		git ls-files -u dir >out &&
    -+		test_line_count_cmd --out = 3 grep -v file-in-the-way out
    ++		test_line_count_cmd = 3 grep -v file-in-the-way out
      	fi &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
    ++	test_line_count_cmd = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Same as previous, but merged other
      	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
      
     -	test 5 -eq "$(git ls-files -u | wc -l)" &&
    -+	test_line_count_cmd --out = 5 git ls-files -u &&
    ++	test_line_count_cmd = 5 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
    -+		test_line_count_cmd --out = 3 git ls-files -u dir~renamed-file-has-conflicts
    ++		test_line_count_cmd = 3 git ls-files -u dir~renamed-file-has-conflicts
      	else
     -		test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
     +		git ls-files -u dir >out &&
    -+		test_line_count_cmd --out = 3 grep -v file-in-the-way out
    ++		test_line_count_cmd = 3 grep -v file-in-the-way out
      	fi &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
    ++	test_line_count_cmd = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'both rename source and destination
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 2 -eq "$(git ls-files -u | wc -l)"
    -+		test_line_count_cmd --out = 2 git ls-files -u
    ++		test_line_count_cmd = 2 git ls-files -u
      	else
     -		test 1 -eq "$(git ls-files -u | wc -l)"
    -+		test_line_count_cmd --out = 1 git ls-files -u
    ++		test_line_count_cmd = 1 git ls-files -u
      	fi &&
      
      	test_must_fail git diff --quiet &&
    @@ t/t6402-merge-rename.sh: then
     -		test 4 -eq "$(git ls-files -u | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u two | wc -l)" &&
    -+		test_line_count_cmd --out = 4 git ls-files -u &&
    -+		test_line_count_cmd --out = 2 git ls-files -u one &&
    -+		test_line_count_cmd --out = 2 git ls-files -u two &&
    ++		test_line_count_cmd = 4 git ls-files -u &&
    ++		test_line_count_cmd = 2 git ls-files -u one &&
    ++		test_line_count_cmd = 2 git ls-files -u two &&
      
      		test_must_fail git diff --quiet &&
      
    @@ t/t6402-merge-rename.sh: else
     -		test 2 -eq "$(git ls-files -u | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u two | wc -l)" &&
    -+		test_line_count_cmd --out = 2 git ls-files -u &&
    -+		test_line_count_cmd --out = 1 git ls-files -u one &&
    -+		test_line_count_cmd --out = 1 git ls-files -u two &&
    ++		test_line_count_cmd = 2 git ls-files -u &&
    ++		test_line_count_cmd = 1 git ls-files -u one &&
    ++		test_line_count_cmd = 1 git ls-files -u two &&
      
      		test_must_fail git diff --quiet &&
      
    @@ t/t6402-merge-rename.sh: test_expect_success 'pair rename to parent of other (D/
     -		test 4 -eq "$(git ls-files -u | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u two | wc -l)"
    -+		test_line_count_cmd --out = 4 git ls-files -u &&
    -+		test_line_count_cmd --out = 2 git ls-files -u one &&
    -+		test_line_count_cmd --out = 2 git ls-files -u two
    ++		test_line_count_cmd = 4 git ls-files -u &&
    ++		test_line_count_cmd = 2 git ls-files -u one &&
    ++		test_line_count_cmd = 2 git ls-files -u two
      	else
     -		test 2 -eq "$(git ls-files -u | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u two | wc -l)"
    -+		test_line_count_cmd --out = 2 git ls-files -u &&
    -+		test_line_count_cmd --out = 1 git ls-files -u one &&
    -+		test_line_count_cmd --out = 1 git ls-files -u two
    ++		test_line_count_cmd = 2 git ls-files -u &&
    ++		test_line_count_cmd = 1 git ls-files -u one &&
    ++		test_line_count_cmd = 1 git ls-files -u two
      	fi &&
      
      	test_must_fail git diff --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -		test 1 -eq "$(git ls-files -u two~second-rename | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -		test 0 -eq "$(git ls-files -o | wc -l)"
    -+		test_line_count_cmd --out = 5 git ls-files -s &&
    -+		test_line_count_cmd --out = 3 git ls-files -u &&
    -+		test_line_count_cmd --out = 1 git ls-files -u one~HEAD &&
    -+		test_line_count_cmd --out = 1 git ls-files -u two~second-rename &&
    -+		test_line_count_cmd --out = 1 git ls-files -u original &&
    -+		test_line_count_cmd --out = 0 git ls-files -o
    ++		test_line_count_cmd = 5 git ls-files -s &&
    ++		test_line_count_cmd = 3 git ls-files -u &&
    ++		test_line_count_cmd = 1 git ls-files -u one~HEAD &&
    ++		test_line_count_cmd = 1 git ls-files -u two~second-rename &&
    ++		test_line_count_cmd = 1 git ls-files -u original &&
    ++		test_line_count_cmd = 0 git ls-files -o
      	else
     -		test 5 -eq "$(git ls-files -s | wc -l)" &&
     -		test 3 -eq "$(git ls-files -u | wc -l)" &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -		test 1 -eq "$(git ls-files -u two | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -		test 2 -eq "$(git ls-files -o | wc -l)"
    -+		test_line_count_cmd --out = 5 git ls-files -s &&
    -+		test_line_count_cmd --out = 3 git ls-files -u &&
    -+		test_line_count_cmd --out = 1 git ls-files -u one &&
    -+		test_line_count_cmd --out = 1 git ls-files -u two &&
    -+		test_line_count_cmd --out = 1 git ls-files -u original &&
    -+		test_line_count_cmd --out = 2 git ls-files -o
    ++		test_line_count_cmd = 5 git ls-files -s &&
    ++		test_line_count_cmd = 3 git ls-files -u &&
    ++		test_line_count_cmd = 1 git ls-files -u one &&
    ++		test_line_count_cmd = 1 git ls-files -u two &&
    ++		test_line_count_cmd = 1 git ls-files -u original &&
    ++		test_line_count_cmd = 2 git ls-files -o
      	fi &&
      
      	test_path_is_file one/file &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -	test 1 -eq "$(git ls-files -u two | wc -l)" &&
     -	test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -	test 0 -eq "$(git ls-files -o | wc -l)" &&
    -+	test_line_count_cmd --out = 3 git ls-files -u &&
    -+	test_line_count_cmd --out = 1 git ls-files -u one &&
    -+	test_line_count_cmd --out = 1 git ls-files -u two &&
    -+	test_line_count_cmd --out = 1 git ls-files -u original &&
    -+	test_line_count_cmd --out = 0 git ls-files -o &&
    ++	test_line_count_cmd = 3 git ls-files -u &&
    ++	test_line_count_cmd = 1 git ls-files -u one &&
    ++	test_line_count_cmd = 1 git ls-files -u two &&
    ++	test_line_count_cmd = 1 git ls-files -u original &&
    ++	test_line_count_cmd = 0 git ls-files -o &&
      
      	test_path_is_file one &&
      	test_path_is_file two &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'setup merge of rename + small chan
      
     -	test 1 -eq $(git ls-files -s | wc -l) &&
     -	test 0 -eq $(git ls-files -o | wc -l) &&
    -+	test_line_count_cmd --out = 1 git ls-files -s &&
    -+	test_line_count_cmd --out = 0 git ls-files -o &&
    ++	test_line_count_cmd = 1 git ls-files -s &&
    ++	test_line_count_cmd = 0 git ls-files -o &&
      	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
      '
      
-- 
2.32.0.278.gd42b80f139

