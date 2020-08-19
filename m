Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D120BC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6732067C
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pt2SJ2vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHSRyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgHSRyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:54:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BFEC061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:54:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so26333812ljj.5
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GK9mfMWo43h4xCvgFLfVZZmiWaYgiELLCpgMILGc8pk=;
        b=pt2SJ2vMS0EupdwbmgzFMH0yrKv0NSwdtvMDGMQqkgaqIjS3pTQoX9Gm6IJ9awd6uw
         5R5PVMm5+Rt+wMyHt/54tIcCMUe7IrV4KG4HtMcSMxc6iXsB0TxTrr2/R9TfSvI9BWmX
         6tBHw7rNlsc4eH8jGpo8shX61PSF1vu1+hh/SiWaFYmpWyTXDpcjlzrr+99h0cH/+dAE
         hcLDTpsLhEPvp3XJhqocOyjt4eg4q0Sw/FrJebbhsnyaXTowJyT7Mm7M8iMte//6VO5M
         QCDS6gizYRmjjsWrPKGsKAt+5DWPeWKMJUYWiUbIVibJf40ZUM7ts/g4iMZYvXMaCTaf
         0uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=GK9mfMWo43h4xCvgFLfVZZmiWaYgiELLCpgMILGc8pk=;
        b=ketg+CoZgOLnQSCLDq/f5ig+5W9jrujXpHwFk7tMc7RX8kh1A+CuM8CKgG5/fEyU0e
         oD+ZQ7Gk8abv1Vljsxlw4CysulACOzi5n3Fteq/7b00Xz+cdUuwDlwABwRu+YlqolHyO
         VqRLiqbyy+8YdnWtGeZjtwVsWTBHixXugI09S2zJJmsKQnyFD4jkQUVFqyDfUsb0zTo+
         DKm6QlyVS9miCXrrQKQBCw4GEn3gnZ9lQXh1e0/KLGfDe7Yl1Y6mJymBwz0na1Zaxu5z
         1lTaUkVwzC0XI9IgietnkDHxud0XjiQJrr0Egg6xB4CmXKV+SDDrcDe25PumHIbvdr3M
         UJzg==
X-Gm-Message-State: AOAM5336XLbuvIsosyjE91aad7vLW5Pzt7vH08LpPIVMbPZcbIgCPS8W
        tZH2DY1+9v2vRDSKkjx5iiU=
X-Google-Smtp-Source: ABdhPJwWK7lx2Jr9lQaDDg7OXYyMMPhRfv1ckR0QmP7iIbFs+2ZREuyfYN7kLrY2sm7Ox/r5/IPQig==
X-Received: by 2002:a2e:8957:: with SMTP id b23mr11982960ljk.331.1597859661260;
        Wed, 19 Aug 2020 10:54:21 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r19sm7349417lfi.58.2020.08.19.10.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:54:20 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 03/11] commit-graph: consolidate fill_commit_graph_info
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <18d5864f81e89585cc94cd12eca166a9d8b929a5.1597509583.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 19:54:20 +0200
In-Reply-To: <18d5864f81e89585cc94cd12eca166a9d8b929a5.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:35
        +0000")
Message-ID: <857dtuo71v.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
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
> Both fill_commit_graph_info() and fill_commit_in_graph() parse
> information present in commit data chunk. Let's simplify the
> implementation by calling fill_commit_graph_info() within
> fill_commit_in_graph().
>
> The test 'generate tar with future mtime' creates a commit with commit
> time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
> generation number (within CDAT chunk) and has undefined behavior.
>
> The test used to pass

Could you please tell us how does this test starts to fail without the
change to the test described there?  What is the error message, etc.?

>                       as fill_commit_in_graph() guarantees the values of
                           ^^^^^^^^^^^^^^^^^^^^^^

s/fill_commit_in_graph()/fill_commit_graph_info()/

It is fill_commit_graph_info() that changes its behavior in this patch.

> graph position and generation number, and did not load timestamp.
> However, with corrected commit date we will need load the timestamp as
> well to populate the generation number.
>
> Let's fix the test by setting a timestamp of (2 ^ 34 - 1) seconds.

I think this commit should be split into two commits:
- fix to the 'generate tar with future mtime' test
- simplify implementation of fill_commit_in_graph()

The test 'generate tar with future mtime' in t/t5000-tar-tree.sh creates
a commit with commit time of (2 ^ 36 - 1) seconds since EPOCH
(68719476737). However, the commit-graph file format version 1 provides
only 34-bits for storing committer date (32 + 2 bits), not 64-bits.
Therefore maximum far in the future commit time can only be at most
(2 ^ 34 - 1) seconds since EPOCH, as Stolee said in commet for v1
of this series.

This "limitation" is not a problem in practice, because the maximum
timestamp allowed takes place in the year 2514. I hope at that time
there would be no Git version in use that still crashes on changing the
version field in the commit-graph format -- then we can simply get rid
of storing topological levels (generation number v1) in those 30 bits of
CDAT chunk and use full 64 bits for committer date.

Git does not perform any bounds checking for committer date value in
write_graph_chunk_data():

	uint32_t packedDate[2];

	/* ... */

	if (sizeof((*list)->date) > 4)
		packedDate[0] =3D htonl(((*list)->date >> 32) & 0x3);
	else
		packedDate[0] =3D 0;

	packedDate[0] |=3D htonl(commit_graph_data_at(*list)->generation << 2);

	packedDate[1] =3D htonl((*list)->date);
	hashwrite(f, packedDate, 8);

This means that the date is trimmed to 34 bits on save discarding most
significant bits, assuming that unsigned overflow simply discards most
significant bits truncating the signed (?) value.

In this case running the test with GIT_TEST_COMMIT_GRAPH=3D1 would lead to
errors, as the committer date read from the commit graph would be
incorrect, and therefore generation number v2 would also be incorrect.


I don't quite understand however how second part of this patch in its
current iteration, namely simplifing the implementation of
fill_commit_in_graph() makes this bug / error shows...

Do I understand it correctly that before this change the committer date
would always be parsed out of the commit object, instead of reading it
from the commit-graph file?  However the only user of static
fill_commit_in_graph() is the parse_commit_in_graph(), which in turn is
used by parse_commit_gently(); but fill_commit_in_graph() read commit
date from commit-graph before this change... color me confused.

Ah, after the change fill_commit_graph_info() changes its behavior, not
fill_commit_in_graph() as said in the commit message. Before this commit
it used to only load graph position and generation number, and did not
load the timestamp. The function fill_commit_graph_info() is used in
turn by public-facing load_commit_graph_info():

  /*
   * It is possible that we loaded commit contents from the commit buffer,
   * but we also want to ensure the commit-graph content is correctly
   * checked and filled. Fill the graph_pos and generation members of
   * the given commit.
   */
  void load_commit_graph_info(struct repository *r, struct commit *item);

This function is used in turn by get_bloom_filter(), contains_tag_algo()
and parse_commit_buffer(), change in any of which behavior can lead to
failing 'generate tar with future mtime' test.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c      | 29 +++++++++++------------------
>  t/t5000-tar-tree.sh |  4 ++--
>  2 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index ace7400a1a..af8d9cc45e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -725,15 +725,24 @@ static void fill_commit_graph_info(struct commit *i=
tem, struct commit_graph *g,
>  	const unsigned char *commit_data;
>  	struct commit_graph_data *graph_data;
>  	uint32_t lex_index;
> +	uint64_t date_high, date_low;
>
>  	while (pos < g->num_commits_in_base)
>  		g =3D g->base_graph;
>
> +	if (pos >=3D g->num_commits + g->num_commits_in_base)
> +		die(_("invalid commit position. commit-graph is likely corrupt"));
> +

All right, if we want to use fill_commit_graph_info() function to load
the graph data (graph position and generation number) in the
fill_commit_in_graph() we need to perform this check.

I'd think that this check should be here from the beginning, just in
case.


Sidenote: I wonder if it would be good idea to print more information in
the above error message, for example:

	die(_("invalid commit position %ld. commit-graph '%s' is likely corrupt"),
        pos, g->filename);

But this is unrelated thing, tangential to this change, and it might not
add anything useful.

>  	lex_index =3D pos - g->num_commits_in_base;
>  	commit_data =3D g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
>
>  	graph_data =3D commit_graph_data_at(item);
>  	graph_data->graph_pos =3D pos;
> +
> +	date_high =3D get_be32(commit_data + g->hash_len + 8) & 0x3;
> +	date_low =3D get_be32(commit_data + g->hash_len + 12);
> +	item->date =3D (timestamp_t)((date_high << 32) | date_low);
> +

I think this change, moving loading of commit date from commit-graph out
of fill_commit_in_graph() and into fill_commit_graph_info(), is in my
opinion a bit inadequatly described in the commit message. As I
understand it this change prepares fill_commit_graph_info() for
generation number v2, that is Corrected Commit Date, where loading
commit date from CDAT together with loading offset from GDAT would be
necessary to correctly set the 'generation' field of 'struct
commit_graph_data' (on the commit_graph_data_slab).

I'm not sure if it would be worth it splitting this refactoring change
(Move Statements into Function) into a separate patch -- it would split
this commit into three, changing 11 part series into 13 part series.


Note that we might want to update the description of
load_commit_graph_info() in commit-graph.h to include that it
incidentally loads commit date from the commit-graph.  Butthis might be
not worth it -- it is a side effect, not the major goal of this
function.

>  	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
>  }
>
> @@ -748,38 +757,22 @@ static int fill_commit_in_graph(struct repository *=
r,
>  {
>  	uint32_t edge_value;
>  	uint32_t *parent_data_ptr;
> -	uint64_t date_low, date_high;
>  	struct commit_list **pptr;
> -	struct commit_graph_data *graph_data;
>  	const unsigned char *commit_data;
>  	uint32_t lex_index;
>
>  	while (pos < g->num_commits_in_base)
>  		g =3D g->base_graph;
>
> -	if (pos >=3D g->num_commits + g->num_commits_in_base)
> -		die(_("invalid commit position. commit-graph is likely corrupt"));
> +	fill_commit_graph_info(item, g, pos);

All right, the check got moved into fill_commit_graph_info().

>
> -	/*
> -	 * Store the "full" position, but then use the
> -	 * "local" position for the rest of the calculation.
> -	 */
> -	graph_data =3D commit_graph_data_at(item);
> -	graph_data->graph_pos =3D pos;

All right, 'graph_pos' field in the graph data (on commit slab) got
filled by just called load_commit_graph_info().

>  	lex_index =3D pos - g->num_commits_in_base;
> -
> -	commit_data =3D g->chunk_commit_data + (g->hash_len + 16) * lex_index;
> +	commit_data =3D g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;

All right, unrelated cleanup in the neighbourhood.

>
>  	item->object.parsed =3D 1;
>
>  	set_commit_tree(item, NULL);
>
> -	date_high =3D get_be32(commit_data + g->hash_len + 8) & 0x3;
> -	date_low =3D get_be32(commit_data + g->hash_len + 12);
> -	item->date =3D (timestamp_t)((date_high << 32) | date_low);
> -

All right, this code got moved down the call chain into just called
load_commit_graph_info().

> -	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
> -


All right, 'generation' field in the graph data (on commit slab) got
filled by load_commit_graph_info() called at the beginning of the
function.



>  	pptr =3D &item->parents;
>
>  	edge_value =3D get_be32(commit_data + g->hash_len);
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 37655a237c..1986354fc3 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -406,7 +406,7 @@ test_expect_success TIME_IS_64BIT 'set up repository =
with far-future commit' '
>  	rm -f .git/index &&
>  	echo content >file &&
>  	git add file &&
> -	GIT_COMMITTER_DATE=3D"@68719476737 +0000" \
> +	GIT_COMMITTER_DATE=3D"@17179869183 +0000" \
>  		git commit -m "tempori parendum"
>  '
>
> @@ -415,7 +415,7 @@ test_expect_success TIME_IS_64BIT 'generate tar with =
future mtime' '
>  '
>
>  test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar c=
an read our future mtime' '
> -	echo 4147 >expect &&
> +	echo 2514 >expect &&
>  	tar_info future.tar | cut -d" " -f2 >actual &&
>  	test_cmp expect actual
>  '

Looks good to me.

Best,
--=20
Jakub Nar=C4=99bski
