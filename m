Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD3C47097
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0236115B
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFDElo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhFDEln (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 00:41:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FB9C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 21:39:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c5so7879376wrq.9
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=g1L6N6O6XJgDOw6MN30xSUv5PBACazfQLqNTOnS1GPs=;
        b=an6K27ZL+2sX4W84/lAWvlNgG7w2lCDH2Iy4at6ZgUpM59yAmTQskBIZXJzVxEX01K
         +UteFJay8o8rJAoNndVnhdbtqb66pCss/LAytU1ZGn6zdvVz0Y2blPgh2eVilpbyTgaL
         rf9WP1qwJxqZZbef9dB/cooqSPjNfVnCWew4p96A9J+1n+oWq5SA8de7hb/oJpeNpWMs
         9H6AgjX6AbWGpkQchB8HaFsd6ozWhR1/oR8//tdDXNvVw4SwWucGGiOjhEnNDL+elgbb
         pghBW1MYkYxnDib4rgBp2uwP3uoYPTwEmEkUaPkbmvE+THTDdHHjT0mWyyl4CQ8cVTXS
         kyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=g1L6N6O6XJgDOw6MN30xSUv5PBACazfQLqNTOnS1GPs=;
        b=GpLR5y7xRL/cQVD/PuPfFhwFC/2fwKf+jscb+2MFADvM/Fek+o16sWsWIOAFZHor+2
         1aYxMZbCSG6Nldjpgv6Ut+dQMdA0xwLQWRAgV30I8xlxJlsq71ZYaFCyYuZ5T31VXTnd
         h3cnMQfY0bZb3U5DnSdoav8koAKvE+sDxh+/oVJLQoOfny3XnprjKIsbsIaNbIWtsmnG
         WazIkZgWF1vhxAwiyL0zm0KgZmWYdd9t6X7wpV3XFixOlT1hOiKTugT7bZiYR/QcBMpI
         HHSHd1OI9XoMb8UpJR7EoNskgC6HEvyng/foddyKpmr+ytJyGt+coMFHnRFchsDWm1g2
         9Hug==
X-Gm-Message-State: AOAM531rSN9Kyn9vTz/IN1VrXtxbuW4NzjUkU3W8CprscZREmgH7ZDgV
        KJgTrL6edw1ceqKB5gX5Jvztwpc9QmA=
X-Google-Smtp-Source: ABdhPJz4v/kMmvV1CoycJxv7vMuBepvXaGhmGOA/p62/ruaN/OUfN5ewzHMfhlQu13W497DCneaYag==
X-Received: by 2002:a5d:4848:: with SMTP id n8mr1729903wrs.70.1622781580038;
        Thu, 03 Jun 2021 21:39:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g23sm6581268wmk.3.2021.06.03.21.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 21:39:39 -0700 (PDT)
Message-Id: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 04:39:34 +0000
Subject: [PATCH v3 0/4] Optimization batch 12: miscellaneous unthemed stuff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/ort-perf-batch-11 textually, but is semantically
independent of it.

Changes since v2:

 * Made suggested minor tweaks from Stolee on Patch 1
 * Dropped patch 3, for now
 * Added Stolee's Acked-by

Changes since v1 (all for the first patch):

 * Add more comments explaining the sorting function, its purpose, and how
   its expected to be called
 * Small style fixup
 * Switch back to using string_list_sort() instead of direct QSORT()

This short series has a few optimizations, but only one of which affects the
testcases of interest (namely, reducing our time spent on sorting an array).
It also fixes a few comments.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:        5.622 s ±  0.059 s     5.235 s ±  0.042 s
mega-renames:     10.127 s ±  0.073 s     9.419 s ±  0.107 s
just-one-mega:   500.3  ms ±  3.8  ms   480.1  ms ±  3.9  ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


Elijah Newren (4):
  merge-ort: replace string_list_df_name_compare with faster alternative
  diffcore-rename: avoid unnecessary strdup'ing in break_idx
  Fix various issues found in comments
  merge-ort: miscellaneous touch-ups

 diffcore-rename.c                   |  4 +-
 merge-ort.c                         | 80 ++++++++++++++++++++---------
 t/t6423-merge-rename-directories.sh |  2 +-
 3 files changed, 60 insertions(+), 26 deletions(-)


base-commit: 76e253793c9a1d7fdd1836d5e4db26dabd3d713a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-962%2Fnewren%2Fort-perf-batch-12-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-962/newren/ort-perf-batch-12-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/962

Range-diff vs v2:

 1:  c4a0f6a9510c ! 1:  f63ffc2a7c22 merge-ort: replace string_list_df_name_compare with faster alternative
     @@ Commit message
              just-one-mega:   500.3  ms ±  3.8  ms   480.1  ms ±  3.9  ms
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## merge-ort.c ##
      @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      -	 * sorting cause no problems for us.
      +	 * The reason to not use df_name_compare directly was that it was
      +	 * just too expensive (we don't have the string lengths handy), so
     -+	 * I had to reimplement it.
     ++	 * it was reimplemented.
       	 */
      -	int cmp = df_name_compare(one, onelen, S_IFDIR,
      -				  two, twolen, S_IFDIR);
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      +		two++;
      +	}
      +
     -+	c1 = *one;
     -+	if (!c1)
     -+		c1 = '/';
     -+
     -+	c2 = *two;
     -+	if (!c2)
     -+		c2 = '/';
     ++	c1 = *one ? *one : '/';
     ++	c2 = *two ? *two : '/';
      +
      +	if (c1 == c2) {
      +		/* Getting here means one is a leading directory of the other */
      +		return (*one) ? 1 : -1;
      +	} else
     -+		return c1-c2;
     ++		return c1 - c2;
       }
       
       static int read_oid_strbuf(struct merge_options *opt,
 2:  38713ed48273 ! 2:  cd13499a6ff5 diffcore-rename: avoid unnecessary strdup'ing in break_idx
     @@ Commit message
          unrelated optimization noted in passing while looking at the code.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## diffcore-rename.c ##
      @@ diffcore-rename.c: static void register_rename_src(struct diff_filepair *p)
 3:  45e1de5fe780 < -:  ------------ diffcore-rename: enable limiting rename detection to relevant destinations
 4:  2f26d7e935c0 ! 3:  91c0962a7d75 Fix various issues found in comments
     @@ Commit message
              function.  Update the comment now.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## diffcore-rename.c ##
      @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
 5:  7156f26ab299 ! 4:  01352fcdf3a9 merge-ort: miscellaneous touch-ups
     @@ Commit message
          of pushing these changes upstream.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## merge-ort.c ##
      @@ merge-ort.c: static void add_pair(struct merge_options *opt,

-- 
gitgitgadget
