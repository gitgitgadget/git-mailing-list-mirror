Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E82C47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 13:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D698561380
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 13:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhGON5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhGON5X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 09:57:23 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713CBC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 06:54:29 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j5so5045379ilk.3
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OAFjUlXJz1mtOiRzAzwEDQ/e3WSfuzUKpuxhRs1rr/8=;
        b=g+ewD9c5RgDAqHE1MOotJkzg/viTqRxTgfW1a5a+FzIPRsQpg0rb0qL1aHX5KgNpV4
         L1FVxKo8v0c4PXsE06UulDiyfkns4cRutJCcDNQg0rZo5LePfvYnLv/A2ZKmKseOwodx
         DhCoWAASGTmu34Yv0nSgaZoTtvK1O2mqdsfcWZJdlTznNhVSv7GpdF4WDu6QlKXZkQIJ
         wqxpNolBp4sn2YVmMQk8bFnzWJf5e7F807jTdcLmqrcJpENu5euHJTcCyUcwqYJlY686
         bqUd6KYEXviGGjO6lNzPmNFm3t1ckIuMSeCcH9L6h7vMrKAhA5FCFdL3e/bIJOCGzELs
         kEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OAFjUlXJz1mtOiRzAzwEDQ/e3WSfuzUKpuxhRs1rr/8=;
        b=e8225MWCqIIU1NWB6TxhYAcAsvAdlgDXyKoyIqS3DYMmKPAmPcNnKkdyrdJs7o2nNt
         wg5lStKtcJS6DywOYO/1GVT0O+Wd7JjTDnkOuDHBO+e3SqbNiyxCAUWGqcL+kZV8VeGX
         72PY+VnPIq86EtJ3v8/Qct2LJMyHaitL3hzmUGW9xt9HHiKLxmT/IQOMCmkq8ze2L+fG
         qLyY0auIRzEmUG3maN2qIDQLkNLyyyU//I+NKBf0l62oguQufM1Tpi9a3655EG3Zsvds
         1Cl0arc8dlLfqvYG9fqvU5kKVajkzPpSAz9uPa88DZHeL7rgbHcrWvxEiy9dcZ4hYj3e
         MUYw==
X-Gm-Message-State: AOAM533inV8SrLJ3cbwK5wuIqTmvUiNU/toVfdboSwmPA1oQUQxwQpm+
        8UlzTZERDfEEqtnwdYdkv1g=
X-Google-Smtp-Source: ABdhPJyphVG6S8jRVBlagevmtC3CHZZSVFYektO4KYkP/tc423+RFr+e2WhG+3xJnEblto+eA6jK/Q==
X-Received: by 2002:a05:6e02:68c:: with SMTP id o12mr2893394ils.261.1626357268774;
        Thu, 15 Jul 2021 06:54:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id l11sm3190029ios.8.2021.07.15.06.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 06:54:28 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] merge-ort: add data structures for allowable
 trivial directory resolves
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <f7ac01055d9d2e9e2dfdfd780ff7f10fbfd05d5b.1626204784.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f8d4eef7-9768-571f-2fb9-76284d69108f@gmail.com>
Date:   Thu, 15 Jul 2021 09:54:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f7ac01055d9d2e9e2dfdfd780ff7f10fbfd05d5b.1626204784.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2021 3:32 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

The first two patches were easy to follow. This one requires a more
careful read, so here is my attempt to double-check that I am
reading it right.

> In commit f89b4f2bee ("merge-ort: skip rename detection entirely if
> possible", 2021-03-11), we added an additional reason that rename
> detection could be skipped entirely -- namely, if no *relevant* sources
> were present.  Without completing collect_merge_info_callback(), we do
> not yet know if there are no relevant sources.  However, we do know that
> if the current directory on one side matches the merge base, then every
> source file within that directory will not be RELEVANT_CONTENT, and a
> few simple checks can often let us rule out RELEVANT_LOCATION as well.
> This suggests we can just defer recursing into such directories until
> the end of collect_merge_info.

We are not making early decisions, but collecting a list of directories
that cannot be relevant sources. These directories could still be
relevant locations (or content), but we don't want to pay the cost of
recursing right away.

> Since the deferred directories are known to not add any relevant sources
> due to the above properties, then if there are no relevant sources after
> we've traversed all paths other than the deferred ones, then we know
> there are not any relevant sources.  Under those conditions, rename
> detection is unnecessary, and that means we can resolve the deferred
> directories without recursing into them.

Only in the case where there are no relevant sources at the end of
scanning all directories (possibly non-recursively), then we can skip
recursing into these directories because finding relevant locations
is wasted effort now.

This means the performance benefit will be limited to cases where
rename detection isn't needed at all, but that is a frequent enough
case to merit the overhead of tracking this information differently.

> Note that the logic for skipping rename detection was also modified
> further in commit 76e253793c ("merge-ort, diffcore-rename: employ cached
> renames when possible", 2021-01-30); in particular rename detection can
> be skipped if we already have cached renames for each relevant source.
> We can take advantage of this information as well with our deferral of
> recursing into directories where one side matches the merge base.
> 
> Add some data structures that we will use to do these deferrals, with
> some lengthy comments explaining their purpose.

And now that the idea is understood, we are just laying the groundwork
for the process by creating the tracking data structures, not actually
the algorithm to use them. Makes sense to split them up.

> +	/*
> +	 * possible_trivial_merges: directories we defer recursing into

Not only are we deferring the recursion, we might be able to avoid
it entirely. Perhaps "directories to be explored only when needed"
would emphasize this point differently?

> +	 *
> +	 * possible_trivial_merges is a map of directory names to
> +	 * dir_rename_mask.  When we detect that a directory is unchanged on
> +	 * one side, we can sometimes resolve the directory without recursing
> +	 * into it.  Renames are the only things that can prevent such an
> +	 * optimization.  However, for rename sources:
> +	 *   - If no parent directory needed directory rename detection, then
> +	 *     no path under such a directory can be a relevant_source.
> +	 * and for rename destinations:
> +	 *   - If no cached rename has a target path under the directory AND
> +	 *   - If there are no unpaired relevant_sources elsewhere in the
> +	 *     repository
> +	 * then we don't need any path under this directory for a rename
> +	 * destination.  The only way to know the last item above is to defer
> +	 * handling such directories until the end of collect_merge_info(),
> +	 * in handle_deferred_entries().
> +	 *
> +	 * For each we store dir_rename_mask, since that's the only bit of
> +	 * information we need, other than the path, to resume the recursive
> +	 * traversal.
> +	 */
> +	struct strintmap possible_trivial_merges[3];
> +
> +	/*
> +	 * trivial_merges_okay: if trivial directory merges are okay
> +	 *
> +	 * See possible_trivial_merges above.  The "no unpaired
> +	 * relevant_sources elsewhere in the repository" is a single boolean
> +	 * per merge side, which we store here.  Note that while 0 means no,
> +	 * 1 only means "maybe" rather than "yes"; we optimistically set it
> +	 * to 1 initially and only clear when we determine it is unsafe to
> +	 * do trivial directory merges.
> +	 */
> +	unsigned trivial_merges_okay[3];
> +
> +	/*
> +	 * target_dirs: ancestor directories of rename targets
> +	 *
> +	 * target_dirs contains all directory names that are an ancestor of
> +	 * any rename destination.
> +	 */
> +	struct strset target_dirs[3];

These three members seem tightly coupled. Would it be beneficial to
group the data into a 'struct trivial_merge_data' that could then
have an array of three here?

>  	/*
>  	 * dir_rename_mask:
>  	 *   0: optimization removing unmodified potential rename source okay
> @@ -490,6 +535,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
>  		strintmap_func(&renames->dirs_removed[i]);
>  		strmap_func(&renames->dir_renames[i], 0);
>  		strintmap_func(&renames->relevant_sources[i]);
> +		strintmap_func(&renames->possible_trivial_merges[i]);
> +		strset_func(&renames->target_dirs[i]);
> +		renames->trivial_merges_okay[i] = 1; /* 1 == maybe */

This could be collected into an initializer method for the data
required by this optimization instead of three initializations
among many.

>  		if (!reinitialize)
>  			assert(renames->cached_pairs_valid_side == 0);
>  		if (i != renames->cached_pairs_valid_side) {
> @@ -4045,12 +4093,17 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
>  		strintmap_init_with_options(&renames->relevant_sources[i],
>  					    -1 /* explicitly invalid */,
>  					    NULL, 0);
> +		strintmap_init_with_options(&renames->possible_trivial_merges[i],
> +					    0, NULL, 0);
> +		strset_init_with_options(&renames->target_dirs[i],
> +					 NULL, 1);
>  		strmap_init_with_options(&renames->cached_pairs[i],
>  					 NULL, 1);
>  		strset_init_with_options(&renames->cached_irrelevant[i],
>  					 NULL, 1);
>  		strset_init_with_options(&renames->cached_target_names[i],
>  					 NULL, 0);
> +		renames->trivial_merges_okay[i] = 1; /* 1 == maybe */

Here, there is even a separation between the grouped data. If you
don't like the idea of creating helper methods, then at least these
new lines could be grouped together. Bonus points for adding
whitespace between these lines and the others.

Thanks,
-Stolee
