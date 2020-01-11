Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EABFC282DD
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83112077C
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 00:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuyv0AkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgAKA1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:27:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33032 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgAKA1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 19:27:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so2816605lfl.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 16:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ecDjPxePc0hZcYehf92Mu/MGKO+cWsDVHdil+OGVcjI=;
        b=Vuyv0AkIup76LbAd/P7ySMjqak3WbLywWgUKlxRNSnU17yYTZv+0unTEry3XNIT1CU
         ip/+2FHFYI4ot1P2zY4eRzdmzi6XOyGJe+WG2k6PckhBdd8PoVHbSRIoRkXe0bI3YPku
         mKxIY2rgvAP/9mhxVSfl5MjAag4F+mTkanz5H0pKCBLh30vEPpVo92YNcxkiNixx5tJn
         Y10P+GcibE82NN5ULkkoBKvplSTLD8dfaeGbDA9rd7n31TAywdRdmbkyJPl9+5cS7Q9P
         HIQv0a+Q1rcTAeNT/lMCOkLH4OGQoemURA9KOqupmCu/oObzaN1aPCgODmhzawmEGMTs
         kcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ecDjPxePc0hZcYehf92Mu/MGKO+cWsDVHdil+OGVcjI=;
        b=hV7sedrBRw27HAq99IdZtcQj0fuLA+iPM0QMvaSImUeNNEtwqLQ2jsc0m6OetGSTun
         qTfLIof75hWaM0CS9g0J7/B0R2SYpfa7Tty7w3EJsD3vsRqbLNc4CHcSHuEYT6nQNnbI
         dD9pdTC1LJ4HInqQaeGm7wndRPp70QsqStpXTmbJYD4bp426+6KPw/Saa5lOwmdB6MEA
         nBBH/dqgDcbR6eTqlnoOLl/QVnekrzOSiFe/hNE8OKXD4XQdKiuSmQyueR8dM5etCzJF
         UuXK71UjsW1k0YXQ6W7Msr2+H8Im/Qe+q70FefeRHUAzBOGHUoN37TSejyy8EJQX/jWg
         nXQg==
X-Gm-Message-State: APjAAAUpsfAwD2b3vAfjmgJwcUJIrTbIUTIiy7HlZsgxYDBi2uPDxC8U
        O0vtonRvIm9zIxJ06RW/d2Y=
X-Google-Smtp-Source: APXvYqzy6NOf9LHNQJBat9hx05wnwdnSJWUkOBZ4a5TElOMkp2WxhAXS2uZRYWnj5dI9WA63deyykg==
X-Received: by 2002:a05:6512:25c:: with SMTP id b28mr3943015lfo.184.1578702452220;
        Fri, 10 Jan 2020 16:27:32 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id g15sm1658565ljn.32.2020.01.10.16.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 16:27:31 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 8/9] revision.c: use bloom filters to speed up path based revision walks
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <72a2bbf6765a1e99a3a23372f801099a07fe11a5.1576879520.git.gitgitgadget@gmail.com>
Date:   Sat, 11 Jan 2020 01:27:23 +0100
In-Reply-To: <72a2bbf6765a1e99a3a23372f801099a07fe11a5.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:19
        +0000")
Message-ID: <86d0bqsuqc.fsf@gmail.com>
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
> If bloom filters have been written to the commit-graph file, revision wal=
k will
> use them to speed up revision walks for a particular path.

I'd propose the following change, to make structure of the above
sentence simpler:

  Revision walk will now use Bloom filters for commits to speed up
  revision walks for a particular path (for computing history of a
  path), if they are present in the commit-graph file.

> Note: The current implementation does this in the case of single pathspec
> case only.
>
> We load the bloom filters during the prepare_revision_walk step when deal=
ing

I think it would flow better with the following change:

s/when dealing/, but only when dealing/

> with a single pathspec. While comparing trees in rev_compare_trees(), if =
the
> bloom filter says that the file is not different between the two trees, we
> don't need to compute the expensive diff. This is where we get our perfor=
mance
> gains.

Maybe we should also add:

  The other answer we can get from the Bloom filter is "maybe".

>
> Performance Gains:
> We tested the performance of `git log --path` on the git repo, the linux =
and
> some internal large repos, with a variety of paths of varying depths.

I think you meant `git log <path>`, not `git log --path`.

>
> On the git and linux repos:
> we observed a 2x to 5x speed up.

It would be good, I think, to have some specific numbers: starting from
this version, for this path, with and without Bloom filters it takes so
long (and the improvement in %).

While at it, it might be good idea to provide _costs_: how much
additional space on disk Bloom filters take for those specific examples,
and how much extra time (and memory) it takes to compute Bloom filters.

With actual specific numbers we can estimate when it would start to be
worth it to create Bloom filter data...

>
> On a large internal repo with files seated 6-10 levels deep in the tree:
> we observed 10x to 20x speed ups, with some paths going up to 28 times
> faster.

It would be nice to see specific numbers, if showing pathnames is
possible.  In any case it would be good to have more information: what
paths give 10x, what give 20x, and what kinds give 28x speedup (what
is path depth, how many objects, etc.).

>
> RFC Notes:
> I plan to collect the folloowing statistics around this usage of bloom fi=
lters
> and trace them out using trace2.
> - number of bloom filter queries,
> - number of "No" responses (file hasn't changed)
> - number of "Maybe" responses (file may have changed)
> - number of "Commit not parsed" cases (commit had too many changes to hav=
e a
>   bloom filter written out, currently our limit is 512 diffs)

Perhaps also:
  - histogram of bloom filter sizes in 64-bit blocks
    (which is rough histogram of number of changes per commit)

Though I think all those statistics are a bit specific to the
repository, and how you use Git.

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com
> Helped-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  bloom.c              | 20 ++++++++++++
>  bloom.h              |  4 +++
>  revision.c           | 67 +++++++++++++++++++++++++++++++++++++--
>  revision.h           |  5 +++
>  t/t4216-log-bloom.sh | 74 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 168 insertions(+), 2 deletions(-)
>  create mode 100755 t/t4216-log-bloom.sh
>
> diff --git a/bloom.c b/bloom.c
> index 86b1005802..0c7505d3d6 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -235,3 +235,23 @@ struct bloom_filter *get_bloom_filter(struct reposit=
ory *r,
>=20=20
>  	return filter;
>  }
> +
> +int bloom_filter_contains(struct bloom_filter *filter,
> +			  struct bloom_key *key,
> +			  struct bloom_filter_settings *settings)
> +{
> +	int i;
> +	uint64_t mod =3D filter->len * BITS_PER_BLOCK;
> +
> +	if (!mod)
> +		return 1;

Ah, so filter->len equal to zero denotes too many changes for a Bloom
filter, and this conditional is a short-circuit test: always return
"maybe".

I wonder if we should explicitly check for filter->len =3D 1 and
filter->data[0] =3D 0, which should be empty Bloom filter -- for commit
with no changes with respect to first parent, and short-circuit
returning 0 (no file would ever belong).

> +
> +	for (i =3D 0; i < settings->num_hashes; i++) {
> +		uint64_t hash_mod =3D key->hashes[i] % mod;
> +		uint64_t block_pos =3D hash_mod / BITS_PER_BLOCK;

I have seen this code before... ;-)  The add_key_to_filter() function
includes almost identical code, but I am not sure if it is feasible to
eliminate this (slight) code duplication.  Probably not.

> +		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
> +			return 0;

All right, if at least one hash function does not match, return "no"...

> +	}
> +
> +	return 1;

... else return "maybe".

> +}

I am wondering however if this code should not be moved earlier in the
series, so that commit 2/9 in series actually adds fully functional
[semi-generic] Bloom filter implementation.

> diff --git a/bloom.h b/bloom.h
> index 101d689bbd..9bdacd0a8e 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -44,4 +44,8 @@ void fill_bloom_key(const char *data,
>  		    struct bloom_key *key,
>  		    struct bloom_filter_settings *settings);
>=20=20
> +int bloom_filter_contains(struct bloom_filter *filter,
> +			  struct bloom_key *key,
> +			  struct bloom_filter_settings *settings);
> +
>  #endif
> diff --git a/revision.c b/revision.c
> index 39a25e7a5d..01f5330740 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -29,6 +29,7 @@
>  #include "prio-queue.h"
>  #include "hashmap.h"
>  #include "utf8.h"
> +#include "bloom.h"
>=20=20
>  volatile show_early_output_fn_t show_early_output;
>=20=20
> @@ -624,11 +625,34 @@ static void file_change(struct diff_options *option=
s,
>  	options->flags.has_changes =3D 1;
>  }
>=20=20
> +static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
> +						 struct commit *commit,
> +						 struct bloom_key *key,
> +						 struct bloom_filter_settings *settings)

All right, this function name is certainly descriptive.  I wonder if it
wouldn't be better to use a shorter name, like maybe_different(), or
maybe_not_treesame(), so that the conditional using this function would
read naturally:

  if (!maybe_different(revs, commit, revs->bloom_key,
  		       revs->bloom_filter_settings))
  	return REV_TREE_SAME;

But this might be just a matter of taste.

> +{
> +	struct bloom_filter *filter;
> +
> +	if (!revs->repo->objects->commit_graph)
> +		return -1;
> +	if (commit->generation =3D=3D GENERATION_NUMBER_INFINITY)
> +		return -1;

O.K., so we check that there is loaded commit graph, and that given
commit is in a commit graph, otherwise we return "no data".

I agree with distinguishing between "no data" value (which is <0, a
convention for denoting errors), and "maybe" value.  Currently this
distinction is not utilized, but it would help in the case of more than
one path given -- in "no data" case there is no need to check other
paths against non-existing Bloom filter.

> +	if (!key || !settings)
> +		return -1;

Why the check for non-NULL 'key' and 'settings' is the last check?

BTW. when it is possible for key or settings to be NULL?  Or is it just
defensive programming?

> +
> +	filter =3D get_bloom_filter(revs->repo, commit, 0);

O.K., we won't be recomputing Bloom filter if it is not present either
on slab (as "inside-out" auxiliary data for a commit), or in the
commit-graph (in Bloom filter chunks).

> +
> +	if (!filter || !filter->len)
> +		return 1;

Sidenote: bloom_filter_contains() would also indirectly check for
filter->len being zero.  Though this doesn't cost much.

Shouldn't !filter case return value of -1 i.e. "no data", rather than
return value of 1 i.e. "maybe"?

> +
> +	return bloom_filter_contains(filter, key, settings);
> +}

All right.

> +
>  static int rev_compare_tree(struct rev_info *revs,
> -			    struct commit *parent, struct commit *commit)
> +			    struct commit *parent, struct commit *commit, int nth_parent)
>  {
>  	struct tree *t1 =3D get_commit_tree(parent);
>  	struct tree *t2 =3D get_commit_tree(commit);
> +	int bloom_ret =3D 1;
>=20=20
>  	if (!t1)
>  		return REV_TREE_NEW;
> @@ -653,6 +677,16 @@ static int rev_compare_tree(struct rev_info *revs,
>  			return REV_TREE_SAME;
>  	}
>=20=20
> +	if (revs->pruning.pathspec.nr =3D=3D 1 && !nth_parent) {

All right, Bloom filter stores information about changed paths with
respect to first-parent changes only, so if we are asking about is not a
first parent (where nth_parent =3D=3D 0), we cannot use Bloom filter.

Currently we limit the check to single pathspec only; that is a good
start and a good simplification.

> +		bloom_ret =3D check_maybe_different_in_bloom_filter(revs,
> +								  commit,
> +								  revs->bloom_key,
> +								  revs->bloom_filter_settings);
> +
> +		if (bloom_ret =3D=3D 0)
> +			return REV_TREE_SAME;

Pretty straightforward.

> +	}
> +
>  	tree_difference =3D REV_TREE_SAME;
>  	revs->pruning.flags.has_changes =3D 0;
>  	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
> @@ -855,7 +889,7 @@ static void try_to_simplify_commit(struct rev_info *r=
evs, struct commit *commit)
>  			die("cannot simplify commit %s (because of %s)",
>  			    oid_to_hex(&commit->object.oid),
>  			    oid_to_hex(&p->object.oid));
> -		switch (rev_compare_tree(revs, p, commit)) {
> +		switch (rev_compare_tree(revs, p, commit, nth_parent)) {

All right, we need to pass information about the index of the parent;
and we have just done that.  Good.

>  		case REV_TREE_SAME:
>  			if (!revs->simplify_history || !relevant_commit(p)) {
>  				/* Even if a merge with an uninteresting
> @@ -3342,6 +3376,33 @@ static void expand_topo_walk(struct rev_info *revs=
, struct commit *commit)
>  	}
>  }
>=20=20
> +static void prepare_to_use_bloom_filter(struct rev_info *revs)

All right, I see that pointers to bloom_key and bloom_filter_settings
were added to the rev_info struct.  I understand why the former is here,
but the latter seems to be there just as a shortcut (to not owned data),
which is fine but a bit strange.

Or is the latter here to allow for Bloom filter settings to possibly
change from commit-graph file in the chain to commit-graph file, and
thus from commit to commit?

> +{
> +	struct pathspec_item *pi;

Maybe 'pathspec' (or the like) instead of short and cryptic 'pi' would
be better a better name... unless 'pi' is used in other places already.

> +	const char *path;
> +	size_t len;
> +
> +	if (!revs->commits)
> +	    return;

When revs->commits may be NULL?  I understand that we need to have this
check because we use revs->commits->item next (sidenote: can revs ever
be NULL?).

Would `git log --all -- <path>` use Bloom filters (as it theoretically
could)?

> +
> +	parse_commit(revs->commits->item);

Why parsing first commit on the list of starting commits is needed here?
Please help me understand this line.

And shouldn't we use repo_parse_commit() here?

> +
> +	if (!revs->repo->objects->commit_graph)
> +		return;
> +
> +	revs->bloom_filter_settings =3D revs->repo->objects->commit_graph->sett=
ings;
> +	if (!revs->bloom_filter_settings)
> +		return;

All right, so if there is no commit graph, or the commit graph does not
include Bloom filter data, there is nothing to do.

Though I worry that it would make Git do not use Bloom filter if the top
commit-graph in the chain does not include Bloom filter data, while
other commit-graph files do (and Git could have used that information to
speed up the file history query).

> +
> +	pi =3D &revs->pruning.pathspec.items[0];
> +	path =3D pi->match;
> +	len =3D strlen(path);


Why not the following, if we do not do any checks for 'pi' value:

  +	path =3D &revs->pruning.pathspec.items[0]->match;

A question: is the path in the `match` field in `struct pathspec`
normalized with respect to trailing slash (for directories)?  Bloom
filter stores pathnames for directories without trailing slash.

What I mean is if, for example, both of those would use Bloom filter
data:

  $ git log -- Documentation/
  $ git log -- Documentation

> +
> +	load_bloom_filters();
> +	revs->bloom_key =3D xmalloc(sizeof(struct bloom_key));
> +	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);

All right, looks good.

Though... do we leak revs->bloom_key, as should we worry about it?

> +}
> +
>  int prepare_revision_walk(struct rev_info *revs)
>  {
>  	int i;
> @@ -3391,6 +3452,8 @@ int prepare_revision_walk(struct rev_info *revs)
>  		simplify_merges(revs);
>  	if (revs->children.name)
>  		set_children(revs);
> +	if (revs->pruning.pathspec.nr =3D=3D 1)
> +	    prepare_to_use_bloom_filter(revs);

Looks good.

Minor nitpick: 4 spaces instead of tab are used for indentation (or, to
be more exact a tab followed by 4 space, instead of two tabs):

  +	if (revs->pruning.pathspec.nr =3D=3D 1)
  +		prepare_to_use_bloom_filter(revs);

>  	return 0;
>  }
>=20=20
> diff --git a/revision.h b/revision.h
> index a1a804bd3d..65dc11e8f1 100644
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
> @@ -291,6 +293,9 @@ struct rev_info {
>  	struct revision_sources *sources;
>=20=20
>  	struct topo_walk_info *topo_walk_info;
> +
> +	struct bloom_key *bloom_key;
> +	struct bloom_filter_settings *bloom_filter_settings;

It might be a good idea to add one-line comment above those newly
introduced fields.  The `struct rev_info` has many subsections of fields
described by such comments (or even block comments), like e.g.

  /* Starting list */
  /* Parents of shown commits */
  /* The end-points specified by the end user */
  /* excluding from --branches, --refs, etc. expansion */
  /* Traversal flags */
  /* diff info for patches and for paths limiting */

  /*
   * Whether the arguments parsed by setup_revisions() included any
   * "input" revisions that might still have yielded an empty pending
   * list (e.g., patterns like "--all" or "--glob").
   */

>  };
>=20=20
>  int ref_excluded(struct string_list *, const char *path);
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> new file mode 100755
> index 0000000000..d42f077998
> --- /dev/null
> +++ b/t/t4216-log-bloom.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +
> +test_description=3D'git log for a path with bloom filters'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup repo' '
> +	git init &&
> +	git config core.commitGraph true &&
> +	git config gc.writeCommitGraph false &&
> +	infodir=3D".git/objects/info" &&
> +	graphdir=3D"$infodir/commit-graphs" &&
> +	test_oid_init

Why do you use `test_oid_init`, when you are *not* using `test_oid`?
I guess it is because t5318-commit-graph.sh uses it, isn't it?

The `graphdir` shell variable is not used either.

> +'
> +
> +test_expect_success 'create 9 commits and repack' '
> +	test_commit c1 file1 &&
> +	test_commit c2 file2 &&
> +	test_commit c3 file3 &&
> +	test_commit c4 file1 &&
> +	test_commit c5 file2 &&
> +	test_commit c6 file3 &&
> +	test_commit c7 file1 &&
> +	test_commit c8 file2 &&
> +	test_commit c9 file3
> +'

Wouldn't it be better for this step to be a part of 'setup repo' step?
Anyway, the test name says '... and repack', but `git repack` is missing
(it should be done after last test_commit).

I think it would be good idea to test behavior of Bloom filters with
respect to directories, so at least one file should be in a subdirectory
(maybe even deeper in hierarchy).

We should also test the behavior with respect to merges, and when we are
not following the first parent.  But that might be a separate part of
this test.

> +
> +printf "c7\nc4\nc1" > expect_file1

Doing things outside test is discouraged.  We can create a separate test
that creates those expect_file* files, or it can be a part of 'create
commits' test.

Anyway, instead of doing test without Bloom filters (something that
should have been tested already by other parts of testsuite), and then
doing the same test with Bloom filter, why not compare that the result
without and with Bloom filter is the same.  The t5318-commit-graph.sh
test does this with help of graph_git_two_modes() function:

  graph_git_two_modes () {
  	git -c core.commitGraph=3Dtrue  $1 >output
  	git -c core.commitGraph=3Dfalse $1 >expect
  	test_cmp expect output
  }

Sidenote: I wonder if it is high time to create t/lib-commit-graph.sh
helper with, among others, this common function.

> +
> +test_expect_success 'log without bloom filters' '
> +	git log --pretty=3D"format:%s"  -- file1 > actual &&

CodingGuidelines:57: Redirection operators should be written with space
before, but no space after them.  (Minor nitpick)

  +	git log --pretty=3D"format:%s"  -- file1 >actual &&

> +	test_cmp expect_file1 actual
> +'
> +
> +printf "c8\nc7\nc5\nc4\nc2\nc1" > expect_file1_file2

  +printf "c8\nc7\nc5\nc4\nc2\nc1" >expect_file1_file2

> +
> +test_expect_success 'multi-path log without bloom filters' '
> +	git log --pretty=3D"format:%s"  -- file1 file2 > actual &&

  +	git log --pretty=3D"format:%s"  -- file1 file2 >actual &&

> +	test_cmp expect_file1_file2 actual
> +'
> +
> +graph_read_expect() {

CodingGuidelines:144: We prefer a space between the function name and
the parentheses, and no space inside the parentheses.  (Minor nitpick)

  +graph_read_expect () {

> +	OPTIONAL=3D""
> +	NUM_CHUNKS=3D5
> +	if test ! -z $2
> +	then
> +		OPTIONAL=3D" $2"
> +		NUM_CHUNKS=3D$((3 + $(echo "$2" | wc -w)))

This should be either

  +		NUM_CHUNKS=3D$((5 + $(echo "$2" | wc -w)))

or more future proof

  +		NUM_CHUNKS=3D$(($NUM_CHUNKS + $(echo "$2" | wc -w)))

We got away with this bug because we were not using octopus merges, and
there were no optional core chunks, that is we never call
graph_read_expect with second parameter in this test.

> +	fi
> +	cat >expect <<- EOF

Why there is space between "<<-" and "EOF"?

> +	header: 43475048 1 1 $NUM_CHUNKS 0
> +	num_commits: $1
> +	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data$=
OPTIONAL
> +	EOF
> +	test-tool read-graph >output &&
> +	test_cmp expect output
> +}
> +
> +test_expect_success 'write commit graph with bloom filters' '
> +	git commit-graph write --reachable --changed-paths &&
> +	test_path_is_file $infodir/commit-graph &&
> +	graph_read_expect "9"
> +'

All right, this is preparatory step for further tests.

> +
> +test_expect_success 'log using bloom filters' '
> +	git log --pretty=3D"format:%s" -- file1 > actual &&
> +	test_cmp expect_file1 actual
> +'
> +
> +test_expect_success 'multi-path log using bloom filters' '
> +	git log --pretty=3D"format:%s"  -- file1 file2 > actual &&
> +	test_cmp expect_file1_file2 actual
> +'

With graph_git_two_modes() it would be much simpler:

  +test_expect_success 'single-path log' '
  +	git_graph_two_modes "git log --pretty=3Dformat:%s -- file1"
  +'

  +test_expect_success 'multi-path log' '
  +	git_graph_two_modes "git log --pretty=3Dformat:%s -- file1 file2"
  +'

What is missing is:
1. checking that Git is actually _using_ Bloom filters
   (which might be difficult to do)
2. testing that Bloom filters work also for history of subdirectories
   e.g. "git log -- subdir/" and "git log -- subdir"; this would of
   course require adjusting setup step
3. testing specific behaviors, like "git log --all -- file1"
4. merges with history following second parent
5. commits with no changes and/or merges with no first-parent changes
6. commit with more than 512 changed files (marked as slow test,
   and perhaps created with fast-import interface, like bulk commit
   creation in test_commit_bulk)

> +
> +test_done

Best regards,
--=20
Jakub Nar=C4=99bski
