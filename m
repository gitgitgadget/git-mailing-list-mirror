Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3628CD3437
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 04:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjISEoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 00:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISEoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 00:44:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197518F
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 21:44:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fdd5c1bbbso3739920b3a.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 21:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695098657; x=1695703457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWz9UuSnaU4fiLIgk/V7ZXJ+WjbZWt8OvAQJeZ0cV00=;
        b=m1b9VGvb3oc/8PRRPB3V/pk6vIz6AmpDqHa22V7/xXzns5kJIY/VlOvg4+S6j5Jgi7
         oFfowIhQOxkQQ3JiFQMW93XekxfdA0eVo3qyw0ua0hmwqLMnLbkuI0FcGJtIsJQs6xlK
         WiZAfXlPYC2UVsM6EsxLfBJCqNXEuCijrao9/Mu48iB0uI3eD9rPQqZCkcjTbT7rCzst
         Hxi08qAydDaZoTe6IYl4fzw0lmHq/tYOiVGwiGZERDFLS3g1GU6Z8Pf0zXcLKzLRWPxr
         Q2o/kb5mLes1MWWM9k1kPaBoYiBIQy7lh/GRNzbJoHNozsYF+uhD+6Q0G2i39iYbXDTJ
         C9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695098657; x=1695703457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWz9UuSnaU4fiLIgk/V7ZXJ+WjbZWt8OvAQJeZ0cV00=;
        b=Mg82e1PbENyXffmlfbkdodvOHHxzWoN9Wnzjl6NcwRgmkBSkmf6ysZ3NwzGJhU3K4Z
         0D4gzb8s0MAIekufhCfRFwwWpTw2RGtF+Egmy0G7ESUJweU/lONzuvTTewj5JJk6yIxI
         GtMzKiwYVICnADS3xYKW66FYeSGd81Q0VtSu60I2Msesyz8uPzQjb47xMznDhsRMmPf+
         GYWSFi9z6JI4T727t0l55uCJEPRW+y64CkiG3qehzcaNyPEOcRQLhs7lZuguyRoHW3Qx
         Oqpws4wYpacRGjXiSxEHHjn6dJQU+UnQqKv7zUpEecp3HP+pjX5fggKy9OKBsNGQn0aX
         JV3g==
X-Gm-Message-State: AOJu0YwCEl33kZDbTSBP8kXg1moNsMbHZG58qcKGJLxuN/pVBxeURF7P
        ig2RoS9Atmo6E+oGgE83Q0g=
X-Google-Smtp-Source: AGHT+IFJEEjig013z37R98GsXVjQorrAIHnrAxYZ8QqvHertInxvf+zumwmbtBFBEn3RCwOIt27www==
X-Received: by 2002:aa7:868d:0:b0:68e:2c2a:aa1d with SMTP id d13-20020aa7868d000000b0068e2c2aaa1dmr1785246pfo.11.1695098657405;
        Mon, 18 Sep 2023 21:44:17 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78e10000000b00682669dc19bsm7803382pfr.201.2023.09.18.21.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 21:44:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 735EB81B96CD; Tue, 19 Sep 2023 11:44:14 +0700 (WIB)
Date:   Tue, 19 Sep 2023 11:44:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
Message-ID: <ZQknHjKdGZV3vJpV@debian.me>
References: <ZQhI5fMhDE82awpE@debian.me>
 <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JWm9GDNqPXLF7usH"
Content-Disposition: inline
In-Reply-To: <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JWm9GDNqPXLF7usH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 04:26:44PM -0400, Michael Strawbridge wrote:
> Hi,
>=20
> Author of a8022c5f7b67 (send-email: expose header information to
> git-send-email's sendemail-validate hook, 2023-04-19) here.
>=20
> On 2023-09-18 08:56, Bagas Sanjaya wrote:
> > I triggered this issue on patch series with cover letter. To reproduce:
> >
> > 1. Clone git.git repo, then branch off:
> >
> >    ```
> >    $ git clone https://github.com/git/git.git && cd git
> >    $ git checkout -b test
> >    ```
> >
> > 2. Make two dummy signed-off commits:
> >
> >    ```
> >    $ echo test > test && git add test && git commit -s -m "test"
> >    $ echo "test test" >> test && git commit -a -s -m "test test"
> >    ```
> >
> > 3. Generate patch series:
> >
> >    ```
> >    $ mkdir /tmp/test
> >    $ git format-patch -o /tmp/test --cover-letter main
> >    ```
> >
> > 4. Send the series to dummy address:
> >
> >    ```
> >    $ git send-email --to=3D"pi <pi@pi>" /tmp/test/*.patch
> >    ```
>=20
> I tried to repro this today on my side.=C2=A0 I can repro the error when
> using the address "pi <pi@pi>" but that's not a valid email address and
> so one would expect it to fail in the extract_valid_address_or_die
> function with the error that you mention.=C2=A0 As soon as I make the add=
ress
> valid like "pi <pi@pi.com>", git send-email no longer complains.
>=20
> In your original case, are you trying to send email to an invalid email
> address?=C2=A0 Is it an alias by chance?

I triggered this regression when I passed multiple addresses separated by c=
omma
(like `--to=3D"foo <foo@acme.com>,bar <bar@acme.com>"`, but somehow I manag=
ed to
reduce the trigger to one address only (in this case, "pi <pi@pi.com>"). As=
 for
multiple addresses part, let me know if I should post another regression
report.

--=20
An old man doll... just what I always wanted! - Clara

--JWm9GDNqPXLF7usH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZQknEQAKCRB7tWyQc2rT
CIw2AP95pHliLH1kUEw40Gv7vJ6V/Es6LiW1v5F1E43MhWscVgEAmqlv4wnAUlmN
kAhHp9Rtb1GSe7bvFbzw+YB1f9mUcQY=
=nQ1R
-----END PGP SIGNATURE-----

--JWm9GDNqPXLF7usH--
