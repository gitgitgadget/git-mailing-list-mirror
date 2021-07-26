Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99996C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 08:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9B460F4B
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 08:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhGZH4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 03:56:22 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:58930 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhGZH4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 03:56:21 -0400
Date:   Mon, 26 Jul 2021 08:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1627288608;
        bh=HgHvU0XrFWGfZwXdNvf344H263ItECPFLKQgk2HxUpQ=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Yr4TZIUCIOsPUhl1sAZo2BRbt2xKxOKdyVBQ4sVgv97KznEpwSJR15TACyQzSW6oa
         PM6zga/L5Yta4NSJZF+zJdcKKBdXmY9MKNMXLegPbfRl3QdKB46aEBkvMbuJTroUB+
         Gjcm/TT5iqnk2SHB12VMHgzdWTVdFWUSCv8L451OsnQ0R7OIeIlBBWtS8lZ+vH70kc
         VCvr9aM453VESM4w3r/Q/Fo+aRL4cljufgMS5Ul9WWVAu25sZkcFwVZgdkh4dzB6/G
         UMjmctudmY/krm+z3uXLOu2SnBOveefreepN+dLinyTEAzx9UBt9GMDvwer9h4NUJP
         rBIVs0gDXpeGA==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     jonathantanmy@google.com, bmwill@google.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: ref-in-want does not consider namespace
Message-ID: <CD2XNXHACAXS.13J6JTWZPO1JA@schmidt>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="---------------------758914107c9ea768e7a7d15bf19dd4c1"; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------758914107c9ea768e7a7d15bf19dd4c1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Date: Mon, 26 Jul 2021 10:36:37 +0200
Message-Id: <CD2XNXHACAXS.13J6JTWZPO1JA@schmidt>
To: <git@vger.kernel.org>
Cc: <jonathantanmy@google.com>, <bmwill@google.com>
Subject: ref-in-want does not consider namespace
From: "Kim Altintop" <kim@eagain.st>

Hello,

I am experimenting with the ref-in-want feature using a custom client and p=
lain
`git-upload-pack` on the server end. To my suprise, it turned out that fetc=
hing
from a namespaced repository requires the `want-ref` lines to specify the r=
efs
in namespaced form. That is:

Say I have the ref `refs/namespaces/foo/refs/heads/main`. I launch upload-p=
ack
with `--namespace=3Dfoo`. Running `ls-refs` with a namespace-relative

  `ref-prefix refs/heads/*`

will work as expected, but sendingr

  `want-ref refs/heads/main`

will result in

  `ERR unknown ref refs/heads/main`

Sending

  `want-ref refs/namespaces/foo/refs/heads/main`

works, and the corresponding `wanted-refs` section will contain the ref as =
given
(ie. including the namespace path).

Since my understanding of git namespaces is that they should be transparent=
 to
the client, I find this surprising.

I dug up an early version of a patch introducing the feature, which did han=
dle
namespaces [0], but what eventually landed (authored by Brandon Williams)
didn't.


Was this an oversight, or is there a specific reason for the behaviour?


Thanks,
Kim



[0]: https://lore.kernel.org/git/d0d42b3bb4cf755f122591e191354c53848f197d.1=
485381677.git.jonathantanmy@google.com/

-----------------------758914107c9ea768e7a7d15bf19dd4c1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmD+dBcJELImUbUYn6P0FiEEAieFEAJRAcVXZKBwsiZRtRif
o/QAAKN4AQDv+sWZLKBgO1zrRRRyd+YHS5drj+XRAtsv9prXpj4duQD/a6T0
dVDgW1cOHTnpaTWQC5vfJ5oTquNyBwgRQmndwQs=
=U1/c
-----END PGP SIGNATURE-----


-----------------------758914107c9ea768e7a7d15bf19dd4c1--

