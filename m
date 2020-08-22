Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7EC433E1
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 00:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4D12067C
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 00:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkFNB4tG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHVAFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 20:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHVAFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 20:05:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED186C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 17:05:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so3684845ljc.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dSbmE+uYPtEW1FISTUeHogKGDrm/IX5WPT/NyKP6KCA=;
        b=bkFNB4tGhpWARbTCgfzqd2553Yiq9x/3doa0cCV6/pe0PyUPhOgq61oXNs+nz2Ulkb
         ieQmAb1r/xPxxIDEwXzVQuWp4lpG8LlEUqQ9TD57gQfsdHW20li+LYjrpUUe3PfA3UN8
         zs6K68uFHQl8aaQBw9p36bgI+vBB7jo2iJEKNS2oDWcbq14IU4zmZlobm8dcdLI1h49X
         JXdEQl6punpQka97NYbGhPa3TgwQu5bxACy29ItQFeeqPyMKSfQdT9jlKQpT6CFevs3B
         XwG9wWvxkRh+8tn04G2yzJWpAysABbTU+XFcPwxATaDMOsGKY//bhtjngKxtx7sPsXsm
         1zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=dSbmE+uYPtEW1FISTUeHogKGDrm/IX5WPT/NyKP6KCA=;
        b=d+86SP7cdxEmCoCz1a+BnO1cjRnbOu0PPFFhKYmkU0/Nl2s7azW2odO0J2U4obp+Nw
         bvkGyzc46bjFl08egDdZLBfCR27XtfJGCzW+4IBtOjEvved50JVpRaqHyX2Sfpytz//H
         DCpp8S9afy4+s02nz+rp1Y8dJgD/DSr+B4XoUE2TwoBntrWIwhpEfzzthICJueo58nZu
         qvSAki5xTSef3nprrbFzo19ZKEF5VTfwQ7jiAYPB1p1r1uhbjJXYCVGlYqf2wUGdnFGg
         HaTIbXj7p2EM1QMNqmjOMGUazD3bVygJCMzdLPpHzPKLFlVyDynF5P0BVll9McKPjrkj
         9hwQ==
X-Gm-Message-State: AOAM533di7XZkK+FZeNS9Z1q+Zx5Vgw5OYIE1nAcFJPzp0ZDfm7Cd51p
        /RaHHj2k+pRPodxS39o7o7g=
X-Google-Smtp-Source: ABdhPJwmyyf0rfmLmLE2U1VGIw+ueq6TEMMy0nETMUPY7O6drkFME5yg50CwCR/ZaJPkp1dMFMOVpg==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr2401700ljn.115.1598054743718;
        Fri, 21 Aug 2020 17:05:43 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u28sm685882ljd.39.2020.08.21.17.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 17:05:42 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 07/11] commit-graph: implement corrected commit date
In-Reply-To: <4074ace65be3094d35dd0aaedb89eb5a0ec98cee.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:39
        +0000")
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <4074ace65be3094d35dd0aaedb89eb5a0ec98cee.1597509583.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
Date:   Sat, 22 Aug 2020 02:05:41 +0200
Message-ID: <85wo1rk0iy.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> With most of preparations done, let's implement corrected commit date.
>
> The corrected commit date for a commit is defined as:
>
> * A commit with no parents (a root commit) has corrected commit date
>   equal to its committer date.
> * A commit with at least one parent has corrected commit date equal to
>   the maximum of its commit date and one more than the largest corrected
>   commit date among its parents.

Good.

>
> To minimize the space required to store corrected commit date, Git
> stores corrected commit date offsets into the commit-graph file. The
> corrected commit date offset for a commit is defined as the difference
> between its corrected commit date and actual commit date.

Perhaps we should add more details about data type sizes in question.

Storing corrected commit date requires sizeof(timestamp_t) bytes, which
in most cases is 64 bits (uintmax_t).  However corrected commit date
offsets can be safely stored^* using only 32 bits.  This halves the size
of GDAT chunk, reducing per-commit storage from 2*H + 16 + 8 bytes to
2*H + 16 + 4 bytes, which is reduction of around 6%, not including
header, fanout table (OIDF) and extra edges list (EDGE).

Which might mean that the extra complication is not worth it, and we
should store corrected commit date directly instead.

*) unless for example one of commits is malformed but valid,
   and has committerdate of 0 Unix time, 1 January 1970.

>
> While Git does not write out offsets at this stage, Git stores the
> corrected commit dates in member generation of struct commit_graph_data.
> It will begin writing commit date offsets with the introduction of
> generation data chunk.

OK, so the agenda for introducing geeration number v2 is as follows:
- compute generation numbers v2, i.e. corrected commit date
- store corrected commit date [offsets] in new GDAT chunk,
  unless backward-compatibility concerns require us to not to
- load [and compute] corrected commit date from commit-graph
  storing it as 'generation' field of `struct commit_graph_data`,
  unless backward-compatibility concerns require us to store
  topological levels (generation number v1) in there instead

Because the reachability condition for corrected commit date and for
topological level is exactly the same, we don't need to do anything to
take advantage of generation number v2.

Though we can use generation number v2 in more cases, where we turned
off use of generation numbers because v1 gave worse performance than
date heuristics.

Did I got this right?

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 58 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index a2f15b2825..fd69534dd5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -169,11 +169,6 @@ static int commit_gen_cmp(const void *va, const void=
 *vb)
>  	else if (generation_a > generation_b)
>  		return 1;
>
> -	/* use date as a heuristic when generations are equal */
> -	if (a->date < b->date)
> -		return -1;
> -	else if (a->date > b->date)
> -		return 1;

At first I was wondering why this tie-breaking is beig removed; wouldn't
be needed for backward-compatibility?  But then I remembered that this
comparison function is used _only_ for sorting commits when writing
Bloom filters, for `git commit-graph write --reachable --changed-paths ...`

Assuming that when writing the commit graph we always compute geeration
number v2 and 'generation' field stores corrected commit date, we don't
need to use date as a heuristic when generations are equal, and it would
not help in tie-breaking anyway.

All right.

>  	return 0;
>  }
>
> @@ -1342,10 +1337,14 @@ static void compute_generation_numbers(struct wri=
te_commit_graph_context *ctx)
>  					ctx->commits.nr);
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>  		uint32_t level =3D *topo_level_slab_at(ctx->topo_levels, ctx->commits.=
list[i]);
> +		timestamp_t corrected_commit_date =3D commit_graph_data_at(ctx->commit=
s.list[i])->generation;

All right, so the pattern is to add 'corrected_commit_date' stuff after
'topological_level' stuff.

>
>  		display_progress(ctx->progress, i + 1);
>  		if (level !=3D GENERATION_NUMBER_V1_INFINITY &&
> -		    level !=3D GENERATION_NUMBER_ZERO)
> +		    level !=3D GENERATION_NUMBER_ZERO &&
> +		    corrected_commit_date !=3D GENERATION_NUMBER_INFINITY &&
> +		    corrected_commit_date !=3D GENERATION_NUMBER_ZERO
> +		    )
>  			continue;
>
>  		commit_list_insert(ctx->commits.list[i], &list);
> @@ -1354,17 +1353,26 @@ static void compute_generation_numbers(struct wri=
te_commit_graph_context *ctx)
>  			struct commit_list *parent;
>  			int all_parents_computed =3D 1;
>  			uint32_t max_level =3D 0;
> +			timestamp_t max_corrected_commit_date =3D 0;
>
>  			for (parent =3D current->parents; parent; parent =3D parent->next) {
>  				level =3D *topo_level_slab_at(ctx->topo_levels, parent->item);
> +				corrected_commit_date =3D commit_graph_data_at(parent->item)->genera=
tion;
>
>  				if (level =3D=3D GENERATION_NUMBER_V1_INFINITY ||
> -				    level =3D=3D GENERATION_NUMBER_ZERO) {
> +				    level =3D=3D GENERATION_NUMBER_ZERO ||
> +				    corrected_commit_date =3D=3D GENERATION_NUMBER_INFINITY ||
> +				    corrected_commit_date =3D=3D GENERATION_NUMBER_ZERO
> +				    ) {
>  					all_parents_computed =3D 0;
>  					commit_list_insert(parent->item, &list);
>  					break;
> -				} else if (level > max_level) {
> -					max_level =3D level;
> +				} else {
> +					if (level > max_level)
> +						max_level =3D level;
> +
> +					if (corrected_commit_date > max_corrected_commit_date)
> +						max_corrected_commit_date =3D corrected_commit_date;
>  				}
>  			}
>
> @@ -1374,6 +1382,10 @@ static void compute_generation_numbers(struct writ=
e_commit_graph_context *ctx)
>  				if (max_level > GENERATION_NUMBER_MAX - 1)
>  					max_level =3D GENERATION_NUMBER_MAX - 1;
>  				*topo_level_slab_at(ctx->topo_levels, current) =3D max_level + 1;
> +
> +				if (current->date > max_corrected_commit_date)
> +					max_corrected_commit_date =3D current->date - 1;
> +				commit_graph_data_at(current)->generation =3D max_corrected_commit_d=
ate + 1;
>  			}
>  		}
>  	}

All right.  Looks good to me.

> @@ -2372,8 +2384,8 @@ int verify_commit_graph(struct repository *r, struc=
t commit_graph *g, int flags)
>  	for (i =3D 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit, *odb_commit;
>  		struct commit_list *graph_parents, *odb_parents;
> -		timestamp_t max_generation =3D 0;
> -		timestamp_t generation;
> +		timestamp_t max_corrected_commit_date =3D 0;
> +		timestamp_t corrected_commit_date;

This is simple, and perhaps unnecessary, rename of variables.
Shouldn't we however verify *both* topological level, and
(if exists) corrected commit date?

>
>  		display_progress(progress, i + 1);
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> @@ -2412,9 +2424,9 @@ int verify_commit_graph(struct repository *r, struc=
t commit_graph *g, int flags)
>  					     oid_to_hex(&graph_parents->item->object.oid),
>  					     oid_to_hex(&odb_parents->item->object.oid));
>
> -			generation =3D commit_graph_generation(graph_parents->item);
> -			if (generation > max_generation)
> -				max_generation =3D generation;
> +			corrected_commit_date =3D commit_graph_generation(graph_parents->item=
);
> +			if (corrected_commit_date > max_corrected_commit_date)
> +				max_corrected_commit_date =3D corrected_commit_date;

Actually, commit_graph_generation(<commit>) can return either corrected
commit date, or topological level, the latter in backward-compatibility
case (if at least one commit-graph file is lacking GDAT chunk, because
[some of] it was created by the "Old" Git).

>
>  			graph_parents =3D graph_parents->next;
>  			odb_parents =3D odb_parents->next;
> @@ -2436,20 +2448,12 @@ int verify_commit_graph(struct repository *r, str=
uct commit_graph *g, int flags)
>  		if (generation_zero =3D=3D GENERATION_ZERO_EXISTS)
>  			continue;
>
> -		/*
> -		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
> -		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
> -		 * extra logic in the following condition.
> -		 */
> -		if (max_generation =3D=3D GENERATION_NUMBER_MAX)
> -			max_generation--;

All right, this was needed for checking the correctness of topological
levels (generation number v1) because we were checking not that it
fullfills the reachability condition, but more strict one: namely that
topological level of commit is equal to maximum of topological levels of
its parents plus one.

The comment about checking both generation number v1 and v2 still
applies.

> -
> -		generation =3D commit_graph_generation(graph_commit);
> -		if (generation !=3D max_generation + 1)
> -			graph_report(_("commit-graph generation for commit %s is %u !=3D %u"),
> +		corrected_commit_date =3D commit_graph_generation(graph_commit);
> +		if (corrected_commit_date < max_corrected_commit_date + 1)
> +			graph_report(_("commit-graph generation for commit %s is %"PRItime" <=
 %"PRItime),
>  				     oid_to_hex(&cur_oid),
> -				     generation,
> -				     max_generation + 1);
> +				     corrected_commit_date,
> +				     max_corrected_commit_date + 1);

All right, we check less strict condition for corrected commit date.

>
>  		if (graph_commit->date !=3D odb_commit->date)
>  			graph_report(_("commit date for commit %s in commit-graph is %"PRItim=
e" !=3D %"PRItime),

Best,
--=20
Jakub Nar=C4=99bski
