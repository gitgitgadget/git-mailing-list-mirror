Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8269BCD6E71
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 13:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjJKNlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjJKNlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 09:41:37 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F53A4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 06:41:34 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af86819ba9so4503690b6e.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697031693; x=1697636493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0BkZW2cgXNC2CxvFJFtNyDpDI3HyAHcW1lvu65TFa0=;
        b=AzXrsZbtqqCJOySUCqFoKrGUE7CnegO2T8Tcj6BaHf2hhmX4mwE+oYx5FYt0tlHoYx
         sUNr9j9mjGaAhNLLie+HV2T/VQ8/FmSF6R9du8qGoAZy6ndKcKz17kpP/N9RWiPGyJBR
         inQR1Eqal5bKu58viP97u12OuwktWCyJJRYE7UjyZPk88bo0M1LWpR/mfHKYojmlC6gP
         BtmSQxdT4Dqhgt1NGW6s0YQP0Db0O596qzIWgI05hozC66U3FlPUfIUW6Vc30tlb69V9
         Tuvp3MLzEQr7klQq2Ny0Yz5vQgXjDxBGQ3W0vZLhX/H35ZAg85mAl5hElPhG8ftl478P
         +sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697031693; x=1697636493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0BkZW2cgXNC2CxvFJFtNyDpDI3HyAHcW1lvu65TFa0=;
        b=soX0rJgpF+VpotrTz6eCWsDRwZJqlI7f3Sz5I7ggNi6fHGlmLcK+9easMpIDAjfMjf
         aNbGTCLi3N7HsTNLt0PDMC85U9kwD9K19uFll2bHv8Up9Z8RITpIBSbfK3QXkTc/W2BT
         lMxydbT8ImJaHreb3Oz11DU7gLMxAiX6Jpe4vGikI40t3LsE0uJjVzCdSv5ktzMsL848
         1Jv2FjZS+U/WpDwV37DgTMP4dyv2nB5lttGUpwT/3ybwUX138CHi4+6ScUZnpNrdboFF
         Yqk4LcueCLyP+NZ9V8hhnzyal5Y8W3b5tT7lwKDv3cO+4SgKYuFYNOouQd9r16pjTepP
         skgw==
X-Gm-Message-State: AOJu0YwtbbdIZLmNksV6/sAysuKhluR2ZqlMRWnNXvtfaDe/kz9C+29t
        HwC/Wkx4bfjZkMYHiBP2934=
X-Google-Smtp-Source: AGHT+IH0OEf1tJ/yFla2UmmM4NSEsHdgPV/iz62MgMwYaB/8CrAJDy/nUdJKeOF12Rouz9EAA+BMbg==
X-Received: by 2002:a05:6358:4188:b0:139:d5f0:c027 with SMTP id w8-20020a056358418800b00139d5f0c027mr20093702rwc.30.1697031692204;
        Wed, 11 Oct 2023 06:41:32 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e19-20020aa78253000000b006950032f0c9sm10107220pfn.84.2023.10.11.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:41:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4529381BD510; Wed, 11 Oct 2023 20:41:14 +0700 (WIB)
Date:   Wed, 11 Oct 2023 20:41:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
Message-ID: <ZSal-mQIZAUBaq6g@debian.me>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pydDo5xg4OE4IEiW"
Content-Disposition: inline
In-Reply-To: <20230925161748.GA2149383@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pydDo5xg4OE4IEiW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 12:17:48PM -0400, Jeff King wrote:
> On Mon, Sep 25, 2023 at 10:48:29AM -0400, Todd Zullinger wrote:
>=20
> > From the peanut gallery... could the presence or lack of the
> > Email::Valid perl module be a factor?
>=20
> Ah, thanks! The thought of differing modules even occurred to me, since
> I know we have a few optimistic dependencies, but when I looked I didn't
> manage to find that one (somehow I thought Mail::Address was the
> interesting one here; I think I might be getting senile).
>=20
> With Email::Valid installed, I can reproduce with just (in git.git, but
> I think it would work in any repo):
>=20
>   $ echo "exit 0" >.git/hooks/sendemail-validate
>   $ chmod +x .git/hooks/sendemail-validate
>   $ git send-email --dry-run -1 --to=3Dfoo@example.com,bar@example.com
>   error: unable to extract a valid address from: foo@example.com,bar@exam=
ple.com
>=20
> Disabling the hook with "chmod -x" makes the problem go away (and this
> is with current "master", hence the more readable error message).
>=20
> I think the issue is that a8022c5f7b ends up in extract_valid_address()
> via this call stack:
>=20
>   $ =3D main::extract_valid_address('foo@example.com,bar@example.com') ca=
lled from file '/home/peff/compile/git/git-send-email' line 1161
>   $ =3D main::extract_valid_address_or_die('foo@example.com,bar@example.c=
om') called from file '/home/peff/compile/git/git-send-email' line 2087
>   @ =3D main::unique_email_list('foo@example.com,bar@example.com') called=
 from file '/home/peff/compile/git/git-send-email' line 1507
>   @ =3D main::gen_header() called from file '/home/peff/compile/git/git-s=
end-email' line 2113
>   . =3D main::validate_patch('/tmp/WfoPQSKCUa/0001-The-twelfth-batch.patc=
h', 'auto') called from file '/home/peff/compile/git/git-send-email' line 8=
15
>=20
> whereas prior to that commit, we hit it later:
>=20
>   $ =3D main::extract_valid_address('foo@example.com') called from file '=
/home/peff/compile/git/git-send-email' line 1166
>   @ =3D main::validate_address('foo@example.com') called from file '/home=
/peff/compile/git/git-send-email' line 1189
>   @ =3D main::validate_address_list('foo@example.com', 'bar@example.com')=
 called from file '/home/peff/compile/git/git-send-email' line 1348
>   @ =3D main::process_address_list('foo@example.com,bar@example.com') cal=
led from file '/home/peff/compile/git/git-send-email' line 1091
>=20
> So the issue is the call to gen_header() added in validate_patch(). We
> won't yet have processed the address lists by that point. We can move
> those calls up, but it requires moving a bit of extra code, too (like
> the parts prompting for the "to" list if it isn't filled in).
>=20
> Possibly the validation checks need to be moved down, if they want to
> see a more complete view of the emails. But now we're doing more work
> (like asking the user to write the cover letter!) before we do
> validation, which is probably bad.
>=20
> So I dunno. Maybe gen_header() should be lazily doing this
> process_address_list() stuff? I'm not very familiar with the send-email
> code, so I'm not sure what secondary effects that could have.
>=20

Michael, did you look into this since you authored the culprit?

--=20
An old man doll... just what I always wanted! - Clara

--pydDo5xg4OE4IEiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZSal6AAKCRB7tWyQc2rT
CL4yAQDxJRYhzZyCsQibZxdhTmnDgmtzhZBJn62dhTzBLwvZqwD/VjYe9xs5TZD2
phdHRSSbgwixP0WvRc4CKU5OJGlP8g8=
=yezc
-----END PGP SIGNATURE-----

--pydDo5xg4OE4IEiW--
