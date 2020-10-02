Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3917C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E73B2072E
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLIM+8sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJBUDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJBUDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 16:03:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87489C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 13:03:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so2012302pfp.11
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s2G8XE5OUu7OEbb0y5gdrC5leD010LnkeF/V2Sicsp4=;
        b=GLIM+8sDTB0rp4D9UN/X7J3jfHw5R1Rkjo8u37QBeoMut25Dd9xnHY9iGHuk9mmVnz
         YpuxRJeg7aDwkmfNO5DCB/vBpELscug6QxPBZ/2w7cvvLZ+8atVYx6jzDL4txDdaPHK0
         bgulyA+N89fd/QjbSJsv9+lQMSI5+OodNHbgRbU+mnPC0dolImZPE57jRX8IKq+MFKjC
         RATdDKOCZ/ZtR4hyfGp2Dy5trM+XQwuLezKKiULpYa9RpUo1Sibvsd+zyx+bdgE6KOHp
         riR4GDzkZ2D0icPwnvK8xOaMJwUEjsFjBgpTNvLNGWlXaNyH5QlLX2+NQe42lFv3b6hs
         IiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s2G8XE5OUu7OEbb0y5gdrC5leD010LnkeF/V2Sicsp4=;
        b=pjDSWIdP0vEGrDPsogcvjbDxubwskR11Bx/kFY5jO80ltOj2SFA3bsPdx/vK7qp3oj
         wfmTM5JFZYZbKPQ5GMOnUtqyPyQxqYFZ2mpR5aKs99CbNLiRSO8Qzkoj1OdacXtdJqjI
         aBRDTgfKeGnIVUNNFWVZ7ytfLIfW8+LUA+75Bs5zLBSVg8nxt/Zjnu3+DKTrRnpeYzym
         Kcc4AQ0He5yuV6/cxvTq7OLx5cJ2b+l0gLQAeKaDzrbzr/xxeb6uSiArbr9IPrUmUC8T
         ZX3R5mMD9iYAXZg9PpuKy/Dpo/anKiocI8spW2GyjNONOeKvJKZZK0HkArcHuQOgOZPU
         LgTA==
X-Gm-Message-State: AOAM533sn1m9nXLp5aCEwSUVR5sb6ByvFTK+vBMuLICdVr46ROEyJvSL
        Mk9RKWN4BQ0BP8JTPt6aT9Q=
X-Google-Smtp-Source: ABdhPJxNFQVd1RUexgte1VKR+ZpIaDaSwt+Ex3Be+446ybzKvL8juACK7Zex08IodtiGYBsHiwCedQ==
X-Received: by 2002:a63:1d5a:: with SMTP id d26mr3656975pgm.432.1601668994874;
        Fri, 02 Oct 2020 13:03:14 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id w195sm2855417pff.74.2020.10.02.13.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 13:03:14 -0700 (PDT)
Date:   Sat, 3 Oct 2020 01:33:08 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-reach: fix in_merge_bases_many bug
Message-ID: <20201002200308.GC78209@mail.clickyotomy.dev>
References: <pull.739.git.1601650736489.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.739.git.1601650736489.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 10/02/2020 14:58, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Way back in f9b8908b (commit.c: use generation numbers for
> in_merge_bases(), 2018-05-01), a heuristic was used to short-circuit
> the in_merge_bases() walk. This works just fine as long as the
> caller is checking only two commits, but when there are multiple,
> there is a possibility that this heuristic is _very wrong_.
> 
> Some code moves since then has changed this method to
> repo_in_merge_bases_many() inside commit-reach.c. The heuristic
> computes the minimum generation number of the "reference" list, then
> compares this number to the generation number of the "commit".
> 
> In a recent topic, a test was added that used in_merge_bases_many()
> to test if a commit was reachable from a number of commits pulled
> from a reflog. However, this highlighted the problem: if any of the
> reference commits have a smaller generation number than the given
> commit, then the walk is skipped _even if there exist some with
> higher generation number_.
> 
> This heuristic is wrong! It must check the MAXIMUM generation number
> of the reference commits, not the MINIMUM.
> 
> This highlights a testing gap. t6600-test-reach.sh covers many
> methods in commit-reach.c, including in_merge_bases() and
> get_merge_bases_many(), but since these methods either restrict to
> two input commits or actually look for the full list of merge bases,
> they don't check this heuristic!
> 
> Add a possible input to "test-tool reach" that tests
> in_merge_bases_many() and add tests to t6600-test-reach.sh that
> cover this heuristic. This includes cases for the reference commits
> having generation above and below the generation of the input commit,
> but also having maximum generation below the generation of the input
> commit.
> 
> The fix itself is to swap min_generation with a max_generation in
> repo_in_merge_bases_many().
> 
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Reported-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     Fix in_merge_bases_many() with commit-graphs
>     
>     Johannes alerted me to the difficulties Srinidhi was having with 
>     in_merge_bases_many() and commit-graphs. Sorry that I hadn't seen that
>     thread and the issues therein.
>     
>     After working with Johannes to investigate what was happening, we found
>     a 2-year-old bug in the generation number checks!
>     
>     Thanks, -Stolee
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-739%2Fderrickstolee%2Fin-merge-bases-many-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-739/derrickstolee/in-merge-bases-many-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/739
> 
>  commit-reach.c        |  8 ++++----
>  t/helper/test-reach.c |  2 ++
>  t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/commit-reach.c b/commit-reach.c
> index efd5925cbb..50175b159e 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -321,7 +321,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
>  {
>  	struct commit_list *bases;
>  	int ret = 0, i;
> -	uint32_t generation, min_generation = GENERATION_NUMBER_INFINITY;
> +	uint32_t generation, max_generation = GENERATION_NUMBER_ZERO;
>  
>  	if (repo_parse_commit(r, commit))
>  		return ret;
> @@ -330,12 +330,12 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
>  			return ret;
>  
>  		generation = commit_graph_generation(reference[i]);
> -		if (generation < min_generation)
> -			min_generation = generation;
> +		if (generation > max_generation)
> +			max_generation = generation;
>  	}
>  
>  	generation = commit_graph_generation(commit);
> -	if (generation > min_generation)
> +	if (generation > max_generation)
>  		return ret;

This is correct; good catch.

>  	bases = paint_down_to_common(r, commit,
> diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
> index 14a3655442..cda804ed79 100644
> --- a/t/helper/test-reach.c
> +++ b/t/helper/test-reach.c
> @@ -107,6 +107,8 @@ int cmd__reach(int ac, const char **av)
>  		printf("%s(A,B):%d\n", av[1], ref_newer(&oid_A, &oid_B));
>  	else if (!strcmp(av[1], "in_merge_bases"))
>  		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
> +	else if (!strcmp(av[1], "in_merge_bases_many"))
> +		printf("%s(A,X):%d\n", av[1], in_merge_bases_many(A, X_nr, X_array));
>  	else if (!strcmp(av[1], "is_descendant_of"))
>  		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
>  	else if (!strcmp(av[1], "get_merge_bases_many")) {
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index 475564bee7..f807276337 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -110,6 +110,36 @@ test_expect_success 'in_merge_bases:miss' '
>  	test_three_modes in_merge_bases
>  '
>  
> +test_expect_success 'in_merge_bases_many:hit' '
> +	cat >input <<-\EOF &&
> +	A:commit-6-8
> +	X:commit-6-9
> +	X:commit-5-7
> +	EOF
> +	echo "in_merge_bases_many(A,X):1" >expect &&
> +	test_three_modes in_merge_bases_many
> +'
> +
> +test_expect_success 'in_merge_bases_many:miss' '
> +	cat >input <<-\EOF &&
> +	A:commit-6-8
> +	X:commit-7-7
> +	X:commit-8-6
> +	EOF
> +	echo "in_merge_bases_many(A,X):0" >expect &&
> +	test_three_modes in_merge_bases_many
> +'
> +
> +test_expect_success 'in_merge_bases_many:miss-heuristic' '
> +	cat >input <<-\EOF &&
> +	A:commit-6-8
> +	X:commit-7-5
> +	X:commit-6-6
> +	EOF
> +	echo "in_merge_bases_many(A,X):0" >expect &&
> +	test_three_modes in_merge_bases_many
> +'
> +
>  test_expect_success 'is_descendant_of:hit' '
>  	cat >input <<-\EOF &&
>  	A:commit-5-7
> 
> base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
> -- 
> gitgitgadget

Thanks Derrick and Johannes, for identifying the problem
and fixing the bug.

-- 
Srinidhi Kaushik
