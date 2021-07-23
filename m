Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D6C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FBB60EB6
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhGWVPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:15:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54252 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhGWVPn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 17:15:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2A561570B5;
        Fri, 23 Jul 2021 17:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PSypOC54J5lC
        fg/YKEL5Wf5dOxAwkCwiYdWuBbN8qSU=; b=LUN66zcKHaTeyrEewdf2HOLdYrhU
        YaEXYYSmKGayC8MmeyJ6dF1RDGLWnqE8/6FFMBR1OlFpcrv/c0b9+dzYYuzPqxsd
        WOg52LfQvZ8BVwFy2e+4IZQ5MpyLoS5w8+xIKQc5epXTVwXHZHs5Uk5PYhJ6NEE8
        6VAN+6DQ11GW+MY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB3031570B4;
        Fri, 23 Jul 2021 17:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2E211570B0;
        Fri, 23 Jul 2021 17:56:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/3] midx: don't provide a total for QSORT() progress
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
        <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
        <patch-2.3-3411fe0515-20210722T121801Z-avarab@gmail.com>
Date:   Fri, 23 Jul 2021 14:56:10 -0700
In-Reply-To: <patch-2.3-3411fe0515-20210722T121801Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 14:20:16 +0200")
Message-ID: <xmqqfsw4lmo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB279F34-EC00-11EB-ABD0-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The quicksort algorithm can be anywhere between O(n) and O(n^2), so
> providing a "num objects" as a total means that in some cases we're
> going to go past 100%.
>
> This fixes a logic error in 5ae18df9d8e (midx: during verify group
> objects by packfile to speed verification, 2019-03-21), which in turn
> seems to have been diligently copied from my own logic error in the
> commit-graph.c code, see 890226ccb57 (commit-graph write: add
> itermediate progress, 2019-01-19).

Interesting.

>
> That commit-graph code of mine was removed in
> 1cbdbf3bef7 (commit-graph: drop count_distinct_commits() function,
> 2020-12-07), so we don't need to fix that too.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  midx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index 9a35b0255d..eaae75ab19 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1291,7 +1291,7 @@ int verify_midx_file(struct repository *r, const =
char *object_dir, unsigned flag
> =20
>  	if (flags & MIDX_PROGRESS)
>  		progress =3D start_sparse_progress(_("Sorting objects by packfile"),
> -						 m->num_objects);
> +						 0);
>  	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
>  	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
>  	stop_progress(&progress);
