Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADDCC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 21:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B39C61026
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 21:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbhIHVHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 17:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhIHVHf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 17:07:35 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF53C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 14:06:27 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s15so3151998qta.10
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=30mIc7MTbEm2vwUP8eOj98AHKLnSJjMZPlSwFa7Q80Q=;
        b=PTIQApDe9/npIEsP4VhL9WXInSSCxhHSwhzVS1Iy7CU8oCWZy0n6XHqgr3po7iJCe4
         g1iSPiGWsqsMAHmFXu8O1EM5NBdeDldvMXZjEe2kVS+wqLA6PCbOF0N4FCKl0UYyUy2E
         jzZFXOLbW1xd86MTBomD4Flr0rtmelxQbaS2MVRjKwNNMRYdQZrjMAkAn4Gm9tHW7Cfz
         miuW86iiCsOMjLUiLMhC/RFMNeAHTDKmD8qkMgFUePc2aFDdxd9t8DqSlSS9TOvBywGG
         171Yj8WQtIjFU1bhPnG5dAQgpXruW2e+tcvtZkVZ4S8qsFsPypAQ5dQjAbaNv2DD3WrO
         1VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=30mIc7MTbEm2vwUP8eOj98AHKLnSJjMZPlSwFa7Q80Q=;
        b=Fr/rmvZJLGgQVJ+ffyB/4ufq9oYOCAKJ3YR2XJ1ezS4mJ84iAmW4nrAnWwV9Wrb3aI
         mjKrmBG/NVutmMJst+VCOUvMhK/uVPT4BDi+J16SCF9OR4eHp31NSa0zRoKAWfgofS8a
         pUV/rPZkm/6RGh6RTxUPAOjLxVV/+/drQ9i/oENDx1o+m5ICb5fhrq0XTxJr0PrgTVS5
         qJG5vcrtO9NLmJ0iIZoAo78pd0Vj/Rf/DouOJ6UaEOP7552znIv9X1ISB4KFC7B1KG1y
         FKj5EqVA3Wvfo85xa9lg2flVeCUnZTK7AzkZbzy7amLqzbxNkhKrbs+StrE8TlS4cqPi
         sARQ==
X-Gm-Message-State: AOAM533YY/dFCy/lJqQVuIdEjIrzL3yqDUz6rPhKlt0K38uigBh3uduw
        CFd36ssiHNyNgse/epruECA=
X-Google-Smtp-Source: ABdhPJz61eTJIU7KIhF8mXWigZbcimlYz3zJu04BJK7q7U+dujRpr/LFT3PCuEiw+69XZpVMXY9vvg==
X-Received: by 2002:a05:622a:3d4:: with SMTP id k20mr316884qtx.417.1631135186012;
        Wed, 08 Sep 2021 14:06:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id az6sm218611qkb.70.2021.09.08.14.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 14:06:25 -0700 (PDT)
Subject: Re: [PATCH 06/13] add: skip paths that are outside sparse-checkout
 cone
To:     Matheus Tavares <matheus.bernardino@usp.br>, gitgitgadget@gmail.com
Cc:     derrickstolee@github.com, dstolee@microsoft.com,
        git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
References: <eeba97ad492307302637faf33f6bf6ae8965faa3.1629842085.git.gitgitgadget@gmail.com>
 <20210827211310.108999-1-matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <011f2b86-c0d0-c473-36f2-a2b8fc566050@gmail.com>
Date:   Wed, 8 Sep 2021 17:06:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210827211310.108999-1-matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 5:13 PM, Matheus Tavares wrote:
> On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>>
>> Subject: [PATCH 06/13] add: skip paths that are outside sparse-checkout cone
> 
> Perhaps this could be "skip _tracked_ paths that ..." (to help
> differentiate the end goal of this patch from the previous one).
> 
>> diff --git a/pathspec.c b/pathspec.c
>> index 44306fdaca2..0e6e60fdc5a 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -39,7 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>>                 return;
>>         for (i = 0; i < istate->cache_nr; i++) {
>>                 const struct cache_entry *ce = istate->cache[i];
>> -               if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
>> +               if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
>> +                   (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
> 
> Hmm, even though we skip the sparse paths here, cmd_add() will call
> add_files_to_cache() at the end and still update these paths in the
> index. I think there are two ways to fix this. We could either change
> run_diff_files() to skip these paths (but I don't know how other callers
> of this functions want to handle this, so maybe this needs to hide
> behind an option flag):

Ok, this sent me off on a tangent (see other replies) trying to show
that 'git add <sparse-path>' is still modifying index entries. I finally
added enough checks that this fails in my merge/cherry-pick/rebase tests
for conflicts outside of the sparse-checkout cone. Here is a test that I
can add to t3705 to get a failure:

test_expect_success 'git add fails outside of sparse-checkout definition' '
	test_when_finished git sparse-checkout disable &&
	test_commit a &&
	git sparse-checkout init &&
	git sparse-checkout set a &&

	git update-index --no-skip-worktree sparse_entry &&
	test_must_fail git add sparse_entry &&
	test_sparse_entry_unstaged
'
 
> diff --git a/diff-lib.c b/diff-lib.c
> index f9eadc4fc1..4245d7ead5 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -198,7 +198,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  				continue;
>  		}
>  
> -		if (ce_uptodate(ce) || ce_skip_worktree(ce))
> +		if (ce_uptodate(ce) || ce_skip_worktree(ce) ||
> +		    !path_in_sparse_checkout(ce->name, istate))
>  			continue;
>  
>  		/*
> 
> Or we could change the callback in add itself:
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index f675bdeae4..3d7762aac2 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -94,6 +94,10 @@ static void update_callback(struct diff_queue_struct *q,
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filepair *p = q->queue[i];
>  		const char *path = p->one->path;
> +
> +		if (!path_in_sparse_checkout(path, &the_index))
> +			continue;
> +
>  		switch (fix_unmerged_status(p, data)) {
>  		default:
>  			die(_("unexpected diff status %c"), p->status);

If I use this second callback, then I have access to 'include_sparse'
in the later change that adds the --sparse option.

> I believe we also need to update a few other places to use the
> `(ce_skip_worktree(ce) || !path_in_sparse_checkout())` logic in order to
> avoid updating tracked sparse paths: chmod_pathspec() for add's --chmod
> option, renormalize_tracked_files() for --renormalize, and
> read-cache.c:refresh_index() for --refresh.

OK, I'll make sure to include and test these cases.
 
>>                         continue;
>>                 ce_path_match(istate, ce, pathspec, seen);
>>         }
> 
> Hmm, don't we also want to update
> find_pathspecs_matching_skip_worktree() in this patch to use
> path_in_sparse_checkout()? I see you did that in patch 8, but I think
> this should be together with this current patch as, without it, we stop
> adding tracked sparse paths but we print no error/advice message about
> it.

I'll merge the patches to avoid confusion.

Thanks,
-Stolee
