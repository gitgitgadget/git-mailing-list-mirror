Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A5EC35657
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B08222C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcHSf/vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBURcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:32:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45523 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgBURb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 12:31:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id e18so2974101ljn.12
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 09:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0PB57b2nbeOd9z1iEeOaMUH9hksIGUWBBPb/0X4S1i4=;
        b=BcHSf/vzlGXzbnNJIq9QU9VRkUw4pMlzoIC7uYS6dV7uAWyJPq+SjYCmDa9Bxz7mm/
         opLS819rPc54Rz8mGkBcvHWVI9mpwL7XdbDa2kl8Wd17CPa3wwQDij9PjHuP5KZqcGTW
         LO0M32TF2FnD57/6LFoMUOJoR8Nr/u4rLKcz6pG8ytAo7tW5pPJmEt+wLiV2H2oaQvYr
         WpdVOZiJft1/EEkh5Nq2egHPLnsWZ6nEe7cftOjs3EHY2AKgquMNXGxSyyNej8ulyFMa
         VC+/tRQNk053zzUlPN4B5q2XXu0iZPC/DDScU/4ePlTn14lo8NN0XljRxU/dktP0DVBp
         egEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=0PB57b2nbeOd9z1iEeOaMUH9hksIGUWBBPb/0X4S1i4=;
        b=KJttruTREj2pJ9CiUygfEHmY5BveJB8tWtsEObuhY0StA1hIPBoENCJtx/hw6hTPHw
         pJl8I25+26LVI3VPSIfxJzO4sFkj7i9KvxyHpm4ImcD8fLZfg8XBVkKPti/lHfSRKdpG
         c7PflaowCNvDoUEbTZYWGZ1VuxAi1tU67Qkk49/6Ej099Swh6kuMeDiWsTiQgYsZ9CWE
         FIG1OWG5qnSq/Yx+gZXuJNsoi925IpxryAI5SXsY9tdoVMfIdjBLC4or9tDe+vX/iFs4
         9/rybKYdTn4+HsQh77L+qXSsjBHDTQIm0NplibUerPJQSyN/ZFMYrxiwZR7lU66jxfJV
         7niQ==
X-Gm-Message-State: APjAAAXyEwLB6MWEWYE6enXZn2OIY1pQUmmShuuOclle82wPf2ubBa2X
        Gm9ro5CpFEDRNsg05TFDKfU=
X-Google-Smtp-Source: APXvYqyZMqCKPELarcRh6mlMGRweVe+wTbDg2m3kz2TSZr46VG0Fjzg1WSEmXIhx1JJ4onJTjx1O+g==
X-Received: by 2002:a2e:860c:: with SMTP id a12mr22846981lji.146.1582306316721;
        Fri, 21 Feb 2020 09:31:56 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id k12sm1982601lfc.33.2020.02.21.09.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 09:31:55 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, garimasigit@gmail.com, christian.couder@gmail.com,
        emilyshaffer@gmail.com, gitster@pobox.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 10/11] revision.c: use Bloom filters to speed up path based revision walks
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <77f1c561e8205c0598b57bf572640d21d64757f8.1580943390.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Feb 2020 18:31:50 +0100
In-Reply-To: <77f1c561e8205c0598b57bf572640d21d64757f8.1580943390.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:29
        +0000")
Message-ID: <86o8trdeyh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> Revision walk will now use Bloom filters for commits to speed up revision
> walks for a particular path (for computing history for that path), if they
> are present in the commit-graph file.

Why do we need to turn this feature off for --walk-reflog?

Anyway, in my opinion this restriction should be stated explicitly in
the commit message, if kept.=20

>
> We load the Bloom filters during the prepare_revision_walk step, but only
> when dealing with a single pathspec.

I would add the qualifier "currently" here, i.e. s/only/currently only/
to make it clear that it is the limitation of current implementation,
and not the inherent implementation of the technique.

>                                      While comparing trees in
> rev_compare_trees(), if the Bloom filter says that the file is not differ=
ent
> between the two trees, we don't need to compute the expensive diff. This =
is
> where we get our performance gains. The other response of the Bloom filter
> is `maybe`, in which case we fall back to the full diff calculation to
> determine if the path was changed in the commit.

All right, looks good.

Very minor nitpick: s/`maybe`/'maybe'/ (in my opinion).

>
> Performance Gains:
> We tested the performance of `git log -- <path>` on the git repo, the lin=
ux
> and some internal large repos, with a variety of paths of varying depths.

Another repository that we could test Bloom filters feature would be, as
I have written before, Android AOSP frameworks core repository
https://android.googlesource.com/platform/frameworks/base/
because being written in Java it has deep path hierarchy, and it also
has large number of commits.

>
> On the git and linux repos:
> - we observed a 2x to 5x speed up.

It would be nice to have at least one specific and repeatable example:
in given repository, starting from given commit or tag, following the
history of given path, what are timing results for doing some specific
command with and without Bloom filters computed and enabled.

One might also want to know the cost of this speedup: how much disk
space does it take (i.e. how large is the commit-graph file with and
without Bloom filters chunks), and how long does it take to compute
(i.e. how much time writing commit-graph takes with and without using
--changed-paths options).

>
> On a large internal repo with files seated 6-10 levels deep in the tree:
> - we observed 10x to 20x speed ups, with some paths going up to 28 times
>   faster.

This is good to know.

In the future we might want to have procedurally generated synthetic
repository, where we would be able to control number of files, depth of
filesystem hierarchy, average number of changes per commit, etc. to be
used for performance testing.  (Just wishful thinking)

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com
> Helped-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  revision.c                 | 124 +++++++++++++++++++++++++++++++-
>  revision.h                 |  11 +++
>  t/helper/test-read-graph.c |   4 ++
>  t/t4216-log-bloom.sh       | 140 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 277 insertions(+), 2 deletions(-)
>  create mode 100755 t/t4216-log-bloom.sh
>
> diff --git a/revision.c b/revision.c
> index 8136929e23..d1622afa17 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -29,6 +29,8 @@
>  #include "prio-queue.h"
>  #include "hashmap.h"
>  #include "utf8.h"
> +#include "bloom.h"
> +#include "json-writer.h"
>=20=20
>  volatile show_early_output_fn_t show_early_output;
>=20=20
> @@ -624,11 +626,114 @@ static void file_change(struct diff_options *optio=
ns,
>  	options->flags.has_changes =3D 1;
>  }
>=20=20
> +static int bloom_filter_atexit_registered;
> +static unsigned int count_bloom_filter_maybe;
> +static unsigned int count_bloom_filter_definitely_not;
> +static unsigned int count_bloom_filter_false_positive;
> +static unsigned int count_bloom_filter_not_present;
> +static unsigned int count_bloom_filter_length_zero;
> +
> +static void trace2_bloom_filter_statistics_atexit(void)
> +{
> +	struct json_writer jw =3D JSON_WRITER_INIT;
> +
> +	jw_object_begin(&jw, 0);
> +	jw_object_intmax(&jw, "filter_not_present", count_bloom_filter_not_pres=
ent);
> +	jw_object_intmax(&jw, "zero_length_filter", count_bloom_filter_length_z=
ero);
> +	jw_object_intmax(&jw, "maybe", count_bloom_filter_maybe);
> +	jw_object_intmax(&jw, "definitely_not", count_bloom_filter_definitely_n=
ot);
> +	jw_end(&jw);
> +
> +	trace2_data_json("bloom", the_repository, "statistics", &jw);
> +
> +	jw_release(&jw);
> +}

I thought that it would be better to put this part together with tests
that absolutely require this functionality in a separate subsequent
patch, but now I am not so sure.  It is nice to have all or almost all
tests created in a single patch.

Looks good to me, but I don't know much about trace2 API, so take it
with a pinch of salt.

> +
> +static void prepare_to_use_bloom_filter(struct rev_info *revs)
> +{
> +	struct pathspec_item *pi;
> +	char *path_alloc =3D NULL;
> +	const char *path;
> +	int last_index;
> +	int len;
> +
> +	if (!revs->commits)
> +	    return;

I see that we need this because in next command we dereference
revs->commits to get revs->commits->item.

If I understand it correctly empty pending list may happen with "--all"
or "--glob" options, but somebody with more experience in this area of
code is needed to state for sure.

Should we test `git log --all -- <path>`?

> +
> +	repo_parse_commit(revs->repo, revs->commits->item);

Are we calling this function for its side-effects?  Wouldn't using
prepare_commit_graph(revs->repo) here be a better solution?

> +
> +	if (!revs->repo->objects->commit_graph)
> +		return;

Looks good to me.  If there is no commit graph, then there are no Bloom
filters to consult.

> +
> +	revs->bloom_filter_settings =3D revs->repo->objects->commit_graph->bloo=
m_filter_settings;

Hmmm... is that why bloom_filter_settings is a pointer to struct, and
not struct itself?

> +	if (!revs->bloom_filter_settings)
> +		return;

Looks good to me.  If there is no Bloomm filter in the commit-graph
file, then there are no Bloom filters to consult.

> +
> +	pi =3D &revs->pruning.pathspec.items[0];
> +	last_index =3D pi->len - 1;
> +

It might be a good idea to add a comment explaining what is happening
here, for example:

  +	/* remove single trailing slash from path, if needed */
> +	if (pi->match[last_index] =3D=3D '/') {
> +	    path_alloc =3D xstrdup(pi->match);
> +	    path_alloc[last_index] =3D '\0';
> +	    path =3D path_alloc;
> +	} else
> +	    path =3D pi->match;
> +
> +	len =3D strlen(path);

We can avoid computing strlen(path) here, because in first branch of
this conditional we have len =3D last_index, in the second branch we have
len =3D pi->len.

> +
> +	revs->bloom_key =3D xmalloc(sizeof(struct bloom_key));
> +	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);

All right, this is the meat of this function: creating bloom_key for a
path.  Looks good to me.

> +
> +	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
> +		atexit(trace2_bloom_filter_statistics_atexit);
> +		bloom_filter_atexit_registered =3D 1;
> +	}

OK, here we register trace2 Bloom filter statistics handler, but only
once, and only when needed.

> +
> +	free(path_alloc);

OK, path_alloc is either xstrdup-ed string, or NULL, and is no longer
needed (after possibly being used to create bloom_key).

> +}
> +
> +static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
> +						 struct commit *commit)
> +{
> +	struct bloom_filter *filter;
> +	int result;
> +
> +	if (!revs->repo->objects->commit_graph)
> +		return -1;
> +
> +	if (commit->generation =3D=3D GENERATION_NUMBER_INFINITY)
> +		return -1;

Idle thought: would it be useful to gather for trace2 statistics also
number of commits encountered that were outside commit-graph?

> +
> +	filter =3D get_bloom_filter(revs->repo, commit, 0);
> +
> +	if (!filter) {
> +		count_bloom_filter_not_present++;
> +		return -1;
> +	}
> +
> +	if (!filter->len) {
> +		count_bloom_filter_length_zero++;
> +		return -1;
> +	}
> +
> +	result =3D bloom_filter_contains(filter,
> +				       revs->bloom_key,
> +				       revs->bloom_filter_settings);
> +
> +	if (result)
> +		count_bloom_filter_maybe++;
> +	else
> +		count_bloom_filter_definitely_not++;
> +
> +	return result;
> +}

The whole check_maybe_different_in_bloom_filter() looks good to me,
thanks to designing and building a good API.

> +
>  static int rev_compare_tree(struct rev_info *revs,
> -			    struct commit *parent, struct commit *commit)
> +			    struct commit *parent, struct commit *commit, int nth_parent)
>  {
>  	struct tree *t1 =3D get_commit_tree(parent);
>  	struct tree *t2 =3D get_commit_tree(commit);
> +	int bloom_ret =3D 1;

I don't understand why it is initialized to 1, and not to 0.

>=20=20
>  	if (!t1)
>  		return REV_TREE_NEW;
> @@ -653,11 +758,23 @@ static int rev_compare_tree(struct rev_info *revs,
>  			return REV_TREE_SAME;
>  	}
>=20=20
> +	if (revs->pruning.pathspec.nr =3D=3D 1 && !revs->reflog_info && !nth_pa=
rent) {

Shouldn't we check upfront here that revs->bloom_key is not NULL?
I don't think we check this down the callchain...

Or even better replace the first two checks with it, as revs->bloom_key
is set only if (revs->pruning.pathspec.nr =3D=3D 1 && !revs->reflog_info),
see addition to prepare_revision_walk() below.

Of course the !nth_parent check needs to be kept, as this changes during
the revision walk (it is a limitation of current version of Bloom filter
in that only changes with respect to first parent are stored in filter).

> +		bloom_ret =3D check_maybe_different_in_bloom_filter(revs, commit);
> +
> +		if (bloom_ret =3D=3D 0)
> +			return REV_TREE_SAME;
> +	}

All right, if we have single pathspec, and we don't walk reflog (?), and
we are interested in first parent, then we query the Bloom filter.

The Bloom filter can return 'no' or 'maybe'; if it returns 'no' then we
can short-circuit and avoid computing the tree diff.

> +
>  	tree_difference =3D REV_TREE_SAME;
>  	revs->pruning.flags.has_changes =3D 0;
>  	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
>  			   &revs->pruning) < 0)
>  		return REV_TREE_DIFFERENT;
> +
> +	if (!nth_parent)

Shouldn't this condition be exactly the same as for running
check_maybe_different_in_bloom_filter()?  Otherwise due to initializing
bloom_ret to 1 we would get wrong statistics, isn't it?

> +		if (bloom_ret =3D=3D 1 && tree_difference =3D=3D REV_TREE_SAME)
> +			count_bloom_filter_false_positive++;
> +

All right, looks good.

>  	return tree_difference;
>  }
>=20=20
> @@ -855,7 +972,7 @@ static void try_to_simplify_commit(struct rev_info *r=
evs, struct commit *commit)
>  			die("cannot simplify commit %s (because of %s)",
>  			    oid_to_hex(&commit->object.oid),
>  			    oid_to_hex(&p->object.oid));
> -		switch (rev_compare_tree(revs, p, commit)) {
> +		switch (rev_compare_tree(revs, p, commit, nth_parent)) {
>  		case REV_TREE_SAME:
>  			if (!revs->simplify_history || !relevant_commit(p)) {
>  				/* Even if a merge with an uninteresting

OK, we are just dding new parameter, with the information needed to
decide whether Bloom filters can be used or not.

> @@ -3362,6 +3479,8 @@ int prepare_revision_walk(struct rev_info *revs)
>  				       FOR_EACH_OBJECT_PROMISOR_ONLY);
>  	}
>=20=20
> +	if (revs->pruning.pathspec.nr =3D=3D 1 && !revs->reflog_info)
> +		prepare_to_use_bloom_filter(revs);

Well, the limitation that the technique _currently_ works only with a
single pathspec is stated explicitly, but the fact that it is turned off
for some reason for --walk-reflog is not.

Otherwise, looks good to me.

>  	if (revs->no_walk !=3D REVISION_WALK_NO_WALK_UNSORTED)
>  		commit_list_sort_by_date(&revs->commits);
>  	if (revs->no_walk)
> @@ -3379,6 +3498,7 @@ int prepare_revision_walk(struct rev_info *revs)
>  		simplify_merges(revs);
>  	if (revs->children.name)
>  		set_children(revs);
> +
>  	return 0;
>  }

Unrelated coding style fixup, but we are doing changes in the
neighborhood.  All right, I can agree to that.

>=20=20
> diff --git a/revision.h b/revision.h
> index 475f048fb6..7c026fe41f 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -56,6 +56,8 @@ struct repository;
>  struct rev_info;
>  struct string_list;
>  struct saved_parents;
> +struct bloom_key;
> +struct bloom_filter_settings;
>  define_shared_commit_slab(revision_sources, char *);
>=20=20
>  struct rev_cmdline_info {
> @@ -291,6 +293,15 @@ struct rev_info {
>  	struct revision_sources *sources;
>=20=20
>  	struct topo_walk_info *topo_walk_info;
> +
> +	/* Commit graph bloom filter fields */
> +	/* The bloom filter key for the pathspec */
> +	struct bloom_key *bloom_key;
> +	/*
> +	 * The bloom filter settings used to generate the key.
> +	 * This is loaded from the commit-graph being used.
> +	 */
> +	struct bloom_filter_settings *bloom_filter_settings;

It is nice having those explanatory comments.

Sidenote: if I understand it correctly, revs->bloom_key is allocated but
never free()d.  On the other hand revs->bloom_filter_settings is a weak
reference / is set to the value of other pointer, which is allocated and
free()d together with commit_graph struct.

>  };
>=20=20
>  int ref_excluded(struct string_list *, const char *path);
> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index d2884efe0a..aff597c7a3 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -45,6 +45,10 @@ int cmd__read_graph(int argc, const char **argv)
>  		printf(" commit_metadata");
>  	if (graph->chunk_extra_edges)
>  		printf(" extra_edges");
> +	if (graph->chunk_bloom_indexes)
> +		printf(" bloom_indexes");
> +	if (graph->chunk_bloom_data)
> +		printf(" bloom_data");
>  	printf("\n");

This chunk could be moved to the commit adding --changed-paths
option... on the other hand if all tests are to be added by this patch,
it can be left as is.

>=20=20
>  	UNLEAK(graph);
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> new file mode 100755
> index 0000000000..19eca1864b
> --- /dev/null
> +++ b/t/t4216-log-bloom.sh
[...]

I'll leave reviewing tests of this feature for the next email.

Best regards,
--=20
Jakub Nar=C4=99bski
