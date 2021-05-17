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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D5DC43461
	for <git@archiver.kernel.org>; Mon, 17 May 2021 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4618761209
	for <git@archiver.kernel.org>; Mon, 17 May 2021 13:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhEQNmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 09:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbhEQNmo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 09:42:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AECDC061756
        for <git@vger.kernel.org>; Mon, 17 May 2021 06:41:26 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c3so6490428oic.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aC2QISbGpK+17T3mbUaLNnuPziAFTd4si9xplcjFaX8=;
        b=djht4iw1lIJVd2DO2cxyPQBmWZquahqNICfsbCaPMjtebjrz9gwbH1jMeGHklTcTmv
         4XvpDuoSNebYKnt5TPSZO/NGCxtv9zts9QHDhO0KNa6uYZThZ13HqnD2RnRh+MdqPQcH
         t56mjmMVwMAuIh3BET0RT64wJZdIDeLVpyNXtYoCoq47Rw6NHqDR4DPnmmT7+qXnWHTU
         RrLm9tOtTQhbDvBg8Q/CdNjYiS4HbsIDx5Ns4w6OIXbsSi5uMB8ldtcxKRQRDRz5iRLl
         fAPIJKpHU5cydGv4aiD7i01QEnMB8Gfund1ltVJqWBHPZHYgktFAfRkGsEwNwp5UVCCQ
         eUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aC2QISbGpK+17T3mbUaLNnuPziAFTd4si9xplcjFaX8=;
        b=W3HpMaCK2gmMcV3LhRbJW5vOoNqnc9dXsrItEqQBnI1fiBIpin6Ju5wAlHksaAkrAm
         I0BZ9o7KToz7EQFcC+icniJsy9d0OT9TM6vMt/0sDInszAwOEA1L0nGKt4Uqegf5dY2r
         QHLR1Y6Uw14Ewx8+4hd+F8nuc+WbsdLUbk7n0852KlsV7+lXFf5Qqn9SDa1hgKKS9pbe
         6nrykE5veunWXDLDPzT1BWFqLJYiu9VqUUdRCW7hq4YWBI3awD8PPppLKCFN3h1NCdhq
         eu9dcjC46jlY7GbV9rVINbbEBsjCLeXgdc99tK0u/tQa7k9v0VJThiXHm3x14ZqpJ7OG
         xotg==
X-Gm-Message-State: AOAM533oIY9Yq2EDcHPRU1Xk8cwzTxyzDnbHv/mDScfkxbDf0vyWEBrH
        eMjbmpfydcSgNFHIIJJ3mrw8GAQJfwbdLw==
X-Google-Smtp-Source: ABdhPJxVXwfkbta/rcVc4X+qc+968mntQSu0aIlfKkhA9M131bxQ7uUnBP8jtSYE5o/DSLlaXQSFBg==
X-Received: by 2002:aca:ab16:: with SMTP id u22mr10712664oie.122.1621258885665;
        Mon, 17 May 2021 06:41:25 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:4c59:3ee5:6b74:d819])
        by smtp.gmail.com with ESMTPSA id x6sm3010319ool.6.2021.05.17.06.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 06:41:25 -0700 (PDT)
Subject: Re: [PATCH v2 06/13] merge-ort: add data structures for in-memory
 caching of rename detection
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <2a9e73de2beef5f51ad76fe1d9aaaed926a5fce8.1620094339.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b9bb5b44-47ce-8198-c546-8f07d03ef863@gmail.com>
Date:   Mon, 17 May 2021 09:41:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2a9e73de2beef5f51ad76fe1d9aaaed926a5fce8.1620094339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When there are many renames between the old base of a series of commits
> and the new base for a series of commits, the sequence of merges
> employed to transplant those commits (from a cherry-pick or rebase
> operation) will repeatedly detect the exact same renames.  This is
> wasted effort.
> 
> Add data structures which will be used to cache rename detection
> results, along with the initialization and deallocation of these data
> structures.  Future commits will populate these caches, detect the
> appropriate circumstances when they can be used, and employ them to
> avoid re-detecting the same renames repeatedly.

I appreciate the definitions and boilerplate for these data
structures being isolated to their own patch.

> @@ -140,6 +140,37 @@ struct rename_info {
>  	int callback_data_nr, callback_data_alloc;
>  	char *callback_data_traverse_path;
>  
> +	/*
> +	 * cached_pairs: Caching of renames and deletions.
> +	 *
> +	 * These are mappings recording renames and deletions of individual
> +	 * files (not directories).  They are thus a map from an old
> +	 * filename to either NULL (for deletions) or a new filename (for
> +	 * renames).
> +	 */
> +	struct strmap cached_pairs[3];
> +
> +	/*
> +	 * cached_target_names: just the destinations from cached_pairs
> +	 *
> +	 * We sometimes want a fast lookup to determine if a given filename
> +	 * is one of the destinations in cached_pairs.  cached_target_names
> +	 * is thus duplicative information, but it provides a fast lookup.
> +	 */
> +	struct strset cached_target_names[3];

These two work well together. Very clear.

> +	/*
> +	 * cached_irrelevant: Caching of rename_sources that aren't relevant.
> +	 *
> +	 * cached_pairs records both renames and deletes.  Sometimes we
> +	 * do not know if a path is a rename or a delete because we pass
> +	 * RELEVANT_LOCATION to diffcore_rename_extended() and based on
> +	 * various optimizations it returns without detecting whether that
> +	 * path is actually a rename or a delete.  We need to cache such
> +	 * paths too, but separately from cached_pairs.
> +	 */
> +	struct strset cached_irrelevant[3];

I'm having a hard time parsing what these "irrelevant" paths will be.
It seems like diffcore_rename_extended() will report something other
than "rename" or "delete" for some paths. Could we explicitly mark
that state as "irrelevant"?

	/*
	 * cached_irrelevant: Caching of rename_sources that aren't relevant.
	 *
	 * cached_pairs records both renames and deletes.  Sometimes we
	 * do not know if a path is a rename or a delete because we pass
	 * RELEVANT_LOCATION to diffcore_rename_extended() which might
	 * describe a path as "irrelevant" instead of as a "rename" or "delete".
	 *  We need to cache such paths too, but separately from cached_pairs.
	 */

Does this make sense? diffcore_rename_extended() might need an update
to match this extra, explicit state.

The rest of the code looks good.

Thanks,
-Stolee
