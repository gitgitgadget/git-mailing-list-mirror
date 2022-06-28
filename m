Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E4C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 07:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245739AbiF1HxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242547AbiF1HxP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 03:53:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F835388F
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 00:53:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id pk21so24035888ejb.2
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UgUtcwIZX2qPJyIgeCxzbtSVWloSpuWqZaL0ZLoHps0=;
        b=ZIp34jUKpL1Ip21wALomZl7H3T9o7dDHfPrGK/V5gVd2NNs0Hr7YsRcN6SdOae9Njg
         7+M3AyHDYYFA6WLAJ9O1azPy4SLgqU64YSdkV6Et9NSjdzM3jIxTdnVbUbLKf/iwCPqd
         c5KpqAQPafqqcHZUIzzEMqU0OI0QbzZyKoSW7YMBnknhDLv1uqREUQDMo0voIshTjhGM
         nqvWyySzPfvuIWuzrFcC9q4k3JJNDFpSjo8Ofd40doHIdSjLVWGXNFWEBuU7AMSsITef
         EKLWM6WQmHJHEDwdseOjI/M2iwxcui5N8cmwkKlzyYLJDlSMj8dhHG9l7XoHt6fy6PzV
         2gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UgUtcwIZX2qPJyIgeCxzbtSVWloSpuWqZaL0ZLoHps0=;
        b=NaB/i8msfGNzQUAQ0SiXInfB/LYQ/jIEosiqylmT7Mwjg78oa0/1NxySG9Wk+QtfHW
         /wDieiuFo+P1cS77EFohbVjBV95Z1/WyvsRRPuoOM0WYvOCuyBwWhqOlb91tKpOxKmsd
         eYfOO1b4/Z09Synb0ajxnp67A11E/7z4EM9U66JX0L1x65+nUGhHyxWRXU8P4fu5EsZD
         sva+cw46m9rT3VYjBjj+YuMiplGodYQGTxh996lcHN6JM28EXXXuxxBGANa9Tx6876Lc
         zbhNsF9lB4fEYr9bjqDWX05m61OCpuSqgCWOS2ivRv/IvH+UI2j7NTj7ijvDTJJJ1p4w
         Bj9g==
X-Gm-Message-State: AJIora8K8fo7DqpfPUxZ83+e79lJUAT7YBPw0dtjEOEGIXlJ08bQEkTD
        9vl+r2xJASVUAsHwpqYdTfQ=
X-Google-Smtp-Source: AGRyM1vRhZUQlAgmbJTVigKzZ/1SlBjjVFrXZq7rZtyXaWcU8afY4VXtism+pFNPEEndNdplTWerNw==
X-Received: by 2002:a17:907:ea7:b0:70f:a27a:dac0 with SMTP id ho39-20020a1709070ea700b0070fa27adac0mr17375258ejc.25.1656402792800;
        Tue, 28 Jun 2022 00:53:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906a19600b0071cef8bafc3sm6095484ejy.1.2022.06.28.00.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:53:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6623-001jl8-2x;
        Tue, 28 Jun 2022 09:53:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: Re: [PATCH v3 2/2] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
Date:   Tue, 28 Jun 2022 09:49:58 +0200
References: <cover.1656044659.git.hanxin.hx@bytedance.com>
 <cover.1656381667.git.hanxin.hx@bytedance.com>
 <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>
Message-ID: <220628.865yklgr6g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 28 2022, Han Xin wrote:

> The commit-graph is used to opportunistically optimize accesses to
> certain pieces of information on commit objects, and
> lookup_commit_in_graph() tries to say "no" when the requested commit
> does not locally exist by returning NULL, in which case the caller
> can ask for (which may result in on-demand fetching from a promisor
> remote) and parse the commit object itself.
>
> However, it uses a wrong helper, repo_has_object_file(), to do so.
> This helper not only checks if an object is mmediately available in
> the local object store, but also tries to fetch from a promisor remote.
> But the fetch machinery calls lookup_commit_in_graph(), thus causing an
> infinite loop.
>
> We should make lookup_commit_in_graph() expect that a commit given to it
> can be legitimately missing from the local object store, by using the
> has_object_file() helper instead.
>
> Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> ---
>  commit-graph.c                             |  2 +-
>  t/t5329-no-lazy-fetch-with-commit-graph.sh | 53 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5329-no-lazy-fetch-with-commit-graph.sh
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 2b52818731..2dd9bcc7ea 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -907,7 +907,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
>  		return NULL;
>  	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
>  		return NULL;
> -	if (!repo_has_object_file(repo, id))
> +	if (!has_object(repo, id, 0))
>  		return NULL;
>  
>  	commit = lookup_commit(repo, id);
> diff --git a/t/t5329-no-lazy-fetch-with-commit-graph.sh b/t/t5329-no-lazy-fetch-with-commit-graph.sh
> new file mode 100755
> index 0000000000..d7877a5758
> --- /dev/null
> +++ b/t/t5329-no-lazy-fetch-with-commit-graph.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +test_description='test for no lazy fetch with the commit-graph'
> +
> +. ./test-lib.sh
> +
> +if ! test_have_prereq ULIMIT_PROCESSES

I think the prereq in 1/2 would be better off squashed into this commit.

> +then
> +	skip_all='skipping tests for no lazy fetch with the commit-graph, ulimit processes not available'
> +	test_done
> +fi
> +
> +test_expect_success 'setup: prepare a repository with a commit' '
> +	git init with-commit &&
> +	test_commit -C with-commit the-commit &&
> +	oid=$(git -C with-commit rev-parse HEAD)
> +'
> +
> +test_expect_success 'setup: prepare a repository with commit-graph contains the commit' '
> +	git init with-commit-graph &&
> +	echo "$(pwd)/with-commit/.git/objects" \

nit: you can use $PWD instead of $(pwd).

> +		>with-commit-graph/.git/objects/info/alternates &&
> +	# create a ref that points to the commit in alternates
> +	git -C with-commit-graph update-ref refs/ref_to_the_commit "$oid" &&
> +	# prepare some other objects to commit-graph
> +	test_commit -C with-commit-graph something &&
> +	git -c gc.writeCommitGraph=true -C with-commit-graph gc &&
> +	test_path_is_file with-commit-graph/.git/objects/info/commit-graph
> +'
> +
> +test_expect_success 'setup: change the alternates to what without the commit' '
> +	git init --bare without-commit &&

Maybe run a successful cat-file here...
> +	echo "$(pwd)/without-commit/objects" \
> +		>with-commit-graph/.git/objects/info/alternates &&
> +	test_must_fail git -C with-commit-graph cat-file -e $oid
...to show that it fails after the "echo" above?
> +'
> +
> +test_expect_success 'setup: prepare any commit to fetch' '
> +	test_commit -C with-commit any-commit &&
> +	anycommit=$(git -C with-commit rev-parse HEAD)

I think this would be better just added before a \n\n in the next test.
> +'
> +
> +test_expect_success 'fetch any commit from promisor with the usage of the commit graph' '
> +	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
> +	git -C with-commit-graph config remote.origin.promisor true &&
> +	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
> +	run_with_limited_processses env GIT_TRACE="$(pwd)/trace" \
> +		git -C with-commit-graph fetch origin $anycommit 2>err &&


> +	test_i18ngrep ! "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
> +	test $(grep "fetch origin" trace | wc -l) -eq 1


Use "grep", not "test_i18ngrep", and this should use "test_line_count".

But actually better yet: this whole thing looks like it could use
"test_subcommand" instead, couldn't it?
