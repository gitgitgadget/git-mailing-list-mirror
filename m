Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B82AC433FE
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 19:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiB1TwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiB1TwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 14:52:11 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806E10217B
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 11:50:58 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso4348070oop.13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 11:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x7nb1aglhi6elY+9ugs1IrCPqbE4s4yIdFPORuIrng4=;
        b=NLIjUYiPbJNPw3FMk/AsONmGxvbDf4AVHrZ6TiZj5JmS5egTwqivhDy6TjBpRoL+VU
         GKi6/DV5FA1Z5k4qwjHLbAMlaPB+43agGPhy/28XjbIwRt8G6GTFil3JaxGOtUbtAie0
         rIkDZpPnBu2CZxmUwWvBk7ZrvT4KCUUsfdG5uWFtZXG8BJu3uVGAce9/2MVbDmQHd1ZC
         KPZgY2f253dl7Crz2ses1A6A9BjTjYdllCMMt0qxCegiRZgHAEQn+/A9B1LH11u4ixOb
         uPVLIyDfnWAzfNhGmdz7mvj01Ob0Or46IFSuXwtVHS2W2Nie9RlXqRDQzpuf8Kg/MiCu
         bKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x7nb1aglhi6elY+9ugs1IrCPqbE4s4yIdFPORuIrng4=;
        b=et10DMm/zXSOW16acKcsI7xFMF5WQwMlrXDsJp2ciUc6qtfIPEXSEDHZoKLsx/96+l
         dpcLoiMW73qpoJIyOZrxAI3T7+Ve5f8S3kX3ZsFsNYGFI5NCGZnm359N2lJsb7DDkBQp
         /ElsotyZKCVbUVfjfVu2Mc8qfF5+3IDx2Sa2/MFAoBTfzFLpGIyLuL4dV+7lVkfuxgOs
         E0LQUaB4vAGj6KKalSwSns6DjrBbAeLRRnl7JLOQHcW22W/NAKWcLN9Z1qwfvubDvLN5
         ghJItzBO0G0nAWiKpcnr4OxL0q7VLjZQTJcW499VDfuo0H5boxSe5QL+IRcL4BPBgzt8
         jySg==
X-Gm-Message-State: AOAM532AQnFjJDboZAdZ0fG7KEehAOM6NTEn6QnDre09PDIMLzMhqdp4
        dcfb8XuTX/OiMHRnIUyaNZHl
X-Google-Smtp-Source: ABdhPJyv9ru/epFw/O/GUV3kBtylhTxDfAwwvRZh+Y+5UYyt57Tof1dDo5S1NpWWfveaNsA5Qu6apg==
X-Received: by 2002:a05:6870:1041:b0:d3:521b:f78a with SMTP id 1-20020a056870104100b000d3521bf78amr8703486oaj.13.1646077857653;
        Mon, 28 Feb 2022 11:50:57 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x12-20020a056830244c00b005ad233e0ba3sm5483499otr.48.2022.02.28.11.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 11:50:57 -0800 (PST)
Message-ID: <e4096124-e566-0842-f17c-366645c3e37c@github.com>
Date:   Mon, 28 Feb 2022 14:50:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] name-rev: use generation numbers if available
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20220228190738.2112503-1-jacob.e.keller@intel.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220228190738.2112503-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2022 2:07 PM, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> If a commit in a sequence of linear history has a non-monotonically
> increasing commit timestamp, git name-rev might not properly name the
> commit.
> 
> This occurs because name-rev uses a heuristic of the commit date to
> avoid searching down tags which lead to commits that are older than the
> named commit. This is intended to avoid work on larger repositories.
> 
> This heuristic impacts git name-rev, and by extension git describe
> --contains which is built on top of name-rev.
> 
> Further more, if --annotate-stdin is used, the heuristic is not enabled
> because the full history has to be analyzed anyways. This results in
> some confusion if a user sees that --annotate-stdin works but a normal
> name-rev does not.
> 
> If the repository has a commit graph, we can use the generation numbers
> instead of using the commit dates. This is essentially the same check
> except that generation numbers make it exact, where the commit date
> heuristic could be incorrect due to clock errors.
> 
> Add a test case which covers this behavior and shows how the commit
> graph makes the name-rev process work.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> The initial implementation of this came from [1]. Should this have Stolee's
> sign-off?
> 
> [1]: https://lore.kernel.org/git/42d2a9fe-a3f2-f841-dcd1-27a0440521b6@github.com/

I think your implementation is sufficiently different (and better)
that you don't need my co-authorship _or_ sign-off.

> +static void set_commit_cutoff(struct commit *commit)
> +{
> +	timestamp_t generation;
> +
> +	if (cutoff > commit->date)
> +		cutoff = commit->date;
> +
> +	generation = commit_graph_generation(commit);
> +	if (generation_cutoff > generation)
> +		generation_cutoff = generation;
> +}

I appreciate that you split this out into its own method to isolate
the logic.

> +/* Check if a commit is before the cutoff. Prioritize generation numbers
> + * first, but use the commit timestamp if we lack generation data.
> + */
> +static int commit_is_before_cutoff(struct commit *commit)
> +{
> +	if (generation_cutoff < GENERATION_NUMBER_INFINITY)
> +		return commit_graph_generation(commit) < generation_cutoff;
> +
> +	return commit->date < cutoff;
> +}

There are two subtle things going on here when generation_cutoff is
zero:

1. In a commit-graph with topological levels _or_ generation numbers v2,
   commit_graph_generation(commit) will always be positive, so we don't
   need to do the lookup.

2. If the commit-graph was written by an older Git version before
   topological levels were implemented, then the generation of commits
   in the commit-graph are all zero(!). This means that the logic here
   would be incorrect for the "all" case.

The fix for both cases is to return 1 if generation_cutoff is zero:

	if (!generaton_cutoff)
		return 1;
> -	if (start_commit->date < cutoff)
> +	if (commit_is_before_cutoff(start_commit))

> -			if (parent->date < cutoff)
> +			if (commit_is_before_cutoff(parent))

Nice replacements.

> -	if (all || annotate_stdin)
> +	if (all || annotate_stdin) {
> +		generation_cutoff = 0;
>  		cutoff = 0;
> +	}

Good.

> -		if (commit) {
> -			if (cutoff > commit->date)
> -				cutoff = commit->date;
> -		}
> +		if (commit)
> +			set_commit_cutoff(commit);

Another nice replacement.

> +# A-B-C-D-E-main
> +#
> +# Where C has a non-monotonically increasing commit timestamp w.r.t. other
> +# commits
> +test_expect_success 'non-monotonic commit dates setup' '
> +	UNIX_EPOCH_ZERO="@0 +0000" &&
> +	git init non-monotonic &&
> +	test_commit -C non-monotonic A &&
> +	test_commit -C non-monotonic --no-tag B &&
> +	test_commit -C non-monotonic --no-tag --date "$UNIX_EPOCH_ZERO" C &&
> +	test_commit -C non-monotonic D &&
> +	test_commit -C non-monotonic E
> +'
> +
> +test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
> +	test_config -C non-monotonic core.commitGraph true &&
> +	(
> +		cd non-monotonic &&
> +
> +		# Ensure commit graph is up to date
> +		git -c gc.writeCommitGraph=true gc &&

"git commit-graph write --reachable" would suffice here.


> +
> +		echo "main~3 tags/D~2" >expect &&
> +		git name-rev --tags main~3 >actual &&
> +
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'name-rev --all works with non-monotonic' '

This is working because of the commit-graph, right? We still have
it from the previous test, so we aren't testing that this works
when we only have the commit date as a cutoff.

> +	(
> +		cd non-monotonic &&
> +
> +		cat >expect <<-\EOF &&
> +		E
> +		D
> +		D~1
> +		D~2
> +		A
> +		EOF
> +
> +		git log --pretty=%H >revs &&
> +		git name-rev --tags --annotate-stdin --name-only <revs >actual &&
> +
> +		test_cmp expect actual
> +	)

Do you want to include a test showing the "expected" behavior
when there isn't a commit-graph file? You might need to delete
an existing commit-graph (it will exist in the case of
GIT_TEST_COMMIT_GRAPH=1).

I also see that you intended to test the "--all" option, which
is not included in your test. That's probably the real key to
getting this test to work correctly. Deleting the graph will
probably cause a failure on this test unless "--all" is added.

Thanks,
-Stolee

