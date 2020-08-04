Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C72C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A3E2076C
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9i4/fZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgHDArA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHDAq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:46:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52239C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:46:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so11822196ljj.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Nkm9AbYWOeboxAuGjIrEGc9C4ShcE/7k027Zxj2wj+M=;
        b=R9i4/fZMicpkOP2eK6eZuKOll9VHyIvWyDtOt/D6TzI3gjxx9C+/9P5q79EhU0RSew
         wpuwNviGCjYqG1+avDfqdfMTu65jOJVdBJ2mVF+ihXoMc5JjxeSnXnWUVqDML0cfej0X
         qLoms0xxOE84rVq29xtJizxUnhvSbD8OseAMucDpb3WzVkS0V+E+O2/gx28+8WBzrGGe
         n0shsl02SEDXmc17MzE0ec06qz3IAUKraZ0Kdph1O33gexdKVcyiQXoCyLKtey1BT5CF
         BtuG1PXTJNBvsAp+wqk7hFQwIFcEhwtja4eUhVV2jtCv1n8Ido1nYAjmdvmBKr6cQvnT
         +pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Nkm9AbYWOeboxAuGjIrEGc9C4ShcE/7k027Zxj2wj+M=;
        b=P/uIsMi59RrtIigjaFxvdLERQNPxtuVtPwFy7o2SC416D0D7Zc4M+Wvrn4UnV/q8bO
         axZ2XNg4bjTHAu0yQRJbo+sqlKUUfZKibIjNlIQD18BwsKFPfyiXtot9RcDu/CdVlCA5
         O6RTtGCuJtv8hrXvZQ/JyHmBTzmSVWQ1+UnDpLLbO/z5D9G2N+9ibAGm7no4Dmu4lwav
         bTxn4N5mWmZA4yUlaPpNnAEwn3RGpDY8wU7EENg87AWZweDS70TO69b8GPUfnE6ZzXDt
         bbJoSWVWaCkAfVZwjFpdw9/Y0nU7hlcbJpxTz1EJtPTvmnvQDb6o+segf6GmOcSBvb2p
         t28A==
X-Gm-Message-State: AOAM533hfrfcogtIziLYqC4/1qtQsdDc3RZh4FFOWVv9SHHcSNtKbbtl
        xcTZXCukhNnDjzofdP04E30=
X-Google-Smtp-Source: ABdhPJzXDKZhEBuU0ZAnAowjNRSxoSfxX8RFXu7k6QOJbNA19xuqED9YS+eIoXhpoZlzlD0gLyQIgw==
X-Received: by 2002:a2e:d19:: with SMTP id 25mr8004501ljn.217.1596502017679;
        Mon, 03 Aug 2020 17:46:57 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id i26sm4672065ljj.102.2020.08.03.17.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:46:56 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/6] commit-graph: fix regression when computing bloom filter
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
Date:   Tue, 04 Aug 2020 02:46:55 +0200
In-Reply-To: <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Tue, 28 Jul 2020 09:13:46
        +0000")
Message-ID: <85eeonutj4.fsf@gmail.com>
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
> With 3d112755 (commit-graph: examine commits by generation number), Git
> knew to sort by generation number before examining the diff when not
> using pack order. c49c82aa (commit: move members graph_pos, generation
> to a slab, 2020-06-17) moved generation number into a slab and
> introduced a helper which returns GENERATION_NUMBER_INFINITY when
> writing the graph. Sorting is no longer useful and essentially reverts
> the earlier commit.
>
> Let's fix this by accessing generation number directly through the slab.

It looks like unfortunate and unforeseen consequence of putting together
graph position and generation number in the commit_graph_data struct.
During writing of the commit-graph file generation number is computed,
but graph position is undefined (yet), and commit_graph_generation()
uses graph_pos field to find if the data for commit is initialized;
in this case wrongly.

Anyway, when writing the commit graph we first compute generation
number, then (if requested) the changed-paths Bloom filter.  Skipping
the unnecessary check is a good thing... assuming that commit_gen_cmp()
is used only when writing the commit graph, and not when traversing it
(because then some commits may not have generation number set, and maybe
even do not have any data on the commit slab) - which is the case.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 1af68c297d..5d3c9bd23c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c

We might want to add function comment either here or in the header that
this comparisonn function is to be used only for `git commit-graph
write`, and not for graph traversal (even if similar funnction exists in
other modules).

> @@ -144,8 +144,9 @@ static int commit_gen_cmp(const void *va, const void =
*vb)
>  	const struct commit *a =3D *(const struct commit **)va;
>  	const struct commit *b =3D *(const struct commit **)vb;
>
> -	uint32_t generation_a =3D commit_graph_generation(a);
> -	uint32_t generation_b =3D commit_graph_generation(b);
> +	uint32_t generation_a =3D commit_graph_data_at(a)->generation;
> +	uint32_t generation_b =3D commit_graph_data_at(b)->generation;
> +
>  	/* lower generation commits first */
>  	if (generation_a < generation_b)
>  		return -1;

Best,
--
Jakub Nar=C4=99bski
