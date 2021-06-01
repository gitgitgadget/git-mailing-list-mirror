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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0217C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA77561263
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhFAPAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAPAV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:00:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB68C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:58:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h12-20020a05600c350cb029019fae7a26cdso53985wmq.5
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cDpMr2hKtHJjKeTIbuYRQgKcc7tc2kaw0JApypyPPoc=;
        b=ikBvyG6LRfygGhZrfUhe9Wg9nO2zgoEbfWD6B24lJDrl7OrgrDWrXXpHW7NzPpZLEh
         eET7eR6Jsn6FohbqmIFswyKvYdYNnIsUn1+z/IvGl9WChggDm5u7qzMtml94MtrTcK6o
         Uqb1vvJEF3Af9HOqApaquxnWZckBTdmm0zhsjYwVTJufC0lxW/wDbnl8nlu2412Ih1LS
         cHxoU554QH7nFwUhhEB+mKyR1H9i8Aj/zLqJYXn78NL5Cq6SJq2/Bh9HrfsS/T1eHfRN
         jWR7Pzc+CH+Z4/sIdryANDnUBhWXnmRNeBW/5ROveC0F/jQ6lfYb0mHGjTUJ75Zbyi23
         izZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=cDpMr2hKtHJjKeTIbuYRQgKcc7tc2kaw0JApypyPPoc=;
        b=pcAX/EMHerd6a7pFjHl8bHmmVe1RIXZZHsvFPb9gnfCfAv5GuEwY8qx/gBCBUKJDD2
         tcOhScgtaa+Zk9y7ppon+nrIGkg/eVOWmjTVrE5o9jQV9X5kF5KrolNnCeLmBvhhOE3F
         SPE6isIevs3/DAfFXQ3reCcSbB+osT/JBtNoEn/OwLWg79XL2wmAx5zPmVFHAciSfxPH
         8/Wy8E416Kw3ZvYZ8SHxnY0lIVCyQKIW+IqwAqCAob8q6tAEBW5ufdcMTLfkftqjzt9N
         ZvWwjyzxihn3J8oRTb/dNli5s9meSOICIehSzwfBbGgJGJeTFYMEihtc9PpnlD5lLGht
         nGAw==
X-Gm-Message-State: AOAM533g3GpYWSCkK/FkdWMXzNSgHzrq56FtU6O/KEKWLFhTU4yRcEVV
        jUrKizCpYAnHQFXoYlgKAAalSyHr1M0=
X-Google-Smtp-Source: ABdhPJx9LsC7vHkpd/7uPt1eHFLln8MN97ksmFsEK2HC02FGMUP9cPmbPowmEhg1ReQFlssdERtpYQ==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr27495667wml.168.1622559517615;
        Tue, 01 Jun 2021 07:58:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm390026wmq.48.2021.06.01.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:58:37 -0700 (PDT)
Message-Id: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.git.1622104642.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:58:30 +0000
Subject: [PATCH v2 0/5] Optimization batch 12: miscellaneous unthemed stuff
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
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/ort-perf-batch-11 textually, but is semantically
independent of it.

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


Elijah Newren (5):
  merge-ort: replace string_list_df_name_compare with faster alternative
  diffcore-rename: avoid unnecessary strdup'ing in break_idx
  diffcore-rename: enable limiting rename detection to relevant
    destinations
  Fix various issues found in comments
  merge-ort: miscellaneous touch-ups

 diffcore-rename.c                   | 52 ++++++++++++++---
 diffcore.h                          |  2 +
 merge-ort.c                         | 86 +++++++++++++++++++++--------
 t/t6423-merge-rename-directories.sh |  2 +-
 4 files changed, 110 insertions(+), 32 deletions(-)


base-commit: 76e253793c9a1d7fdd1836d5e4db26dabd3d713a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-962%2Fnewren%2Fort-perf-batch-12-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-962/newren/ort-perf-batch-12-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/962

Range-diff vs v1:

 1:  5055dfce3281 ! 1:  c4a0f6a9510c merge-ort: replace string_list_df_name_compare with faster alternative
     @@ Commit message
          "-sort" to either rebase or merge, sorting an array takes more time than
          anything else.  Serves me right for naming my merge strategy this way.
      
     -    Rewrite the comparison function and remove as many levels of indirection
     -    as possible (e.g. the old code had
     -        cmp_items() ->
     -          string_list_df_name_compare() ->
     -            df_name_compare()
     -    now we just have sort_dirs_next_to_their_children()), and tweak it to be
     -    as optimized as possible for our specific case.  These changes reduced
     -    the time spent in "plist special sort" by ~25% in the mega-renames case.
     +    Rewrite the comparison function in a way that does not require finding
     +    out the lengths of the strings when comparing them.  While at it, tweak
     +    the code for our specific case -- no need to handle a variety of modes,
     +    for example.  The combination of these changes reduced the time spent in
     +    "plist special sort" by ~25% in the mega-renames case.
      
          For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
          performance work; instrument with trace2_region_* calls", 2020-10-28),
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
       /*** Function Grouping: functions related to process_entries() ***/
       
      -static int string_list_df_name_compare(const char *one, const char *two)
     -+static int sort_dirs_next_to_their_children(const void *a, const void *b)
     ++static int sort_dirs_next_to_their_children(const char *one, const char *two)
       {
      -	int onelen = strlen(one);
      -	int twolen = strlen(two);
     ++	unsigned char c1, c2;
     ++
       	/*
      -	 * Here we only care that entries for D/F conflicts are
      -	 * adjacent, in particular with the file of the D/F conflict
      -	 * appearing before files below the corresponding directory.
      -	 * The order of the rest of the list is irrelevant for us.
      +	 * Here we only care that entries for directories appear adjacent
     -+	 * to and before files underneath the directory.  In other words,
     -+	 * we do not want the natural sorting of
     ++	 * to and before files underneath the directory.  We can achieve
     ++	 * that by pretending to add a trailing slash to every file and
     ++	 * then sorting.  In other words, we do not want the natural
     ++	 * sorting of
      +	 *     foo
      +	 *     foo.txt
      +	 *     foo/bar
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      +	 * To achieve this, we basically implement our own strcmp, except that
      +	 * if we get to the end of either string instead of comparing NUL to
      +	 * another character, we compare '/' to it.
     ++	 *
     ++	 * If this unusual "sort as though '/' were appended" perplexes
     ++	 * you, perhaps it will help to note that this is not the final
     ++	 * sort.  write_tree() will sort again without the trailing slash
     ++	 * magic, but just on paths immediately under a given tree.
       	 *
      -	 * To achieve this, we sort with df_name_compare and provide
      -	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      -	 * since in other cases any changes in their order due to
      -	 * sorting cause no problems for us.
      +	 * The reason to not use df_name_compare directly was that it was
     -+	 * just too expensive, so I had to reimplement it.
     ++	 * just too expensive (we don't have the string lengths handy), so
     ++	 * I had to reimplement it.
       	 */
      -	int cmp = df_name_compare(one, onelen, S_IFDIR,
      -				  two, twolen, S_IFDIR);
     --	/*
     ++
     + 	/*
      -	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
      -	 * that 'foo' comes before 'foo/bar'.
     --	 */
     ++	 * NOTE: This function will never be called with two equal strings,
     ++	 * because it is used to sort the keys of a strmap, and strmaps have
     ++	 * unique keys by construction.  That simplifies our c1==c2 handling
     ++	 * below.
     + 	 */
      -	if (cmp)
      -		return cmp;
      -	return onelen - twolen;
     -+	const char *one = ((struct string_list_item *)a)->string;
     -+	const char *two = ((struct string_list_item *)b)->string;
     -+	unsigned char c1, c2;
      +
      +	while (*one && (*one == *two)) {
      +		one++;
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
      +	if (c1 == c2) {
      +		/* Getting here means one is a leading directory of the other */
      +		return (*one) ? 1 : -1;
     -+	}
     -+	else
     ++	} else
      +		return c1-c2;
       }
       
     @@ merge-ort.c: static void process_entries(struct merge_options *opt,
       
       	trace2_region_enter("merge", "plist special sort", opt->repo);
      -	plist.cmp = string_list_df_name_compare;
     --	string_list_sort(&plist);
     -+	QSORT(plist.items, plist.nr, sort_dirs_next_to_their_children);
     ++	plist.cmp = sort_dirs_next_to_their_children;
     + 	string_list_sort(&plist);
       	trace2_region_leave("merge", "plist special sort", opt->repo);
       
     - 	trace2_region_leave("merge", "process_entries setup", opt->repo);
 2:  7212816c8d47 = 2:  38713ed48273 diffcore-rename: avoid unnecessary strdup'ing in break_idx
 3:  19150b575058 = 3:  45e1de5fe780 diffcore-rename: enable limiting rename detection to relevant destinations
 4:  98c9a419b313 = 4:  2f26d7e935c0 Fix various issues found in comments
 5:  e85dad887f95 = 5:  7156f26ab299 merge-ort: miscellaneous touch-ups

-- 
gitgitgadget
