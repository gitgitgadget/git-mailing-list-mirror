Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECF9C07EBC
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A76F2253A
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404938AbhASOvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392973AbhASNAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 08:00:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A294C0613C1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 04:52:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m4so19603545wrx.9
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qj2HTVCHS3x4UjWFcvRSVa8mj9lV5r6InqCbMi7a2Ck=;
        b=VnWUlD1H721Mq+GMzEJxYXoTM//PIIq6qTJzh3H2w+xgOa5CPyl69eY+CmmJnXVfqY
         2a3j7mNQ2tmiki4GTWRTMP+hCW315F3yLD6+O/HZVeI5uAJxpJSS3ZeA2r32dSjD1HdW
         GVqUssjDtffpJpraU14QSCGSpEJyS0zGM4Laygx2CJjfXVwlO2QO2rAvSiVLpLX15TBr
         WMOdM8tuMIKpaab2iL/TcO8lkIwfky2BK/DFh+jRdurWNRVPSSWA/sLXP1Eg8m4/B3EJ
         ixgX3X1lmIvrLM7wiA7jG+Rqu+WSPoLKEv2UDbgPRlvxB48k9QZWGRhgN5y1FaGCS7z2
         q50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qj2HTVCHS3x4UjWFcvRSVa8mj9lV5r6InqCbMi7a2Ck=;
        b=YLfSy0OB5r4fMFNsSoVvYwERX378FCxZ5vpR8EoDYcUEo2oFCn6EcDOvRMkMegevgb
         J5jnI6tS1zifQ/IlHt7uz6HoPvxHQkc9lBwbP8hTqFrK6tyfxFDJF6Qu3OXnLLJS+20W
         YDhWoQf2AXBdh0+OQhW/rXRxYQZt3+gMkbRJzvPkpwnG94Xxe7GnYHczw7GAkU+k/c1y
         ipa4mXAdxwUpmCEJp0pIMxbtsmahfmTqnDE8/QdOT41gFVwirKMx/IpD0OOgvFtfIANz
         9+245r0mwNw2hqYv/V2rZP3sVMR64SXU9stAC8xZRm0pi1GwyOIoavzuf/azyd+bqfn0
         tfNA==
X-Gm-Message-State: AOAM531RK+MwYncNDYYUH9ZyutjHES6GdHcFTHsmGVa0kGRtpRPBBy+n
        r0mH3gdQli/cmogdIdXLcmgqsqvUaX8=
X-Google-Smtp-Source: ABdhPJwUzJCPQ/NUZj/Kg6m7mdIA6kmuvS0sXEiV4A5uYesRQ2O8e210lS7i6zt/U+RgSmSuzwU2xg==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr4157214wru.43.1611060726044;
        Tue, 19 Jan 2021 04:52:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm3995535wmq.45.2021.01.19.04.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:52:05 -0800 (PST)
Message-Id: <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
In-Reply-To: <pull.838.git.1610940216.gitgitgadget@gmail.com>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 12:52:02 +0000
Subject: [PATCH v2 0/2] Two cleanups around 'prefetch' refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a couple things that caught my eye during a recent evaluation of
the maintenance feature:

 1. 'refs/prefetch/' refs show up in 'git log' decorations. Auto-hide these.
 2. t7900-maintenance.sh had some scary warnings that end up being
    unimportant.

This is based on 'master' at 66e871b (The third batch, 2021-01-15).

Update in v2: deleting refs more safely for alternate ref backends. (Thanks,
Taylor!)

Thanks, -Stolee

Derrick Stolee (2):
  maintenance: set log.excludeDecoration durin prefetch
  t7900: clean up some broken refs

 builtin/gc.c           |  6 ++++++
 t/t7900-maintenance.sh | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)


base-commit: 66e871b6647ffea61a77a0f82c7ef3415f1ee79c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-838%2Fderrickstolee%2Fprefetch-refs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-838/derrickstolee/prefetch-refs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/838

Range-diff vs v1:

 1:  5b2ce9049a6 = 1:  5b2ce9049a6 maintenance: set log.excludeDecoration durin prefetch
 2:  616b73a6556 ! 2:  35038dfd037 t7900: clean up some broken refs
     @@ Commit message
      
          All that is left is to clean up the tests in t7900-maintenance.sh to
          remove these tags and refs that are not being repacked for the
     -    incremental-repack tests.
     +    incremental-repack tests. Use update-ref to ensure this works with all
     +    ref backends.
      
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
       	^HEAD~1
       	EOF
      +
     ++	# Delete refs that have not been repacked in these packs.
     ++	git for-each-ref --format="delete %(refname)" \
     ++		refs/prefetch refs/tags >refs &&
     ++	git update-ref --stdin <refs &&
     ++
      +	# Replace the object directory with this pack layout.
     -+	# However, it does not include all objects from the remotes.
     -+	rm -rf .git/refs/prefetch &&
     -+	rm -rf .git/refs/tags &&
       	rm -f $packDir/pack-* &&
       	rm -f $packDir/loose-* &&
       	ls $packDir/*.pack >packs-before &&

-- 
gitgitgadget
