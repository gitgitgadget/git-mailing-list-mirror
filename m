Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC82C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C9860E09
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhHBM62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhHBM61 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 08:58:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A5C0613D5
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 05:58:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hw6so16843301ejc.10
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=opFw02COXnigJkAV5eAlBY19aT8H4q7E3sY8nsELu5o=;
        b=r1HGEqB8oPpjcEPEsrM0la1Q3SiDDzK1vQfFw+3656NyC4bZcv/1bCCkrAxXEP4+yc
         vbcjH3QwHRi7yALPT9jn4abpcqvY8LDzF5xzQzaMNiKGXSBcOsKdpEPizzBwFR5SG6dN
         ttqaFbaD1RuE5YYyxm1qtNTDzQSSIhY4N8i5PT+cSZ4jvOfB7VfIdyYjpIrvxFQYtdt/
         kOobDMkBG/EAgm+SvMmhCLzVx0XuSN1hVYkrB+2NZrYh/WeXx9NN5CkqEGVNbvVp40Dy
         PAg0yVj66/rg4290zVnv2RSRpcY0Xo+/RZKjHgzpUq8i53sQdeFXKUK3xm1X68NN3c9Y
         w0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=opFw02COXnigJkAV5eAlBY19aT8H4q7E3sY8nsELu5o=;
        b=MgUlwtBOsUwhimOdON5hbKV+ADM/PHbx0+LQ1NQ+jrwHMc3wdQ90vLq5GAqXU/Rb9r
         PtJ+YdZziJVNBuKaPrKgJfZMy4P3zfu4NjEMY0eDX8ChYd/7auiWxDOAXLGhblPR8OBT
         75y7xiObzx3b0S6chlrkIGjjBEo/n+gz0IParA1Y7ha1fWio/qnZdSWyNqoHusbDdBnR
         nODKhqrCrR/fGr0ivRaE4apuVEBxo7/Gdumo1hEJSan/4xPfnSi4CSE1yRlmujuyJkzR
         0P2FqRo9243GuqPU0PRUWfTr/4+xxPSd6nkZcLLP6RxADRgD5zWmgZU6th1O9i+vBn/d
         J8EQ==
X-Gm-Message-State: AOAM53116FBhYOKvb3cLBedCFXelThK7P4H1wyHrdpfJ9wznOgEfNdm5
        wxpOAEJMOCFgbR8kUoUdBxA=
X-Google-Smtp-Source: ABdhPJykuDKjRTtNpqoCTAR2EkTkdfWPr+Dw5A2Zzwl1k9WbWuY2KKfeyJAfe7m95NkvWsM2TBA2Wg==
X-Received: by 2002:a17:906:4ad9:: with SMTP id u25mr15296353ejt.106.1627909096825;
        Mon, 02 Aug 2021 05:58:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u4sm4548317eje.81.2021.08.02.05.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 05:58:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/4] revision: avoid loading object headers multiple
 times
Date:   Mon, 02 Aug 2021 14:55:09 +0200
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <b9897e102afbcab3bfee58ed8bda24257d8b54fb.1627896460.git.ps@pks.im>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <b9897e102afbcab3bfee58ed8bda24257d8b54fb.1627896460.git.ps@pks.im>
Message-ID: <87v94onguw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> When loading references, we try to optimize loading of commits by using
> the commit graph. To do so, we first need to determine whether the
> object actually is a commit or not, which is why we always execute
> `oid_object_info()` first. Like this, we'll unpack the object header of
> each object first.
>
> This pattern can be quite inefficient in case many references point to
> the same commit: if the object didn't end up in the cached objects, then
> we'll repeatedly unpack the same object header, even if we've already
> seen the object before.
>
> Optimize this pattern by using `lookup_unknown_object()` first in order
> to determine whether we've seen the object before. If so, then we don't
> need to re-parse the header but can directly use its object information
> and thus gain a modest performance improvement. Executed in a real-world
> repository with around 2.2 million references:
>
>     Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --no=
t --all --not $newrev
>       Time (mean =C2=B1 =CF=83):      4.771 s =C2=B1  0.238 s    [User: 4=
.440 s, System: 0.330 s]
>       Range (min =E2=80=A6 max):    4.539 s =E2=80=A6  5.219 s    10 runs
>
>     Benchmark #2: HEAD: rev-list --unsorted-input --objects --quiet --not=
 --all --not $newrev
>       Time (mean =C2=B1 =CF=83):      4.454 s =C2=B1  0.037 s    [User: 4=
.122 s, System: 0.332 s]
>       Range (min =E2=80=A6 max):    4.375 s =E2=80=A6  4.496 s    10 runs
>
>     Summary
>       'HEAD: rev-list --unsorted-input --objects --quiet --not --all --no=
t $newrev' ran
>         1.07 =C2=B1 0.05 times faster than 'HEAD~: rev-list --unsorted-in=
put --objects --quiet --not --all --not $newrev'
>
> The downside is that `lookup_unknown_object()` is forced to always
> allocate an object such that it's big enough to host all object types'
> structs and thus we may waste memory here. This tradeoff is probably
> worth it though considering the following struct sizes:
>
>     - commit: 72 bytes
>     - tree: 56 bytes
>     - blob: 40 bytes
>     - tag: 64 bytes
>
> Assuming that in almost all repositories, most references will point to
> either a tag or a commit, we'd have a modest increase in memory
> consumption of about 12.5% here.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  revision.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index f06a5d63a3..671b6d6513 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -359,14 +359,22 @@ static struct object *get_reference(struct rev_info=
 *revs, const char *name,
>  				    const struct object_id *oid,
>  				    unsigned int flags)
>  {
> -	struct object *object;
> +	struct object *object =3D lookup_unknown_object(revs->repo, oid);
> +
> +	if (object->type =3D=3D OBJ_NONE) {
> +		int type =3D oid_object_info(revs->repo, oid, NULL);
> +		if (type < 0 || !object_as_type(object, type, 1)) {

Let's s/int type/enum object_type, personally I think we should never do
"type < 0" either, and check OBJ_BAD explicitly, but I've seemingly lost
that discussion on-list before.

But I think the consensus is that we should not do !type, but rather
type =3D=3D OBJ_NONE.
