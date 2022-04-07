Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955D5C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 21:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiDGVzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDGVzF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 17:55:05 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DA11728A6
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:53:01 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 724665A0EC;
        Thu,  7 Apr 2022 21:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649368380;
        bh=JsHnhWQ9hdL2RG4UGyDb1ikE5dJjNBYZb8BURfyszqw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mLNxPN+yMFN5CNGdBRHBwqhmJXSbk0FQoSDbubqxI6cIVM/sjJ6Yff/kIOaoSrKEg
         gk1+RAGj5TM8KisfFwyeKPooWZYhNhf6IJhS5wNLCsLCi5ooRSEZwdCS+dtQhiSUfw
         yvX92locm/AfCGN5yAcGOyti+yzdBC1v17IK42IiTN/Gr23ijXFoZnBljSiUhOE9Px
         cLpv9vLRRLXCmIeaVD9lPNJ6cXZrlYTfd5kKKacl9+OpEL4xdD86ibWwWwh4uctem8
         fTB9C4CktTx+aZ4DNp5fGvW2vk+AUZbV8UY+Q763OCjuQbKRGfDXYnhRYq1s/6VWAx
         N1i9jCm/JoLna/+uUQCUBFHGx6g1QG9TQo18L6sPFLe3OMfuQ32ivc+bcCkPOHedh0
         ZVfXi2J47/oi6dXJvdvIFVyezk1ScmXWPovTsfTHgdhaNv8yYXILM8Y25QFYsvcBgB
         XDSPuwmOXbSzvzaa8K1yuE1zBoImaqYjz+WEeUzjsuKDzGhMB6a
Date:   Thu, 7 Apr 2022 21:52:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to get git-send-email use a proxy?
Message-ID: <Yk9dOoit/Ua69s7A@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAJyCBOSAekywgzVSf1uGb8s+hY7a7A=0fC5kFhMVpiqS1KEw4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UWYenPWuekUK358a"
Content-Disposition: inline
In-Reply-To: <CAJyCBOSAekywgzVSf1uGb8s+hY7a7A=0fC5kFhMVpiqS1KEw4w@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UWYenPWuekUK358a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-06 at 14:19:43, Shaoxuan Yuan wrote:
> Greetings, Git community,
>=20
> I'm using git-send-email with Git 2.35.1 under system
> 5.4.72-microsoft-standard-WSL2, x86_64 GNU/Linux.
>=20
> I am on a system-wide socks5 proxy. Although I set the global
> .gitconfig to use the socks5 proxy trying to send emails, the
> connection to the SMTP server seems does not go through the proxy at
> all.
>=20
> Other git commands do go through the globally set .gitconfig proxy,
> git-send-email seems to be an exception.

I think you're referring to http.proxy.  That affects only HTTP, HTTPS,
and FTP (if we even still support that).  All of those protocols are
handled by libcurl, which includes native proxy support.  It doesn't
affect other protocols like SSH or SMTP.

> So I'm wondering if there needs to be a code change in
> 'git-send-email.perl' to run the connection through a proxy, or I just
> need to tune the setting to accomplish this?

git send-email is written in Perl and doesn't use libcurl, so it doesn't
have proxy support.  If there's a particular optional module we could
dynamically load to provide proxy support, that's an option we could
support if someone wanted to provide a patch.

In the mean time, you could also try using some sort of tool, like
socat, to bind a local port tunnelling over the proxy to the destination
server and then use SMTP over that local port to connect.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--UWYenPWuekUK358a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYk9dOQAKCRB8DEliiIei
gQrhAQDzBJlmV31vezyXSrcg7IDZKS6v/Yg1ZmK+pJVVgYl0IwEAuplKyxVO3+QL
Wz9o+CLOiHzrdz+IjMuFZ7Ho2ZT46wM=
=eoNA
-----END PGP SIGNATURE-----

--UWYenPWuekUK358a--
