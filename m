Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9C1C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AC5610FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344835AbhIGO6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhIGO6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 10:58:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDE8C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 07:56:57 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t35so8149472qtc.6
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version;
        bh=w1K7c3dN+QJ6QVm3U3Bw1k/mDkpS+L+AOuEIb+Z5fm8=;
        b=f8gAyIQSBk1CzUgI0NmtxqC4/d/7SV6XkHThlepomntvWs/Y6FJPMwbjveHAf3ES3d
         kY40Mne/QQyo5uSpqqM4PVKT8PEcIAVUgmzIK623QyDAQjTatEi/3bGQenyRKHYu8Qkx
         Y+NC8/8Wg9U8XcT8+Gu6zsmae6Zy0I2yndNN0Dit4nIVyh90shUKhAi6mFAkDWljM1G6
         oSveKJ775fUPrmhFE+xs/ohdJ15wixEPzayb2UYTzuGkxyLnC5ZN98a5YcSQ9FaMEaHL
         EFU/T6zh8E8oloOj5uEAXf81whmqPNk9+9QgV/3CoesqTdhjcrefmKbhU94rD9iFwuTt
         Ozgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version;
        bh=w1K7c3dN+QJ6QVm3U3Bw1k/mDkpS+L+AOuEIb+Z5fm8=;
        b=ha5v8+PPIIXNUFuJJewOLJY5hGzSP4H0cfjZZ25bwr76VnzNq0HO/oZ2tyvRuKFCLB
         PilVu2BcMI7+K1qAx1Klt7OwbTTeaV1OzmsrJkZMiMkq7is+d3ZP/9zhhRx6vcgatT6y
         3cRYihVofzD5khqCC2jb1nGnoP+gLolZt5B5AMtSqWq1lgs80QEC9DyNmGgFJMTLHTsH
         bzvz+VZMjsEcjNKRSIJEPQq+WTJo0E0+u7cjGSPKHePwtIwE0xnrw6aOpKY9HC/cK3dm
         zM4dbMdmw4ZkLoBIBxT5iWvG/7jeFi44j2b3AavsOOaoX4EMtivveYUaAJZlxY0QDG2M
         TU9Q==
X-Gm-Message-State: AOAM530rvOST2OhEnLQRA1qrthVNgdD11WNqWb/9UamTPBvXvng8+GgN
        8NRgDMwqUxfj+yG1MdpE+Rfpj4tG8QlnzA==
X-Google-Smtp-Source: ABdhPJybQrdGFDBhqf3DqHr4Surp/qzrzrsOYoBTb4ucFhXLcqr5Ui7DBZDM9PksEtV99J9SxZ1ISA==
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr16271557qtw.242.1631026616465;
        Tue, 07 Sep 2021 07:56:56 -0700 (PDT)
Received: from [139.147.217.39] ([139.147.217.39])
        by smtp.gmail.com with ESMTPSA id p187sm9016829qkd.101.2021.09.07.07.56.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:56:56 -0700 (PDT)
Message-ID: <fd7b8c130d9220b3871f2aecfe80b8d342d6deb0.camel@gmail.com>
Subject: Re: [PATCH 2/3] Die if filter is attempted without a worktree
From:   Calum McConnell <calumlikesapplepie@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Tue, 07 Sep 2021 10:56:54 -0400
In-Reply-To: <87lf49nye4.fsf@evledraar.gmail.com>
References: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
         <20210906181002.625647-2-calumlikesapplepie@gmail.com>
         <87lf49nye4.fsf@evledraar.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-TKGKY124TQJZA3PLEfCE"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-TKGKY124TQJZA3PLEfCE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-09-07 at 00:09 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:
>=20
> On Mon, Sep 06 2021, Calum McConnell wrote:
>=20
> > As far as I know, this isn't possible.=C2=A0 Rather than add a bunch of
> > code to workarround something that might not be possible, lets just
> > halt and catch fire if it does.=C2=A0 This might need to be removed bef=
ore
> > the change goes into master
> >=20
> > Signed-off-by: Calum McConnell <calumlikesapplepie@gmail.com>
> > ---
> > =C2=A0convert.c | 5 +++++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/convert.c b/convert.c
> > index 5d64ccce57..df70c250b0 100644
> > --- a/convert.c
> > +++ b/convert.c
> > @@ -646,6 +646,11 @@ static int filter_buffer_or_fd(int in, int out,
> > void *data)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sq_quote_buf(&worktreeP=
ath, the_repository->worktree);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dict[1].value =3D workt=
reePath.buf;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The results of a nonexist=
ent worktree could be... weird.=C2=A0
> > Lets avoid*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if(dict[1].value =3D=3D NULL=
){
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0BUG("There is no worktree for this worktree
> > substitution");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> This BUG() addition is itself buggy, elsewhere e.g. in builtin/gc.c you
> can see where we have conditions like:
>=20
> =C2=A0=C2=A0=C2=A0 the_repository->worktree ? the_repository->worktree :
> the_repository->gitdir;
>=20
> I'm not bothering much with the greater context here, but if we suppose
> that we have a case where worktreePath.buf is NULL, then
> the_repository->worktree surely must have been NULL, and if you check
> what sq_quote_buf() does, you'll see:
>=20
> =C2=A0=C2=A0=C2=A0 void sq_quote_buf(struct strbuf *dst, const char *src)
> =C2=A0=C2=A0=C2=A0 [...]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while =
(*src) {
>=20
> I.e. we'd segfault anyway if that "src" were to be NULL.
>=20
> Even if that weren't the case then that's not the same as the
> worktreePath.buf being NULL, which even if we suppose sq_quote_buf()
> won't segfault and just returned won't AFAICT ever be the case, see the
> comment for strbuf_slopbuf in strbuf.c. So I think that even if you
> somehow reached this with a NULL worktree that BUG() won't ever be
> reached.
>=20
> I think this can probably just be dropped, to the extent that we need
> some check like this it seems like it should happen a lot earlier in
> convert.c than here, i.e. during the early setup can't we detect & abort
> if we don't have a required worktree?

Part of the reason I inserted this check was because I wasn't sure about
the ordering on a checkout into an empty directory (eg, would there
actually be the filter script when it ran?).=C2=A0 On deeper thought, howev=
er,
that problem wouldn't even be solved by this.=C2=A0 Not to mention how you
would need to include the script on the initial commit, and such.

Since the check doesn't even do what I thought it would do, I thought of a
better approach: rather than having it expand to the working tree, it
expands to the git directory.=C2=A0 This means that you can place your scri=
pts
in a much better location: since .git/config must be modified anyways to
use a filter, it doesn't entail a loss of features.

Why I ever thought to use the worktree is beyond me. Patch V2 coming in a
few days.

Calum McConnell


--=-TKGKY124TQJZA3PLEfCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE/vC/PEGxsMPJ5u5w7/Xh1+DNmzIFAmE3fbYACgkQ7/Xh1+DN
mzItHRAA5rtfJoxrsiQjt1idbXL8su0yS3wDu6H20cE+17WPXhEOJorVxYDUh7wC
+DXQucbi3doWqpMrKmzc4T8vP7i6akaUYb4NQY8SnCpW0twhuRRgJPyRxwuP+WOA
eLPWCiQ68Du8J2RRRKOmFsE3rBPlccPM8E843gQj6L+7DalYLBkB4k1xxqZ55DHi
mARE6N0TnetnIzqIG8jskA6q5sk1bOBw4Gqwc4zlNJWNZEIe6AjpPYp2aJTa6luL
uAXgKhx+D5Ye+GD9KD8iajb5U2zADIuhsnPLbnaeBv7gTLSFmdQbLbHAZY26UD/b
K/652HIFEnQvQrckO1q9MoG+Q4zDKybA9jKduVN6ea9hojfOoTQDnxErMU0dZguU
zOFMTXE6/dt+czknlZBl/3uv910l/WJS9tLML4UPYwEA29W8d9SCsdNlMW7khhCf
2ee9Ff0OsVrNNKE7WWBoMNqQGxitqQp/HmjeMglUFMIAwEUW7t394aHRWC2s1ihW
N94rSGjDBuP1HvLetYyHPmucdMXLmIMeHt+2b3ksacoxWcdvw9VpTH9Xt6WWaqXL
JYw4Z6Isn+NnT8/S8x85ffpRAYU1q/RhXnkX8A9lO1Efz9RFzpzmnMVKNhHsk7uO
JadWD2dCtKdMRXm+ZyZXAdid+UFMng+lY+1EVBgdE41WY4Gob2o=
=o4kZ
-----END PGP SIGNATURE-----

--=-TKGKY124TQJZA3PLEfCE--

