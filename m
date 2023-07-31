Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1810C001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 10:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGaK6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjGaK5b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 06:57:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43662699
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 03:56:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-78bb7b89cabso236456539f.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690800972; x=1691405772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U17/jg0fTePfGGSqXsRQcPQ48wqOYuywutXRI68rq8A=;
        b=LDrLlseYOmRZG8nQZx59tAzUJAGpPnFrMsunPPAIuH6nkrQG/cK1FCJQ8m8B3FxQ19
         YAz6pcR0OHHYzfIlePyWyu/xTIPZdMdQUE+tL9s+C6JXgxK3i13XqeXusNsWC0TpbFYT
         +bXD2prETFUwjl74kA64eDhmkqoyqke0D8TUVWW6HChc0uXsmKZN+AzWvRpHm/KZ9xXV
         SGets4qgPwxjKmLrhnjGOw7bgebcB19xgy5xd9YfHaPGwTZfmmghbFGwI9WS6t0KPBS1
         RU2szGclXGm/FHjQu3F+KH5o8zyReoiGIbHHP+SvttUEmsFC69tCAnipoKnqiGZjwxMq
         e/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800972; x=1691405772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U17/jg0fTePfGGSqXsRQcPQ48wqOYuywutXRI68rq8A=;
        b=FP1x31+wo3x63HixYPaSE4CfBC36oFXP0vJWo5zEorAkF42EKtk9uXiErAJhOnIFKW
         fX/2n8ddgr0Aaxan6G7IHjuHr3sBTEA1mp2ivTWEpdfK0h+oQebJGhXeZEPE9urui69r
         FwN3A9TmcEapXZ9mKpH0S0Qv1knyU03EMORvtxRrnIPctQxUBLA8nPjpUI2wkET15hZJ
         kcAuC0niUQyetj/L7JPwFrwTQt0QgIkFXccQf74Lm7V/CRAAULVoNbeem5Gjg/R3fkUY
         buXyD3d6HvbCQHCTUO5F5usrrOJ38rouYLGzEEgj/Cn1Gk+DiiQ5jqvdgFdAdSluiHgL
         VyWQ==
X-Gm-Message-State: ABy/qLYMs8aADNU8Ox43orVqb7IQ6r7i5bLUkAGbsk5GwLRp/F46jvhF
        futODUzgPxSbHdU6FJHoTvs=
X-Google-Smtp-Source: APBJJlGS87q1tEIeY/3upD2va0doTxW4ToI/6KeqrwM+0ECThNmT+Sb9QrnSnikFZ9GJDV6RI09okQ==
X-Received: by 2002:a05:6e02:1d0d:b0:349:1bcc:922a with SMTP id i13-20020a056e021d0d00b003491bcc922amr4130064ila.5.1690800972204;
        Mon, 31 Jul 2023 03:56:12 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a23-20020a637057000000b0054ff36967f7sm7819636pgn.54.2023.07.31.03.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:56:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 426DF815AA27; Mon, 31 Jul 2023 17:56:08 +0700 (WIB)
Date:   Mon, 31 Jul 2023 17:56:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Benjamin Stein <benji_stein@hotmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Bug: fetch with deepen shortens history
Message-ID: <ZMeTR1rj9RH27CUL@debian.me>
References: <PH8P223MB06996E110EF25C386AA314E19F26A@PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM>
 <PH8P223MB0699B4956F3FE9DC736419FA9F03A@PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dej1+207BwjFr15y"
Content-Disposition: inline
In-Reply-To: <PH8P223MB0699B4956F3FE9DC736419FA9F03A@PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dej1+207BwjFr15y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 12:03:31AM +0000, Benjamin Stein wrote:
> > Hello git gurus,
>=20
> > Here's an atypical bug report for you. I'm sorry for not starting with =
the template, but the context/setup are longer=20
> > than felt useful in that format.
> >=20
> > I have what I believe to be a (relatively) simple, reproducible test ca=
se (repo setup/steps below) around shallow=20
> > checkouts at merge commits and deepening where the behavior is quite su=
rprising - I end up with a smaller history=20
> > after a fetch operation than when I started!
> >
> > =C2=A0[...snip...]
>=20
> Hello again. It's been a month, and I didn't even get a "yes, we tested t=
his and confirm the problem", so I thought I'd check in on this.
>=20
> I also found a commit setup where even my "working" solution steps (only =
using deepen) still ends up with the unexpected behavior, so I thought I'd =
add that in here as a simpler scenario to experiment=C2=A0with. It happens =
when both sides of the merge are the same number of commits to the merge ba=
se.
>=20
> Let me know if there's any additional information I can provide or someth=
ing I can do to help resolve.

(also Cc: Junio and Taylor.)

I think in most cases, people doing shallow clones for testing mainline
branch of whatever project they're hacking. If at some later date they
wish to deepen their clones, they can do that up to specified date:

```
$ git clone <clone url> project && cd project
(hack, hack, hack)
$ git checkout main
$ git fetch --shallow-since=3D2023-01-01 && git repack -A -d
```

I often use this method when cloning quite large repos when I'm on mobile
data (via WiFi tethering) due to bandwidth limitation.

>=20
> Thanks,
> Benji
>=20
> ---------simple-bug-setup.sh---------
> set -x
> # Setup working folder for easy cleanup
> mkdir git-test && cd git-test
>=20
> # Setup repo
> mkdir source-repo &&=C2=A0 cd source-repo
> git init
> git branch -m trunk
> for i in {01..05}; do echo "start${i}" >> start; git add start; git commi=
t -m "start${i}"; done
> git branch old-checkpoint
> for i in {01..10}; do echo "new${i}" >> new; git add new; git commit -m "=
new${i}"; done
> git checkout -b feature HEAD~4
> for i in {01..03}; do echo "feature${i}" >> feature; git add feature; git=
 commit -m "feature${i}"; done
> git checkout trunk
> git merge --no-edit feature
> cd ..
> sleep 1
>=20
> # simple checkout
> git clone --no-local source-repo --depth=3D1 --branch trunk shallow-clone=
-only-deepen
> cd shallow-clone-only-deepen
> git remote set-branches --add origin '*'
> git fetch --deepen=3D4 origin HEAD feature # this also works if we use fe=
ature
> git fetch origin --shallow-exclude=3Dold-checkpoint feature
> git log --oneline origin/feature | wc -l # 9, expected
> git fetch --deepen=3D1 origin feature
> git log --oneline origin/feature | wc -l # 4, unexpected
> cd ..
> sleep 1
>=20

Thanks for the script that you provided.

--=20
An old man doll... just what I always wanted! - Clara

--Dej1+207BwjFr15y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZMeTQQAKCRB7tWyQc2rT
CCYzAP9TU4zeuugBK+6xqKoPp+8Z4Ec5f68AOc9Cax916jV8FwD/ZAX2BhwcZrJ/
VkhSFGkAaGZUHF11nHS8F3RPDP63Qg0=
=yjXD
-----END PGP SIGNATURE-----

--Dej1+207BwjFr15y--
