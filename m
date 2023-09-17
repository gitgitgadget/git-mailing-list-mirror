Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F3CD37B4
	for <git@archiver.kernel.org>; Sun, 17 Sep 2023 09:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjIQJ6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Sep 2023 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjIQJ61 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2023 05:58:27 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0234118B
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 02:58:22 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c0b3cea424so2282240a34.2
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694944701; x=1695549501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mN0TZX6pP64IEfwOzKN2Wyy4eiMPdInaHLMHAlxUzJE=;
        b=Dz9esI1xwgblf8KTqs78n+Q9jMGb7tewS6k68kInHPx6JamVBPbneygKGEzcPuUq0L
         T7LRfsIJ2ibH/hbJ5RIuFFgj6fJhi/Gm6pxsFucHv4K+nbo/NIPIm+c0b6AY/uFD7XQC
         mmFWc2yzAYzKYgLta+slX+r2TANG6LzBCcyrgIeM0T1YU2QpyfOQSb580TAEbk84r+96
         5UYLn8nvqzJrF/2+xXCi8S0V3IaVhMgQidRlfKGVo9wOlN97ouz9p372RTnC6diuMa6k
         IqfmI2PFOjdhmw7OUcM/BJNEJxnGWDJIG6PxfZTe/oMX1IzHxYvBKLomhpW4ts9vMTq3
         r5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694944701; x=1695549501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN0TZX6pP64IEfwOzKN2Wyy4eiMPdInaHLMHAlxUzJE=;
        b=uc8nsGppjhUmYaagPaonQZVbdvvX7uIdJsAOMbgQZcBW8IC1zFl4YRgkz/elBOSR4c
         E8l9jNyGa+DRpJG3GrEBVb+aidZ8m2FXrZETeb8nH/n1ImWrUqLyJqcyZMSUZBQvzrFe
         ywJkMdIV3H55oWvYxqnD/q+aMFlmAqwGhctdswg2pWfJAv7tN3W62tlX3GDQgw8eOXN/
         ocaDSoVsiy73zu18WJGZ3Onl4ne7zEd/NmsilIk7XLlP0F8SBcx4Hix79Thfye2XKZwn
         jXvxfHGzS/oCppKHPFuaCl1Qyl3JhRaFsgRs57wETDiW22/1uKhZmmjqmO38RICd/2TS
         gfOw==
X-Gm-Message-State: AOJu0Yy+l6rZM4ZglpEeLC2NWRBkov6/sIi30JVcAeAlzvWJaYtrHxvp
        yj+MSihX5W/0KaANNlYSbHEg4UnygBY=
X-Google-Smtp-Source: AGHT+IE882CcZk1yBEAqS+W02xFnDWUC7DDABP9Kw11OSrru9wSTfp4BMvNH/YKAI+NmSQ8VBFUFLA==
X-Received: by 2002:a9d:6d96:0:b0:6bd:152f:9913 with SMTP id x22-20020a9d6d96000000b006bd152f9913mr7199034otp.29.1694944701253;
        Sun, 17 Sep 2023 02:58:21 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t13-20020a63954d000000b00564be149a15sm5096073pgn.65.2023.09.17.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 02:58:19 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9066C81B2E83; Sun, 17 Sep 2023 16:58:15 +0700 (WIB)
Date:   Sun, 17 Sep 2023 16:58:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Magnus Holmgren <magnus.holmgren@milientsoftware.com>,
        git@vger.kernel.org
Cc:     Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: Please explain avoiding history simplifications when diffing
 merges
Message-ID: <ZQbNtgd82iARQ39D@debian.me>
References: <3337579.YDm8p7mPUg@utklippan>
 <2250343.okVFLFBGsW@utklippan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nUof6ZrtP0LBIQGj"
Content-Disposition: inline
In-Reply-To: <2250343.okVFLFBGsW@utklippan>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nUof6ZrtP0LBIQGj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 05:10:28PM +0200, Magnus Holmgren wrote:
> Friday, 8 September 2023 11:09:20 CEST, I wrote
> > QGit was bitten by
> > https://github.com/git/git/commit/0dec322d31db3920872f43bdd2a7ddd282a5b=
e67
>=20
> Maybe I should link to the QGit issue:
> https://github.com/tibirna/qgit/issues/129
>=20
> > It looks like passing --simplify-merges to override the default solves =
the
> > problem, but I still want to ask here because I'm not sure I fully
> > understand
> > the reasoning:
> > > the default history simplification would remove merge commits from
> > > consideration if the file "path" matched the second parent.
>=20
> As I wrote at the above URL, I realized that the old git log output witho=
ut --
> simplify-merges and the output with --simplify-merges aren't quite the sa=
me.=20
> The old output indeed omits some interesting merge commits, which may exp=
lain=20
> why the change was made, but git log --simplify-merges does include them,=
 so=20
> it seems a reasonable default to me.

Can you provide examples?

>=20
> However, QGit has a problem: git log --diff-merges=3Dseparate includes a=
=20
> separate diff for each parent, but only for each parent with differences=
=20
> compared to the merge commit, *and* there's no custom format placeholder =
for=20
> the current parent, only for the list of parents (%P/%p). How should one =
go=20
> about adding that? I figure the format_commit_context struct in pretty.c =
needs=20
> another field.

What are you trying to accomplish with your proposed formatting verbs?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--nUof6ZrtP0LBIQGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZQbNsAAKCRB7tWyQc2rT
CJqfAP9WFedX2PDjX/3ATU8E+cfAspj9LRD3HJsyJN/fMXKw8QD/beWN0RvNsDEE
wNta7+JknRAA34/tJVhZY59c3ycZ7g4=
=56lF
-----END PGP SIGNATURE-----

--nUof6ZrtP0LBIQGj--
