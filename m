Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD683C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FB661247
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhJAVlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:41:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59403 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhJAVlE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:41:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CDFDC16476F;
        Fri,  1 Oct 2021 17:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Jcs67CXMr5KC
        rSJ102YIO7Ca+42ulHFB+tbySEh0uIU=; b=nfXwNya5oJoUhvrYFZqveUJRMiBQ
        J0hMfI+G6nQnzOW4zjU6f1Cho2Fo4n8IBxp/dC9RGyH8nngzE+ZqQnc/AoExPviL
        eopoW/CiFTy/pfX9rAPDOcO7+oBTspJaK6904CEmW7y2D/6Kb82CWRnCv5n1tk3k
        e0bR6UcncmHx3uM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C666016476D;
        Fri,  1 Oct 2021 17:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5FB3616476C;
        Fri,  1 Oct 2021 17:39:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 6/6] unpack-trees.[ch]: define and use a
 UNPACK_TREES_OPTIONS_INIT
References: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
        <patch-v3-6.6-18358f5d57a-20211001T102056Z-avarab@gmail.com>
Date:   Fri, 01 Oct 2021 14:39:16 -0700
In-Reply-To: <patch-v3-6.6-18358f5d57a-20211001T102056Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 1 Oct
 2021 12:27:36
        +0200")
Message-ID: <xmqqk0iw4e7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 077A653A-2300-11EC-A04B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/archive.c b/archive.c
> index a3bbb091256..210d7235c5a 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -269,7 +269,7 @@ int write_archive_entries(struct archiver_args *arg=
s,
>  		write_archive_entry_fn_t write_entry)
>  {
>  	struct archiver_context context;
> -	struct unpack_trees_options opts;
> +	struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
>  	struct tree_desc t;
>  	int err;
>  	struct strbuf path_in_archive =3D STRBUF_INIT;
> @@ -300,7 +300,6 @@ int write_archive_entries(struct archiver_args *arg=
s,
>  	 * Setup index and instruct attr to read index only
>  	 */
>  	if (!args->worktree_attributes) {
> -		memset(&opts, 0, sizeof(opts));
>  		opts.index_only =3D 1;
>  		opts.head_idx =3D -1;
>  		opts.src_index =3D args->repo->index;

These two hunks almost makes me say "Meh" (I am adding this
parenthetical comment after reading the patch thru and I am not yet
convinced otherwise).

The reason why we had memset(0), getting rid of which I have no
problem about, is because we didn't prepare the members of the
structure using initializer in the first place, no?  The "opts" is
used only in this block, so instead of these lines, we could have

	if (!args->worktree_attributes) {
		struct unpack_trees_options opts =3D {
			.index_only =3D 1,
                        .head_idx =3D -1,
		        ...
			.fn =3D oneway_merge;
		};
		init_tree_desc(...);
		if (unpack_trees(1, &t, &opts))
			...

which would be much easier to understand.  We can get rid of
memset(0), having UNPACK_TREES_OPTIONS_INIT did not help us much.

Some hunks show that we have code between the location where "opts"
is declared and where we know for certain that "opts" needs to be
actually used and with what values in its members, like ...

> diff --git a/builtin/am.c b/builtin/am.c
> index e4a0ff9cd7c..82641ce68ec 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1901,7 +1901,7 @@ static void am_resolve(struct am_state *state)
>  static int fast_forward_to(struct tree *head, struct tree *remote, int=
 reset)
>  {
>  	struct lock_file lock_file =3D LOCK_INIT;
> -	struct unpack_trees_options opts;
> +	struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
>  	struct tree_desc t[2];
> =20
>  	if (parse_tree(head) || parse_tree(remote))
> ...
> =20
>  	refresh_cache(REFRESH_QUIET);
> =20
> -	memset(&opts, 0, sizeof(opts));
>  	opts.head_idx =3D 1;
>  	opts.src_index =3D &the_index;
>  	opts.dst_index =3D &the_index;

... this one.  And it is not necessarily a good idea to initialize
"opts" with the actual values we'd use, and _INIT does help us
getting rid of memset(0);

But many in this patch are much simpler like this one:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 8c69dcdf72a..fea4533dbec 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -639,10 +639,9 @@ static int reset_tree(struct tree *tree, const str=
uct checkout_opts *o,
>  		      int worktree, int *writeout_error,
>  		      struct branch_info *info)
>  {
> -	struct unpack_trees_options opts;
> +	struct unpack_trees_options opts =3D UNPACK_TREES_OPTIONS_INIT;
>  	struct tree_desc tree_desc;
> =20
> -	memset(&opts, 0, sizeof(opts));
>  	opts.head_idx =3D -1;
>  	opts.update =3D worktree;
>  	opts.skip_unmerged =3D !worktree;

which can be initialized with designated initializers in place, and
having an _INIT macro would not help us very much.

> @@ -719,9 +718,8 @@ static int merge_working_tree(const struct checkout=
_opts *opts,
>  	} else {
>  		struct tree_desc trees[2];
>  		struct tree *tree;
> -		struct unpack_trees_options topts;
> +		struct unpack_trees_options topts =3D UNPACK_TREES_OPTIONS_INIT;
> =20
> -		memset(&topts, 0, sizeof(topts));
>  		topts.head_idx =3D -1;
>  		topts.src_index =3D &the_index;
>  		topts.dst_index =3D &the_index;

Likewise here.

So...
