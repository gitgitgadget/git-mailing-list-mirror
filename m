Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B7C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7955F206C3
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpA5CJ47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgFHQby (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbgFHQbw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 12:31:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B4C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 09:31:52 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so10611231lfi.12
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Lhu7xJ6IUmTvt/tqJ6tiHnFsHC5oeuwSQnQD1cldh7o=;
        b=RpA5CJ47vUYvoKPrfdMyTc2oCkRV0OctlJBq30TBZoqrShq5MKMLc9Oyg3Rgpwg/Tn
         B8fnGHjGvVq0ZLWUU7gebdpEgKsT1RqUaE11VXz3MUtIRJuPI3JFZjGJ68228JNl9EQT
         sXbvZsPKSrO8pjjpS/jT6syZ91Bf+Yl5s9X4LyNfhmQNLm7lJHloPVWpE6xUz/DPEqxE
         W77u3JsmHDoVkDEA5EX1UKmMmpFuZgImilkRIA/izl6DLJs1WqN1kkljTuYardWUqabj
         XpHXouWzdA5Ma/Ki7U7Iwv8AUjQnFIeVceltSYLahlkYUGwJg1mXttwJHhEqIb9mNno1
         dXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Lhu7xJ6IUmTvt/tqJ6tiHnFsHC5oeuwSQnQD1cldh7o=;
        b=jSMQgTBJ/dhREG4GBHF25oGPuQ0jldQqsBn3/Oz4WbJpLr5uTCpOi4/1pDKvHYJDU2
         H6fxZj1VmwS6J7zMzLhBlFcAJgf+sZPmbT4iPe2t35gTI+rCMj42hjgtPB0w5C7olWrW
         6HyGvpudMNWYYD4SBu9n7I7RsU71pp8UEYp6gp7+O1MwDyBEz4HXf0FCcjAyRneVV1XA
         ZdVrs8V/FdIkCQsuijWPRao4IfUceUwQ5bcMmSBPdojjtzNvvsBsER1gtUf8qNdsct3G
         qXbhtlnZIXDfYsTaXLITOdhlkvVGN72aK6LDyAPbGkv3zUVO1lbtKaKmswrt8+UT59QD
         ahTw==
X-Gm-Message-State: AOAM530U2XWfvouPvwNhUJ4aLbEk7SKhOW7i9NWSL6VHAIknSpTur5g1
        ZNzGzO4/idgfmHXLvbKOtkI=
X-Google-Smtp-Source: ABdhPJz/hWg9Pg25KjS+dOhTkk1pFk/SG51OSXqtH2ODXC4yHlT/J2R4fUqJdyv8QqKA5H1RiSU77A==
X-Received: by 2002:a05:6512:60f:: with SMTP id b15mr12954746lfe.159.1591633910757;
        Mon, 08 Jun 2020 09:31:50 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id s8sm3813080ljh.101.2020.06.08.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:31:49 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSOC Patch v2 3/4] commit-graph: use generation directly when writing commit-graph
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <20200607193237.699335-1-abhishekkumar8222@gmail.com>
        <20200607193237.699335-4-abhishekkumar8222@gmail.com>
Date:   Mon, 08 Jun 2020 18:31:49 +0200
In-Reply-To: <20200607193237.699335-4-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Mon, 8 Jun 2020 01:02:36 +0530")
Message-ID: <85zh9dsemi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> commit_graph_generation() returns GENERATION_NUMBER_INFINITY if the
> graph position for commit is COMMIT_NOT_FROM_GRAPH.
>
> While this is true when reading from a commit graph, no graph positions
> are associated with a commit when writing a commit graph. Therefore, the
> helper incorrectly returns GENERATION_NUMBER_INFINITY despite having a
> finite generation number.
>
> Let's fix this by using generation number directly when writing a commit
> graph.

I think that to avoid having non-working patch (which can cause problems
when bisecting), it would be a better idea to switch the order of
patches 2 and 3.  This way we won't have incorrect behaviour.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f7cca4def4..0dc79e7c90 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1070,7 +1070,7 @@ static void write_graph_chunk_data(struct hashfile =
*f, int hash_len,
>  		else
>  			packedDate[0] =3D 0;
>=20=20
> -		packedDate[0] |=3D htonl(commit_graph_generation((*list)) << 2);
> +		packedDate[0] |=3D htonl(commit_graph_data_at(*list)->generation << 2);
>

All right.

>  		packedDate[1] =3D htonl((*list)->date);
>  		hashwrite(f, packedDate, 8);
> @@ -1301,9 +1301,11 @@ static void compute_generation_numbers(struct writ=
e_commit_graph_context *ctx)
>  					_("Computing commit graph generation numbers"),
>  					ctx->commits.nr);
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
> +		uint32_t generation =3D commit_graph_data_at(ctx->commits.list[i])->ge=
neration;
> +
>  		display_progress(ctx->progress, i + 1);
> -		if (commit_graph_generation(ctx->commits.list[i]) !=3D GENERATION_NUMB=
ER_INFINITY &&
> -		    commit_graph_generation(ctx->commits.list[i]) !=3D GENERATION_NUMB=
ER_ZERO)
> +		if (generation !=3D GENERATION_NUMBER_INFINITY &&
> +		    generation !=3D GENERATION_NUMBER_ZERO)
>  			continue;
>

All right; this also introduces local variable to avoid accessing the
slab twice^W four times...

>  		commit_list_insert(ctx->commits.list[i], &list);
> @@ -1314,8 +1316,9 @@ static void compute_generation_numbers(struct write=
_commit_graph_context *ctx)
>  			uint32_t max_generation =3D 0;
>=20=20
>  			for (parent =3D current->parents; parent; parent =3D parent->next) {
> -				if (commit_graph_generation(parent->item) =3D=3D GENERATION_NUMBER_I=
NFINITY ||
> -				    commit_graph_generation(parent->item) =3D=3D GENERATION_NUMBER_Z=
ERO) {
> +
> +				if (generation =3D=3D GENERATION_NUMBER_INFINITY ||
> +				    generation =3D=3D GENERATION_NUMBER_ZERO) {
>  					all_parents_computed =3D 0;
>  					commit_list_insert(parent->item, &list);
>  					break;

... which is then used here.

Best,
--=20
Jakub Nar=C4=99bski
