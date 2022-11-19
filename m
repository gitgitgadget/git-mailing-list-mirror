Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E540BC433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 01:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiKSBnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiKSBmp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 20:42:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09820922DD
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 16:49:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id me22so285970ejb.8
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 16:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsYff3ZER74iXP3gmH5u5Sk+2QrLIpw8TrQvsBqD6EI=;
        b=nHJQs9bY6XS8PJP8IM26dmdqH5ifajsNqTcSA9s1QuuptE+0XtmrrPJBYJKEiutsUF
         YnTQyOIA0WQmOp3jMIvW4Rta0aOqqRzIdsCpT3hlkdiddZvy/ZjajDVqslAAyHcb3Scf
         0b14rVdgOukiTEtgsHYMmsOpNL2GVQJJ76sMKM/dNZWnATb4rtWnjUdGaU/OQg2xQAmz
         RUmkLRojfuZBctT9Y0zoNlTT2MHqneiYZMmfirigHryTljnD2pV2H+j5UplPyAIIHNZq
         fG7pcb+I3mcjRz4HcszIyYBIRdNgpSpssOVlIH1ALVe1fPNzzmIOGJz4OqSjsZe+F8Xj
         zdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsYff3ZER74iXP3gmH5u5Sk+2QrLIpw8TrQvsBqD6EI=;
        b=IBj8Ar4XG74j1rB1Zh1NU6QE1zjCfr1afKQ4eAiBcrHB7rz2Pp18+PL9ZO7rQ+Z+R7
         avPkG71JWj8m0DAyfy6dG8pYX9xrMKwgfmCRTOCdnsXE3zZ7QU6eOIKkXQc9LRLjmlgQ
         pPPdwEmATzoPAjoY6MeS6Oh6XoM8PqEPGvM2lnVxvCjDxnVesdsRiD4IXwhNR40SCPQ8
         Qx5t79coZ1InwV+7Clc1Qips5dDh2dUFecjmlnVtm6PzqdSjdsxkdI1gepczm3N0o+Xf
         xyr2KpkuPV/AQ7yu8XdmA2cU2F/CZq+Qiuvf0nTwTNrGibVkozSg5LSWo5b5D9UWYcJP
         LtbQ==
X-Gm-Message-State: ANoB5pkhvNjUpVmuH1Ouu2Yb4tEErOzouFkF3MNKTO5SNusOXPuthB3S
        q+r3xK5fa4QkZa9aph7+JMs=
X-Google-Smtp-Source: AA0mqf7s0CKXII8KrlrQFVivU4xal/9cvyCeVMlKDoTDK4iwQ8aN1JqA875DycIyxSa0VaBDrcupgg==
X-Received: by 2002:a17:906:9493:b0:7ad:83cb:85e6 with SMTP id t19-20020a170906949300b007ad83cb85e6mr8191502ejx.108.1668818950346;
        Fri, 18 Nov 2022 16:49:10 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s26-20020a056402165a00b0046800749670sm2426489edx.53.2022.11.18.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:49:09 -0800 (PST)
Date:   Sat, 19 Nov 2022 01:49:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] am: Allow passing --no-verify flag
Message-ID: <Y3goBHxEd8xUE4Bc@orome>
References: <20221118132743.3525725-1-thierry.reding@gmail.com>
 <Y3fNQ9ysAeOsyOSQ@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1n9JsfI7VPV1xIRd"
Content-Disposition: inline
In-Reply-To: <Y3fNQ9ysAeOsyOSQ@nand.local>
User-Agent: Mutt/2.2.8 (2022-11-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1n9JsfI7VPV1xIRd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 01:21:55PM -0500, Taylor Blau wrote:
> On Fri, Nov 18, 2022 at 02:27:43PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The git-am --no-verify flag is analogous to the same flag passed to
> > git-commit. It bypasses the pre-applypatch and applypatch-msg hooks
> > if they are enabled.
>=20
> The patch below looks reasonable to me. Is there a way that we could
> test this easily? It looks trivially correct to my eyes, but I want to
> avoid the possibility of regressing here in the future.

Yeah, turns out this can be pretty easily checked. I'll resend a v2 with
the test included.

Thierry

--1n9JsfI7VPV1xIRd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN4KAQACgkQ3SOs138+
s6EAghAAwyGxfOwaguDVu/yKYfLUI6X+S0SKnQd3gi7NIqNhNJw8Y6Cfn6TCPtnz
ziCLoMfSXvmehsZP85xj6RRPTFFDfmgASuHtVW8u2Ufcm2bQ55NgoBSAuufoT+l7
akBFyi4u3Dviba2vQIXX3jVn4Q57tEjY6Uaf3PR4JLfOQbBNxNFXSSIiezE+gkK6
tEZ3DD9vUm0AabQz17ZOMFbkz1SRf0oB1p3iHByyBuMzLZrXGSAflHCx/LRf2vam
En4AGJQQbMRBY5M7T8cg8s09C5LNJWbqTchdzgBadBA0sJWRXsgvDZjr1OPIjobA
CTQIQcMkYoWvfPDgNuzwmnehoG9twVF8A5ckDOs0eXBtaguhXLeYScPD22vbtMI6
Xa0rG5+IxYZTZwojOIKW/dUlVjJO7wbHBb0XDDT7eHTCyNNBYjDhFQHPdB8y3wcX
TkivhBVPLDatXau/yO1P5BqsuAVBUdeiqvbse/wRnpCyPjTn0ofaaW+ShJAHBcl3
9ZxOOfHVqzn7RXSWkIorh0WwQdxoSBrdyTjsWhegUp/Mpaa8hJEHnk0TyOpgNSBP
MvT/yT9eB8dBgo/BAvMf18ZkLLveM//WOoRF19n97oeGWKA9iCmXevPngsk0Xe78
EhLIO9qkT6EicdyfcSnJgrxVmHguC9MdvMXKEqielkM8pPxFwH4=
=tPGC
-----END PGP SIGNATURE-----

--1n9JsfI7VPV1xIRd--
