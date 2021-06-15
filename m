Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290C4C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146E461420
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhFORXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhFORW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:22:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA4C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:20:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l184so12025803pgd.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfnxfAYYnAKKQBsh0dfSDCQwT7npbu2l7lH66xRg40Q=;
        b=WjWb9/Sii3wJyY8nMVJB5migSiK3fwWZ3FMuM4EdXethlxqjxjXWWZRlblA/DIpuVc
         qLa+ipmUYL9RySJLFwaecqpo2mH6gh6K9TOxZCn3RufnXfY1Pdrj/l7XZJlAqDJp/Bvh
         MjZJwl767LOqBLsL++1F7Z9vR0TAwzbyX7+DKBr1LMET5hIxW2Pl5xvpJ/fq51gJ3YCQ
         1pnWqXV2Hsz4cPDQcLBQw0DOUhcyuTHPcT1v45o/O2f4D52R19VYYzYW0vTEEOVFRY20
         slSpfudUbSUyiHGIUlDe4NE0m/kY5O3d7//B7xwjXnHKqiplAoIUL8yniQbn9WxKZ3zk
         x6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfnxfAYYnAKKQBsh0dfSDCQwT7npbu2l7lH66xRg40Q=;
        b=n2IIJw0qQes9Xqqn1snZ6CFxktHOVA/3J64HFNpTrQ7zqGs4hxnNJKrkemx+iRV19d
         pwjJavYX9WEOJE14ygZkvsPDR6+JJcP2rvVvB06/DLHy5N97JVmWS1tKxEED5DLLU0I2
         2gQWxkx+cF9EtHV2RHkf6TYK2BBT1kcl8QFm5K/CJyop36iKM8j++kIHXsfeNw7kEn2H
         sFRGmyvkPFiayvhhPmy6jiIyYhko1bslb66N3CFj/zq+VEnin/hthhtarph1QnAq5lfu
         UBIt3C73+D03wb5tnQQAz7g/M3awE6gVlcru8e2TGSdTF3+XiGUsrXMfDrbPyfu8EruN
         RKhQ==
X-Gm-Message-State: AOAM5314104aw4UjG0NGAUz7kdM1ggdFELbrVJCWx0eNnBAPZEs/8p8O
        k//wS5iDBI5BTbQAmpGbpAwRqwEd1HY=
X-Google-Smtp-Source: ABdhPJzgsu8Uy2YAIo847ugGVZRf7EBLxBzmOKlVXE/PnEiQUQKICJTMEqFl2uaEurBD62KBQV8bAg==
X-Received: by 2002:aa7:9581:0:b029:2ea:39e:2224 with SMTP id z1-20020aa795810000b02902ea039e2224mr5521926pfj.32.1623777653510;
        Tue, 15 Jun 2021 10:20:53 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id z22sm16864162pfa.157.2021.06.15.10.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:20:52 -0700 (PDT)
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
Subject: [PATCH v2 0/5] t: new helper test_line_count_cmd
Date:   Wed, 16 Jun 2021 00:20:33 +0700
Message-Id: <20210615172038.28917-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series to clear false positive when applying Junio's suggestion to
to a series written by Ævar [1].

Change since v1:
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

Đoàn Trần Công Danh (5):
  test-lib-functions: introduce test_line_count_cmd
  t6402: use find(1) builtin to filter instead of grep
  t0041: use test_line_count_cmd to check std{out,err}
  t6400: use test_line_count_cmd to count # of lines in stdout
  t6402: use test_line_count_cmd to count # of lines in stdout

 t/t0041-usage.sh        |  53 ++++++----------
 t/t6400-merge-df.sh     |  16 ++---
 t/t6402-merge-rename.sh | 132 +++++++++++++++++++---------------------
 t/test-lib-functions.sh | 117 +++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 114 deletions(-)

Range-diff against v1:
1:  bdce5e51ff < -:  ---------- test-lib-functions: introduce test_line_count_cmd
-:  ---------- > 1:  a823312b19 test-lib-functions: introduce test_line_count_cmd
2:  09a440ed25 = 2:  6e8f2d4289 t6402: use find(1) builtin to filter instead of grep
-:  ---------- > 3:  33daa5ee2f t0041: use test_line_count_cmd to check std{out,err}
3:  98a335a442 ! 4:  729ebb8f50 t6400: use test_line_count_cmd to count # of lines in stdout
    @@ t/t6400-merge-df.sh: test_expect_success 'modify/delete + directory/file conflic
     -	test 5 -eq $(git ls-files -s | wc -l) &&
     -	test 4 -eq $(git ls-files -u | wc -l) &&
     +	test_line_count_cmd --out = 5 git ls-files -s &&
    -+	test_line_count_cmd --out = 4 git ls-files -u  &&
    ++	test_line_count_cmd --out = 4 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 0 -eq $(git ls-files -o | wc -l)
    -+		test_line_count_cmd --out = 2 git ls-files -o
    ++		test_line_count_cmd --out = 0 git ls-files -o
      	else
     -		test 1 -eq $(git ls-files -o | wc -l)
    -+		test_line_count_cmd --out = 3 git ls-files -o
    ++		test_line_count_cmd --out = 1 git ls-files -o
      	fi &&
      
      	test_path_is_file letters/file &&
    @@ t/t6400-merge-df.sh: test_expect_success 'modify/delete + directory/file conflic
      
     -	test 5 -eq $(git ls-files -s | wc -l) &&
     -	test 4 -eq $(git ls-files -u | wc -l) &&
    -+	test_line_count_cmd --out = 5 git ls-files -s  &&
    -+	test_line_count_cmd --out = 4 git ls-files -u  &&
    ++	test_line_count_cmd --out = 5 git ls-files -s &&
    ++	test_line_count_cmd --out = 4 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 0 -eq $(git ls-files -o | wc -l)
    -+		test_line_count_cmd --out = 2 git ls-files -o
    ++		test_line_count_cmd --out = 0 git ls-files -o
      	else
     -		test 1 -eq $(git ls-files -o | wc -l)
    -+		test_line_count_cmd --out = 3 git ls-files -o
    ++		test_line_count_cmd --out = 1 git ls-files -o
      	fi &&
      
      	test_path_is_file letters/file &&
4:  69e4a0b6d7 ! 5:  1b450e4148 t6402: use test_line_count_cmd to count # of lines in stdout
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	test_line_count_cmd --out = 3 git ls-files -u  &&
    -+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way  &&
    ++	test_line_count_cmd --out = 3 git ls-files -u &&
    ++	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Same as previous, but merged other
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	test_line_count_cmd --out = 3 git ls-files -u  &&
    -+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way  &&
    ++	test_line_count_cmd --out = 3 git ls-files -u &&
    ++	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      
     -	test 3 -eq "$(git ls-files -u | wc -l)" &&
     -	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
    -+	test_line_count_cmd --out = 3 git ls-files -u  &&
    -+	test_line_count_cmd --out = 3 git ls-files -u dir  &&
    ++	test_line_count_cmd --out = 3 git ls-files -u &&
    ++	test_line_count_cmd --out = 3 git ls-files -u dir &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
      	test_must_fail git merge --strategy=recursive dir-in-way &&
      
     -	test 5 -eq "$(git ls-files -u | wc -l)" &&
    -+	test_line_count_cmd --out = 5 git ls-files -u  &&
    ++	test_line_count_cmd --out = 5 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
    @@ t/t6402-merge-rename.sh: test_expect_success 'Rename+D/F conflict; renamed file
     +		test_line_count_cmd --out = 3 grep -v file-in-the-way out
      	fi &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way  &&
    ++	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'Same as previous, but merged other
      	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
      
     -	test 5 -eq "$(git ls-files -u | wc -l)" &&
    -+	test_line_count_cmd --out = 5 git ls-files -u  &&
    ++	test_line_count_cmd --out = 5 git ls-files -u &&
      	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
      	then
     -		test 3 -eq "$(git ls-files -u dir~renamed-file-has-conflicts | wc -l)"
    @@ t/t6402-merge-rename.sh: test_expect_success 'Same as previous, but merged other
     +		test_line_count_cmd --out = 3 grep -v file-in-the-way out
      	fi &&
     -	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
    -+	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way  &&
    ++	test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way &&
      
      	test_must_fail git diff --quiet &&
      	test_must_fail git diff --cached --quiet &&
    @@ t/t6402-merge-rename.sh: then
     -		test 4 -eq "$(git ls-files -u | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u two | wc -l)" &&
    -+		test_line_count_cmd --out = 4 git ls-files -u  &&
    -+		test_line_count_cmd --out = 2 git ls-files -u one  &&
    -+		test_line_count_cmd --out = 2 git ls-files -u two  &&
    ++		test_line_count_cmd --out = 4 git ls-files -u &&
    ++		test_line_count_cmd --out = 2 git ls-files -u one &&
    ++		test_line_count_cmd --out = 2 git ls-files -u two &&
      
      		test_must_fail git diff --quiet &&
      
    @@ t/t6402-merge-rename.sh: else
     -		test 2 -eq "$(git ls-files -u | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u two | wc -l)" &&
    -+		test_line_count_cmd --out = 2 git ls-files -u  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u one  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u two  &&
    ++		test_line_count_cmd --out = 2 git ls-files -u &&
    ++		test_line_count_cmd --out = 1 git ls-files -u one &&
    ++		test_line_count_cmd --out = 1 git ls-files -u two &&
      
      		test_must_fail git diff --quiet &&
      
    @@ t/t6402-merge-rename.sh: test_expect_success 'pair rename to parent of other (D/
     -		test 4 -eq "$(git ls-files -u | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 2 -eq "$(git ls-files -u two | wc -l)"
    -+		test_line_count_cmd --out = 4 git ls-files -u  &&
    -+		test_line_count_cmd --out = 2 git ls-files -u one  &&
    ++		test_line_count_cmd --out = 4 git ls-files -u &&
    ++		test_line_count_cmd --out = 2 git ls-files -u one &&
     +		test_line_count_cmd --out = 2 git ls-files -u two
      	else
     -		test 2 -eq "$(git ls-files -u | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u one | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u two | wc -l)"
    -+		test_line_count_cmd --out = 2 git ls-files -u  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u one  &&
    ++		test_line_count_cmd --out = 2 git ls-files -u &&
    ++		test_line_count_cmd --out = 1 git ls-files -u one &&
     +		test_line_count_cmd --out = 1 git ls-files -u two
      	fi &&
      
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -		test 1 -eq "$(git ls-files -u two~second-rename | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -		test 0 -eq "$(git ls-files -o | wc -l)"
    -+		test_line_count_cmd --out = 5 git ls-files -s  &&
    -+		test_line_count_cmd --out = 3 git ls-files -u  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u one~HEAD  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u two~second-rename  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u original  &&
    -+		test_line_count_cmd --out = 2 git ls-files -o
    ++		test_line_count_cmd --out = 5 git ls-files -s &&
    ++		test_line_count_cmd --out = 3 git ls-files -u &&
    ++		test_line_count_cmd --out = 1 git ls-files -u one~HEAD &&
    ++		test_line_count_cmd --out = 1 git ls-files -u two~second-rename &&
    ++		test_line_count_cmd --out = 1 git ls-files -u original &&
    ++		test_line_count_cmd --out = 0 git ls-files -o
      	else
     -		test 5 -eq "$(git ls-files -s | wc -l)" &&
     -		test 3 -eq "$(git ls-files -u | wc -l)" &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -		test 1 -eq "$(git ls-files -u two | wc -l)" &&
     -		test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -		test 2 -eq "$(git ls-files -o | wc -l)"
    -+		test_line_count_cmd --out = 5 git ls-files -s  &&
    -+		test_line_count_cmd --out = 3 git ls-files -u  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u one  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u two  &&
    -+		test_line_count_cmd --out = 1 git ls-files -u original  &&
    -+		test_line_count_cmd --out = 4 git ls-files -o
    ++		test_line_count_cmd --out = 5 git ls-files -s &&
    ++		test_line_count_cmd --out = 3 git ls-files -u &&
    ++		test_line_count_cmd --out = 1 git ls-files -u one &&
    ++		test_line_count_cmd --out = 1 git ls-files -u two &&
    ++		test_line_count_cmd --out = 1 git ls-files -u original &&
    ++		test_line_count_cmd --out = 2 git ls-files -o
      	fi &&
      
      	test_path_is_file one/file &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'check handling of differently rena
     -	test 1 -eq "$(git ls-files -u two | wc -l)" &&
     -	test 1 -eq "$(git ls-files -u original | wc -l)" &&
     -	test 0 -eq "$(git ls-files -o | wc -l)" &&
    -+	test_line_count_cmd --out = 3 git ls-files -u  &&
    -+	test_line_count_cmd --out = 1 git ls-files -u one  &&
    -+	test_line_count_cmd --out = 1 git ls-files -u two  &&
    -+	test_line_count_cmd --out = 1 git ls-files -u original  &&
    -+	test_line_count_cmd --out = 2 git ls-files -o  &&
    ++	test_line_count_cmd --out = 3 git ls-files -u &&
    ++	test_line_count_cmd --out = 1 git ls-files -u one &&
    ++	test_line_count_cmd --out = 1 git ls-files -u two &&
    ++	test_line_count_cmd --out = 1 git ls-files -u original &&
    ++	test_line_count_cmd --out = 0 git ls-files -o &&
      
      	test_path_is_file one &&
      	test_path_is_file two &&
    @@ t/t6402-merge-rename.sh: test_expect_success 'setup merge of rename + small chan
      
     -	test 1 -eq $(git ls-files -s | wc -l) &&
     -	test 0 -eq $(git ls-files -o | wc -l) &&
    -+	test_line_count_cmd --out = 1 git ls-files -s  &&
    -+	test_line_count_cmd --out = 2 git ls-files -o  &&
    ++	test_line_count_cmd --out = 1 git ls-files -s &&
    ++	test_line_count_cmd --out = 0 git ls-files -o &&
      	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
      '
      
-- 
2.32.0.278.gd42b80f139

