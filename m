Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D61C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 03:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJRDCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJRDCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 23:02:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B8B7EFD7
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 20:02:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so12725469pjl.3
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 20:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ln2QeAtMdww/m3SY9I5YlIOJcERTd44ouLoqU89VV7A=;
        b=E01vC7S0WAcvcQ0XdPXC2MNl06jR2k99DnJbS7Y2kvjCQ/+UQ1uufK6/075s+2KVFq
         tNyc3SBdWRqzkkavFM2xc1Rb/+jgXjfdvRPoQR2CVBleL5qjfmiPutUyBe7BggSXeBEr
         EYVWiaUYPX8khncPF1sUFZc4HOyIIkw2rpLjexj7BG1Xq9FdsY3rlzqmm0CYgR6nqZXq
         ujJtO0bP+6gvrgST4SN5cluYNgSWqyoHNkPl/IsYAtWjlW8erksNg3BmwGbajpKQzkEf
         H7vYhMiZ9VgKeARMRf9G79pJzhhoUydVdDDXBjI5Muh4W5B+/BgaUoBiQ7uRJ07x1vlP
         HxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ln2QeAtMdww/m3SY9I5YlIOJcERTd44ouLoqU89VV7A=;
        b=lHHxICEFu0rrNMaeO+d+smnh8OJ7k2nMYyvRUdLWLj9HjtfSLZt/48NrOjja8pNsqr
         PvYCmr92/Va9TORgfhFgvqTTuZMR9KYfDP9ZTuiek8MLaJntTeQgL6xMSxJF4+iTHtp0
         n0iNYze0wIrtM7cpcF+gsD1jZS32o/UXiWmenDSblEpCKQSLSrzQ/j8C3pbFUvCVNqtD
         7l+4f9TmnNrrwZZ14hgug1wLcG3AmH+vqZq8K7XNLHhVDoLM67bOdtqNYH+34/HdnQb8
         d8bDgBj4GNwUPD8ycUk23CP41ZaFVdb2DLWK1deZsnvzJ0tYyuAP9g/pHOkJvQuti0hj
         X8/g==
X-Gm-Message-State: ACrzQf1e2zkrcRImQrw5ab4VVpnP2AugSTeK/GjJpElpAIYWibPP6VLZ
        IIFvHCkfQZ9ii/5vmebfma34Ll3H9oU=
X-Google-Smtp-Source: AMsMyM5FZsQi/RPOt8ifx9rSxY0vfjMdSZA3pTOdr95IDYeLkkYUWfLhk+9cZjFYCDjWLUMpEzMyPg==
X-Received: by 2002:a17:90b:3805:b0:20d:4e77:371f with SMTP id mq5-20020a17090b380500b0020d4e77371fmr1091271pjb.170.1666062163969;
        Mon, 17 Oct 2022 20:02:43 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a16c800b002005fcd2cb4sm10646945pje.2.2022.10.17.20.02.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:02:43 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 97A0B103AE0; Tue, 18 Oct 2022 10:02:38 +0700 (WIB)
Date:   Tue, 18 Oct 2022 10:02:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Subject: git revert --reference doesn't populate commit subject
Message-ID: <Y04XTl6yWXZv6xk5@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hb4mvZM7Ag0U4CIw"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Hb4mvZM7Ag0U4CIw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When reverting commit with `git revert`, the subject for revert commit
is populated ("Revert <original commit subject>"). However, when
reverting with `git revert --reference`, the subject doesn't get
populated; only commit message is generated ("This reverts <original
commit reference>..."). When no subject is given, the first paragraph of
the message automatically becomes commit subject.

To reproduce:

```
$ mkdir /tmp/test && cd /tmp/test
$ git init && git branch -m main
$ echo "test" > test
$ git add test && git commit -m "test"
$ echo "whoops" > test
$ git commit -a -m "whoops"
$ git revert HEAD
// keep the commit message by just exiting the editor
$ git log -n 1 --pretty=3D"format:%s" -p HEAD
  Revert "whoops"
$ echo "whoops" > test
$ git commit -a -m "whoops again"
$ git revert --reference HEAD
// keep the commit message by just exiting the editor
$ git log -n 1 --pretty=3D"format:%s" -p HEAD
  This reverts <reference to "whoops again" commit>.
```

In the reproducer above, I expect that the second revert generates
`Revert "whoops again"` subject.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Hb4mvZM7Ag0U4CIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQQJRmM4Nl+8BKPNGvtCNk3+7YYOdAUCY04XRgAKCRBCNk3+7YYO
dADrAP97MhNi2ITksRdK4lpUuqyAiGyzSMm7fkVX7lFKrQoFOAD/VAudkHhuvWh4
ChOS1QJpAGRSnPU31Yxm1f9PGMYdxiE=
=powW
-----END PGP SIGNATURE-----

--Hb4mvZM7Ag0U4CIw--
