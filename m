Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6873FC433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B46764DD1
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBNHfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhBNHfo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:35:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DECC061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:35:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u5so727070wmj.0
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=EC45s3A+bVTCFVIorZTnKCgxYM3vhM0cTGWAAiTnaQQ=;
        b=V1HXdGpOcgH0289BtQ0pK1aStuvlE7xFRoy9aDPHX9EoKNuKcNAski3GaMIeF7lDsV
         pMW6JTNmypSspm+8wBaLx4PtI8bmv5Pv8Pcu7eaw3lnUQY4BbRvHGEvOHmAFR5d22OJC
         KuUj8WisMD3yli17Iv9QUikiOie3uPWIoWPtz4/65jvgvu4GfLu99i1hJZs6mR+Fe8F0
         PSbXa4QVIOIoPpIIsENnjd0Ttq/9OT6JEzroJZ7gt4fFYZmfaewrYNxd7VKa+sHRLzFu
         IWl0CBczdNCKRdUffahUe7S1LaVe0QNi4o4Z7JQ/9/djSz204zxtL7cb6N9agNen9pN/
         wSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=EC45s3A+bVTCFVIorZTnKCgxYM3vhM0cTGWAAiTnaQQ=;
        b=ME0qkuEteUgtcbcqv/o6G/SiOIhwmt/0baYXIMQamtUh0EfmPcnkk7yzbRqHk29RUg
         Dj0tUQPX1XAQKBE0QtTQBZISoIxcEWUDE8nzh1ieXf3S2k5XdiJ8i7eH2zUyYFdlloqo
         KKDFB9Ji8+GVMlEYiZHxMikPv0HERrZOiVhj79yQ11/9JQAC18gHJ+RUrr5nDJ4cNNzT
         ympB9z5s/4JFdvxgtp+07l8rsKmn/FIdGzV4pHqMNvwPHSjrq/Vs7gDYGk8YVAcbVzCU
         Fmpp+y6GUX0l9HvJV5FS/xCcaNMgzvnruWXLqhORFt6mOMngTcBKClR++C3VGYaL3pT7
         OjBg==
X-Gm-Message-State: AOAM533PbhCH03fIuvlvfqSlUJBVAUkwriNBE8MaP62RLJptVpZ4Uv12
        fN8RPuhR3yHcBCg5qvEyoulC/w9banQ=
X-Google-Smtp-Source: ABdhPJyn29toBXcMUsWNlvfyMkc3Ww7BF1NbWTToBrprN42wp4BTGViw5NYZ6UC0AWVyQSQ7L72Pgw==
X-Received: by 2002:a1c:4e13:: with SMTP id g19mr9310752wmh.55.1613288103017;
        Sat, 13 Feb 2021 23:35:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm17349402wmq.26.2021.02.13.23.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:35:02 -0800 (PST)
Message-Id: <pull.842.v3.git.1613288101.gitgitgadget@gmail.com>
In-Reply-To: <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
References: <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:34:59 +0000
Subject: [PATCH v3 0/2] Optimization batch 6: make full use of exact renames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes full use of exact renames; removing not only a destination
pair, but a source pair as well when an exact rename is found and copy
detection is not turned on.

Changes since v2:

 * Fix a comment typo, and fix a multi-line comment that didn't need to be a
   multi-line comment

Elijah Newren (2):
  diffcore-rename: no point trying to find a match better than exact
  diffcore-rename: filter rename_src list when possible

 diffcore-rename.c | 71 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 10 deletions(-)


base-commit: f0117958910fbc734457a83a9f8ecc3c62463417
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-842%2Fnewren%2Fort-perf-batch-6-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-842/newren/ort-perf-batch-6-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/842

Range-diff vs v2:

 1:  770e894b4abd = 1:  a59c1960f614 diffcore-rename: no point trying to find a match better than exact
 2:  7ae9460d3dba ! 2:  dd6595b45640 diffcore-rename: filter rename_src list when possible
     @@ diffcore-rename.c: static int find_renames(struct diff_score *mx, int dst_cnt, i
      +	if (detecting_copies)
      +		return; /* nothing to remove */
      +	if (break_idx)
     -+		return; /* culling incompatbile with break detection */
     ++		return; /* culling incompatible with break detection */
      +
      +	/*
      +	 * Note on reasons why we cull unneeded sources but not destinations:
     @@ diffcore-rename.c: static int find_renames(struct diff_score *mx, int dst_cnt, i
       {
       	int detect_rename = options->detect_rename;
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     + 	if (minimum_score == MAX_SCORE)
       		goto cleanup;
       
     - 	/*
     +-	/*
      -	 * Calculate how many renames are left (but all the source
      -	 * files still remain as options for rename/copies!)
     -+	 * Calculate how many renames are left
     - 	 */
     +-	 */
     ++	/* Calculate how many renames are left */
       	num_destinations = (rename_dst_nr - rename_count);
      +	remove_unneeded_paths_from_src(want_copies);
       	num_sources = rename_src_nr;

-- 
gitgitgadget
