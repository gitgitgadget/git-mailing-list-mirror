Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB96DC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 23:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AFA619C7
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 23:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhCWX7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 19:59:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:43767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhCWX6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 19:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616543921;
        bh=vIe9yfM0UeDsCteyNkcQgkir+Mjzja+OO5xOJIZakCQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i4RT5egDVQqqOugY4o+gj/u6VpOrXVdY/jh3jj8sicxH2m/uFamIdukH8Fy0e62Co
         NJFW5sf4PfjIjCsSi/6bnmQpRsvnR0RsXDovNPoFuPa4Mo6nqNBmomGmXD5IyMNVID
         feuWrGNsiDuCgS0txeHl76vYftccF0DszXbijQrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.9.78] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxlzI-1laMgx1Ppe-00zFuv; Wed, 24
 Mar 2021 00:58:41 +0100
Date:   Wed, 24 Mar 2021 00:58:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v7 11/15] merge-octopus: rewrite in C
In-Reply-To: <20210317204939.17890-12-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103232323330.50@tvgsbejvaqbjf.bet>
References: <20201124115315.13311-1-alban.gruin@gmail.com> <20210317204939.17890-1-alban.gruin@gmail.com> <20210317204939.17890-12-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:62dz5Git+vuAW0Jf+cS4DdH4WGDl9gOpB0sG2qR1khjNf8lPfd3
 QlyQiWGTU923JWfoG3lwp0fxJP5qu23rQ8DVSyTL0f55G44MOSF7s4wX89sOnQmJ73lXL62
 eZNtbPty9qRfZBLBoKXPTkuk0ZiCRPZr/d58BvRkSciDwsLHyz1ry7MUZbnD4Tp/rDpU4eM
 pCVxoAC75cyIwczauZ6kA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WiyRACMc4s4=:DNtbd6DiXXPAVUfpdyKj9X
 KBzynorZ7zkuHQQfzOEbw5ntv68HRL95fzyw+P6kUo6YyKsN6y0m29R+JVFu8/T8Ou/bTLmkM
 MlXNsvgdfVvJTHI6blpkWv+nF+592ojsz5JyQS8QdqbKxOLp7bD3A8kPq1FUMGgeE5tpSvtEU
 oV5hdl4bX+S4L0r9advjNPOOB7IMTcTeb1yLjm9hSzcrs9CaVvnRCHtFq2REyvWiMKwX92D12
 zBVshA4c0Yw22VebRGreZbTPn0V+POC3/D+PLySEw9FihA9Kbwj/R/hBVhv1lHdgGa6w5gLjH
 p+gnlWYKJJ55H7UrVgyswxhe3wE34GhE2zr1FGur+JaJGm1kL4aGqrJiodzLjAp+0BIV+jlqj
 ls5lqXzFhxxTwpea+r0rQV7El9IdaIWBoKLbFF4JmhE2UyOEeE10oqPFBu8+oK9eUf5TkHjL8
 Jmoo/YDi5aRHPiBbJe1MHohNZARW5Ng787HJB5KPyKEQxxGpr5mCvtENhpovCi8wpCZ0fzUAy
 3mOP+/jG5omOJqwDVsINCggdyMKrg7kQSadUtO4nNgnrD85VW1n/RruAiEQjqcQN6Xv3b3c14
 YzgRQ+WdJ7LUwlsxrMIqlON5sGx8o6Bu8Gpics/QRTu7Z1n2kDRY/RVhT3cwCp5BYJ7TlXJ85
 h922l+Xy1eaD7dGJAE4BjQDms8unvZte3EMt8YEGx/bI1hd+qKIg4kmpbspdJF4o9C+a8BruX
 t8NGTOp8AXHpnia9txG2zr9+peNM6xxU3F2mjUdahRpVEn9Xbsc7MPOD6EiFTDrABJgRh8j6V
 Vf8wpz6v1kK1LMXPJtqdBGwZg6XleZsftjkmPc9puwgZljCoGcD3Pune0SLK2AHqtMtcgu8Fo
 RXeKrG8lFXDGmRJDg92vZrlnjNpTTrRWCTxe2ZljI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Wed, 17 Mar 2021, Alban Gruin wrote:

> This rewrites `git merge-octopus' from shell to C.  As for the two last
> conversions, this port removes calls to external processes to avoid
> reading and writing the index over and over again.
>
>  - Calls to `read-tree -u -m (--aggressive)?' are replaced by calls to
>    unpack_trees().
>
>  - The call to `write-tree' is replaced by a call to
>    write_index_as_tree().
>
>  - The call to `diff-index ...' is replaced by a call to
>    repo_index_has_changes().
>
>  - The call to `merge-index', needed to invoke `git merge-one-file', is
>    replaced by a call to merge_all_index().
>
> The index is read in cmd_merge_octopus(), and is wrote back by

s/wrote/written/

> merge_strategies_octopus().

I wonder why, though. Maybe the commit message could clarify that?

> Here to, merge_strategies_octopus() takes two commit lists and a string

s/to,/too,/

> to reduce frictions when try_merge_strategies() will be modified to call

s/frictions/friction/

> it directly.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>
> [...]
> diff --git a/builtin/merge-octopus.c b/builtin/merge-octopus.c
> new file mode 100644
> index 0000000000..9b9939b6b2
> --- /dev/null
> +++ b/builtin/merge-octopus.c
> @@ -0,0 +1,70 @@
> +/*
> + * Builtin "git merge-octopus"
> + *
> + * Copyright (c) 2020 Alban Gruin
> + *
> + * Based on git-merge-octopus.sh, written by Junio C Hamano.
> + *
> + * Resolve two or more trees.
> + */
> +
> +#include "cache.h"
> +#include "builtin.h"
> +#include "commit.h"
> +#include "merge-strategies.h"
> +
> +static const char builtin_merge_octopus_usage[] =3D
> +	"git merge-octopus [<bases>...] -- <head> <remote1> <remote2> [<remote=
s>...]";
> +
> +int cmd_merge_octopus(int argc, const char **argv, const char *prefix)
> +{
> +	int i, sep_seen =3D 0;
> +	struct commit_list *bases =3D NULL, *remotes =3D NULL;
> +	struct commit_list **next_base =3D &bases, **next_remote =3D &remotes;
> +	const char *head_arg =3D NULL;
> +	struct repository *r =3D the_repository;
> +
> +	if (argc < 5)
> +		usage(builtin_merge_octopus_usage);
> +
> +	setup_work_tree();
> +	if (repo_read_index(r) < 0)
> +		die("invalid index");
> +
> +	/*
> +	 * The first parameters up to -- are merge bases; the rest are
> +	 * heads.
> +	 */
> +	for (i =3D 1; i < argc; i++) {
> +		if (strcmp(argv[i], "--") =3D=3D 0)
> +			sep_seen =3D 1;
> +		else if (strcmp(argv[i], "-h") =3D=3D 0)
> +			usage(builtin_merge_octopus_usage);
> +		else if (sep_seen && !head_arg)
> +			head_arg =3D argv[i];
> +		else {
> +			struct object_id oid;
> +			struct commit *commit;
> +
> +			if (get_oid(argv[i], &oid))
> +				die("object %s not found.", argv[i]);
> +
> +			commit =3D oideq(&oid, r->hash_algo->empty_tree) ?
> +				NULL : lookup_commit_or_die(&oid, argv[i]);
> +
> +			if (sep_seen)
> +				next_remote =3D commit_list_append(commit, next_remote);
> +			else
> +				next_base =3D commit_list_append(commit, next_base);
> +		}
> +	}
> +
> +	/*
> +	 * Reject if this is not an octopus -- resolve should be used
> +	 * instead.
> +	 */
> +	if (commit_list_count(remotes) < 2)
> +		return 2;

As with `merge-resolve`, I would suggest to:

- move this input validation down to `merge_strategies_octopus()`, and
- change that function's signature to return an `enum`, and then
- make sure that that `enum` uses easy-to-understand labels.

> +
> +	return merge_strategies_octopus(r, bases, head_arg, remotes);
> +}
>
> [...]
>
> diff --git a/merge-strategies.c b/merge-strategies.c
> index a51700dae5..ebc0d0b1e2 100644
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -367,3 +368,177 @@ int merge_strategies_resolve(struct repository *r,
>
>  	return 0;
>  }
> +
> +static int write_tree(struct repository *r, struct tree **reference_tre=
e)
> +{
> +	struct object_id oid;
> +	int ret;
> +
> +	if (!(ret =3D write_index_as_tree(&oid, r->index, r->index_file,
> +					WRITE_TREE_SILENT, NULL)))
> +		*reference_tree =3D lookup_tree(r, &oid);
> +
> +	return ret;
> +}
> +
> +static int octopus_fast_forward(struct repository *r, const char *branc=
h_name,
> +				struct tree *tree_head, struct tree *current_tree,
> +				struct tree **reference_tree)

While I objected to the name of the `fast_forward()` function, I think the
`octopus_fast_forward()` function is named aptly.

> +{
> +	/*
> +	 * The first head being merged was a fast-forward.  Advance the
> +	 * reference commit to the head being merged, and use that tree
> +	 * as the intermediate result of the merge.  We still need to
> +	 * count this as part of the parent set.
> +	 */
> +	struct tree_desc t[2];
> +
> +	printf(_("Fast-forwarding to: %s\n"), branch_name);
> +
> +	init_tree_desc(t, tree_head->buffer, tree_head->size);
> +	if (add_tree(current_tree, t + 1))
> +		return -1;
> +	if (fast_forward(r, t, 2, 0))
> +		return -1;
> +	if (write_tree(r, reference_tree))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int octopus_do_merge(struct repository *r, const char *branch_na=
me,
> +			    struct commit_list *common, struct tree *current_tree,
> +			    struct tree **reference_tree)
> +{
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct commit_list *i;
> +	int nr =3D 0, ret =3D 0;
> +
> +	printf(_("Trying simple merge with %s\n"), branch_name);
> +
> +	for (i =3D common; i; i =3D i->next) {
> +		struct tree *tree =3D repo_get_commit_tree(r, i->item);
> +		if (add_tree(tree, t + (nr++)))
> +			return -1;
> +	}
> +
> +	if (add_tree(*reference_tree, t + (nr++)))
> +		return -1;
> +	if (add_tree(current_tree, t + (nr++)))
> +		return -1;
> +	if (fast_forward(r, t, nr, 1))
> +		return 2;
> +
> +	if (write_tree(r, reference_tree)) {
> +		struct lock_file lock =3D LOCK_INIT;
> +
> +		puts(_("Simple merge did not work, trying automatic merge."));
> +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);

It is a bit funny to see this as the only time in this patch where the
index is locked, and it is immediately released thereafter.

I would have expected the lock to be taken first thing in
`merge_strategies_octopus()` and then being committed only on success, or
on failure to merge.

> +		ret =3D !!merge_all_index(r->index, 0, 0, merge_one_file_func, NULL);
> +		write_locked_index(r->index, &lock, COMMIT_LOCK);
> +
> +		write_tree(r, reference_tree);
> +	}
> +
> +	return ret;
> +}
> +
> +int merge_strategies_octopus(struct repository *r,
> +			     struct commit_list *bases, const char *head_arg,
> +			     struct commit_list *remotes)
> +{
> +	int ff_merge =3D 1, ret =3D 0, nr_references =3D 1;
> +	struct commit **reference_commits, *head_commit;
> +	struct tree *reference_tree, *head_tree;
> +	struct commit_list *i;
> +	struct object_id head;
> +	struct strbuf sb =3D STRBUF_INIT;
> +
> +	get_oid(head_arg, &head);
> +	head_commit =3D lookup_commit_reference(r, &head);
> +	head_tree =3D repo_get_commit_tree(r, head_commit);
> +
> +	if (parse_tree(head_tree))
> +		return 2;
> +
> +	if (repo_index_has_changes(r, head_tree, &sb)) {
> +		error(_("Your local changes to the following files "
> +			"would be overwritten by merge:\n  %s"),
> +		      sb.buf);
> +		strbuf_release(&sb);
> +		return 2;
> +	}
> +
> +	CALLOC_ARRAY(reference_commits, commit_list_count(remotes) + 1);
> +	reference_commits[0] =3D head_commit;
> +	reference_tree =3D head_tree;
> +
> +	for (i =3D remotes; i && i->item; i =3D i->next) {
> +		struct commit *c =3D i->item;
> +		struct object_id *oid =3D &c->object.oid;
> +		struct tree *current_tree =3D repo_get_commit_tree(r, c);
> +		struct commit_list *common, *j;
> +		char *branch_name =3D merge_get_better_branch_name(oid_to_hex(oid));
> +		int up_to_date =3D 0;
> +
> +		common =3D repo_get_merge_bases_many(r, c, nr_references, reference_c=
ommits);
> +		if (!common) {
> +			error(_("Unable to find common commit with %s"), branch_name);
> +
> +			free(branch_name);
> +			free_commit_list(common);
> +			free(reference_commits);
> +
> +			return 2;
> +		}
> +
> +		for (j =3D common; j && !up_to_date && ff_merge; j =3D j->next) {
> +			up_to_date |=3D oideq(&j->item->object.oid, oid);

Semantically, I would argue that this is an `||=3D`, not `|=3D`: we want a
Boolean "or", not a bit-wise one.

> +
> +			if (!j->next &&
> +			    !oideq(&j->item->object.oid,
> +				   &reference_commits[nr_references - 1]->object.oid))
> +				ff_merge =3D 0;
> +		}

Hmm. This is combining two things into the same loop, with a combined loop
condition. The two things are:

	case "$LF$common$LF" in
        *"$LF$SHA1$LF"*)
                eval_gettextln "Already up to date with \$pretty_name"
                continue
                ;;
        esac

        if test "$common,$NON_FF_MERGE" =3D "$MRC,0"
        then
                # The first head being merged was a fast-forward.
                # Advance MRC to the head being merged, and use that
                # tree as the intermediate result of the merge.
                # We still need to count this as part of the parent set.

                eval_gettextln "Fast-forwarding to: \$pretty_name"
                git read-tree -u -m $head $SHA1 || exit
                MRC=3D$SHA1 MRT=3D$(git write-tree)
                continue
        fi

        NON_FF_MERGE=3D1

The first one tries to verify that the `common` list contains `oid`. The C
code does this, too, using the intuitive variable name `up_to_date`, which
is good.

Now, big question: is there a way for the loop to exit before we had a
chance to see the common commit that is identical to `oid`? And I think
there is: `ff_merge` is not reset between the outer loop (the one
iterating over `remotes`). If that is the case, then we would miss that
we're already up to date.

Next thing is that `if test "$common,$NON_FF_MERGE" =3D "$MRC,0"` thing.
This is turned into that `if (!j->next && ...)` thing, and I _think_ that
it does the wrong thing. Rather than verifying that the `common` list
is identical to "MRC" (=3D the merge reference list), it would only ever
compare the last entries of `common` and MRC.

I have a hard time convincing myself that this is idempotent to the shell
script version.

Instead, I think it should read somewhat like this:

		for (j =3D common, k =3D 0; j && (!up_to_date || ff_merge); j =3D j->nex=
t) {
			up_to_date ||=3D oideq(&j->item->object.oid, oid);

			if (ff_merge &&
			    (k >=3D nr_references ||
			     !oideq(&j->item->object.oid,
				    &reference_commits[k++]->object.oid))
				ff_merge =3D 0;
		}

But quite honestly, this still looks "too clever" and too fragile to me.
For something as rare as an octopus merge, I'd _much_ rather have simpler
code that is easy to reason about and does the job reliably (if somewhat
slower than a hyper-optimized version):

		/*
		 * If `oid` is reachable from `HEAD`, we're already up to
		 * date.
		 */
		for (j =3D common; j; j =3D j->next)
			if (oideq(&j->item->object.oid, oid)) {
				up_to_date =3D 1;
				break;
			}

		if (up_to_date) {
			printf(_("Already up to date with %s\n"), branch_name);

			free(branch_name);
			free_commit_list(common);
			continue;
		}

		for (j =3D common, k =3D 0; ff_merge && j; j =3D j->next)
			if (k >=3D nr_references ||
			    !oideq(&j->item->object.oid,
				   &reference_commits[k++]->object.oid))
				ff_merge =3D 0;
		if (k !=3D nr_references)
			ff_merge =3D 0;


But the more I stare at the shell script code, the more I start to believe
that this `MRC` business is just a very convoluted way to essentially
verify that the `HEAD` is the _single_ merge base.

I say that because I cannot fail to notice that `$common` separates the
merge bases by newlines, while `$MRC` separates its entries by spaces.
Therefore,

		test "$common,$NON_FF_MERGE" =3D "$MRC,0"

can only ever evaluate to `true` if both `$common` and `$MRC` contains
exactly one and the same oid, namely the one of the revision to which we
just fast-forwarded in the previous iteration.

Therefore, the logic does not even need a loop. It would be as trivial as:

		/*
		 * If we could fast-forward so far and `HEAD` is the
		 * single merge base with the current `remote` revision,
		 * keep fast-forwarding.
		 */
		if (ff_merge && common && !common->next && nr_references =3D=3D 1 &&
		    oideq(common->item->object.oid,
			  reference_commit[0]->object.oid)) {
			ret =3D octopus_fast_forward(r, branch_name, head_tree,
						   current_tree, &reference_tree);
			nr_references =3D 0;
		} else {
			ff_merge =3D 0;
			ret =3D octopus_do_merge(r, branch_name, common,
					       current_tree, &reference_tree);
		}


> +
> +		if (up_to_date) {
> +			printf(_("Already up to date with %s\n"), branch_name);
> +
> +			free(branch_name);
> +			free_commit_list(common);
> +			continue;
> +		}
> +
> +		if (ff_merge) {
> +			ret =3D octopus_fast_forward(r, branch_name, head_tree,
> +						   current_tree, &reference_tree);
> +			nr_references =3D 0;
> +		} else {
> +			ret =3D octopus_do_merge(r, branch_name, common,
> +					       current_tree, &reference_tree);
> +		}
> +
> +		free(branch_name);
> +		free_commit_list(common);
> +
> +		if (ret =3D=3D -1 || ret =3D=3D 2)
> +			break;
> +		else if (ret && i->next) {
> +			/*
> +			 * We allow only last one to have a
> +			 * hand-resolvable conflicts.  Last round failed
> +			 * and we still had a head to merge.
> +			 */
> +			puts(_("Automated merge did not work."));
> +			puts(_("Should not be doing an octopus."));
> +
> +			free(reference_commits);
> +			return 2;

I see that you moved this block from the beginning of the loop to the end
(in the script, it was at the start of the loop). This is a good change.

I wonder, though, whether it wouldn't make more sense to replace the last
two lines with this:

			ret =3D 2;
			break;

That way, we need not worry about releasing resources in multiple places
in the future: it will all be done at the end of the function.

Phew. What a lot to unpack.

Please let me express my gratitude for working on this. My many comments
may seem as if I am unhappy with the progress, but nothing could be
further from the truth. I am impressed by your tenacity, and I hope that I
could do my little bit to make this patch series as good as we can.

Thanks,
Dscho

> +		}
> +
> +		reference_commits[nr_references++] =3D c;
> +	}
> +
> +	free(reference_commits);
> +	return ret;
> +}
> diff --git a/merge-strategies.h b/merge-strategies.h
> index bba4bf999c..8de2249ee6 100644
> --- a/merge-strategies.h
> +++ b/merge-strategies.h
> @@ -32,5 +32,8 @@ int merge_all_index(struct index_state *istate, int on=
eshot, int quiet,
>  int merge_strategies_resolve(struct repository *r,
>  			     struct commit_list *bases, const char *head_arg,
>  			     struct commit_list *remote);
> +int merge_strategies_octopus(struct repository *r,
> +			     struct commit_list *bases, const char *head_arg,
> +			     struct commit_list *remote);
>
>  #endif /* MERGE_STRATEGIES_H */
> --
> 2.31.0
>
>
