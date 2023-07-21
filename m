Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D7C04A94
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 14:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjGUOme (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGUOma (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 10:42:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D3030C4
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 07:42:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E359B197AC5;
        Fri, 21 Jul 2023 10:42:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pGouT4hNIlue
        GOtqgKuab4TSpCncZ/Oq5kR4DUy+OH8=; b=lhurHL4xj/4H1uVHRQWMcK0C6gDj
        tmIXA3oGrPNL6WtiWK0P1CmtTyy71bnJjTe4ME1SDcBPj+HkMsLiizix8CxdehCK
        BH6iudzRJ6dYYapq8stkho0rZwmsj46ciAI/0mIdrVrx5T+gw2h7Km/mVB/Ob0kU
        yJkwt/tpZecARVY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D54D1197AC4;
        Fri, 21 Jul 2023 10:42:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35FB3197AC2;
        Fri, 21 Jul 2023 10:42:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] show-branch: fix --no-sparse
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <3f590f19-11a2-36d7-2520-1d1625ca1a25@web.de>
Date:   Fri, 21 Jul 2023 07:42:26 -0700
In-Reply-To: <3f590f19-11a2-36d7-2520-1d1625ca1a25@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 21 Jul 2023 14:41:43 +0200")
Message-ID: <xmqqwmytxr59.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D010236A-27D4-11EE-84F9-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Since 57343652a5 (show-branch: migrate to parse-options API, 2009-05-21=
)
> git show-branch has accepted the option --no-sparse, but it does the
> same as --sparse.  That's because it's defined using OPT_SET_INT with a
> value of 0, which sets 0 when negated, too.

Hmph, am I expected to compare these patches with what I sent a few
days ago and pick whichever are the better ones?  Can I delegate
that task to somebody else ;-)?

        jc/am-parseopt-fix		<xmqqr0p5gjv3.fsf@gitster.g>
        jc/branch-parseopt-fix		<xmqqjzuxgjmi.fsf@gitster.g>
        jc/describe-parseopt-fix	<xmqqy1jcgbiv.fsf@gitster.g>
        jc/parse-options-reset		<xmqq1qh4c998.fsf@gitster.g>
        jc/parse-options-short-help	<xmqq5y6gg8fn.fsf@gitster.g>
        jc/parse-options-show-branch	<xmqqh6pzc15n.fsf@gitster.g>
        jc/transport-parseopt-fix	<xmqqedl4gag8.fsf@gitster.g>

Some of them are already in 'next' as they were so trivial.

Thanks.

> Turn --no-sparse into the opposite of --sparse by using OPT_BOOL and
> storing the option's status directly in a variable named "sparse"
> instead of in negative form in "dense".
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/show-branch.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index a86b3c7677..99b3f4a09a 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -649,7 +649,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
>  	int with_current_branch =3D 0;
>  	int head_at =3D -1;
>  	int topics =3D 0;
> -	int dense =3D 1;
> +	int sparse =3D 0;
>  	const char *reflog_base =3D NULL;
>  	struct option builtin_show_branch_options[] =3D {
>  		OPT_BOOL('a', "all", &all_heads,
> @@ -676,8 +676,8 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
>  			    REV_SORT_IN_GRAPH_ORDER),
>  		OPT_BOOL(0, "topics", &topics,
>  			 N_("show only commits not on the first branch")),
> -		OPT_SET_INT(0, "sparse", &dense,
> -			    N_("show merges reachable from only one tip"), 0),
> +		OPT_BOOL(0, "sparse", &sparse,
> +			 N_("show merges reachable from only one tip")),
>  		OPT_SET_INT(0, "date-order", &sort_order,
>  			    N_("topologically sort, maintaining date order "
>  			       "where possible"),
> @@ -940,7 +940,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
>  			    !is_merge_point &&
>  			    (this_flag & (1u << REV_SHIFT)))
>  				continue;
> -			if (dense && is_merge &&
> +			if (!sparse && is_merge &&
>  			    omit_in_dense(commit, rev, num_rev))
>  				continue;
>  			for (i =3D 0; i < num_rev; i++) {
> --
> 2.41.0
