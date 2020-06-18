Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9EBC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D50207DD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="M3ulI1d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgFRUbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:31:10 -0400
Received: from mout.web.de ([212.227.17.12]:43637 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgFRUbI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592512262;
        bh=Fg720wRUoP+aMuEK9mtbbF5whGsX74d2A++rLP7QnrM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M3ulI1d9eL3CrCor4dZ/vS8PKw+zz/19rBkjmExk7pVXOaNYrg8gmiLO1QmqEwmqY
         TeeCX/sonAhRaHg8DXkxA+czZJbrj1IIoAldP4VxmH1hEpBKcElkXu54bkxHlRU93Z
         MEA+i5p5bidvMj1LPMa1AFhKNOqQ9phvxI0kIj6w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuKF-1jSxhb1E4b-00LQP9; Thu, 18
 Jun 2020 22:31:02 +0200
Subject: Re: [PATCH 5/8] commit-graph: check all leading directories in
 changed path Bloom filters
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <9975fc96f1269b049ebdd54835a63480c3dcbe4e.1592252093.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <acfd97a7-9a53-0ad1-41f5-48524ceb99db@web.de>
Date:   Thu, 18 Jun 2020 22:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9975fc96f1269b049ebdd54835a63480c3dcbe4e.1592252093.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fiIeHg3oNQl9fbdCX9ZQbb4qf3+bf3eIO0Q/dd1MzOfybeID7OQ
 ezfp4LMWS4UWxaUrcp7ZNlpe+ky7dg66E9WPK764xMZqDgdJVoLuyvQ2z3vrS3j88Gi7wGS
 ycycqh+FdMbUi5OWpVJPvmBPnJmjBV7jWjpRYpJxZ/iYK2aWZ473kOPmbjzusal4JNomWLo
 tNpuI019qtHDH6IXF6rBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nI2SldKQdGE=:JDO670FmaikjXvc3Q1G3iy
 jsmwntEEv46F3LgokuVQ0qzwyK5g652QpgsCbVystkbFwxcsZHiXE7plW3ONsb8yp1fJUl0TL
 XNxh5044+EjOnJ7nmDHjHfLxsMH50kUwOIzN4Tbggl3XZnjCz8z18LB5aVFA6LT5Y1/GblaZO
 IHct0L4QFrTgP94iWzik8Q8AlL628it/ZabjgjqjK+BejWnwbK9xqhuE3zWcmFiqA+Qap6DqP
 Oebi1BFxTXnyGaEhLymfg0tox/hqC5CD/Q7/HQKDpDHgD98so2zW8/zf6DfH3ax1quFnE086i
 y2NSdqVzaQD7dBc1KtF0ITzA6ifA0c/n5ks7GhJDZfwU2W9zS4nv5EH3oFmDpebSVw9ZfDSP9
 Qw/kxsmwufdFVqMZU4P/XC8wLmvFJ2NixxxpgJBeHFZ3t92uFNMKjFAClld/vxV3b7PD6sEDW
 CD4+rSUn3uAi7Ua/jfU0Po6wMb7bObmPln/5QCLzwvFdUZ6nDVuZoud5qobIioaxSfoOyTI+J
 MrMxL0aewrxYQzTHQc8nrHIRbmQpCiUrlNKrndIkNmmqA5hYRKj1S6F7HVlGnANlqDkTGXrRV
 fLQ9iuUfDgkZTT6GlFjsGuiHjathz/Iuk56N69s1wFYqucsM9QYs58kJ8x1yreg795k4fPtCS
 bLDjPwq14nxZ9I1NMxWl1XqPdpMKFVHlYB6t9bFuo3zHyJ9vXwEDSrMwoe1Wk2LlNlxBVXr2g
 xIbXcq5vl2kZyxQCB4Xfs1/fBqxiTRpwAJh9Zo4HzyBbN042ktcdYF0kEgcMK8zLvkKB7JiC+
 EsKIw/UvOFdM6gdNXLv6A5Iy/BMhwpK2+pkKLmfDk3B+zp/g3xtJ1L1lWcPeeNhnQsWzhwOJ7
 H9jX9T4fHYAj/YTEAbIU/mwJze1cJNvPlC1en/5DTxwHO8Db1b7UaZZcW4rRg9eMLdTRwJYAx
 OuOJPMNy/jjl3dAK9rOoHMjLCe/oI2imOvVq8KwoG1ICbYlvXoGaJ+uorBHGhzXpMdoqy9WEO
 sAooHqTgJy+J9Mjs4q7/F5zIv5rIsZBU1XKuEF4JIFeWRmcDwojMMu6Ur0SIP2mIpFF6Kzcyw
 jTfvmTLr9fCEraip9m1+jGZ6Cr8IdQN5+1jqjCgEWRf8slD15k9++6+DY+mwaoWiEsK/oFj97
 YcsOM2O45bJ2L6SmMqVwYeSPv+opLgKpaUCrgVcZVg4y9ee8PRVEXtqGffAP2pNPf+MD0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.20 um 22:14 schrieb SZEDER G=C3=A1bor via GitGitGadget:
> From: =3D?UTF-8?q?SZEDER=3D20G=3DC3=3DA1bor?=3D <szeder.dev@gmail.com>
>
> The file 'dir/subdir/file' can only be modified if its leading
> directories 'dir' and 'dir/subdir' are modified as well.
>
> So when checking modified path Bloom filters looking for commits
> modifying a path with multiple path components, then check not only
> the full path in the Bloom filters, but all its leading directories as
> well.  Take care to check these paths in "deepest first" order,
> because it's the full path that is least likely to be modified, and
> the Bloom filter queries can short circuit sooner.
>
> This can significantly reduce the average false positive rate, by
> about an order of magnitude or three(!), and can further speed up
> pathspec-limited revision walks.  The table below compares the average
> false positive rate and runtime of
>
>   git rev-list HEAD -- "$path"
>
> before and after this change for 5000+ randomly* selected paths from
> each repository:
>
>                     Average false           Average        Average
>                     positive rate           runtime        runtime
>                   before     after     before     after   difference
>   ------------------------------------------------------------------
>   git             3.220%   0.7853%     0.0558s   0.0387s   -30.6%
>   linux           2.453%   0.0296%     0.1046s   0.0766s   -26.8%
>   tensorflow      2.536%   0.6977%     0.0594s   0.0420s   -29.2%

Nice!

>
> *Path selection was done with the following pipeline:
>
> 	git ls-tree -r --name-only HEAD | sort -R | head -n 5000
>
> The improvements in runtime are much smaller than the improvements in
> average false positive rate, as we are clearly reaching diminishing
> returns here.  However, all these timings depend on that accessing
> tree objects is reasonably fast (warm caches).  If we had a partial
> clone and the tree objects had to be fetched from a promisor remote,
> e.g.:
>
>   $ git clone --filter=3Dtree:0 --bare file://.../webkit.git webkit.notr=
ees.git
>   $ git -C webkit.git -c core.modifiedPathBloomFilters=3D1 \
>         commit-graph write --reachable
>   $ cp webkit.git/objects/info/commit-graph webkit.notrees.git/objects/i=
nfo/
>   $ git -C webkit.notrees.git -c core.modifiedPathBloomFilters=3D1 \
>         rev-list HEAD -- "$path"
>
> then checking all leading path component can reduce the runtime from
> over an hour to a few seconds (and this is with the clone and the
> promisor on the same machine).
>
> This adjusts the tracing values in t4216-log-bloom.sh, which provides a
> concrete way to notice the improvement.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  revision.c           | 35 ++++++++++++++++++++++++++---------
>  revision.h           |  6 ++++--
>  t/t4216-log-bloom.sh |  2 +-
>  3 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index c644c660917..027ae3982b4 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -670,9 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev_=
info *revs)
>  {
>  	struct pathspec_item *pi;
>  	char *path_alloc =3D NULL;
> -	const char *path;
> +	const char *path, *p;
>  	int last_index;
> -	int len;
> +	size_t len;
> +	int path_component_nr =3D 0, j;
>
>  	if (!revs->commits)
>  		return;
> @@ -705,8 +706,22 @@ static void prepare_to_use_bloom_filter(struct rev_=
info *revs)
>
>  	len =3D strlen(path);
>
> -	revs->bloom_key =3D xmalloc(sizeof(struct bloom_key));
> -	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings=
);
> +	p =3D path;
> +	do {
> +		p =3D strchrnul(p + 1, '/');
> +		path_component_nr++;
> +	} while (p - path < len);

Hmm, that "+ 1" makes me a bit nervous.  Can we be sure that path is not
an empty string?

And shouldn't we use is_dir_sep() or find_last_dir_sep() instead of
hard-coding a slash?

> +
> +	revs->bloom_keys_nr =3D path_component_nr;
> +	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
> +
> +	p =3D path;
> +	for (j =3D 0; j < revs->bloom_keys_nr; j++) {
> +		p =3D strchrnul(p + 1, '/');

Same here, of course.

Also note that this puts shorter sub-strings first.


> +
> +		fill_bloom_key(path, p - path, &revs->bloom_keys[j],
> +			       revs->bloom_filter_settings);
> +	}
>
>  	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
>  		atexit(trace2_bloom_filter_statistics_atexit);
> @@ -720,7 +735,7 @@ static int check_maybe_different_in_bloom_filter(str=
uct rev_info *revs,
>  						 struct commit *commit)
>  {
>  	struct bloom_filter *filter;
> -	int result;
> +	int result =3D 1, j;
>
>  	if (!revs->repo->objects->commit_graph)
>  		return -1;
> @@ -740,9 +755,11 @@ static int check_maybe_different_in_bloom_filter(st=
ruct rev_info *revs,
>  		return -1;
>  	}
>
> -	result =3D bloom_filter_contains(filter,
> -				       revs->bloom_key,
> -				       revs->bloom_filter_settings);
> +	for (j =3D 0; result && j < revs->bloom_keys_nr; j++) {
> +		result =3D bloom_filter_contains(filter,
> +					       &revs->bloom_keys[j],
> +					       revs->bloom_filter_settings);
> +	}

This checks shorter sub-strings first, contradicting the "deepest first"
strategy mentioned in the commit message.

This can easily be fixed by inverting the traversal of one of the loops,
of course.  Or perhaps do something like this?

	revs->bloom_keys =3D NULL;
	revs->bloom_keys_nr =3D 0;
	strbuf_add(&path, pi->match, pi->len);
	strbuf_trim_trailing_dir_sep(&path);
	for (;;) {
		const char *sep;
		ALLOC_GROW(revs->bloom_keys, revs->bloom_keys_nr + 1, alloc);
		fill_bloom_key(path.buf, path.len,
			       &revs->bloom_keys[revs->bloom_keys_nr++],
			       revs->bloom_filter_settings);
		sep =3D find_last_dir_sep(path.buf);
		if (!sep)
			break;
		strbuf_setlen(&path, sep - path.buf);
	}
	strbuf_release(&path);

The find_last_dir_sep() calls scan the first part of the string over and
over, which is a bit silly.  A strbuf_trim_trailing_path_component()
could start at the end and scan backwards if that turns out to be an
actual problem.

ALLOC_GROW wastes memory on revs->bloom_keys, and reallocating instead
of allocating the right size from the start has a cost as well, but I'd
expect this to be dwarfed by the actual revision walk.

>
>  	if (result)
>  		count_bloom_filter_maybe++;
> @@ -782,7 +799,7 @@ static int rev_compare_tree(struct rev_info *revs,
>  			return REV_TREE_SAME;
>  	}
>
> -	if (revs->bloom_key && !nth_parent) {
> +	if (revs->bloom_keys_nr && !nth_parent) {
>  		bloom_ret =3D check_maybe_different_in_bloom_filter(revs, commit);
>
>  		if (bloom_ret =3D=3D 0)
> diff --git a/revision.h b/revision.h
> index 7c026fe41fc..abbfb4ab59a 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -295,8 +295,10 @@ struct rev_info {
>  	struct topo_walk_info *topo_walk_info;
>
>  	/* Commit graph bloom filter fields */
> -	/* The bloom filter key for the pathspec */
> -	struct bloom_key *bloom_key;
> +	/* The bloom filter key(s) for the pathspec */
> +	struct bloom_key *bloom_keys;
> +	int bloom_keys_nr;
> +
>  	/*
>  	 * The bloom filter settings used to generate the key.
>  	 * This is loaded from the commit-graph being used.
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index c7011f33e2c..c13b97d3bda 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -142,7 +142,7 @@ test_expect_success 'setup - add commit-graph to the=
 chain with Bloom filters' '
>
>  test_bloom_filters_used_when_some_filters_are_missing () {
>  	log_args=3D$1
> -	bloom_trace_prefix=3D"statistics:{\"filter_not_present\":3,\"zero_leng=
th_filter\":0,\"maybe\":8,\"definitely_not\":6"
> +	bloom_trace_prefix=3D"statistics:{\"filter_not_present\":3,\"zero_leng=
th_filter\":0,\"maybe\":6,\"definitely_not\":8"
>  	setup "$log_args" &&
>  	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
>  	test_cmp log_wo_bloom log_w_bloom
>

