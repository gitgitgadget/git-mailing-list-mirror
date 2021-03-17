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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21718C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FCA64EEE
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhCQVWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhCQVW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:22:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EDFC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:22:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so5983992wmq.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=evf4SAv4dKr2DyGPj9GiUgVccSMBanFvzSEpdlkaFQg=;
        b=nPehyGch3fakhUaBLRoJG9ZWbOfKYE7yL+udFz6v44I5OcAH//ELRXMG0WJN4K6DBw
         9CM23dcdf2nE2ElkSJXiDCeHsS/QpgP2aCUFFeunzaIknJhQ3QZIXNG6goVdvMqetRAn
         jhJ1HV/I/uGo4uBv/qWeEZOYDyNrh5grL0yzeNQ4DDcwWE7zryGCO2YYfLpdh9atoiC1
         dHD0tI2tjctaCz9AwJDvGnL5Wmc1X6bq9mqv6qSfbaIPkPIliLm/O/uiO/jqGAuVsk23
         c4ghB26Yz2QX0hoS13toRXQy8jc3XnRHgG1eAE/2bNeX6hrIqKr1IyEeiAbQFc27jzX8
         CzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=evf4SAv4dKr2DyGPj9GiUgVccSMBanFvzSEpdlkaFQg=;
        b=Y6+F/+alxNAdWXlbNy0O5i0wIs1N0YJ0P/rUNHZepAebulFiNNfo1O+eCJutA3ibSp
         lFD+V/sPGFig8JW1CNyZ/FLHTbURvU8NxRZxMZSQaDx6rJdH8iOKKEGxWLkN9vq12WAm
         u9rmwb4BXWVyt674Kwzo3mCYSK4ymFY0n0CAMnGtBGgti2Lqlx7AfrZj78VNo1c5Is+s
         pBR8OJh9co9MXiJxbk8hdkXA9bFgZ1jsEnEg1DU61mx73w5YLTWTW61rOgNN0v0R8Lth
         LgbnbXcsBgsa3dL2CHcDYc4Z9E9ShAyOch5tlv8BL78Br6mgRODmWg2LBOI3OyLLzdqU
         jZUQ==
X-Gm-Message-State: AOAM532Q7qdX9biTHP2N/VFyXJfxjT7I6sO7TSye6iPoxXzbel3ObNPg
        8HRR7edLn3KiRGvbRn/5dEIr5C08qMo=
X-Google-Smtp-Source: ABdhPJwd6j6EUWJC5Yis5jV75BWLA1GDKcBTwTRJvZlorMU+TGC/zPR+osdf4NFW9qF5oDRNBuHyjg==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr609868wmg.177.1616016144485;
        Wed, 17 Mar 2021 14:22:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm240413wrw.63.2021.03.17.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:22:24 -0700 (PDT)
Message-Id: <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
In-Reply-To: <pull.903.git.1615760258.gitgitgadget@gmail.com>
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:22:20 +0000
Subject: [PATCH v2 0/3] teach git to respect fsmonitor in diff-index
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

Skip lstat deletion check during git diff-index (similar to how it already
does so in git diff-files). Add perf benchmark for this case. Add assert for
guaranteeing that fsmonitor is refreshed in this case.

Update since Patch Series V1:

 * Fix spaces->tabs issue in fsmonitor.h
 * Remove comment in test-chmtime.c - to avoid it going stale

cc: Eric Sunshine sunshine@sunshineco.com

Nipunn Koorapati (3):
  fsmonitor: skip lstat deletion check during git diff-index
  fsmonitor: add assertion that fsmonitor is valid to check_removed
  fsmonitor: add perf test for git diff HEAD

 diff-lib.c                | 23 +++++++++++++++--------
 fsmonitor.h               | 11 +++++++++++
 t/helper/test-chmtime.c   |  4 ++--
 t/perf/p7519-fsmonitor.sh |  4 ++++
 4 files changed, 32 insertions(+), 10 deletions(-)


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-903%2Fnipunn1313%2Fnk%2Ffsmonitor-in-diff-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-903/nipunn1313/nk/fsmonitor-in-diff-index-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/903

Range-diff vs v1:

 1:  75a3c46c4055 = 1:  75a3c46c4055 fsmonitor: skip lstat deletion check during git diff-index
 2:  dda5b537a3f0 ! 2:  afd326c5011b fsmonitor: add assertion that fsmonitor is valid to check_removed
     @@ fsmonitor.h: void refresh_fsmonitor(struct index_state *istate);
      + */
      +static inline int is_fsmonitor_refreshed(const struct index_state *istate)
      +{
     -+    return !core_fsmonitor || istate->fsmonitor_has_run_once;
     ++	return !core_fsmonitor || istate->fsmonitor_has_run_once;
      +}
      +
       /*
 3:  740302586dd8 ! 3:  f9d0fd594fdb fsmonitor: add perf test for git diff HEAD
     @@ Commit message
      
       ## t/helper/test-chmtime.c ##
      @@ t/helper/test-chmtime.c: int cmd__chmtime(int argc, const char **argv)
     + 		uintmax_t mtime;
     + 
       		if (stat(argv[i], &sb) < 0) {
     - 			fprintf(stderr, "Failed to stat %s: %s\n",
     +-			fprintf(stderr, "Failed to stat %s: %s\n",
     ++			fprintf(stderr, "Failed to stat %s: %s. Skipping\n",
       			        argv[i], strerror(errno));
      -			return 1;
     -+			// Skip and move on - eg if it's a broken symlink
      +			continue;
       		}
       

-- 
gitgitgadget
