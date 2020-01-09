Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEDCC282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89032067D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 19:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JobJB4pV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbgAITMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:12:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35471 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388728AbgAITMU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 14:12:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so8455393lja.2
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 11:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4GFDB2XJ8BgW0509NLWOTt7ASwwebQ8yXPTNcKF/Nvk=;
        b=JobJB4pVzGNZHWbtKl5GeVD4lih4E5syBPd2QSMd5+tMDok4P5oghXQ+LzaxvCEuDk
         dsGssbo7oE5W34JLg3V32P3lTSpKxv5LsrFybFFsQztJ0pKCTBCCCa6JZX+mseOD6by3
         WNjRgV/g3rYcdiOcs288Jt0nJrVseConvjP3HiZ4OVTvC9/pI8+cyGHr92Tcb33rNVyp
         IQNgAuxxs35439RlPBwRr+/N/Mi14kTcpcSbaPCbExpL40mCz5eOFKwOsbLf+pEzETiY
         1d3asO5baw1x7+jYn9jJHpOg1k/soAOGydbkpou5f5jkITbYhDSAuFGIHRF45HsdXvl4
         31aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=4GFDB2XJ8BgW0509NLWOTt7ASwwebQ8yXPTNcKF/Nvk=;
        b=PtbT1c9eGu7D9IWU81fovg+8DD2354iVjiJzYntPABOnaa/P8w9Xj8XhyTPsCmECic
         QMXz9zfM69TI+Y7v9LypQcbCg0WqPWo45mfhd7A4A9KvHSpM5xWyyLa493YuW+wBOur/
         Z+qW/MMhef2vovHFSFbT4H5uHtp0KGyWsF+vKgeQbQPO//CZnjvilNfuVHh/PNug9sqh
         WODpa53NCpcNRW0HKtchyEPiliZ9hIGdUJkrfNfqplPtEBD1d/3Vj0DC74uMWXpH/BlH
         GV/RO0qwTxQTFhMg6NdIbA0MnJFko8FDamhNySi7Lg4b5mtBMmBckFH86wIck7m2gTv/
         i5qg==
X-Gm-Message-State: APjAAAVdK5xMT17R+yJK+d+J5c/9d47Ani29gVCupsD40bhMji6+lVXq
        cR0A+dpGrqCAkAmMrb38iis=
X-Google-Smtp-Source: APXvYqzewVmVOBpvH9m71Zo+3/oh16eDCk+HolFJiDOCxf96HJDscNjEuPdTVfPDTE3o1RYNnYx2BA==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr7775592ljo.86.1578597137840;
        Thu, 09 Jan 2020 11:12:17 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id n30sm3988566lfi.54.2020.01.09.11.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 11:12:17 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 7/9] commit-graph: reuse existing bloom filters during write.
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <1e2acb37ad710cb0d1c09ed163fdd4473a27335c.1576879520.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 20:12:07 +0100
In-Reply-To: <1e2acb37ad710cb0d1c09ed163fdd4473a27335c.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:18
        +0000")
Message-ID: <86r208v3zs.fsf@gmail.com>
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
Overly long lines in the commit message.

> Read previously computed bloom filters from the commit-graph file if poss=
ible
> to avoid recomputing during commit-graph write.

Hmmm.  This fixes (somewhat) the problem that I have noticed in previous
patch that the Bloom filter was computed at least twice, once for BIDX
chunk, once fo BDAT chunk.

I think the order should be:
 - use Bloom filter on slab, if present
 - fill it from commit graph, if saved there
 - if needed, compute it from scratch (expensive operation!)

If I understand it correctly, it now does it... though possibly with
unnecessary memory allocation if commit-graph file does not include
Bloomm filters data, and (re)computing is not requested (see later).

But I might be wrong here.

>
> Reading from the commit-graph is based on the format in which bloom filte=
rs are
> written in the commit graph file. See method `fill_filter_from_graph` in =
bloom.c

This description reads a bit strange; it looks like it states a truism
(we read in the format we wrote).  It think it should be rephrased in
different way for better readability.

>
> For reading the bloom filter for commit at lexicographic position i:

I think it would better read as:

  To read Bloom filter for a given commit with lexicographic position
  'i' we need to:

> 1. Read BIDX[i] which essentially gives us the starting index in BDAT for=
 filter
>    of commit i+1 (called the next_index in the code)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                    |
                    \- I think would be not needed with better var name

I would also add that it gives the position [one past] the end of Bloom
filter data for i-th commit.

>
> 2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT =
for
>    filter of commit i (called the prev_index in the code)

Minor nitpick: Full stops are missing.

Why it is called prev_index and next_index, while it is either
curr_index and next_index or prev_index and curr_index, or maybe even
better beg_index and end_index?

>    For i =3D 0, prev_index will be 0. The first lexicographic commit's fi=
lter will
>    start at BDAT.

I would state it

     For first commit, with i =3D 0, Bloom filter data starts at the
     beginning, just past the header in BDAT chunk.

>
> 3. The length of the filter will be next_index - prev_index, because BIDX=
[i]
>    gives the cumulative 8-byte words including the ith commit's filter.
>
> We toggle whether bloom filters should be recomputed based on the compute=
_if_null
> flag.

All right.
>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  bloom.c        | 40 ++++++++++++++++++++++++++++++++++++++--
>  bloom.h        |  3 ++-
>  commit-graph.c |  6 +++---
>  3 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/bloom.c b/bloom.c
> index 08328cc381..86b1005802 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -1,5 +1,7 @@
>  #include "git-compat-util.h"
>  #include "bloom.h"
> +#include "commit.h"
> +#include "commit-slab.h"
>  #include "commit-graph.h"
>  #include "object-store.h"
>  #include "diff.h"
> @@ -119,13 +121,35 @@ static void add_key_to_filter(struct bloom_key *key,
>  	}
>  }
>=20=20
> +static void fill_filter_from_graph(struct commit_graph *g,
> +				   struct bloom_filter *filter,
> +				   struct commit *c)
> +{
> +	uint32_t lex_pos, prev_index, next_index;
> +

> +	while (c->graph_pos < g->num_commits_in_base)
> +		g =3D g->base_graph;
> +
> +	lex_pos =3D c->graph_pos - g->num_commits_in_base;

This part shares common code with load_oid_from_graph(), only without
some of error checking; perhaps it might be good to extract it into a
separate helper function, e.g. `lex_index(&g, c->graph_pos)`.

Minor nitpick about the consistency of function names: why
load_oid_from_graph(), but fill_filter_from_graph(), and not
load_filter_from_graph() / load_bloom_from_graph()?

> +
> +	next_index =3D get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
> +	if (lex_pos)

I think using

  +	if (lex_pos > 0)

or

  +	if (lex_pos >=3D 0)

might be easier to reason about.

> +		prev_index =3D get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
> +	else
> +		prev_index =3D 0;
> +
> +	filter->len =3D next_index - prev_index;

The above command reads a bit strange: next - prev?  not  next - curr,
or curr - prev?  Wouldn't it be better to name it begin_index and
end_index, or beg_index and end_index for brevity?

> +	filter->data =3D (uint64_t *)(g->chunk_bloom_data + 8 * prev_index + 12=
);

Please do not use magic constants; use instead something like:

  +	filter->data =3D (uint64_t *)(g->chunk_bloom_data +
  +				    sizeof(uint64_t) * prev_index +
  +				    BLOOMDATA_CHUNK_HEADER_SIZE);

Perhaps using `3*sizeof(unit32_t)` instead of magic value 12 would be
enough; but having symbolic name for BDAT chunk header size is better, I
think.

> +}
> +
>  void load_bloom_filters(void)
>  {
>  	init_bloom_filter_slab(&bloom_filters);
>  }
>=20=20
>  struct bloom_filter *get_bloom_filter(struct repository *r,
> -				      struct commit *c)
> +				      struct commit *c,
> +				      int compute_if_null)

I'm not sure about `compute_if_null` name...

>  {
>  	struct bloom_filter *filter;
>  	struct bloom_filter_settings settings =3D DEFAULT_BLOOM_FILTER_SETTINGS;
> @@ -134,6 +158,18 @@ struct bloom_filter *get_bloom_filter(struct reposit=
ory *r,
>  	const char *revs_argv[] =3D {NULL, "HEAD", NULL};
>=20=20
>  	filter =3D bloom_filter_slab_at(&bloom_filters, c);

Note that the documentation for `slab_at(slab, commit)` is documented in
`commit-slab.h` as

 *   This function locates the data associated with the given commit in
 *   the indegree slab, and returns the pointer to it.  The location to
 *   store the data is allocated as necessary.
                       ~~~~~~~~~~~~~~~~~~~~~~

Should we worry about this possibly unnecessary allocation (if there is
no Bloom filter chunk in the commit-graph, and we are not recomputing
it)?

There is `slab_peek(slab_commit)` with the following properties:

 *   This function is similar to indegree_at(), but it will return NULL
 *   until a call to indegree_at() was made for the commit.

> +
> +	if (!filter->data) {

What does the Bloom filter for a commit with no changes looks like?
What about for a commit with more than 512 changes?  Do, in either of
those cases, filter->len is 0?  If yes, what about filter->data?

> +		load_commit_graph_info(r, c);
> +		if (c->graph_pos !=3D COMMIT_NOT_FROM_GRAPH && r->objects->commit_grap=
h->chunk_bloom_indexes) {

Please wrap overly long lines (109 characters seems too long; the
CodingGuidelines states:

 - We try to keep to at most 80 characters per line.

  +		if (c->graph_pos !=3D COMMIT_NOT_FROM_GRAPH &&
  +		    r->objects->commit_graph->chunk_bloom_indexes) {

You seem to assume here that in the chain of commit-graph files either
all of them would have Bloom filters, or all of them would be missing
Bloom filters.  Isn't it however possible for only some of the
commit-graph files in chain to include Bloom filter data chunks?

In such case, the top commit-graph file may have BIDX chunk
(bloom_indexes), but the commit-graph with the commit 'c' might not have
it.  Or the top commit-graph file may be missing BIDX chunk, so Git
would recompute it even if the commit-graph file for commit 'c' includes
it.

If such situation is forbidden, how the restriction is managed?

Note: in any case, this needs to be tested!

> +			fill_filter_from_graph(r->objects->commit_graph, filter, c);
> +			return filter;
> +		}
> +	}

All right, if it is not in slab, we try to read if from the commit
graph.  Looks all right.

> +
> +	if (filter->data || !compute_if_null)
> +			return filter;
                ^^^^^^^^
                 |
                 \- one tab too many

If we have found existing filter (on slab or in the commit-graph), or if
we won't be recomputing it, return it.  O.K.

> +
>  	init_revisions(&revs, NULL);
>  	revs.diffopt.flags.recursive =3D 1;
>=20=20
> @@ -198,4 +234,4 @@ struct bloom_filter *get_bloom_filter(struct reposito=
ry *r,
>  	DIFF_QUEUE_CLEAR(&diff_queued_diff);
>=20=20
>  	return filter;
> -}
> \ No newline at end of file
> +}

Accidental change.

> diff --git a/bloom.h b/bloom.h
> index ba8ae70b67..101d689bbd 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -36,7 +36,8 @@ struct bloom_key {
>  void load_bloom_filters(void);
>=20=20
>  struct bloom_filter *get_bloom_filter(struct repository *r,
> -				      struct commit *c);
> +				      struct commit *c,
> +				      int compute_if_null);
>

All right, this is just update of the function signature.

>  void fill_bloom_key(const char *data,
>  		    int len,
> diff --git a/commit-graph.c b/commit-graph.c
> index def2ade166..0580ce75d5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1032,7 +1032,7 @@ static void write_graph_chunk_bloom_indexes(struct =
hashfile *f,
>  	uint32_t cur_pos =3D 0;
>=20=20
>  	while (list < last) {
> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list, 0);
>  		cur_pos +=3D filter->len;
>  		hashwrite_be32(f, cur_pos);
>  		list++;
> @@ -1051,7 +1051,7 @@ static void write_graph_chunk_bloom_data(struct has=
hfile *f,
>  	hashwrite_be32(f, settings->bits_per_entry);
>=20=20
>  	while (first < last) {
> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *first);
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *first, 0);
>  		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
>  		first++;
>  	}

O.K., so those two do not compute Bloom filters, but they are called
from write_commit_graph_file(), which in turn is called in
write_commit_graph() *after* running compute_bloom_filters().

Looks good to me, then.

> @@ -1218,7 +1218,7 @@ static void compute_bloom_filters(struct write_comm=
it_graph_context *ctx)
>=20=20
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>  		struct commit *c =3D ctx->commits.list[i];
> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c);
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c, 1);
>  		ctx->total_bloom_filter_size +=3D sizeof(uint64_t) * filter->len;
>  		display_progress(progress, i + 1);
>  	}

All right, so compute_bloom_filters() ensures that it is actually
computed (if needed).

Looks good to me.

Regards,
--=20
Jakub Nar=C4=99bski
