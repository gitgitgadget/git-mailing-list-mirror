Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0872FC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 16:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C346122B40
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 16:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbhAWQVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 11:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbhAWQVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 11:21:09 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146AC06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 08:20:29 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id l14so2141250qvp.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version:user-agent;
        bh=UJ/qdB1/SOOaZGlYrPiu2lfjFaM34x4346/MF7LzNf4=;
        b=X9itjIa+/D+yEj1fetO97YRHWYqPU5aSjgsTv7ME/Q3Q8CHUV/b5jdtmDwSkDRDgTa
         qRWQ490fCuF+LuZTv5li2odnpUk0YI11TmY74jkwAmfc3QPaIkkTtd67ZuCBbyQA7J1p
         xxD/QMz6Ko3S9fhBxVDklP783+eOPKzhU+73oUMgLDiK88lyrt+433DnT3UG2TBcQjb4
         Oxlsl4N35utKddaDDdCv8+ST1+Ro0FwjA3ysWJ2ako+B/wEkcPc+9Pp7BG7UrX5fRBkF
         KBPp4hAYzrbsTB1hLGoxk0btg2dplFlOyAH4VGSis7/gFDt0Zl0PyhBMFTPyV0Ph5hxb
         inWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :user-agent;
        bh=UJ/qdB1/SOOaZGlYrPiu2lfjFaM34x4346/MF7LzNf4=;
        b=FFwWtj6HzJq+7i080nL5vYmHJJidVN1GpHuyxiFEcDDMISgB9NkZyOSxCZCAau+cL3
         pA81Avnm0kYp8Arrld2bOZpH4UMgx7nVfbgIPwv6ey2QiyRExO/x9fzSpcKGkYR0gjrZ
         BowjpyHYcIfWXuxPmJ0kMwUEI0t8xPET6tPP7Bk3BNKvrYyRXEQ6nmfhKzLyYP82dcvz
         I/95PNVLdhf0dG0aNAQsGF+4WnEWPeNHOS3NA5iOZ8r9Ip3wn9IcEjApIZDpqfabNkw0
         vJKGwBrRt5nG0MAoSwwbEGKU9FL9Hks50ceoM45VgnXsRzUARMKqX/rM5/bZjAKPhNCg
         eAGA==
X-Gm-Message-State: AOAM531DJvhjvNV7L0A+QdhXO+LLkrL1OM0va+MXcyiBtPEjbBgFJ+hF
        aHwAqcR9e1k7dldl3pg7toUERyeHxjAQPg==
X-Google-Smtp-Source: ABdhPJyftWx8YlsR202FOf/l/t0i//CN0tfwAmkC7uqOnFZyea4BFMLJpYAnHHIUr1tl6geYUeYnLA==
X-Received: by 2002:a0c:e4cf:: with SMTP id g15mr727286qvm.23.1611418827949;
        Sat, 23 Jan 2021 08:20:27 -0800 (PST)
Received: from ?IPv6:2600:8805:d480:eb70:192:442e:dbb0:9a27? ([2600:8805:d480:eb70:192:442e:dbb0:9a27])
        by smtp.gmail.com with ESMTPSA id u5sm8605287qka.86.2021.01.23.08.20.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 08:20:26 -0800 (PST)
Message-ID: <508da412f239180b3cbfff4f676cc0072d04cd93.camel@gmail.com>
Subject: gitattributes filter: add new %r that expands to repository root
From:   Calum McConnell <calumlikesapplepie@gmail.com>
To:     git@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-R9okPeogc8g95SOk8YHZ"
Date:   Fri, 22 Jan 2021 12:11:25 -0500
MIME-Version: 1.0
User-Agent: Evolution 3.38.2-1 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-R9okPeogc8g95SOk8YHZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git Maintainers,

When building content filters with gitattributes, for instance to ensure
git stores the plain-text rather than the binary form of data in certain
formats, it is often advantageous to separate the filters into separate
scripts.  However, as the $PWD where content filters are executed is
unspecified (at least, unspecified in the git documentation I could find),
so the path to scripts needs to be specified as an absolute path.  That
means that the guide for setting up a repository which uses scripts to
filter content cannot simply consist of "copy-paste the following lines to
your .git/config file", and it means that the otherwise safe operation of
moving a git repository from one folder to another is decidedly unsafe.

To fix this, I propose the addition of a "%r" sequence, similar to the
existing "%f", which expands to the repository root (as opposed to the
path of the file undergoing filtering).  This would enable calls to
content filter scripts to be (for instance) stored in a root /scripts
folder, and the git-config value to be "sh %r/scripts/erase-all-secret-
plots".  If backwards compatibility is a serious concern, the sequence
could only be expanded if it occurs at the beginning of the first two
words.

I believe that would be simple to implement, and would be willing to do so
myself, but wanted to get your views first. =20

Another useful addition, but one that would be less simple to implement
would be the creation of a way for a set of default keys to be added to
all repositories that clone from a certain remote.  This could take the
form of a .gitconfig-defaultkeys file in the root of the repository, which
is appended to .git/config on clone, if there are core structural reasons
that prevent a configuration file (even one with a restricted set of
permitted keys) from being included in the tracked repository itself.

This is my first message to the git mailing list, so apologies if I
did/said something wrong/stupid/obvious! Please give me feedback.

Thank you,
Calum McConnell


--=-R9okPeogc8g95SOk8YHZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE/vC/PEGxsMPJ5u5w7/Xh1+DNmzIFAmALBzoACgkQ7/Xh1+DN
mzJBYxAAi1nZ2kEukRs2fKh0J+M/hVGSoHpnSAxnyuiArqfGm+J+cK1bherP6Yer
Zz4U5a+Vs2Pz72+rd9hgWq8re9F1OI3kgzh3b+SBq0rAy3IhigJHLBpNwdyQoMwn
iU3sFdo4hav/PLVDftNpPQGgtd0rt5mU8qhpZTUrJemqnyWGHmcwmCMHEYP87tyh
SxxZFYl+eyDeMzhbt7z+GE9XO8fdm+5NQA3l3L9YiPyq08DFGJlBPIl6LbF8R2B0
49rqukiSEnnkyCOuTPtWjmlVo7QpfWc0BGiQ2A4fTXf+6gnac0TrgqSQJ/QYWibJ
49duLUZ5LvwoNjSsgXbOfB6FUT8rUmJU4hbRZosTLe/xAGdjfjvS0ZFB+kALlYfu
oYdmqlpymtSuhnRuhFBZhXsL5vccB1mQgw7jnf35s7HLM59t3v2/EumZYWB0MWJR
be/s9TrvKFNayDeZsZaqo4wJncxVb/V+R9Pgl2fxZ1gAEucgc/APKD6BSSHVqZqs
U6NePBTm+PL7aCACXXKvz5ibCF7N51HtoI2T3Mlzx/kGfWMpsdVTOajJMC8WXDUT
PMUseYXqp0EFIeR4MZL+vyovMUBA0iFyih4m3XznYd/IbcbTc9KyxNtCdwtc8jK1
4C/83epyYNbKJ7Zc4s8+DkwJ2qr5PB08DCf/s+sdKxeo9n+ax+U=
=1qo+
-----END PGP SIGNATURE-----

--=-R9okPeogc8g95SOk8YHZ--

