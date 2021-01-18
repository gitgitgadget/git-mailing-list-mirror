Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E6C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA9D207A0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437703AbhARUVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394210AbhARULA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 15:11:00 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1357C061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:10:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d15so6726699qtw.12
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dUeuyOjTax4ZPla3/ZzFFEjxPANJI5Wx2oazES5vITc=;
        b=KDh+lS2lCBA7LmbTArTMCXCfsU+5YPQyLAIjrVIgA881Z5eNNbK2jaQ5t6wP49f/1D
         3MR1BsWhb4g8If3S9dWqYh2ZT3LVCS6ORo6aLiIkP2ivE59WG7ps4RMtPH5WbfpTVEyS
         aBYYX95Tuj4MMji7p4uVrKVL5q9ubHGCvlFTyth49ZbTX53atPNHS648bGRKFTHnRsJU
         BAWc2m8QxIwi9iBWqxKyRQuS6MKgkcgrKYQEOg0Cedstv2OQEhYnLfthbK51ePk4+FOP
         K3trsoHXwef4V4dIbwBwBomSNj2m8xftQ8qbrI35JLfDdBqCQYtpQb0D36JuyCznBp/p
         UU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dUeuyOjTax4ZPla3/ZzFFEjxPANJI5Wx2oazES5vITc=;
        b=dT0f2IQGTa6YXUUzqFGxWHGrAeZBoRTf1P6cGoBHLAn1aY791zj0s14hMm2KqbmcwF
         pBkhuu+mnTLTJtiSBnA0OMMEt9JkGutNt33wg0gJ3o+fHTfTOywkh0JM4u9g90Tr1pL0
         z5D3b5fikVsKKOo8sbOBcNTG4/uSzzbaoI+OE00O+ODOhOM38Whj+NUJntYK32dpjaCa
         +1TACGNeVXMdenO31e9lkFPkRuh9SnMwOX1TLKFgSPVcVzGE/VxvhiwS/K7/6pfncx1f
         BdexFRgxbx5K+/DWv241MnT8eeqVlPTVIC493T74gblsEGFxLrF2OonW2hgN9QBwz1KA
         O+bQ==
X-Gm-Message-State: AOAM532gA/Nx/azA5FPu9poT6BymOSs7Fgouz9NbuG+YCRzBFwb7EhA9
        Jv9CpFFQlmqhTBCBwq5N04Z8bw==
X-Google-Smtp-Source: ABdhPJyonlZSbSat+e/mRvMcF0lfvfKTVFaQO/jI6Xv9oGbvfdxfPHH3skL0p5Lp4H9WDWZxcWiugg==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr1306470qtv.56.1611000619111;
        Mon, 18 Jan 2021 12:10:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id i13sm11185447qkk.83.2021.01.18.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 12:10:18 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:10:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 05/17] merge-ort: add outline of
 get_provisional_directory_renames()
Message-ID: <YAXrKLM5vkkwmxjC@nand.local>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
 <bb4285250cdef2fcd16a22f8540968c871302c9f.1610055365.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb4285250cdef2fcd16a22f8540968c871302c9f.1610055365.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 07, 2021 at 09:35:53PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> This function is based on merge-recursive.c's get_directory_renames(),
> except that the first half has been split out into a not-yet-implemented
> compute_rename_counts().  The primary difference here is our lack of the
> non_unique_new_dir boolean in our strmap.  The lack of that field will
> at first cause us to fail testcase 2b of t6423; however, future
> optimizations will obviate the need for that ugly field so we have just
> left it out.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 378ac495d09..73d3ff97f52 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -721,11 +721,69 @@ static int handle_content_merge(struct merge_options *opt,
>
>  /*** Function Grouping: functions related to directory rename detection ***/
>
> +static void compute_rename_counts(struct diff_queue_struct *pairs,
> +				  struct strmap *dir_rename_count,
> +				  struct strset *dirs_removed)
> +{
> +	die("Not yet implemented!");
> +}
> +
>  static void get_provisional_directory_renames(struct merge_options *opt,
>  					      unsigned side,
>  					      int *clean)
>  {
> -	die("Not yet implemented!");
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +	struct rename_info *renames = &opt->priv->renames;
> +
> +	compute_rename_counts(&renames->pairs[side],
> +			      &renames->dir_rename_count[side],
> +			      &renames->dirs_removed[side]);
> +	/*
> +	 * Collapse
> +	 *    dir_rename_count: old_directory -> {new_directory -> count}
> +	 * down to
> +	 *    dir_renames: old_directory -> best_new_directory
> +	 * where best_new_directory is the one with the unique highest count.
> +	 */
> +	strmap_for_each_entry(&renames->dir_rename_count[side], &iter, entry) {
> +		const char *source_dir = entry->key;
> +		struct strintmap *counts = entry->value;
> +		struct hashmap_iter count_iter;
> +		struct strmap_entry *count_entry;
> +		int max = 0;
> +		int bad_max = 0;
> +		const char *best = NULL;
> +
> +		strintmap_for_each_entry(counts, &count_iter, count_entry) {
> +			const char *target_dir = count_entry->key;
> +			intptr_t count = (intptr_t)count_entry->value;

Just to make sure I understand what's going on here: you're storing the
whole int inside the pointer (and not pointing at it)?

> +			if (count == max)
> +				bad_max = max;
> +			else if (count > max) {
> +				max = count;
> +				best = target_dir;
> +			}
> +		}
> +
> +		if (max == 0)
> +			continue;

This is new from merge_recursive.c:get_directory_renames(). What is it
doing here?

> +		if (bad_max == max) {
> +			path_msg(opt, source_dir, 0,
> +			       _("CONFLICT (directory rename split): "
> +				 "Unclear where to rename %s to; it was "
> +				 "renamed to multiple other directories, with "
> +				 "no destination getting a majority of the "
> +				 "files."),
> +			       source_dir);
> +			*clean &= 0;

Also not a big deal, but why not simply '*clean = 0'?

> +		} else {
> +			strmap_put(&renames->dir_renames[side],
> +				   source_dir, (void*)best);

Ah, answering my onw question: this is indeed shoving the int into your
void*. That said, shouldn't this be '(void*)(intptr_t)best'?

Thanks,
Taylor
