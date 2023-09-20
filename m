Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B926CE79CB
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 11:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjITLAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 07:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjITLAM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 07:00:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3DD3
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 04:00:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c3d6d88231so53435225ad.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695207606; x=1695812406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84q4NYYOqeXVbgE3FrDrEWbjogbGEPkb0ofg5tOQpDo=;
        b=iAimu853DWlOXKPBgYxRqoBupUyX0YDacf33WKNjg06G/yVr6x+Xn3Tr8WYnUFuAjA
         /Feq52Ey97YPImSAJ0++Djid+zYL28Tunb5dolaPjCv0onY87DOnne462xy6E1oBzcxj
         KTualdU9sH7XUG/pPDOloCtMfGsFS8QI8J9cvi4HEMEgBBj8463IAV4aC+1HnodIt8iU
         OmHR4OglNbUk4bTAbi//yriMr+1+qkeNBdwBJtY6H/7w0iPNUYdiC3gDDxfkNv+mYXqO
         B56h7ElhkY3ux6QIpA2ghHIA9csWTTxBzd/iRqguZ0Vi990BQADJZ26eo9xKcwr9BlFF
         5G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695207606; x=1695812406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84q4NYYOqeXVbgE3FrDrEWbjogbGEPkb0ofg5tOQpDo=;
        b=j/O+9UxWbN3cz5DM1oZSBJbDlYsEZ9UVj9nWmTh+y5txc3LLkeh7CQnZV1sB/Mguqx
         bPSYuFthI9r3do5OGLJLsOB3caqs/FlXUuxDQeN/fpUVE7vplUqqLPBfiEn4w4JTveKM
         2O+KfxwaE19yULE+rlVxKIsPiMfc78dpFCVROxmm4oJvWbeHUQ1BAvUxyRNuN9JHi3we
         v7uM+9BlauXwoj1FvuXLgI0bABb1FRVhuojkDprSMSFeXXiZ8uzs6uO+zU3bZ0ri3L6B
         a3lVzeiFAzlBzQupNBBEXhC8UJ7LAflL99NXjcBsNqjwBGyyz60P7xMzsWPWH5MjY90U
         fc7w==
X-Gm-Message-State: AOJu0Yzju08mu2TBh/yzaN0ZKZkE9zoK9iS1bt5JWycavhQK3+7nxIuD
        rpU7sPhWoxYqQVT5qHMTGPE=
X-Google-Smtp-Source: AGHT+IFwsK5Nt4BNQVvCykORd85rXPNvIcP3Fos2aPtb+uLqAw3t45RDpSnxsSVStWGspa7zc55u5A==
X-Received: by 2002:a17:902:d2cd:b0:1c0:d17a:bfe9 with SMTP id n13-20020a170902d2cd00b001c0d17abfe9mr2526644plc.46.1695207605706;
        Wed, 20 Sep 2023 04:00:05 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001c44dbc92a2sm7882536plw.184.2023.09.20.04.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:00:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2686681A3119; Wed, 20 Sep 2023 18:00:02 +0700 (WIB)
Date:   Wed, 20 Sep 2023 18:00:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
Message-ID: <ZQrQsa5GJEVhBttT@debian.me>
References: <ZQhI5fMhDE82awpE@debian.me>
 <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com>
 <ZQknHjKdGZV3vJpV@debian.me>
 <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
 <118975ef-c07f-c397-5288-7698e60516a7@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LfZiYMTcSqmnUrtM"
Content-Disposition: inline
In-Reply-To: <118975ef-c07f-c397-5288-7698e60516a7@amd.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LfZiYMTcSqmnUrtM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 10:37:36AM -0400, Michael Strawbridge wrote:
> I suppose I may have mistook what issue was being reported.=C2=A0 I had
> originally understood the problem to be that hook related logic was
> failing with correct email addresses, but it seems rather that we are
> trying to fix an error that occurs when an email address that fails
> extract_valid_address_or_die() is given.=C2=A0 Feel free to ignore my last
> email if that is all we are trying to solve.
>=20

Originally, I was intended to report regression on handling multiple
addresses passed in a single --to/--cc/--bcc option. Previously on Git v2.4=
0,
git-send-email(1) accepts `--to=3D"foo <foo@foo.com>,bar <bar@bar.com>"
as two separate --to addresses (with comma as separator). However, on
v2.41 and up, instead I got perl error as I reported in this thread.
Interestingly, that perl error can be reduced into one invalid addresses.
The same thing also happens to --cc and --bcc. I used aforementioned
trick when I was sending patches to LKML to save frin typing the same
option multiple times, each with different address.

If I need to send separate regression report for above use case,
please let me know.

--=20
An old man doll... just what I always wanted! - Clara

--LfZiYMTcSqmnUrtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQrQrQAKCRD2uYlJVVFO
o7/FAPwJR4h5GBs0M6nQwlIiyyTdINEc6YV7DzcB1jKBhCKpxgD/aTxAFDXvf/7u
tQIf1twsLNs+12i/AMUz6y6LIKsYww4=
=P6/x
-----END PGP SIGNATURE-----

--LfZiYMTcSqmnUrtM--
