Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75B6CCA479
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 21:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGJVuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 17:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJVuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 17:50:18 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F99DF64
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 14:50:17 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7E2E65A1BA
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657489816;
        bh=oJDlAv/GuPZuvlZKIZzQXjDqMM6kUMf62d8adE9D/f8=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=F+WMXfOwlPWLufs/PODhhFFADLNMCDdOs703wfyf8W2Ap6htLY4A6RZBbfy70YqHe
         XKQaNwYl9kdBGwfyetzjzrYmQb8Ib7CFKVb1TAF8Zc28fxaP8+uqz/z2Vvu/I6MrGk
         dDtvZHsWxGNiHlJw+VuYxjlPhEULmF76fAMLxJvYWOuqtudRIYY6JmWns45s8nu3fk
         PsF+bSCmoOl0CuNDkhtRJD+1GcDBVF5M7GcmRsmSyV/4MgCXRQ1o2L9MBcIpHOsk3i
         RmL+L9HcLpnK+yS3s28/TeCaaFnXvg+tJL3ojTWNvWj4XHnCXtLf957/bbrnw6AN7/
         IiuoKaYNNpnJrnYAcs+QinRLjalJvonhgEBbcyIHylHhyO3X4YvdqTwwnqswZYOWPT
         OpURLuhwIBrgSnRYTzq0/UtnOm2qxXF8osGPVtp7Ny+/hWYG+7ULW0SxskKUldNZzv
         cBKtQTtEAFnm0m72ZSs1Fk0Uy155iZfWpa78DZYDsUF9+la5leU
Date:   Sun, 10 Jul 2022 21:50:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Automatic code formatting
Message-ID: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F2i2YTbfD0DrSroo"
Content-Disposition: inline
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--F2i2YTbfD0DrSroo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the past, we've discussed the possibility of using an automatic code
formatter for Git.  That discussion has, as we've seen, not led to us
using one.  I'd like to reopen the discussion and provide a couple
reasons why I think it's a good idea.

We've spent a lot of work encouraging newcomers to contribute to Git.
It's demoralizing when your code comes back with many code style nits to
fix, and it leads to a barrier to contribution.  I also find that I am
likely to take longer to reroll a series if there are many nits to be
fixed, and I find that code style comments are a frequent discussion
topic on my series (even though I generally try to be cognizant of
them).

Having a code formatting tool means that the work for a contributor to
format the file properly consists of about two keystrokes.  This
substantially reduces the amount of time that contributors must spend
thinking about code formatting and simplifies it to an automatic process
that, if we choose, can even be verified in CI.

Most projects written in languages like Rust or Go use an automatic
formatter.  In Go's case, the formatter is specifically stated to be a
fixed style that is nobody's favourite, but because there's an automatic
formatter, everybody just uses it.  Personally, I don't love our coding
style now (I'm a 4-space person in C), but I would love it a lot more if
I didn't have to think about it.  I am substantially less picky about
what the style is than that we have an automated tool to tidy our code,
and I'm okay with us producing the occasional slightly suboptimal style
for the improved efficiency we get.

The impetus for me bringing this up is that I'm rebasing the
SHA-1/SHA-256 interop work to continue work on it and I find myself
spending a lot of time cleaning up formatting that I could instead be
spending on debugging why my tests are failing or writing new code.  I
would like to spend less time on boring scut work and more time solving
interesting problems, as I'm sure we all would.

I should point out that most platforms (and all major platforms) have
clang and therefore I think clang-format should be a fine choice.  It's
highly configurable and will let us pick a style that most resembles the
one we have now. However, I'm not picky and if we like something else
better, great.  As long as the option we pick is shipped in Debian, I'm
for it.

I should note that we already have a .clang-format file, so we can
already use clang-format.  However, we cannot blindly apply it because
it produces output that is not always conformant with our style.  My
proposal here is to define our style in terms of the formatter to avoid
this problem.

Hopefully we can move forward with this discussion and come to some
productive resolution.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--F2i2YTbfD0DrSroo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYstJlgAKCRB8DEliiIei
gWQPAQCdSFCAiZFAeoqo/CNkrwHxmA/00pbU5zvl0Llsomw6QAEA6AJ6q25yYkJo
4BUFkK2bCRVouSqTW/mawzp72DLfbws=
=QHiF
-----END PGP SIGNATURE-----

--F2i2YTbfD0DrSroo--
