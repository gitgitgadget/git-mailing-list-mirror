Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F14C34031
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 00:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C89208E4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 00:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/u14kPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBSAdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:33:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34017 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgBSAdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 19:33:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so25113547ljc.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MIf7z6d2ScchPVXs3fVF45rrBhJaVAkI6X4gH4UWP5s=;
        b=P/u14kPX0XYWAV1BQ9fJbGMRZk4lzIElPJPRo+XoXyt0Yyh7APY2ghostJdIIlxbiZ
         n03u3ufk/f9uxfaKtWDXzIZkNTJ6DiKFSgswEclhz7USIpO/So+CMrANSu8Ed5/FJUOq
         6Negls6pStoL6SwmRp+7avViA6y5lvL4ez70kVid2bod3bcG6SCQuYyRxfG111wj+H+7
         uB48Keylxi3pTkyIh+EGUIPUiSGd0CiHYtTzoVQQHaZkUOLr/dVx6Qev1guuUvEzZnaD
         jslhqXM/NpSRyfqXb1JnzRze/8D9a00n3vZ7GwmhmdLqu5rBju3xQ1TGYmbcFUmF0NAw
         PBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=MIf7z6d2ScchPVXs3fVF45rrBhJaVAkI6X4gH4UWP5s=;
        b=ped1GjIFNa9soidxhlNLEFmrzyofPJRuPifLkzjr5Bdl0XivheZOMOM39iEi24RRWh
         UGNJPn+VqFWqRRAlFbkWHtlK/z0GKdPee8beDCwOK+z8U5phLjbbB11tXf9d1WxxWclQ
         3sPmNk0byLEvLNOR5RUW5X70dcuIuVNvh8WbhnEyMyiGMBPDOuuZHM4I+SRZMhIxQCX9
         pA/koL4LrGIAYubkzsvVb1CKQuceT01taonufFJAclqy4uhDDUqE6QcdV/6Wj2Cp9QBK
         ZiPS20sO/ZXGQhei4nTieVme9cn3cjhhwjS+MtolVbCXSMgpsqE8zvkEppKUJ+7eNlJg
         20Sw==
X-Gm-Message-State: APjAAAXvFIntpKdp+6jR3+YZH6RY23dSd7Ra7fHpGgAp9V2uGNgYdbjN
        Zy4/XJ0WqJHL4hsQiWOrrvs=
X-Google-Smtp-Source: APXvYqw8Y23U/zQyHKFwIsJibm4K6Q1Y/EVC4iUe1AWBDA7+BPbLqkbpDRYtYeiNLsWWSAI/ErcSNA==
X-Received: by 2002:a05:651c:cf:: with SMTP id 15mr14987297ljr.288.1582072386193;
        Tue, 18 Feb 2020 16:33:06 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id 4sm63589lfj.75.2020.02.18.16.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 16:32:30 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Garima Singh <garimasigit@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 06/11] commit-graph: examine commits by generation number
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <58704d81b6b4fbc54715457246aeed783eb32a99.1580943390.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 01:32:04 +0100
In-Reply-To: <58704d81b6b4fbc54715457246aeed783eb32a99.1580943390.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 05 Feb 2020
        22:56:25 +0000")
Message-ID: <865zg3ju2j.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When running 'git commit-graph write --changed-paths', we sort the
> commits by pack-order to save time when computing the changed-paths
> bloom filters. This does not help when finding the commits via the
> --reachable flag.

Minor improvement suggestion: s/--reachable flag/'--reachable' flag/.

>
> If not using pack-order, then sort by generation number before
> examining the diff.

All right, that is good description of what the patch does.

>                     Commits with similar generation are more likely
> to have many trees in common, making the diff faster.

Is this what causes the performance improvement, that subsequently
examined commits are more likely to have more trees in common, which
means that those trees would be hot in cache, making generating diff
faster?  Is it what profiling shows?

>
> On the Linux kernel repository, this change reduced the computation
> time for 'git commit-graph write --reachable --changed-paths' from
> 3m00s to 1m37s.

Would using the trick used for packfiles also for '--reachable', which
would mean commits examined in recency / reachability order, give
similar, worse or better performance improvements?

We would want this sorting order as one of possibilities anyway, because
'--stdin-commits' we could get commits in random order.

>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  commit-graph.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index e125511a1c..32a315058f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -70,6 +70,25 @@ static int commit_pos_cmp(const void *va, const void *=
vb)
>  	       commit_pos_at(&commit_pos, b);
>  }
>=20=20
> +static int commit_gen_cmp(const void *va, const void *vb)
> +{
> +	const struct commit *a =3D *(const struct commit **)va;
> +	const struct commit *b =3D *(const struct commit **)vb;
> +
> +	/* lower generation commits first */

Shouldn't higher generation commits come first, in recency-like order?
Or it doesn't matter if it is sorted in ascending or descending order,
as long as commits with close generation numbers are examined close
together?

> +	if (a->generation < b->generation)
> +		return -1;
> +	else if (a->generation > b->generation)
> +		return 1;
> +
> +	/* use date as a heuristic when generations are equal */
> +	if (a->date < b->date)
> +		return -1;
> +	else if (a->date > b->date)
> +		return 1;
> +	return 0;
> +}

I thought we have had such comparison function defined somewhere in Git
already, but I think I'm wrong here.

> +
>  char *get_commit_graph_filename(const char *obj_dir)
>  {
>  	char *filename =3D xstrfmt("%s/info/commit-graph", obj_dir);
> @@ -821,7 +840,8 @@ struct write_commit_graph_context {
>  		 report_progress:1,
>  		 split:1,
>  		 check_oids:1,
> -		 changed_paths:1;
> +		 changed_paths:1,
> +		 order_by_pack:1;
>=20=20
>  	const struct split_commit_graph_opts *split_opts;
>  	uint32_t total_bloom_filter_data_size;
> @@ -1184,7 +1204,11 @@ static void compute_bloom_filters(struct write_com=
mit_graph_context *ctx)
>=20=20
>  	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
>  	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
> -	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
> +
> +	if (ctx->order_by_pack)
> +		QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
> +	else
> +		QSORT(sorted_by_pos, ctx->commits.nr, commit_gen_cmp);

Here 'sorted_b_pos' variable name no longer reflects reality...
(see comment to the previous patch in the series).

>=20=20
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>  		struct commit *c =3D sorted_by_pos[i];
> @@ -1902,6 +1926,7 @@ int write_commit_graph(const char *obj_dir,
>  	}
>=20=20
>  	if (pack_indexes) {
> +		ctx->order_by_pack =3D 1;
>  		if ((res =3D fill_oids_from_packs(ctx, pack_indexes)))
>  			goto cleanup;
>  	}
> @@ -1911,8 +1936,10 @@ int write_commit_graph(const char *obj_dir,
>  			goto cleanup;
>  	}
>=20=20
> -	if (!pack_indexes && !commit_hex)
> +	if (!pack_indexes && !commit_hex) {
> +		ctx->order_by_pack =3D 1;
>  		fill_oids_from_all_packs(ctx);
> +	}
>=20=20
>  	close_reachable(ctx);

All right, that covers all cases where 'git commit-graph write' writes
serialized commit-graph based on the commits found in packfiles:
'--stdin-packs' and default no option case, in that order.

Looks good.

Best,
--=20
Jakub Nar=C4=99bski
