Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C5FC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA82720679
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEkPLgan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRR7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:59:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34974 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRR7o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 12:59:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id n20so87805lfa.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lsuTAjmyPwG+/hXhvD8/U6X1e/nKswE9zZWEwnCiX+0=;
        b=IEkPLgankQDLNwM0qzy/q3I7D38X7yDGTk73PL3pzrtyMuaDdGjdf/tvwNzh+m0AgC
         //fjnNBncHXYfmL1lKllZ7YrkRsi6SlFKrCZ9Blbvz4StLtvDJy0JB/UYrTlpAxQmjJO
         iNz62Fp6y0WXNYmmJAgTQB8BxD2pixn4hAYAyTGZQSCDGrU/uaTELQGt0ALjDB6j3ubv
         RxquoD/RDbH+Lz4WlGL/ry7gc6DfVLX3eiKOiOEI+QwRXItymReJHjqmhuAx5d+fOleq
         cXJc/Mjb0Q44iOb67YKN7ufxPNJ2bTLnUz1OkIrn15NANTghyK4z4eOKctDSlv62QJZd
         eOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=lsuTAjmyPwG+/hXhvD8/U6X1e/nKswE9zZWEwnCiX+0=;
        b=HdkeMCVy8cHjK3PIK6uWCvln3OZaKRzTqAs5q+WHHJkjQQWPI41Ax9kj5KLPpqemX2
         w3mL06iQRc1bKUltsRwwt8kylOZcM/Wlep/t7giB3EdhD7optvRv7RIR8mNd4jxgCAu8
         JVX6vSL3borZ6jQvBT/LbGakSRiNeUls4MG4K6NfkfmQHsm4o91oT7Mbjy4WPEIxeoHU
         EZxc5LKFEdTs3jfjKIzsIvUpGlOF794J+N0CQ9ZTy9TDvh7ZYf7Vnp5Cn94WQLz0BNlw
         2wWwfAA2/m4t0DC2GrT5KcLPb5JVON/zgnAhX8RfPfqnI+6Nv65VmCZAlbMwBLd6FAYf
         HHLw==
X-Gm-Message-State: APjAAAXgTb8rcuC93QaJFEOGBkt8hoqFQCvVtn3+Rhc2x7kWuD8opl8B
        aFdGwD4fGVwXayHXNihEDTg=
X-Google-Smtp-Source: APXvYqzkEIFTCRE8ZqiAmL0h9jjq9AuwX1+Rle1atQZJ4JjxqPO6PFrS5z+HioZKOwD/YkRWaMDDUw==
X-Received: by 2002:a19:c648:: with SMTP id w69mr10822038lff.44.1582048781269;
        Tue, 18 Feb 2020 09:59:41 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id y18sm2814816ljm.93.2020.02.18.09.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 09:59:40 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Garima Singh <garimasigit@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 05/11] commit-graph: examine changed-path objects in pack order
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <78e8e49c3a1131ffacf660603de60729b3dbadc9.1580943390.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 18:59:31 +0100
In-Reply-To: <78e8e49c3a1131ffacf660603de60729b3dbadc9.1580943390.git.gitgitgadget@gmail.com>
        (Jeff King via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:24
        +0000")
Message-ID: <86k14jkc8s.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff King via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Looking at the diff of commit objects in pack order is much faster than
> in sha1 order, as it gives locality to the access of tree deltas

Nitpick: should we still say sha1 order?  Git is still using SHA-1 as an
*oid*, but hopefully soon it will be transitioning to NewHash =3D SHA-256.
(No need to change anything.)

> (whereas sha1 order is effectively random). Unfortunately the
> commit-graph code sorts the commits (several times, sometimes as an oid
> and sometimes a pointer-to-commit), and we ultimately traverse in sha1
> order.

Actually, commit-graph code needs write_commit_graph_context.commits.list
to be in lexicographical order to be able to turn position in graph into
reference to a commit.  The information about the parents of the commit
are stored using positional references within the graph file.

>
> Instead, let's remember the position at which we see each commit, and
> traverse in that order when looking at bloom filters. This drops my time
> for "git commit-graph write --changed-paths" in linux.git from ~4
> minutes to ~1.5 minutes.

Nitpick: with reordering of patches (which I think is otherwise a good
thing) this patch actually comes before the one adding "--changed-paths"
option to "git commit-graph write".  So it 'This would drop my time'
rather than 'This drops my time...' ;-)

>
> Probably the "--reachable" code path would want something similar.

Has anyone tried doing this?

>
> Or alternatively, we could use a different data structure (either a
> hash, or maybe even just a bit in "struct commit") to keep track of
> which oids we've seen, etc instead of sorting. And then we could keep
> the original order.

I think it is nice to keep those "what ifs?" thoughts in the commit
message.  They add some color.

>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  commit-graph.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 724bfcffc4..e125511a1c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -17,6 +17,7 @@
>  #include "replace-object.h"
>  #include "progress.h"
>  #include "bloom.h"
> +#include "commit-slab.h"
>=20=20
>  #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
> @@ -46,6 +47,29 @@
>  /* Remember to update object flag allocation in object.h */
>  #define REACHABLE       (1u<<15)
>=20=20
> +/* Keep track of the order in which commits are added to our list. */
> +define_commit_slab(commit_pos, int);
> +static struct commit_pos commit_pos =3D COMMIT_SLAB_INIT(1, commit_pos);
> +
> +static void set_commit_pos(struct repository *r, const struct object_id =
*oid)
> +{
> +	static int32_t max_pos;
> +	struct commit *commit =3D lookup_commit(r, oid);
> +
> +	if (!commit)
> +		return; /* should never happen, but be lenient */
> +
> +	*commit_pos_at(&commit_pos, commit) =3D max_pos++;
> +}

All right, that is nice and universal function.

> +
> +static int commit_pos_cmp(const void *va, const void *vb)
> +{
> +	const struct commit *a =3D *(const struct commit **)va;
> +	const struct commit *b =3D *(const struct commit **)vb;
> +	return commit_pos_at(&commit_pos, a) -
> +	       commit_pos_at(&commit_pos, b);
> +}

Hmmm... I wonder what would happen in commit_pos was not set (like
e.g. commit-graph commits not coming from the packfile).  Let's look up
the documenation...

commit_pos_at() returns a pointer to an int... why are we comparing
pointers and not values?  Shouldn't it be

  +	return *commit_pos_at(&commit_pos, a) -
  +	       *commit_pos_at(&commit_pos, b);


With commit_pos_at() the location to store the data is allocated as
necessary (if data for commit doesn't exists), and because we are using
xalloc() the *commit_pos_at() is 0-initialized.  This means that if
commits didn't come from the packfile, we sort all commits as being
equal.  Luckily we fix that in next patch.

> +
>  char *get_commit_graph_filename(const char *obj_dir)
>  {
>  	char *filename =3D xstrfmt("%s/info/commit-graph", obj_dir);
> @@ -1027,6 +1051,8 @@ static int add_packed_commits(const struct object_i=
d *oid,
>  	oidcpy(&(ctx->oids.list[ctx->oids.nr]), oid);
>  	ctx->oids.nr++;
>=20=20
> +	set_commit_pos(ctx->r, oid);
> +
>  	return 0;
>  }
>=20=20
> @@ -1147,6 +1173,7 @@ static void compute_bloom_filters(struct write_comm=
it_graph_context *ctx)
>  {
>  	int i;
>  	struct progress *progress =3D NULL;
> +	struct commit **sorted_by_pos;

In the next patch in series we would sort commits by generation number
and creation data; shouldn't this variable name be more generic to
reflect this, for example just `sorted_commits` or `commits_sorted`?

>=20=20
>  	load_bloom_filters();
>=20=20
> @@ -1155,13 +1182,18 @@ static void compute_bloom_filters(struct write_co=
mmit_graph_context *ctx)
>  			_("Computing commit diff Bloom filters"),
>  			ctx->commits.nr);
>=20=20
> +	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
> +	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
> +	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
> +

All right: allocate array, copy data, sort it.

We need to copy data because (what I think) we need commits in
lexicographical order to be able to turn the position in graph that
parents of a commit are stored as into the reference to this commit.

>  	for (i =3D 0; i < ctx->commits.nr; i++) {
> -		struct commit *c =3D ctx->commits.list[i];
> +		struct commit *c =3D sorted_by_pos[i];

All right: use sorted data.

>  		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c);
>  		ctx->total_bloom_filter_data_size +=3D sizeof(uint64_t) * filter->len;
>  		display_progress(progress, i + 1);
>  	}
>=20=20
> +	free(sorted_by_pos);

Can we free the slab data, i.e. call `clear_commit_pos(&commit_pos);`
here?  Otherwise we are leaking memory (well, except that finishing
command makes the operating system to free memory for us).

>  	stop_progress(&progress);
>  }

Best,
--=20
Jakub Nar=C4=99bski
