Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5AF1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408039AbfJWXca (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:32:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38511 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408036AbfJWXca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:32:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so13041977pgt.5
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lk9rbtacKOjoMtiz228I4j8lZNuDQ72bK9JeYsmBwag=;
        b=IsBdYc7+F33v6sfQ1ewwE6Ex66/kSjA2JzQkvmG+aflbvWB5WUoEV32M1aw3gf4TpX
         nM6iBic7H0aPZ93sABQweLSDzCuW9tCmVbLm86AaoA9RMsKneVGnbaosBUwk99dvqGku
         Qn7RQ2HRPghq07L02ALFtNulciAxKXz36JEC1GHnWLGaq+E8utUNnJPjbxr/YCQWomIU
         KRAR9WgZAmA9EPBUcjOsOVw37rxpLENLVDV9/AOKHL99cPyeebHwXK8a/NdAgVvl69tP
         /VYMqY1kwaYZUTp5Ziyu5StMTrVDrHfB5JUhApzaJykQrVckk3R+8KdgNTuFHvkwmTGb
         NlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lk9rbtacKOjoMtiz228I4j8lZNuDQ72bK9JeYsmBwag=;
        b=tOzoX5GgmdcwiexkxASMw9ILTQk19MpF+OuGP9gFJUT81BZdYuxRDpZ9ltqw/Oq4TW
         zhy3IRuFHu1nFOGX8/4xrTAEzkiCpMztYQbc2wuz7XtylCU+WgtO4s8pYZXPfPNalMcB
         JuwWehYMn+P6NGrukzIv4pYfSDMpvKj8Cx4YOh5dNMnnu3kFvmie4DHT0UM7Trn5ndHE
         s4gZFg730x3phBFRV88QrMZ2eh7raqrUzke3X7PVIlpR6S6uAXh+FjXkxo/ZX9Jqy7T3
         m/V6V6DuGi5KA4PBe3U9OdcOhU/JL3wUg/Kcy6CeR+DFfA/xicwxILAAPeWHAnghy6yG
         RA7w==
X-Gm-Message-State: APjAAAUEmHaaZ5pftPHqAGSOYF+u1yvsbxHiRnrIlscSAZzivi4EmTgu
        4C6Owf98V7bB3bbyiZg/jIjRTYmw
X-Google-Smtp-Source: APXvYqzanX72csJnlkAkM0UO62IzNbi6YxHAxOjRWK52b0zkjphvnCAspEwuuV6HLiNZTf+vzRHYeA==
X-Received: by 2002:a63:d65:: with SMTP id 37mr13142917pgn.386.1571873548549;
        Wed, 23 Oct 2019 16:32:28 -0700 (PDT)
Received: from generichostname ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id a11sm23393624pgw.64.2019.10.23.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:32:27 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:32:25 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] This fixes a bug where even if `merge.conflictStyle =
 diff3`, running `git apply --3way` would not output the base.
Message-ID: <cover.1571873435.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571832176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches 1-3 are general cleanup for t4108, 4 demonstrates the bug and 5
actually fixes it.

Changes since v1:

* Pretty up 4/5 using Eric's suggestion

* Rename print_sanitized_diff() to print_santized_conflicted_diff()

Denton Liu (5):
  t4108: replace create_file with test_write_lines
  t4108: remove git command upstream of pipe
  t4108: use `test_config` instead of `git config`
  t4108: demonstrate bug in apply
  apply: respect merge.conflictStyle in --3way

 apply.c                   |  2 +-
 t/t4108-apply-threeway.sh | 55 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 27 deletions(-)

Range-diff against v1:
1:  9d915748c1 ! 1:  fd1b770c0c t4108: remove git command upstream of pipe
    @@ Commit message
     
         Since only the command `git diff HEAD` was being piped to
         sanitize_conflicted_diff(), move the command into the function and rename
    -    it to print_sanitized_diff().
    +    it to print_sanitized_conflicted_diff().
     
      ## t/t4108-apply-threeway.sh ##
     @@ t/t4108-apply-threeway.sh: test_description='git apply --3way'
    @@ t/t4108-apply-threeway.sh: test_description='git apply --3way'
      . ./test-lib.sh
      
     -sanitize_conflicted_diff () {
    -+print_sanitized_diff () {
    ++print_sanitized_conflicted_diff () {
     +	git diff HEAD >diff.raw &&
      	sed -e '
      		/^index /d
    @@ t/t4108-apply-threeway.sh: test_expect_success 'apply with --3way' '
      	test_must_fail git merge --no-commit side &&
      	git ls-files -s >expect.ls &&
     -	git diff HEAD | sanitize_conflicted_diff >expect.diff &&
    -+	print_sanitized_diff >expect.diff &&
    ++	print_sanitized_conflicted_diff >expect.diff &&
      
      	# should fail to apply
      	git reset --hard &&
    @@ t/t4108-apply-threeway.sh: test_expect_success 'apply with --3way' '
      	test_must_fail git apply --index --3way P.diff &&
      	git ls-files -s >actual.ls &&
     -	git diff HEAD | sanitize_conflicted_diff >actual.diff &&
    -+	print_sanitized_diff >actual.diff &&
    ++	print_sanitized_conflicted_diff >actual.diff &&
      
      	# The result should resemble the corresponding merge
      	test_cmp expect.ls actual.ls &&
    @@ t/t4108-apply-threeway.sh: test_expect_success 'apply -3 with add/add conflict s
      	test_must_fail git merge --no-commit another &&
      	git ls-files -s >expect.ls &&
     -	git diff HEAD | sanitize_conflicted_diff >expect.diff
    -+	print_sanitized_diff >expect.diff
    ++	print_sanitized_conflicted_diff >expect.diff
      '
      
      test_expect_success 'apply -3 with add/add conflict' '
    @@ t/t4108-apply-threeway.sh: test_expect_success 'apply -3 with add/add conflict'
      	# ... and leave conflicts in the index and in the working tree
      	git ls-files -s >actual.ls &&
     -	git diff HEAD | sanitize_conflicted_diff >actual.diff &&
    -+	print_sanitized_diff >actual.diff &&
    ++	print_sanitized_conflicted_diff >actual.diff &&
      
      	# The result should resemble the corresponding merge
      	test_cmp expect.ls actual.ls &&
2:  d77c5f4199 = 2:  43c42b299e t4108: use `test_config` instead of `git config`
3:  5feddf1597 < -:  ---------- t4108: demonstrate bug in apply
-:  ---------- > 3:  58d32e2618 t4108: demonstrate bug in apply
4:  56c31310db ! 4:  5412dc9153 apply: respect merge.conflictStyle in --3way
    @@ apply.c: static void git_apply_config(void)
      static int parse_whitespace_option(struct apply_state *state, const char *option)
     
      ## t/t4108-apply-threeway.sh ##
    -@@ t/t4108-apply-threeway.sh: test_apply_with_3way () {
    - }
    +@@ t/t4108-apply-threeway.sh: test_expect_success 'apply with --3way' '
    + 	test_apply_with_3way
    + '
      
    - test_apply_with_3way success default true
    --test_apply_with_3way failure 'merge.conflictStyle = diff3' 'test_config merge.conflictStyle diff3'
    -+test_apply_with_3way success 'merge.conflictStyle = diff3' 'test_config merge.conflictStyle diff3'
    - 
    - test_expect_success 'apply with --3way with rerere enabled' '
    - 	test_config rerere.enabled true &&
    +-test_expect_failure 'apply with --3way with merge.conflictStyle = diff3' '
    ++test_expect_success 'apply with --3way with merge.conflictStyle = diff3' '
    + 	test_config merge.conflictStyle diff3 &&
    + 	test_apply_with_3way
    + '
-- 
2.24.0.rc0.197.g0926ab8072

