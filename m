Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E7C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiB1PZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiB1PZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:25:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46DE2C66B
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:24:23 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i11so18070787eda.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7C8UyYA1FHp5PlwtN8QIPeOFFryMUf6z6vPvPLYUAxg=;
        b=JBSMUHeOg+Wv/If+3pAYoWv08oDIisB0aJqzXGJDCd5Ye54MSj37OiSkhd6n2tmoIE
         yVrjDX5Q9go+qYprf4bUzqivR1H6QYTaV+GOaC23N/GtIWi21s55sy9ClN/1wTalenbg
         ftaYbtlnvxYYt01GUHY4DKdowpbyMUqQaMoe52oWMj+xTqz0SVi1YmFZ2CCytHf7FSao
         NVPHWdS/myO93geIS5BD+a0uhRUe6K2+Lk0sZuM5kOb7Sc95J9gHKAF5R7/NTqpnjq20
         u7cEtGqqriMb+U2H/OIAKSyWLcZSSB4POmo1Lkxe5VNvziTn+d+wkZuN0e9zev9Am0Sa
         Hg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7C8UyYA1FHp5PlwtN8QIPeOFFryMUf6z6vPvPLYUAxg=;
        b=rQDDJ0uwl/NAzox6u42kAt0A3IdrWZhV3EPoUXTqLoJuTpZrlsN7AWmkrRrvizLJdx
         anW3Fb++q3oaRVIQhPlhm9CVCTLM481WknPqrEO4xpBhbqDRRHkYHHWY1/vE2Hef34qr
         vihsNnVD1GZozBSa+fgnHVmTKH0x/IJiGYByxjp7SSMegBM2qchWF7ykBFd/7qEr26kt
         z2AGBN14uhbk7x9ENZ01yLTyH7KhCuwIaCSXm7DyVv7qb9UWuloRNyqv9dUrj6AKi0zp
         Sl/zO0+Q4zuIg9sryFu4ygxxC+/+0dpxSMuiFx//XbPitKMtaeXwBY9mNIJ9a79KBkS+
         POKA==
X-Gm-Message-State: AOAM5305vY1onXCucZB6EULb1VOoiaPYSzCICiGqFLLAFY0mSKTTujcD
        2z7OLe7Mf1yomD87t+vkNyE/Krptd3g=
X-Google-Smtp-Source: ABdhPJyTy8IYNncCJIwE4utqs/HWxzneXKB0bxLzmqLAxMW+cevGgXCo3hXfuDmNsfiDuSgaG6aJJA==
X-Received: by 2002:a05:6402:1756:b0:410:be91:cd5b with SMTP id v22-20020a056402175600b00410be91cd5bmr20058696edx.375.1646061862042;
        Mon, 28 Feb 2022 07:24:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa13-20020a1709076d0d00b006ce3ef8e1d4sm4422884ejc.31.2022.02.28.07.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 07:24:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOhsq-001QXv-VU;
        Mon, 28 Feb 2022 16:24:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/4] test-read-graph: include extra post-parse info
Date:   Mon, 28 Feb 2022 16:22:04 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
 <2f89275314b4a2a89a18d14e41602bbe2e1988dc.1646056423.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2f89275314b4a2a89a18d14e41602bbe2e1988dc.1646056423.git.gitgitgadget@gmail.com>
Message-ID: <220228.86lexv3tgb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> It can be helpful to verify that the 'struct commit_graph' that results
> from parsing a commit-graph is correctly structured. The existence of
> different chunks is not enough to verify that all of the optional
> features are correctly enabled.
>
> Update 'test-tool read-graph' to output an "options:" line that includes
> information for different parts of the struct commit_graph.
>
> In particular, this change demonstrates that the read_generation_data
> option is never being enabled, which will be fixed in a later change.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/helper/test-read-graph.c    | 13 +++++++++++++
>  t/t4216-log-bloom.sh          |  1 +
>  t/t5318-commit-graph.sh       |  1 +
>  t/t5324-split-commit-graph.sh |  5 +++++
>  4 files changed, 20 insertions(+)
>
> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index 75927b2c81d..c3b6b8d1734 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -3,6 +3,7 @@
>  #include "commit-graph.h"
>  #include "repository.h"
>  #include "object-store.h"
> +#include "bloom.h"
>  
>  int cmd__read_graph(int argc, const char **argv)
>  {
> @@ -45,6 +46,18 @@ int cmd__read_graph(int argc, const char **argv)
>  		printf(" bloom_data");
>  	printf("\n");
>  
> +	printf("options:");
> +	if (graph->bloom_filter_settings)
> +		printf(" bloom(%d,%d,%d)",

I think this is probably unportable, as other code (including in
commit-graph.c) uses "%"PRIu32 when printing uint32_t.

Does this work on our Linux32 job? I was going to quickly check the PR
CI, but it appears the run was skipped for some reason.

> +		       graph->bloom_filter_settings->hash_version,
> +		       graph->bloom_filter_settings->bits_per_entry,
> +		       graph->bloom_filter_settings->num_hashes);
> +	if (graph->read_generation_data)
> +		printf(" read_generation_data");
> +	if (graph->topo_levels)
> +		printf(" topo_levels");
> +	printf("\n");
> +
>  	UNLEAK(graph);
>  
>  	return 0;
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index cc3cebf6722..5ed6d2a21c1 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -48,6 +48,7 @@ graph_read_expect () {
>  	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
>  	num_commits: $1
>  	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
> +	options: bloom(1,10,7)
>  	EOF
>  	test-tool read-graph >actual &&
>  	test_cmp expect actual
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index edb728f77c3..2b05026cf6d 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -104,6 +104,7 @@ graph_read_expect() {
>  	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
>  	num_commits: $1
>  	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
> +	options:
>  	EOF
>  	test-tool read-graph >output &&
>  	test_cmp expect output
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 847b8097109..778fa418de2 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -34,6 +34,7 @@ graph_read_expect() {
>  	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
>  	num_commits: $1
>  	chunks: oid_fanout oid_lookup commit_metadata generation_data
> +	options:
>  	EOF
>  	test-tool read-graph >output &&
>  	test_cmp expect output
> @@ -508,6 +509,7 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
>  		header: 43475048 1 $(test_oid oid_version) 4 1
>  		num_commits: $NUM_SECOND_LAYER_COMMITS
>  		chunks: oid_fanout oid_lookup commit_metadata
> +		options:
>  		EOF
>  		test_cmp expect output &&
>  		git commit-graph verify &&
> @@ -540,6 +542,7 @@ test_expect_success 'do not write generation data chunk if not present on existi
>  		header: 43475048 1 $(test_oid oid_version) 4 2
>  		num_commits: $NUM_THIRD_LAYER_COMMITS
>  		chunks: oid_fanout oid_lookup commit_metadata
> +		options:
>  		EOF
>  		test_cmp expect output &&
>  		git commit-graph verify
> @@ -581,6 +584,7 @@ test_expect_success 'do not write generation data chunk if the topmost remaining
>  		header: 43475048 1 $(test_oid oid_version) 4 2
>  		num_commits: $(($NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS))
>  		chunks: oid_fanout oid_lookup commit_metadata
> +		options:
>  		EOF
>  		test_cmp expect output &&
>  		git commit-graph verify
> @@ -620,6 +624,7 @@ test_expect_success 'write generation data chunk if topmost remaining layer has
>  		header: 43475048 1 $(test_oid oid_version) 5 1
>  		num_commits: $(($NUM_SECOND_LAYER_COMMITS + $NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS + $NUM_FIFTH_LAYER_COMMITS))
>  		chunks: oid_fanout oid_lookup commit_metadata generation_data
> +		options:
>  		EOF
>  		test_cmp expect output
>  	)

I think the rest of this all looks good and obviously correct.
