Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996F0C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D6C2064B
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpAfIYxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKZWHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:07:08 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:45084 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZWHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 17:07:08 -0500
Received: by mail-qk1-f182.google.com with SMTP id x1so2906103qkl.12
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 14:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jogw1inNC58BnFlG5TNN+X3FJgoseCP2Upckc1aHGf0=;
        b=cpAfIYxiFkr/ZcFIap1WkF2h1lJvNNT52vQmMPvXDg7hnLR2sfa/s12abAg8h07w33
         VGG4Me5M2x0xhy6/88c3PrGeVT0jX4zvZfKc+oH2PcMXRyzVXvdQme0AVBU4cmuqRpSG
         X8BsRcADmM1w5hPy9ThrWLR6YcxxBgr6Ro4sMHDb6qhcfaAs3EQidrl0xr1YjF0j6IaP
         DXfFAa3bUiEEfRG3sXAqJz8s/RTlCy/EYBcljGuHcm+dK+KfSqLx9xhBiqM6k1jCOIZk
         AUp9aSebQ+aII8pmDnkTA+H3QpBQTs73Qxf18Sgz1MHquRmsyO3o5k7KDNLyOcewvp+k
         bLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jogw1inNC58BnFlG5TNN+X3FJgoseCP2Upckc1aHGf0=;
        b=V0F+SNbI25HS+oAitx9ysiMlitu2yOz9/FM8VuXovK/bTXO3lj4WsfuFBwZMIksZ+N
         TNF6afqMdNbNr703qYsukwsYW52eE8i6jRv0KIr8g8czsATfj39ruUAV0/a20GdIPIQI
         BHvaDK0d/y+0k9WOrWxEWNZFMWqo3u1mYr1jbax1qvIsn3RQaBYgm/vCJfc+6UkZzPpq
         x3jkaH0/jVd59woiGG+DrI+8qzfKN0d6nlYyvOTz8K8KZ6pnuQ+7R5crXSnGjPtdGC8I
         eldmK1mYgyiXpEZX04ndiR2EMrVjO2wQxbIq2icj56tI/XXlohre2rifl957nKvpu6Fd
         kjYA==
X-Gm-Message-State: APjAAAVTIuBr5LXWjSVLzMiowux9GgPU9c+070YgXVax+1ceUgYW0v4T
        pV9z+zl1H2tWBofH4+6+V7M=
X-Google-Smtp-Source: APXvYqwA2PN0bIHjNR+Eix7U+Qkzt8obpTsCcu1YO5GDSf6llDAhGtEOvPgtxNVjseGjuPCkOWjsAw==
X-Received: by 2002:a05:620a:208d:: with SMTP id e13mr818162qka.208.1574806027127;
        Tue, 26 Nov 2019 14:07:07 -0800 (PST)
Received: from localhost ([165.227.200.42])
        by smtp.gmail.com with ESMTPSA id 13sm982587qke.85.2019.11.26.14.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Nov 2019 14:07:05 -0800 (PST)
Date:   Tue, 26 Nov 2019 17:07:05 -0500
From:   Brandon McCaig <bamccaig@gmail.com>
To:     Tasnad Kernetzky <tasnadk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "git checkout BRANCH -- FILE" deletes staged commits
Message-ID: <20191126220705.5kfrqdtzbfsgu2k3@test-chamber-21.localdomain>
Mail-Followup-To: Tasnad Kernetzky <tasnadk@gmail.com>, git@vger.kernel.org
References: <5cb30154-5753-f229-9fa2-6c82d2896abc@gmail.com>
 <20191122031411.zrg5hv4dvk6dxxus@test-chamber-21.localdomain>
 <aaa2b05a-4c0c-8194-6488-f1b770f3b852@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hevv5lwbb7xqlcvw"
Content-Disposition: inline
In-Reply-To: <aaa2b05a-4c0c-8194-6488-f1b770f3b852@gmail.com>
X-PGP-Key: https://castopulence.org/bamccaig/castopulence.asc
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hevv5lwbb7xqlcvw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tasnad:

On Mon, Nov 25, 2019 at 09:15:18PM +0100, Tasnad Kernetzky wrote:
> Hi Brandon,

Hello,

> On 22.11.19 04:14, Brandon McCaig wrote: [...]
> > When you switch back to branch B the state of the tst file is
> > the same as it exists in the branch B. There is no conflict
> > here so it succeeds, and once it does you no longer have any
> > changes made to tst because the version in your index and
> > working tree matches the version in the HEAD commit.
> >
> > git status at this point would report nothing (assuming no
> > other files are modified).
>=20
> This is the point I actually considered as a bug. There are
> staged changes and usually git doesn't let me switch away from
> a branch in such cases.

I think that Git normally will let you change branches even if
you have changes in your index or working tree as long as the
version of the file in your destination branch matches the HEAD
version. In other words no merge is necessary and no changes can
be lost. I regularly do this when I start making changes on
develop or master, and then decide to branch after the fact. It's
a bit less typing than stashing in between. :)

For example:

	git init checkout
	cd checkout
	echo master >log
	git add log
	git commit -m master
	git checkout -b B
	echo B >>log
	git add log
	git checkout master
	git status

Regards,


--=20
Brandon McCaig <bamccaig@gmail.com> <bambams@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bambams.ca/>
perl -E '$_=3Dq{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'


--hevv5lwbb7xqlcvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6A+1JeuAGnMhPkN33afWAiLlk/IFAl3dogUACgkQ3afWAiLl
k/IG8Q//XVxCfEXF6dSdEor0QBFdtWHZpv0EP35DXp9uDFNuJBHAujQ/9o11US/X
exi3xYynLMzBs3fSIqDuYjSzC+rh2H8XJhBAV4CR2u2aPwir2Emgqrv+EziMGGKn
VkVDkfgGT7kL/C91TbM1hofZTqzm5XwvGmngkdFMqiV06tWu0BdLIzi0sLWVTz7p
4g+No2p65PDy4sBrZhymP59kmuhc9BOi/zFUcMhCaJwVcSLu8uyk/iR0ZBHSVH2E
CkcfH+iYeJpVJzZxFGZaG+ny65iQo0C78GdEtpR66ZDiPaj/ANwF33Qo1UCpjco4
sw6yDxCgIgZaL9NE048Gi/maZe8USSBpDhTIV5rySbJ7FBXyBU4/pjI5bXRisgMh
AhOiFSOLgEaet+GsHO+VebCcj2wIr0C1DsttKRgjTPCSQoyq28ATSr7vDlJvqy4P
KryogOdjTRgrUp0+jUiIRjiWwqLdd/UUvkz8TC6VHQxklgiHhEbdGQKiaTVZ/g/Q
enIYWOtHQwMNTloovlPHNte3nG2rMJ+Iqukk5jVpPm/aW3Et6VIJDwYz0tx8/s2b
X4YnP1TEAoYqTGT6SKtjNbSCodvJwjapWyJXSeZAmiDgWx5lIRfrUytmaGWejlqC
+uK75Xn+Mu+97GV0z4wjGsoGJDEcvcluV0idgPuPOm5NIzlPUM4=
=pJnL
-----END PGP SIGNATURE-----

--hevv5lwbb7xqlcvw--
