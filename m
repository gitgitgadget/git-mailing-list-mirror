Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07E9C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 01:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0F322B2B
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 01:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgLVBMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 20:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 20:12:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93BAC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 17:11:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a12so12897452wrv.8
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 17:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CXDW6VeU/LpWCXGMJ5yDTsJaWg7BXkQFnWYY/qJmBQc=;
        b=GgrcsY5Kqw2+dUSW5i3ZOgwZFwCYRgYXr67iMODHNL04RdpOJnSOo5+LVjf/PfLLsb
         IbzgIjzvlBTzVz5nVhpOHCBTgSzcHEC5yAqR45i4AVfYDp7P8XxS9qJEZMLr7wR8//7s
         9MX+V/0ge+GDAFa2wDVPFdovK6Xyfwlexx5O2jVIwxTePMaBynjBn2kD6Z26PYRv4VPW
         t95oOkXs1/3AjEAHZm8OWR7UHmKS0qmjaG/X8PXZnzL02ED4XjFnPFWAPKdAL37EhOKD
         XKHmPhFccIoId91LMYqv6jg3pnOaxYLuSnBFmCbuXeuP2dXWf7uMG6RvHZh/+jBj+KxR
         MvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CXDW6VeU/LpWCXGMJ5yDTsJaWg7BXkQFnWYY/qJmBQc=;
        b=WF+ej9H07K7gSaybeB5qqyvI7MLPxFdiiyCSWi1XE/8Y7ANbOltco+Z7wnBFJhSLmz
         9IlQjy09SDM6bd4jxgKK7GVJrfcq+p+5UFUoZs589sebqarDWUxXdDz0KcBxeWxL9ZwD
         2Tf2PoDEfkBhQKcFs2WgkBZBYRgqR9feb+NNwkuQqr+kk+vPE8hLoMwW/YQIoXNzGiZ/
         EY5aqsdJ9qF3Ta2I3B1gw735K8WlgY9er8zeQe4PllI65+2l2+/aFJTgzU6J2OmH/4nS
         tsEy1qdb4wE22PO9KwSRQczeuIZ+mNQ8lhd349rjcPV+NZoqfH5iv+4+ZUg6Y3WkhT4B
         6aLA==
X-Gm-Message-State: AOAM531t4MJknKgiDGBRJimeDNiQftWl4c5o/h1FE2llwEg7f++z4cl3
        Mvg2u3ZVrj0KRsoNBQxUoCQ2dTCSBqI=
X-Google-Smtp-Source: ABdhPJyiFccHfSvlCtdttQ8/keasFTb5f4wK86Vl1/dXrpQnfr0t61f6SCUFUL0pDvhr4CaOixcA5g==
X-Received: by 2002:a5d:470d:: with SMTP id y13mr21335426wrq.309.1608599515083;
        Mon, 21 Dec 2020 17:11:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8sm25132829wmc.27.2020.12.21.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 17:11:54 -0800 (PST)
Message-Id: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
References: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 01:11:51 +0000
Subject: [PATCH v4 0/2] negative-refspec: fix segfault on : refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If remote.origin.push was set to ":", git segfaults during a push operation,
due to bad parsing logic in query_matches_negative_refspec. Per bisect, the
bug was introduced in: c0192df630 (refspec: add support for negative
refspecs, 2020-09-30)

We found this issue when rolling out git 2.29 at Dropbox - as several folks
had "push = :" in their configuration. I based my diff off the master
branch, but also confirmed that it patches cleanly onto maint - if the
maintainers would like to also fix the segfault on 2.29

Update since Patch series V1:

 * Handled matching refspec explicitly
 * Added testing for "+:" case
 * Added comment explaining how the two loops work together

Update since Patch series V2

 * style suggestion in remote.c
 * Use test_config
 * Add test for a case with a matching refspec + negative refspec
 * Fix test_config to work with --add
 * Updated commit message to describe what git is told to do instead of
   segfaulting

Update since Patch series V3

 * Removed commit modifying test_config
 * Remove segfault-related comments in test
 * Consolidate the three tests to two tests (1st and 3rd test overlapped in
   functionality)
 * Base the patch series on the maint branch - since the bug affects 2.29.2

Appreciate the reviews from Junio and Eric! Happy Holidays!

Nipunn Koorapati (2):
  negative-refspec: fix segfault on : refspec
  negative-refspec: improve comment on query_matches_negative_refspec

 remote.c                          | 16 +++++++++++++---
 t/t5582-fetch-negative-refspec.sh | 24 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)


base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-820%2Fnipunn1313%2Fnk%2Fpush-refspec-segfault-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-820/nipunn1313/nk/push-refspec-segfault-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/820

Range-diff vs v3:

 1:  733c674bd19 < -:  ----------- test-lib-functions: handle --add in test_config
 2:  20cff2f5c59 ! 1:  e59ff29bdef negative-refspec: fix segfault on : refspec
     @@ Commit message
          (refspec: add support for negative refspecs, 2020-09-30) looks at
          refspec->src assuming it is never NULL, however when
          remote.origin.push is set to ":", then refspec->src is NULL,
     -    causing a segfault within strcmp
     +    causing a segfault within strcmp.
      
          Tell git to handle matching refspec by adding the needle to the
          set of positively matched refspecs, since matching ":" refspecs
          match anything as src.
      
     -    Added testing for matching refspec pushes fetch-negative-refspec
     -    both individually and in combination with a negative refspec
     +    Add test for matching refspec pushes fetch-negative-refspec
     +    both individually and in combination with a negative refspec.
      
          Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
      
     @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "fetch --prune with negat
       	)
       '
       
     -+test_expect_success "push with matching ':' refspec" '
     ++test_expect_success "push with matching : and negative refspec" '
      +	test_config -C two remote.one.push : &&
     -+	# Fails w/ tip behind counterpart - but should not segfault
     -+	test_must_fail git -C two push one
     -+'
     ++	# Fails to push master w/ tip behind counterpart
     ++	test_must_fail git -C two push one &&
      +
     -+test_expect_success "push with matching '+:' refspec" '
     -+	test_config -C two remote.one.push +: &&
     -+	# Fails w/ tip behind counterpart - but should not segfault
     -+	test_must_fail git -C two push one
     ++	# If master is in negative refspec, then the command will not attempt
     ++	# to push and succeed.
     ++	# We do not need test_config here as we are updating remote.one.push
     ++	# again. The teardown of the first test_config will do --unset-all
     ++	git -C two config --add remote.one.push ^refs/heads/master &&
     ++	git -C two push one
      +'
      +
     -+test_expect_success "push with matching and negative refspec" '
     -+	test_config -C two --add remote.one.push : &&
     ++test_expect_success "push with matching +: and negative refspec" '
     ++	test_config -C two remote.one.push +: &&
      +	# Fails to push master w/ tip behind counterpart
      +	test_must_fail git -C two push one &&
      +
     -+	# If master is in negative refspec, then the command will succeed
     -+	test_config -C two --add remote.one.push ^refs/heads/master &&
     ++	# If master is in negative refspec, then the command will not attempt
     ++	# to push and succeed
     ++	git -C two config --add remote.one.push ^refs/heads/master &&
      +	git -C two push one
      +'
      +
 3:  0fd4e9f7459 = 2:  20575407cc0 negative-refspec: improve comment on query_matches_negative_refspec

-- 
gitgitgadget
