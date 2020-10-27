Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9288C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3807A20829
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfF8mX+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443750AbgJ0Sxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:53:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44328 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411502AbgJ0Sxa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 14:53:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id a5so2965010ljj.11
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=owVIZL4QSaHdhzv6VImdYIk7yn5p92Oa8TM5l6TLqME=;
        b=EfF8mX+4gEeL99gjXfS4Qs/HXIJdQu/WlITVQ7AQWZTBh+XSygnbTS99vEWpZ0fb4q
         dOZM0Guao4BOBGhDAQtpXZfDpcCfPBCz2iAhnxB3fDhjZ4GhuLiRLi0UKNGuZY7772Mj
         1XD2YouGtNxlCzQBrGcWR4xlPt3RzqOstUaHi+NsXY3HtsfUVnZ/57lyUa5RDSrkr+4G
         0bLPXDgxmah9AbA8HVkccSWLeNDsJc3YBo3clTErPPv/F44CZt0ec+MrTYXDTsyzIC/n
         ptpARjSi8EszLPmq8G0hIf3ojAJkUNyswoBbOXjLuLi1CY8gbB58wVA0sAzyC5Dwoydt
         jjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=owVIZL4QSaHdhzv6VImdYIk7yn5p92Oa8TM5l6TLqME=;
        b=b1E1RdrYN2qqSM2h0F4j1htYnK3+oCjcWeRO1bvvtyA+S+V8yOou4NDw3iZVsgOltY
         cMqDoNLTzMSU4jGNWhsCfgUOHs3lg2WElwRUPzdH2R2HQrS9GGbBDBUv3huTiSbYmAsz
         eRqsC1k12vR7sGf2Qmxexz6kwZJ7axpEiVRZB9m3wO+4dr59dq3BwcyCSs4vXgYRETW2
         9FBpZviAf/DuYaO85wPA9GENUfn3HeynDLxhPMRbG5Ugm7Z8piW+Q3oVGjAc2hV4ZCls
         o+H1ZaTeOZTm/c6rasP+wnR3O83maoscJaUU30QHIaKW6VS8kR21hIJzdMPGYAJa80e6
         kILg==
X-Gm-Message-State: AOAM532ORrpR23V+N0udI68SEyxRzl+iJyUgNQf8uuqzLo/iKFrhFO1e
        gZyaDiD0apmaTUEIMZg2TaXt+02j2Q/Vjg==
X-Google-Smtp-Source: ABdhPJyaJHUcTYi8wneiXNMZTji8M67mqxPUtaJJ7UYumm3sGUnXVnNtIgcfsNalq7MLdGXWVddRDg==
X-Received: by 2002:a2e:9951:: with SMTP id r17mr1754430ljj.37.1603824805608;
        Tue, 27 Oct 2020 11:53:25 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id v4sm278518ljk.80.2020.10.27.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:53:24 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 06/10] commit-graph: implement corrected commit date
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 19:53:23 +0100
In-Reply-To: <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:41
        +0000")
Message-ID: <85r1pjzejg.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

All right.  We might want to say that it fulfills the same reachability
criteria as topological level, but perhaps this level of detail is not
necessary here.

> As a special case, a root commit with timestamp of zero (01.01.1970
> 00:00:00Z) has corrected commit date of one, to be able to distinguish
> from GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit
> date).

I'm not sure if this special case is really necessary, but it makes for
cleaner reasoning.

> To minimize the space required to store corrected commit date, Git
> stores corrected commit date offsets into the commit-graph file. The
> corrected commit date offset for a commit is defined as the difference
> between its corrected commit date and actual commit date.
>
> Storing corrected commit date requires sizeof(timestamp_t) bytes, which
> in most cases is 64 bits (uintmax_t). However, corrected commit date
> offsets can be safely stored using only 32-bits. This halves the size
> of GDAT chunk, which is a reduction of around 6% in the size of
> commit-graph file.
>
> However, using offsets be problematic if one of commits is malformed but
> valid and has committerdate of 0 Unix time, as the offset would be the
> same as corrected commit date and thus require 64-bits to be stored
> properly.
>
> While Git does not write out offsets at this stage, Git stores the
> corrected commit dates in member generation of struct commit_graph_data.
> It will begin writing commit date offsets with the introduction of
> generation data chunk.

All right.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>

Somewhere in the commit message we should also describe that this commit
changes how commit-graph is verified: from checking that the generation
number agrees with _topological level definition_, that is that for a
given commit it is 1 more than maximum of its parents (with the caveat
that we need to handle GENERATION_NUMBER_V1_MAX values correctly), to
checking that slightly weaker condition fulfilled by both topological
levels (generation number v1) and by corrected commit date (generation
number v2) that for a given commit its generation number is 1 more than
maximum of its parents or larger.

But, as far as I understand it, current code does not handle correctly
GENERATION_NUMBER_V1_MAX case (if we use generation number v1).

On the other hand we could have simpy use functional check, that
generation number used (which can be v1 or v2, or any similar other)
fulfills the reachability condition for each edge, which can be
simplified to checking that generation(parents) <=3D generation(commit).
If the reachability condition is true for each edge, then it is true for
each path, and for each commit.

> ---
>  commit-graph.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index cedd311024..03948adfce 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -154,11 +154,6 @@ static int commit_gen_cmp(const void *va, const void=
 *vb)
>  	else if (generation_a > generation_b)
>  		return 1;
>=20=20
> -	/* use date as a heuristic when generations are equal */
> -	if (a->date < b->date)
> -		return -1;
> -	else if (a->date > b->date)
> -		return 1;

Why this change?  It is not described in the commit message.

Note that while this tie-breaking fallback doesn't make much sense for
corrected committer date generation number v2, this tie-breaking helps
if we have to use topological levels (generation number v2).

>  	return 0;
>  }
>=20=20
> @@ -1357,10 +1352,14 @@ static void compute_generation_numbers(struct wri=
te_commit_graph_context *ctx)
>  					ctx->commits.nr);
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>  		timestamp_t level =3D *topo_level_slab_at(ctx->topo_levels, ctx->commi=
ts.list[i]);

Sidenote: I haven't noticed it earlier, but here 'uint32_t' might be
enough; no need for 'timestamp_t' for 'level' variable.

> +		timestamp_t corrected_commit_date =3D commit_graph_data_at(ctx->commit=
s.list[i])->generation;
>

All right, we compute both generation numbers: topological levels and
corrected commit date.

I guess we use 'corrected_commit_date' instead of simply 'generation' to
make it asier to remember which is which.

>  		display_progress(ctx->progress, i + 1);
>  		if (level !=3D GENERATION_NUMBER_INFINITY &&
> -		    level !=3D GENERATION_NUMBER_ZERO)
> +		    level !=3D GENERATION_NUMBER_ZERO &&
> +		    corrected_commit_date !=3D GENERATION_NUMBER_INFINITY &&
> +		    corrected_commit_date !=3D GENERATION_NUMBER_ZERO

Straightforward addition.

> +		    )

Why this closing parenthesis is now in separated line?

>  			continue;
>=20=20
>  		commit_list_insert(ctx->commits.list[i], &list);
> @@ -1369,17 +1368,25 @@ static void compute_generation_numbers(struct wri=
te_commit_graph_context *ctx)
>  			struct commit_list *parent;
>  			int all_parents_computed =3D 1;
>  			uint32_t max_level =3D 0;
> +			timestamp_t max_corrected_commit_date =3D 0;

All right, straightforward addition.

>=20=20
>  			for (parent =3D current->parents; parent; parent =3D parent->next) {
>  				level =3D *topo_level_slab_at(ctx->topo_levels, parent->item);
> -

Why we have removed this empty line?

> +				corrected_commit_date =3D commit_graph_data_at(parent->item)->genera=
tion;

All right.

>  				if (level =3D=3D GENERATION_NUMBER_INFINITY ||
> -				    level =3D=3D GENERATION_NUMBER_ZERO) {
> +				    level =3D=3D GENERATION_NUMBER_ZERO ||
> +				    corrected_commit_date =3D=3D GENERATION_NUMBER_INFINITY ||
> +				    corrected_commit_date =3D=3D GENERATION_NUMBER_ZERO
> +				    ) {

All right, same as above.

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

All right, reasonable and straightforward.

>  			}
>=20=20
> @@ -1389,6 +1396,10 @@ static void compute_generation_numbers(struct writ=
e_commit_graph_context *ctx)
>  				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
>  					max_level =3D GENERATION_NUMBER_V1_MAX - 1;
>  				*topo_level_slab_at(ctx->topo_levels, current) =3D max_level + 1;
> +
> +				if (current->date && current->date > max_corrected_commit_date)
> +					max_corrected_commit_date =3D current->date - 1;
> +				commit_graph_data_at(current)->generation =3D max_corrected_commit_d=
ate + 1;

All right.

Here we use the same trick as in previous commit (and as above) to avoid
any possible overflow, to minimize number of conditionals.  The fact
that max_corrected_commit_date might store incorrect value doesn't
matter, as it is reset at beginning of this loop.

>  			}
>  		}
>  	}
> @@ -2485,17 +2496,9 @@ int verify_commit_graph(struct repository *r, stru=
ct commit_graph *g, int flags)
>  		if (generation_zero =3D=3D GENERATION_ZERO_EXISTS)
>  			continue;
>=20=20
> -		/*
> -		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
> -		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
> -		 * extra logic in the following condition.
> -		 */
> -		if (max_generation =3D=3D GENERATION_NUMBER_V1_MAX)
> -			max_generation--;
> -

Perhaps in the future we should check that both topological levels, and
also corrected committer date (if it exists) for correctness according
to their definition.  Then the above removed part would be restored (but
with s/max_generation/max_level/).

>  		generation =3D commit_graph_generation(graph_commit);
> -		if (generation !=3D max_generation + 1)
> -			graph_report(_("commit-graph generation for commit %s is %u !=3D %u"),
> +		if (generation < max_generation + 1)
> +			graph_report(_("commit-graph generation for commit %s is %"PRItime" <=
 %"PRItime),

All right, so we relaxed the check so that it will be fulfilled by
generation number v2 (and also by generation number v1, as it implies
the more strict check for v1).

What would happen however if generation holds topological levels, and it
is GENERATION_NUMBER_V1_MAX for at least one parent, which means it is
GENERATION_NUMBER_V1_MAX for a commit?  As you can check, the condition
would be true: GENERATION_NUMBER_V1_MAX < GENERATION_NUMBER_V1_MAX + 1,
so the `git commit-graph verify` would incorrectly say that there is
a problem with generation number, while there isn't one (false positive
detection of error).

Sidenote: I think we don't have to worry about having to introduce
GENERATION_NUMBER_V2_MAX, as the in-memory size (of reconstructed from
disck representation) corrected commiter date is the same as of commiter
date itself, plus some, and I don't see us coming close to 64-bit limit
of timestamp_t for commit dates.

>  				     oid_to_hex(&cur_oid),
>  				     generation,
>  				     max_generation + 1);

Best,
--=20
Jakub Nar=C4=99bski
