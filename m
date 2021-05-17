Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0AAC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 14:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90891611CA
	for <git@archiver.kernel.org>; Mon, 17 May 2021 14:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbhEQOC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbhEQOCw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 10:02:52 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D34C061760
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:01:36 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q10so5782450qkc.5
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DFjOWQ0pivEjlfnJHt17TU5GvuXMNUFUL59YAPDTYXU=;
        b=jDU6Vj5MCNd2a9oGXeJVNKhzXBaOngbVwyiAWVWJcl3sOcsy4Sa5wTIA8jUql58J6q
         aXpfzfLk+3re1xk4jz452bo7XZU017EjhYwKpKO2ikFqU+02jHIRb9rLwdWGSpSuny5+
         43B0rDPQKWNI3eAe/ILv2jUVvAfe0FABtejfJ45Cp4Q6xIgd+eQ8TaVGS3b8MPB7CnfG
         gzA5pIvZadLDpd+he+MIgq6yR9XGM6qxSFD/znjB5f74fuSkFA8a9eFw0jdWT3B2tFVE
         VMR9bOZhIk22/xt5OecRF1yXzBftChRf8LGIUxwjABc9pNPEPSTY+MbdzZ42GriiYkqU
         QqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFjOWQ0pivEjlfnJHt17TU5GvuXMNUFUL59YAPDTYXU=;
        b=BD3hBil2OzzVb68Ej7SJj2d1Wk64N6yxqiKHyltGbToaEOieQAAEk1FHc2XmvUdvyW
         oSL6E6xoIHBLl7vfnL9G/ygSHdgHReIQqF9uZ+UDp7ec3gy8pnv02foxThbEv+5YXjgP
         dMTuQ7ebkWiMnYBbOojMmsqK2kN14gV3+01h1pC1A7q5fYubMOB7E8o+P+lvIGFhHmZ3
         FlNErFEk3CK69LTO55yg6tFd5A8xWPqDqgU5KyZDSYMsDRGtVktYoHifBhdWCbGz5grl
         an5wVsvqE3DF/UtG2Ei5DHwHqhqeUDbCABqtJUBLbiRVIrDUQARVjdv6FYFJ/NAHwW94
         seYQ==
X-Gm-Message-State: AOAM532jDWl+OZlXmsqaQo9yv0IHZkZh/CHK7KNtYZPwS3UcNg088v4m
        rfoiwxeKzmVzxHJWV38fjOk=
X-Google-Smtp-Source: ABdhPJyuZgXwosoAYEoERF70d24kHWiSd2f0LNL8eO3i/YhO19yu+zb3s6tbsvdoOtN0FJijgl/bxQ==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr44979994qkl.256.1621260095379;
        Mon, 17 May 2021 07:01:35 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:20ee:d66c:315:bb13])
        by smtp.gmail.com with ESMTPSA id x18sm10240774qkx.118.2021.05.17.07.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:01:34 -0700 (PDT)
Subject: Re: [PATCH v2 08/13] merge-ort: add code to check for whether cached
 renames can be reused
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <731b6bd15531fc7883a2c70275cea24ac686ab03.1620094339.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fdce6d4b-db42-fd21-f2b4-34eb084a9660@gmail.com>
Date:   Mon, 17 May 2021 10:01:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <731b6bd15531fc7883a2c70275cea24ac686ab03.1620094339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
...
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 5523fc9e86b3..a342cc6344fd 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -140,6 +140,30 @@ struct rename_info {
>  	int callback_data_nr, callback_data_alloc;
>  	char *callback_data_traverse_path;
>  
> +	/*
> +	 * merge_trees: trees passed to the merge algorithm for the merge
> +	 *
> +	 * merge_trees records the trees passed to the merge algorithm.  But,
> +	 * this data also is stored in merge_result->priv.  If a sequence of
> +	 * merges are being done (such as when cherry-picking or rebasing),
> +	 * the next merge can look at this and re-use information from
> +	 * previous merges under certain cirumstances.

s/cirumstances/circumstances/

> +	 *
> +	 * See also all the cached_* variables.
> +	 */
> +	struct tree *merge_trees[3];
> +
> +	/*
> +	 * cached_pairs_valid_side: which side's cached info can be reused
> +	 *
> +	 * See the description for merge_trees.  For repeated merges, at most
> +	 * only one side's cached information can be used.  Valid values:
> +	 *   MERGE_SIDE2: cached data from side2 can be reused
> +	 *   MERGE_SIDE1: cached data from side1 can be reused
> +	 *   0:           no cached data can be reused
> +	 */
> +	int cached_pairs_valid_side;

...

> +static void merge_check_renames_reusable(struct merge_options *opt,
> +					 struct merge_result *result,
> +					 struct tree *merge_base,
> +					 struct tree *side1,
> +					 struct tree *side2)
> +{
> +	struct rename_info *renames;
> +	struct tree **merge_trees;
> +	struct merge_options_internal *opti = result->priv;
> +
> +	if (!opti)
> +		return;
> +
> +	renames = &opti->renames;
> +	merge_trees = renames->merge_trees;
> +	/* merge_trees[0..2] will only be NULL if opti is */
> +	assert(merge_trees[0] && merge_trees[1] && merge_trees[2]);
> +
> +	/* Check if we meet a condition for re-using cached_pairs */
> +	if (     oideq(&merge_base->object.oid, &merge_trees[2]->object.oid) &&
> +		 oideq(     &side1->object.oid, &result->tree->object.oid))
> +		renames->cached_pairs_valid_side = MERGE_SIDE1;
> +	else if (oideq(&merge_base->object.oid, &merge_trees[1]->object.oid) &&
> +		 oideq(     &side2->object.oid, &result->tree->object.oid))

I see how you used whitespace to align the different items in these
conditions, but they are nonstandard so  it's probably best to drop
the extra spaces.

> +		renames->cached_pairs_valid_side = MERGE_SIDE2;
> +	else
> +		renames->cached_pairs_valid_side = 0; /* neither side valid */
> +}
> +
>  /*** Function Grouping: merge_incore_*() and their internal variants ***/
>  
>  /*
> @@ -3949,7 +4002,16 @@ void merge_incore_nonrecursive(struct merge_options *opt,
>  
>  	trace2_region_enter("merge", "merge_start", opt->repo);
>  	assert(opt->ancestor != NULL);
> +	merge_check_renames_reusable(opt, result, merge_base, side1, side2);
>  	merge_start(opt, result);
> +	/*
> +	 * Record the trees used in this merge, so if there's a next merge in
> +	 * a cherry-pick or rebase sequence it might be able to take advantage
> +	 * of the cached_pairs in that next merge.
> +	 */
> +	opt->priv->renames.merge_trees[0] = merge_base;
> +	opt->priv->renames.merge_trees[1] = side1;
> +	opt->priv->renames.merge_trees[2] = side2;
>  	trace2_region_leave("merge", "merge_start", opt->repo);
>  

Again, the functionality seems reasonable. We're not quite to the
punchline of the series.

Thanks,
-Stolee
