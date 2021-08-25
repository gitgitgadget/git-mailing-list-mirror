Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD4C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7A261042
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhHYXpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:45:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A5C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:44:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u14so1930212ejf.13
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wFtsK4QWRi2txDV+EW1Sk0a44PR21RhniJsgq+ZsEIE=;
        b=Od9qI81p/NcgqhD4QEEyTkuLbRvBZLBjhFwRgNQSfPkUk7eCK97OkpqZgYLbNY9cWo
         znpWTCXDRkY5u+4rZRUYjXhAplXILamJSZO4QW8leYT5BRmEGREvw0SdtKP/twYeIHS2
         eATJgNox7ewIxj/mYjlzIsVboSZyr0O/cTlhPh+NzPDYZl2DS6UCoAhiR2IFVIKxvMuL
         84wq4G62t2mo817yn5BJRXat3WkvIjW11gDMwRggNcsUcWd3EtXubSo32lMbqEEDq4F7
         /n7fWhQlaf5NgJvII59HEQMAjudywrNy5TStPIqRXFq+npFDp+85jYuOig0hpBWCNj2m
         knug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wFtsK4QWRi2txDV+EW1Sk0a44PR21RhniJsgq+ZsEIE=;
        b=S1Ip4HyjbUz0GAXd1stHF2WBIFu+qpJ3VmdOfnN7XXvxfU39LMdCKjGNG1e0omIK7h
         LnpLRQ/9raZvafXm6noA8+njq+wyUfOgRGi2NfNW9ZU3mA4THIuFvX5KpOmMXxj5Tdpw
         GigVnO2/FPdPgXLEp6eu9ZTTSw/Rugu9IZ5+pFHBZOfCtzbfmw051dALBYIyyR6bMqEY
         fvkkNflP3RQpMRJvoT9DotCV2snOuxJwBIuaRH0wXRpMhahc2ql2elgl8BUEcypMH2NX
         YIV7aNMis6cnkVF3JT2cuydOylx6v9vPdsNFt4KnrF9j6HgaYNx0jxu7H9J2P1zGdGEb
         BRyA==
X-Gm-Message-State: AOAM531ErVZvXSlwe0aMZ7AmIqvn5YYwNQPc6kH2BI5gD9TPBB3X6b6p
        f8sCeiWHhc/K68MFX3t7Y9Y=
X-Google-Smtp-Source: ABdhPJwudMUgQjCgyOaozuJfP2j3aWivSqqsL2V6jDmK8i+YeDAAbhZoOm6c7s8Y0iXxK0YwsTx4AQ==
X-Received: by 2002:a17:906:f207:: with SMTP id gt7mr1185544ejb.380.1629935089129;
        Wed, 25 Aug 2021 16:44:49 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o19sm723072edr.18.2021.08.25.16.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:44:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] fetch: avoid unpacking headers in object existence
 check
Date:   Thu, 26 Aug 2021 01:44:03 +0200
References: <cover.1629452412.git.ps@pks.im>
 <d3dac607f2235c5913621813c443aa10b99c8fe8.1629452412.git.ps@pks.im>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <d3dac607f2235c5913621813c443aa10b99c8fe8.1629452412.git.ps@pks.im>
Message-ID: <878s0pccnj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 20 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> When updating local refs after the fetch has transferred all objects, we
> do an object existence test as a safety guard to avoid updating a ref to
> an object which we don't have. We do so via `oid_object_info()`: if it
> returns an error, then we know the object does not exist.
>
> One side effect of `oid_object_info()` is that it parses the object's
> type, and to do so it must unpack the object header. This is completely
> pointless: we don't care for the type, but only want to assert that the
> object exists.
>
> Refactor the code to use `repo_has_object_file()`, which both makes the
> code's intent clearer and is also faster because it does not unpack
> object headers. In a real-world repo with 2.3M refs, this results in a
> small speedup when doing a mirror-fetch:
>
>     Benchmark #1: HEAD~: git-fetch
>       Time (mean =C2=B1 =CF=83):     33.686 s =C2=B1  0.176 s    [User: 3=
0.119 s, System: 5.262 s]
>       Range (min =E2=80=A6 max):   33.512 s =E2=80=A6 33.944 s    5 runs
>
>     Benchmark #2: HEAD: git-fetch
>       Time (mean =C2=B1 =CF=83):     31.247 s =C2=B1  0.195 s    [User: 2=
8.135 s, System: 5.066 s]
>       Range (min =E2=80=A6 max):   30.948 s =E2=80=A6 31.472 s    5 runs
>
>     Summary
>       'HEAD: git-fetch' ran
>         1.08 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fetch.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 73f5b286d5..5fd0f7c791 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -846,13 +846,11 @@ static int update_local_ref(struct ref *ref,
>  			    int summary_width)
>  {
>  	struct commit *current =3D NULL, *updated;
> -	enum object_type type;
>  	struct branch *current_branch =3D branch_get(NULL);
>  	const char *pretty_ref =3D prettify_refname(ref->name);
>  	int fast_forward =3D 0;
>=20=20
> -	type =3D oid_object_info(the_repository, &ref->new_oid, NULL);
> -	if (type < 0)
> +	if (!repo_has_object_file(the_repository, &ref->new_oid))
>  		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
>=20=20
>  	if (oideq(&ref->old_oid, &ref->new_oid)) {

I tried grepping the source for any other candidates for a migration to
repo_has_object_file(), but this is the only "type =3D oid_object_info" I
could find that didn't care about the type, perhaps there's some callers
of *_extended() that could be moved over, but that's less likely, and I
didn't check...
