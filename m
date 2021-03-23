Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920C0C433EB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 22:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F746619C2
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhCWWYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 18:24:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:40751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234042AbhCWWWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 18:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616538110;
        bh=mT2033WUCLml1SamUGj+qamyoau2QLzLy7EX8Ltb7Bw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hhgP2Ni6eKcUifg5ypdgobLqykTxG54wkvsTMUeu4EmlY1Yc8gtPONx0w4hr79g87
         WNTQQYrrf6Ppsd8NVUOzmj7ZXu/UM6A9S2PO5YEgUjzCsRcrm9pZOomjzQDCKh7+fe
         B9Qrf4EqBPyoY6SAvYWgERi+Yj0+BhEGoV5QWpxM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.9.78] ([213.196.212.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1lu3Q72grZ-00e7E8; Tue, 23
 Mar 2021 23:21:50 +0100
Date:   Tue, 23 Mar 2021 23:21:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v7 09/15] merge-resolve: rewrite in C
In-Reply-To: <20210317204939.17890-10-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103232257590.50@tvgsbejvaqbjf.bet>
References: <20201124115315.13311-1-alban.gruin@gmail.com> <20210317204939.17890-1-alban.gruin@gmail.com> <20210317204939.17890-10-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uk9F2BtEY0bK9EGNdJvFIi3DF83mcV1mPRQrBW5na7Ertwp+LFk
 viL72hDuHP9hR3RdVZ1xxxnPfSx/T5pRqIWy1onjz+siNOndpXVWypjAJI4ZJCoyQbSBK1q
 lMb16PCZVtKpfNowVMa8CNFBL/IrAwAwxhbalzAe+55I5RhZ+16ivLruvxxkAguI0Hruj/T
 vEu4O038txdeKHQAn+OhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JH2J7CJQp1s=:Wg56Jl1S29jl8WSj5T418Y
 psghzpbC/quziZ/5R7U/JtuGq/dmL2LJnjOjGY5U6iX0EFc3148D1Pd5o9jlvq5vDgOVjOFBb
 ZCJHjlDZHrR2S2Kfrf7lT8D982wwjT7+/KM5h/D7xRUfMtudCovtxjaO2IGS2E2cHM5tFkniX
 nuTV7Ut48o5JMzCWsdGaKQoMUZsOyMvuCjU9/T6+ZF1estrBPg1+YUTSMBpvEz80nLx6KUlf+
 mE7WXQVJy6Jh6zOdloEk940JVLsoSO26pUEQ3UUYAPLlShxzHE4zS56k2rMVwvx3b4ILwL5//
 v4A43xkeIDT8mdPw1mBDweD4uK6zIP3/3XJVi74GKACDoxBAbcRt9VAGBLn/Bj38G7tJbkXL+
 DoyQ64NacVd/jo4pEtFfEV3cT8irrqBxIjPnwSD7WejgcP6eX2b3a6i+upgRKeBd++IPnaLJe
 ago9rE6imvlbsT0ozEq4Cehq4DX47p1ocnfPNWxZRv/2cdoZLCfOu0VFIO6fPcL2KK0PEPWd+
 ZzutiY4OtG2qXh4s9nJwEn0qCGjjcLHQPczFXjEBWmmaxIBWDsxWLVWjmBqNfHirxXk2Btvig
 mjwkIqjdLXCidmrcxs/KsuK9v4H6W+ZU9istlHx8xrX7yR6cUvsxOnZrj1iwE8rxEehGRt1Rw
 HG+vG+uhbj7QjXOuGGnNzsAw5IMJRKMCqU1fO3oNh/NyKwpF4cNa8MVb+9kuvMiqGxxrJHSLx
 GsP76kryVa2qQELKaWmdLv6mlyViB6MzMRyv+IPXaMl3/jAynJ9Z2JBoJaaXIny+p3c91VIC8
 dBfXoUknrOO40pQRP8M8SqEeSV2hWj8x0f2HlyDQo0Fnk5TJvkBW7iKbMNA2q4sliVLgYLqtl
 bZhW2SRn6RCgiKE1vm0MLw+wOuyAhCDPPqAjPTemc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Wed, 17 Mar 2021, Alban Gruin wrote:

> diff --git a/merge-strategies.c b/merge-strategies.c
> index 2717af51fd..a51700dae5 100644
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -272,3 +275,95 @@ int merge_all_index(struct index_state *istate, int=
 oneshot, int quiet,
>
>  	return err;
>  }
> +
> +static int fast_forward(struct repository *r, struct tree_desc *t,
> +			int nr, int aggressive)
> +{
> +	struct unpack_trees_options opts;
> +	struct lock_file lock =3D LOCK_INIT;
> +
> +	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
> +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);

Shouldn't we lock the index first, and _then_ refresh it? I guess not,
seeing as we don't do that either in `cmd_status()`: there, we also
refresh the index and _then_ lock it.

> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.head_idx =3D 1;
> +	opts.src_index =3D r->index;
> +	opts.dst_index =3D r->index;
> +	opts.merge =3D 1;
> +	opts.update =3D 1;
> +	opts.aggressive =3D aggressive;
> +
> +	if (nr =3D=3D 1)
> +		opts.fn =3D oneway_merge;
> +	else if (nr =3D=3D 2) {
> +		opts.fn =3D twoway_merge;
> +		opts.initial_checkout =3D is_index_unborn(r->index);
> +	} else if (nr >=3D 3) {
> +		opts.fn =3D threeway_merge;
> +		opts.head_idx =3D nr - 1;
> +	}

Given the function's name `fast_forward()`, I have to admit that I
somewhat stumbled over these merges.
> +
> +	if (unpack_trees(nr, t, &opts))
> +		return -1;
> +
> +	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
> +		return error(_("unable to write new index file"));
> +
> +	return 0;
> +}
> +
> +static int add_tree(struct tree *tree, struct tree_desc *t)
> +{
> +	if (parse_tree(tree))
> +		return -1;
> +
> +	init_tree_desc(t, tree->buffer, tree->size);
> +	return 0;
> +}

This is a really trivial helper, but it is used a couple times below, so
it makes sense to have it encapsulated in a separate function.

> +
> +int merge_strategies_resolve(struct repository *r,
> +			     struct commit_list *bases, const char *head_arg,
> +			     struct commit_list *remote)

Since it is a list, and since the original variable in the shell script
had been named in the plural form, let's do the same here: `remotes`.

> +{
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct object_id head, oid;
> +	struct commit_list *i;
> +	int nr =3D 0;
> +
> +	if (head_arg)
> +		get_oid(head_arg, &head);
> +
> +	puts(_("Trying simple merge."));

Good. Usually I would recommend to print this to `stderr`, but the
original script prints it to `stdout`, so we should do that here, too.

> +
> +	for (i =3D bases; i && i->item; i =3D i->next) {
> +		if (add_tree(repo_get_commit_tree(r, i->item), t + (nr++)))
> +			return 2;

Since we're talking about a library function, not a `cmd_*()` function,
the return value on error should probably be negative.

Even better would be to let the function return an `enum` that contains
labels with more intuitive meaning than "2".

It _is_ the expected exit code when calling `git merge-resolve`, of course
(because of the `|| exit 2` after that `read-tree` call), but I wonder
whether a better layer for that `2` would be the `cmd_merge_resolve()`
function, letting `merge_strategies_resolve()` report failures in a more
fine-grained fashion.

> +	}
> +
> +	if (head_arg) {

It would probably be easier to read if the `if (head_arg)` clause above
was merged into this here clause.

> +		struct tree *tree =3D parse_tree_indirect(&head);
> +		if (add_tree(tree, t + (nr++)))
> +			return 2;
> +	}
> +
> +	if (remote && add_tree(repo_get_commit_tree(r, remote->item), t + (nr+=
+)))
> +		return 2;

You get away with assuming that `remotes` only contains at most a single
entry because `cmd_merge_resolve()` verified it.

However, as the intention is to use this as a library function, I think
the input validation needs to be moved here instead of relying on all
callers to verify that they send at most one "remote" ref.

Other than that, this patch looks good to me.

Thanks,
Dscho

> +
> +	if (fast_forward(r, t, nr, 1))
> +		return 2;
> +
> +	if (write_index_as_tree(&oid, r->index, r->index_file,
> +				WRITE_TREE_SILENT, NULL)) {
> +		int ret;
> +		struct lock_file lock =3D LOCK_INIT;
> +
> +		puts(_("Simple merge failed, trying Automatic merge."));
> +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
> +		ret =3D merge_all_index(r->index, 1, 0, merge_one_file_func, NULL);
> +
> +		write_locked_index(r->index, &lock, COMMIT_LOCK);
> +		return !!ret;
> +	}
> +
> +	return 0;
> +}
> diff --git a/merge-strategies.h b/merge-strategies.h
> index 8705a550ca..bba4bf999c 100644
> --- a/merge-strategies.h
> +++ b/merge-strategies.h
> @@ -1,6 +1,7 @@
>  #ifndef MERGE_STRATEGIES_H
>  #define MERGE_STRATEGIES_H
>
> +#include "commit.h"
>  #include "object.h"
>
>  int merge_three_way(struct index_state *istate,
> @@ -28,4 +29,8 @@ int merge_index_path(struct index_state *istate, int o=
neshot, int quiet,
>  int merge_all_index(struct index_state *istate, int oneshot, int quiet,
>  		    merge_fn fn, void *data);
>
> +int merge_strategies_resolve(struct repository *r,
> +			     struct commit_list *bases, const char *head_arg,
> +			     struct commit_list *remote);
> +
>  #endif /* MERGE_STRATEGIES_H */
> --
> 2.31.0
>
>
