Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28031C76199
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 00:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32B3208C3
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 00:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipmuph+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgBQABE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 19:01:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32960 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgBQABE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 19:01:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so16777905lji.0
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 16:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WBiR2+px7lBEqzO7jPoZfORjESPWcC+DG5K78o7YV9k=;
        b=Ipmuph+nrno6bqpXH+J0MP+aMyhtLmF7Vh3e6jcFD3iMRnLuVwBWbbimOQSfGEtlJ4
         GX+r2p7WFusZ8Bylx0KrlCBrHplLRfrksFyqJLF2wTY1kLfL6edJhvGaB7Y/fULb+FQg
         6nQYwPkouAAHTDao+FqenJ6HU7zsEr5R5XOzcNfeYnMZIT9/iTsofk0arhiP5kdymv/G
         dhtORp13O3ND2iGzWpNTjYYsjyvAscKmfq4wc1J9YWnGwTvhMQlQTXv3aprj+HvNouOF
         GCaPvfu3nknIhMgV9ftEDMPU5+R2LT9aJaPbbZJz0Jxhi66joU2dxexOgaIWVrPiPex2
         PQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=WBiR2+px7lBEqzO7jPoZfORjESPWcC+DG5K78o7YV9k=;
        b=cqIliMrLxbVREH3PNgwrXMp7c4H6lLJYG/hOv7tFnI4mpinq5PNXZMA1hd1KRwvchk
         c6C4QSMx+CnvwknF4xOaVHzbja1SAMw8Z6jBOONa3TVASX40MML96iAgMVQ6hEJNoaju
         bShA8OSRvCoxJsoeNi/RrMbaEoB/B5saQ7BqQAA7jeEN3zDS7cqIQP/vqhI6pzeIwezQ
         HIWyshjwxD6iJErCXTGR/btrZRGrVfTfFquiyk11jEW97QZff0rJi/kIxqexYlBEccQ+
         pjCnyI8JmWIQhtm7H3dVe/epnMQnItzJuOvEJ+uzLI7qljldH+BSsZAq3NtpE6auh206
         R3og==
X-Gm-Message-State: APjAAAUNhY2pRw8js3VAYI+SJ+bZN756RzV2v/BdnTrGUcBtBCPhLu6s
        Y+4Mo+vHOakbgBcy/dv1Rjk=
X-Google-Smtp-Source: APXvYqyQgC0ggD5vG7QkDyPFcZ2/jiu0JAMjDAB53r8KjiXB5CD1fQPmXpn2lGY2Zxmss7spjymsQA==
X-Received: by 2002:a2e:9955:: with SMTP id r21mr8092551ljj.283.1581897661561;
        Sun, 16 Feb 2020 16:01:01 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id d5sm6574346lfb.20.2020.02.16.16.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Feb 2020 16:01:00 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Garima Singh <garimasigit@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 03/11] diff: halt tree-diff early after max_changes
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <a698c04a78cf2988fb822e0aa532989f925e0a9e.1580943390.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 01:00:53 +0100
In-Reply-To: <a698c04a78cf2988fb822e0aa532989f925e0a9e.1580943390.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 05 Feb 2020
        22:56:22 +0000")
Message-ID: <86h7zqqdze.fsf@gmail.com>
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
> When computing the changed-paths bloom filters for the commit-graph,
> we limit the size of the filter by restricting the number of paths
> in the diff. Instead of computing a large diff and then ignoring the
> result, it is better to halt the diff computation early.

Good idea.

>
> Create a new "max_changes" option in struct diff_options. If non-zero,
> then halt the diff computation after discovering strictly more changed
> paths. This includes paths corresponding to trees that change.

All right; also, it doesn't need to be exact, though it would be good if
it was.

512 changed paths (changed files) usually generate more than 512
elements to be added to the Bloom filter (changed directories and
files), anyway.

>
> Use this max_changes option in the bloom filter calculations. This
> reduces the time taken to compute the filters for the Linux kernel
> repo from 2m50s to 2m35s. On a large internal repository with ~500
> commits that perform tree-wide changes, the time reduced from
> 6m15s to 3m48s.

I wonder if there is some large open-source project with many commits
performing tree-wide changes, that is with many commits with more than
512 changed files with respect to the first parent.

Maybe https://github.com/whosonfirst-data/whosonfirst-data-venue-us-ny
from "Top Ten Worst Repositories to host on GitHub - Git Merge 2017"
could be a good repository to test ;-)

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>

Looks good to me, but that is from cursory examination.
Don't know the area to say anything more.

> ---
>  bloom.c     | 4 +++-
>  diff.h      | 5 +++++
>  tree-diff.c | 6 ++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/bloom.c b/bloom.c
> index 6082193a75..818382c03b 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -134,6 +134,7 @@ struct bloom_filter *get_bloom_filter(struct reposito=
ry *r,
>  	struct bloom_filter_settings settings =3D DEFAULT_BLOOM_FILTER_SETTINGS;
>  	int i;
>  	struct diff_options diffopt;
> +	int max_changes =3D 512;
>=20=20
>  	if (!bloom_filters.slab_size)
>  		return NULL;
> @@ -142,6 +143,7 @@ struct bloom_filter *get_bloom_filter(struct reposito=
ry *r,
>=20=20
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive =3D 1;
> +	diffopt.max_changes =3D max_changes;
>  	diff_setup_done(&diffopt);
>=20=20
>  	if (c->parents)
> @@ -150,7 +152,7 @@ struct bloom_filter *get_bloom_filter(struct reposito=
ry *r,
>  		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
>  	diffcore_std(&diffopt);
>=20=20
> -	if (diff_queued_diff.nr <=3D 512) {
> +	if (diff_queued_diff.nr <=3D max_changes) {
>  		struct hashmap pathmap;
>  		struct pathmap_hash_entry* e;
>  		struct hashmap_iter iter;
> diff --git a/diff.h b/diff.h
> index 6febe7e365..9443dc1b00 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -285,6 +285,11 @@ struct diff_options {
>  	/* Number of hexdigits to abbreviate raw format output to. */
>  	int abbrev;
>=20=20
> +	/* If non-zero, then stop computing after this many changes. */
> +	int max_changes;
> +	/* For internal use only. */
> +	int num_changes;
> +
>  	int ita_invisible_in_index;
>  /* white-space error highlighting */
>  #define WSEH_NEW (1<<12)
> diff --git a/tree-diff.c b/tree-diff.c
> index 33ded7f8b3..f3d303c6e5 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -434,6 +434,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  		if (diff_can_quit_early(opt))
>  			break;
>=20=20
> +		if (opt->max_changes && opt->num_changes > opt->max_changes)
> +			break;
> +
>  		if (opt->pathspec.nr) {
>  			skip_uninteresting(&t, base, opt);
>  			for (i =3D 0; i < nparent; i++)
> @@ -518,6 +521,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
>=20=20
>  			/* t=E2=86=93 */
>  			update_tree_entry(&t);
> +			opt->num_changes++;
>  		}
>=20=20
>  		/* t > p[imin] */
> @@ -535,6 +539,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  		skip_emit_tp:
>  			/* =E2=88=80 pi=3Dp[imin]  pi=E2=86=93 */
>  			update_tp_entries(tp, nparent);
> +			opt->num_changes++;
>  		}
>  	}
>=20=20
> @@ -552,6 +557,7 @@ struct combine_diff_path *diff_tree_paths(
>  	const struct object_id **parents_oid, int nparent,
>  	struct strbuf *base, struct diff_options *opt)
>  {
> +	opt->num_changes =3D 0;
>  	p =3D ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
>=20=20
>  	/*
