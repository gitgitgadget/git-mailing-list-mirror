Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C117C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiDOXsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356595AbiDOXsN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 19:48:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6207A9024B
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:45:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s25so10989638edi.13
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ONqlKgBh9llGqdWaZo3/o1D4KB8q7Hu5quwFWbSjjjk=;
        b=Ld2550Xug2Tsh5iNX+1OIJ5T61BjY3ZYVQ3po3sn9SDPuF6XbimM8e6An7C/2p+5g/
         PIZ8Aukc04MlkX+H5m9wbMPHE4JdPdUW5ZTr4hTU6hmQ9yjld6uxHHJDDd7Q8a0EQUWw
         dIOSDp2TBNtkq5+RoJT5tAyFFcZdxT5Gr08ML0kHwaEvHS7Df4NeWYF/q7dADXW0HVQ8
         J5V1xbdhXbIp9OvkEqVuPF4gJqTk1cFjXvO2Ibaujcvo3919My02zO9KBJwJzIHQ/ZKj
         q3aA/kuOwBU3gid8VwgBRq/rMM0dsQ+CjaZNwTzApkvY3eVQ5t0AsK39fkWflFWoOwt/
         OBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ONqlKgBh9llGqdWaZo3/o1D4KB8q7Hu5quwFWbSjjjk=;
        b=mM+DKDrnEA1e8JLr693/NV4Jj9D+YZCc4bkhmIOxV1D8Hi3+GI8dcey4xRgPzhgm05
         Xa04HMhGZogBUFlzy7q6uEbBqWxrWzhVkFIM4iD2Gzdx42v5Z8r7Bvr6Wozdpt+M5pRO
         NGjeKF6nGP+dt676A0rb38+yegxraD61qm0L8Ub+lIebtp1kRF1zirgIV6+otcA4F1O8
         x6NlvUElWicSs0xBWxhXxch15sCI7G2bsEBhwuUlkCpqcz82nriUEIy9TOqi+MCqzDBj
         YwT1S94RU5KKakMvmRkNdPkPWmMBcp8S1JY4OHfMjEZZPo4toY+7d6++/DcbTnXmum+V
         aH0g==
X-Gm-Message-State: AOAM533nbd1Z9JVqQdUWv07OCSCug+zwDM8AehSvFboaY/Sn1r+pOpxS
        kGFt43RKw0RA3c56oGoM73w=
X-Google-Smtp-Source: ABdhPJz/RLh3FchHAObYnDQpbgfOLQZEyLTf8H7eOkkRisUIH8meFnRqRbUSfhULR3H0h95INL8ZQg==
X-Received: by 2002:a05:6402:26d6:b0:421:6368:33b4 with SMTP id x22-20020a05640226d600b00421636833b4mr1472286edd.242.1650066340749;
        Fri, 15 Apr 2022 16:45:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hy24-20020a1709068a7800b006e888dbf1d6sm2077903ejc.91.2022.04.15.16.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 16:45:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfVdD-005v8W-JQ;
        Sat, 16 Apr 2022 01:45:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood@talktalk.net
Subject: Re: [PATCH 1/2] config.mak.dev: workaround gcc 12 bug affecting
 "pedantic" CI job
Date:   Sat, 16 Apr 2022 01:41:27 +0200
References: <20220415123922.30926-1-carenas@gmail.com>
 <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-2-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220415231342.35980-2-carenas@gmail.com>
Message-ID: <220416.8635idc3mk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Originally noticed by Peff[1], but yet to be corrected[2] and planned to
> be released with Fedora 36 (scheduled for Apr 19).
>
>   dir.c: In function =E2=80=98git_url_basename=E2=80=99:
>   dir.c:3085:13: error: =E2=80=98memchr=E2=80=99 specified bound [9223372=
036854775808, 0] exceeds maximum object size 9223372036854775807 [-Werror=
=3Dstringop-overread]
>    3085 |         if (memchr(start, '/', end - start) =3D=3D NULL
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fedora is used as part of the CI, and therefore that release will trigger
> failures, unless the version of the image used is locked to an older
> release, as an alternative.
>
> Restricting the flag to the affected source file, as well as implementing
> an independent facility to track these workarounds was specifically punted
> to minimize the risk of introducing problems so close to a release.
>
> This change should be reverted once the underlying gcc bug is solved and
> which should be visible by NOT triggering a warning, otherwise.
>
> [1] https://lore.kernel.org/git/YZQhLh2BU5Hquhpo@coredump.intra.peff.net/
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  config.mak.dev | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 3deb076d5e3..335efd46203 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -65,4 +65,9 @@ DEVELOPER_CFLAGS +=3D -Wno-uninitialized
>  endif
>  endif
>=20=20
> +# https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
> +ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
> +DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread
> +endif

What I meant with "just set -Wno-error=3Dstringop-overread on gcc12 for
dir.(o|s|sp)?" was that you can set this per-file:

	dir.sp dir.s dir.o: EXTRA_CPPFLAGS +=3D -Wno-error=3Dstringop-overread

Ditto for the warning suppression in 2/2, we don't currently have any
other warnings like this, but we can suppress them more narrowly.
