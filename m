Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36BBE7F14B
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 00:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjI0Aon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 20:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjI0Aml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 20:42:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0E583C0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 16:57:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27763d36661so3790093a91.3
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 16:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695772673; x=1696377473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RyniuIFTkJ1Ap5ypLkry8ImhOE/2TxRwEm92imIJCs=;
        b=ZqIa9+YdvzkcYgJwS658qthpuiAIDbR05KzFEt+U3sjgj5F9VL8JPbMeeORPtKwfWP
         wu79GC5Wx96alOL5/yMqC1oOoIhU7MQ5wKNmbduAjNFpStbRrU6tCzac/h7gRFQ2Achq
         pKa9rIJxkvT2J+A6prGWZh7LZeu7H3TDHrS92wVBVLXcn7tD1VJ5ALeUqhS5VSiOKdx2
         3fiauQ9bkAXnWHvQ7oYrNSOIi9dwZOmKrjHYmD8lFyxdd2gxk+cDvv2DEt/DO1j9K5Lh
         rM1TZGlCTmGUI4AYF8S79rnQGpqAUWfnoXZ4sGT0J+WR6k3A0fGyhzjTDgLXtKfBuizQ
         U4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695772673; x=1696377473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RyniuIFTkJ1Ap5ypLkry8ImhOE/2TxRwEm92imIJCs=;
        b=I0Gzh3xfFMekYjp0IjEczP8+AfQvg6RKavkIMKZQqkpd7kMUU4IHpDizEsbNl4kXGw
         Ru6kDp0oznjrXS61zb0ofK62xW1KuL8J7IcJd0EpVl4OKu63emMHnh+jWX5XFQMJO+E+
         FWRY4OqTM/Of71RnSX24rQUi0e0Y/1Ym4fRORli255pd5Uch0HRaO08RMc8Sfk8ynfFL
         rF2bEpvMsGDdzjCyvBE+KoDDmGZBZFfYjETNsgA2TqltKS9cCJQ3JnRaHuwJXnCAlcsd
         qur4kcWtFEhBg1m+lfWdV5ZuhgSfnbp6IarKaHLFtG7FeYAxUw/HGIMU34Br2oJpvrLr
         MymQ==
X-Gm-Message-State: AOJu0YyMjkQHwWbvStUfYl+q59oH8lkpkKgb27iKFT4PvtzqgvFGIRYT
        ExcyK5+WGKf4mgIpYHy1q3k=
X-Google-Smtp-Source: AGHT+IG7fpGxzyhwSSIafNG3w1OF1HBYHb5pzAeQJLerZ++yEvrmnLfgaDcTmv/rJp92OTneLI1fxQ==
X-Received: by 2002:a17:90a:7106:b0:267:70a8:abff with SMTP id h6-20020a17090a710600b0026770a8abffmr230174pjk.29.1695772672735;
        Tue, 26 Sep 2023 16:57:52 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c18-20020a17090ab29200b0025023726fc4sm12214347pjr.26.2023.09.26.16.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 16:57:51 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 48FCE8212DDC; Wed, 27 Sep 2023 06:57:47 +0700 (WIB)
Date:   Wed, 27 Sep 2023 06:57:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Isaac To <isaac.chun.to@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git-retry tool or git.retry config (built-in implementation)?
Message-ID: <ZRNv-n_VlIDPX0oi@debian.me>
References: <ZRMLNyHXoWOj6K-l@bilena>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pqdEmhxkmNsPqzlr"
Content-Disposition: inline
In-Reply-To: <ZRMLNyHXoWOj6K-l@bilena>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pqdEmhxkmNsPqzlr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 12:47:51PM -0400, Yaroslav Halchenko wrote:
> Dear Git Gurus,
>=20
> In DataLad (https://datalad.org) we are doing lots of automated cloning,
> fetching etc as part of our CI etc jobs.  Once in a while git operations
> fail [see e.g. 1], and beg us to retry but we need to know when to
> do so, and not do it upon every failed git invocation since some
> failures could be legit (repository is gone). While looking how others
> solve it we found
> https://stackoverflow.com/questions/35014012/git-retry-if-http-request-fa=
iled
> which pointed to tools like git-retry and later part of
> https://chromium.googlesource.com/infra/infra/+/HEAD/go/src/infra/tools/g=
it/retry_regexp.go
> which serve as a collection of regexes to be on lookout for to retry.
>=20
> Would that be the "best" strategy currently? =20

Looking at the actual git_retry.py script [1], it really just wraps
actual Git commands. IMO, git-retry(1) shell script as you mentioned
only calls the python version, which adds another level of indirection
(why not doing it in pure shell?).

AFAIK, to solve the retrying problem, we need to have a way to tell
transport backend (curl/ssh) to resume transfer from the faulty point.

>=20
> As regex matching might eventually break whenever `git` changes
> anything in the output messages, I wondered if there could be a more
> robust internal implementation in git itself?  Similarly git-annex has
> annex.retry config setting which sets the count of retries for
> "retriable" operations. =20

Do you use porcelain interfaces instead of plumbing ones?

Thanks.

[1]: https://chromium.googlesource.com/chromium/tools/depot_tools.git/+/01d=
2cde990f22d409e74e239de7e4d347102d6f6/git_retry.py

--=20
An old man doll... just what I always wanted! - Clara

--pqdEmhxkmNsPqzlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZRNv9AAKCRB7tWyQc2rT
COnnAQCgouz/it5XXa8yFRDH2A+JBbcBL84TaEvHKtEwZ1TczwEAxn9qpN+ti3qJ
STvmxeN5VJ2v6gx2pBuWyb5UhUYQ1wg=
=GeQb
-----END PGP SIGNATURE-----

--pqdEmhxkmNsPqzlr--
