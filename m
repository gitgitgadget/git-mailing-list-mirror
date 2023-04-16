Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CC7C77B73
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 14:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjDPOKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 10:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDPOKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 10:10:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B3B1BEE
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 07:10:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f109b1808so93269866b.1
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681654214; x=1684246214;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZhIJdiWfahVLX+pEM2FPo5GbUCJJB+lkxq0tu3d9VVU=;
        b=HGYFXhLLKiVyVLX63sBhzXIVXw2gnn257Gy7LEQMRUq8JMAr+QcRKdC+OM1tUuNL/H
         QNBEPzZ7z8WZ7W+jmDvEs3AqzowBb5kJMTeI52TNpYuK8wB/XLbYjhnCsoPKmREzFgPl
         VEQJWmCB/QqD2MMc8EMzYZ7Aope9Mzu72U4CUHCVsPInuCqqGovHm4RXTIX5Sit9TjE2
         51dAder88OyPJEPBLJ2IcN/Aj36IxL+VEqY2Bw/bpsZMlz4tClUiV1sb/iAOhhKY/D1m
         52pNEvx6rY4GU2UYgRY2d23l/wa9MBXgrx7tEsKTylFMgq+d7eAG48FSOhHh38RSlq+9
         ThIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681654214; x=1684246214;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhIJdiWfahVLX+pEM2FPo5GbUCJJB+lkxq0tu3d9VVU=;
        b=FNjkalsLbsO8crpfUWqdPLXH3R1vhEnJCI0r1A5AdBlX3QYChCOyfsl45rmrWPRUan
         n/vm6ddtxayl5DFkG4FKC1DhbS3mia8m3bKLJ/YuFNxJlqmirucAWQR2YiuRXhjcHm1K
         jW16CokX4JwBvXzaKmeslcPdrGv4Drk2ROObEHorpgJPuF0KCfHFpmiM11R04A8enzuH
         daVV364jsOBucaYKaHgBuS9F2TIg/h3o4rbeiZvyUrLJPA2f0gKKBI+3s701Tv0+D9Fj
         DZUycu1ku70tP2UH2SyuYfX5mzFB67fosURx6x2kJGsDXwVRnVaR/mBrxMmCWj+1WaMi
         KPYw==
X-Gm-Message-State: AAQBX9cQrFuSODgW0I8Hmz1W+Hsan33H60xMta6mmaksKvs5Vr5BB1FR
        ZbKxXdo9RwRfw1jFD5wXbVW/JaHu010=
X-Google-Smtp-Source: AKy350Y7nlzduM8jp+cCOUxudHDR7hXFx29zq5mt/heuyUrTQ4tsqhVDrHPiT+ULlfmG8sby6Y3Ogw==
X-Received: by 2002:aa7:c7d2:0:b0:506:77e6:395 with SMTP id o18-20020aa7c7d2000000b0050677e60395mr8297837eds.17.1681654214255;
        Sun, 16 Apr 2023 07:10:14 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id a66-20020a509ec8000000b005068d7657eesm2557825edf.78.2023.04.16.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:10:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1po353-005djq-1S;
        Sun, 16 Apr 2023 16:10:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] coccinelle: add and apply branch_get() rules
Date:   Sun, 16 Apr 2023 15:56:56 +0200
References: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
Message-ID: <230416.86ildvsyt6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 06 2023, Rub=C3=A9n Justo wrote:

> There are three supported ways to obtain a "struct branch *" for the
> currently checked out branch, in the current worktree, using the API
> branch_get(): branch_get(NULL), branch_get("") and branch_get("HEAD").
>
> The first one is the recommended [1][2] and optimal usage.  Let's add
> two coccinelle rules to convert the latter two into the first one.
>
>   1. f019d08ea6 (API documentation for remote.h, 2008-02-19)
>
>   2. d27eb356bf (remote: move doc to remote.h and refspec.h, 2019-11-17)

I wondered why it is that we don't just make passing "HEAD" an error,
and what I thought was the case is why: It's because we use this API
both for "internal" callers like what you modify below, but also for
passing e.g. a "HEAD" as an argv element directly to the API, and don't
want every command-line interface to hardcode the "HEAD" =3D=3D NULL. So
that makes sense.

But do we need to support "" at all? changing branch_get() so that we do:

	if (name && !*name)
		BUG("pass NULL, not \"\"");

Passes all our tests, but perhaps we have insufficient coverage.

> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  builtin/fetch.c                     |  2 +-
>  builtin/pull.c                      |  8 ++++----
>  contrib/coccinelle/branch_get.cocci | 10 ++++++++++

We've typically named these rules after the API itself, in this case
this is in remote.c, maybe we can just add a remote.cocci?

>  3 files changed, 15 insertions(+), 5 deletions(-)
>  create mode 100644 contrib/coccinelle/branch_get.cocci
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7221e57f35..45d81c8e02 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1738,7 +1738,7 @@ static int do_fetch(struct transport *transport,
>  	commit_fetch_head(&fetch_head);
>=20=20
>  	if (set_upstream) {
> -		struct branch *branch =3D branch_get("HEAD");
> +		struct branch *branch =3D branch_get(NULL);
>  		struct ref *rm;
>  		struct ref *source_ref =3D NULL;

I wonder if we shouldn't just change all of thes to a new inline helper
with a more obvious name, perhaps current_branch()?
> diff --git a/contrib/coccinelle/branch_get.cocci b/contrib/coccinelle/bra=
nch_get.cocci
> new file mode 100644
> index 0000000000..3ec5b59723
> --- /dev/null
> +++ b/contrib/coccinelle/branch_get.cocci
> @@ -0,0 +1,10 @@
> +@@
> +@@
> +- branch_get("HEAD")
> ++ branch_get(NULL)
> +
> +@@
> +@@
> +- branch_get("")
> ++ branch_get(NULL)
> +

You don't need this duplication, see
contrib/coccinelle/the_repository.cocci.

I think this should do the trick, although it's untested:
=09
	@@
	@@
	  branch_get(
	(
	- "HEAD"
	+ NULL
	|
	- ""
	+ NULL
	)
	  )
=09
A rule structured like that makes it clear that we're not changing the
name, but just the argument.

