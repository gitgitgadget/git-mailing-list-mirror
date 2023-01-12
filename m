Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7BDC54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjALQN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjALQNT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:13:19 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC30A15FCC
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:09:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qk9so45960166ejc.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zrtEzhEaXFmEBFvlpDQt1BApmtRy5wflg4nCGHnABJc=;
        b=kH8Ak/dPvzBG9fY69PB8/PUnCEqxVv456qrRu1vz6rDf9KpB64r9CB9ngQBdc6Ut6c
         QGGmuiDeDFs6IOwMILzGVALo94fDD/29euzoNT1yjJWBmToibkkNfTR5HD6BcUeNZiXM
         fFnHlI07046SoSO8xJgYODJhSQQhJDMKBDkVZNdY2lgj34VI4G4QPwnsEs4m4/m2/Q3G
         91vAhJRxFwLLaAgbyLOU0HPZw8bTVjoefcImqJT5zrYbJaX7Aa3TuOv0TkpB96jS72iV
         mX8YgtYJzZsQNR8F4evsyJypl2pj6Srt7X+Jgr6M0axOXpj/RQ0yr+GEhy9S3WYbaGP6
         rDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrtEzhEaXFmEBFvlpDQt1BApmtRy5wflg4nCGHnABJc=;
        b=aRN8P88r1pV+ZAG5ep0kkS9ztpShcxgGfT6P/OCiL27EN4wVkIk7AJE8Y+wh0Sf4bg
         LwRsuPR91UG+9kdtYMpXau98PEn3InuCM7IZmdYnHBlAZTbLVlZbSM9C12Lsa6TYKgJ7
         GZDsf3XI4LqhhQTnNfyJA4nxXDqEdz/cwG8nfFVuvrbgdBbQXj9bSQAXk3nSIn560/Eb
         +JOIJ+ijeatenszvD0LF9njjIStY8I2i39Hg0R+HE6cb5BjwMaHa/WuqyJgn6YJnfi5A
         TRRvyK79j4ovRSQoVCmDAy0x/7uer9zSEPe7DcGtaw2oJ4L6utv9DwuYtlpfjT7Dzzsh
         ZCcg==
X-Gm-Message-State: AFqh2kpzZBxupFBZ79rBKyK53khIRw6lfdHDoY+fgSx/8NI9deuTCU+Q
        Syzk1SeRH5FtQsGkKGVpvmBNyHc1yWS2YA==
X-Google-Smtp-Source: AMrXdXtRlvZTeKMploiCjz9fIdETBV+uRt+s1220tsDLbL6pYLqwJcS0tyMxZQU2V7IWzWMunFApYw==
X-Received: by 2002:a17:907:3490:b0:7c1:6e08:4c20 with SMTP id zx16-20020a170907349000b007c16e084c20mr24966616ejb.7.1673539762445;
        Thu, 12 Jan 2023 08:09:22 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id la16-20020a170907781000b0084d494b24dcsm4896145ejc.161.2023.01.12.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 08:09:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pG08n-000Jvz-1g;
        Thu, 12 Jan 2023 17:09:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] object-file: fix indent-with-space
Date:   Thu, 12 Jan 2023 17:08:35 +0100
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <Y7l4RznPhTr+O8ZP@coredump.intra.peff.net>
 <230112.86k01s2jzm.gmgdl@evledraar.gmail.com>
 <Y8AwGdtrsjnBdXN7@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y8AwGdtrsjnBdXN7@coredump.intra.peff.net>
Message-ID: <230112.864jsv20r2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Jeff King wrote:

> On Thu, Jan 12, 2023 at 10:13:20AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>>=20
>> On Sat, Jan 07 2023, Jeff King wrote:
>>=20
>> > +	oi.typep =3D type;
>> > +	oi.sizep =3D size;
>> > +	oi.contentp =3D &data;
>> > +	if (lookup_replace)
>> > +		flags |=3D OBJECT_INFO_LOOKUP_REPLACE;
>> > +	if (oid_object_info_extended(r, oid, &oi, flags))
>> > +	    return NULL;
>>=20
>> Style: This is "\t    ", but should be "\t\t".
>
> Hmph, I'm not sure how I managed that. Thanks for pointing it out. The
> commit is in 'next', so I think we'd want this on top (of
> jk/read-object-cleanup).

> -- >8 --
> Subject: [PATCH] object-file: fix indent-with-space
>
> Commit b25562e63f (object-file: inline calls to read_object(),
> 2023-01-07) accidentally indented a conditional block with spaces
> instead of a tab.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/object-file.c b/object-file.c
> index 80b08fc389..ce9efae994 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1708,7 +1708,7 @@ void *repo_read_object_file(struct repository *r,
>  	oi.sizep =3D size;
>  	oi.contentp =3D &data;
>  	if (oid_object_info_extended(r, oid, &oi, flags))
> -	    return NULL;
> +		return NULL;
>=20=20
>  	return data;
>  }

Thanks, I didn't notice (assuming it was too soon, it being less than a
week) that it was in "next" already. This change LGTM, thanks!
