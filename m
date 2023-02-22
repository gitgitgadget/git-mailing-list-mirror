Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A6FC61DA3
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 00:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBVAGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 19:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBVAGK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 19:06:10 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B012FCE9
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 16:06:06 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 34CE75A1A8;
        Wed, 22 Feb 2023 00:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1677024366;
        bh=5kRrBAAdFmFlHsx6sEEnuT3WV2MLbob51xjXWYxEw9Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UzIIseoK1zP+MeTpi9oi62EccFdkA/gI40byCRySZziIHVQEN7mRyoMB5vGPbY1dU
         +hP5Q9RBWNyyY1lyMFh0SJzRuFYjdEHrFoYxWxINYVKjEs2P2QyputmKGnWQxF4HQy
         PSPBBbiOw//1CeTDou7pCbl6wA8fQrZPVwzFhfF69e+1oPggYKUAneR6IrS5vIBPyV
         QR3XxcOEbHm2YofykodF5Z6o9EXbmebnGBsYBUqZkqrzHf5BHL3mfM8L0nLdhR3Pvw
         olVtY1znKNj37TE6C4WkPrKlehzXGfz2hL+PUKMMzPQ+wX1Wh+JRtXBVW1L/xsg5hX
         Lb5qLrkK5fYNVM8aUy59WwnKguFBHkUbXjPnapNCeDsjjXU1UcmMyP8XU3IzH5NBzH
         sWqmOzJ+IkaNLmTDej1HCZeX3/3pBkCzbBc6QHmieS9B3YCRXzP86p3jyCDYPnH0MU
         15IRmp4aHFBl1Y/7T9HCaNWrQqK1me1v9n/EV6KZw2B3rfq+SLO
Date:   Wed, 22 Feb 2023 00:06:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: Parallel worktree checkouts result in index.lock exists
Message-ID: <Y/VcbWogtHrpXU8Z@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
References: <Y/UAaC4oBPIby4kV@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q1+YjFp4ZLQsk40l"
Content-Disposition: inline
In-Reply-To: <Y/UAaC4oBPIby4kV@google.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q1+YjFp4ZLQsk40l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-21 at 17:33:28, Raul E Rangel wrote:
> Hello,
> I'm trying to extract multiple trees in parallel so I can create a
> tarball of the trees. I can't use `git archive` since it doesn't
> currently produce hermetic output, and I need to support older git
> versions.
>=20
> In essence what I'm trying to do is:
>=20
>     git --work-tree ~/tmp/bob1 checkout ff27f5415797ead8bc775518a08f3a4ab=
24abd53 -- . &
>     git --work-tree ~/tmp/bob2 checkout e70ebd7c76b9f9ad44b59e3002a5c57be=
5b9dc12 -- . &
>=20
> When I do this though, I get the following error:
>     [1] 4027482
>     [2] 4027483
>     fatal: Unable to create '/home/rrangel/cros-bazel/.repo/project-objec=
ts/chromiumos/platform/vboot_reference.git/./index.lock': File exists.
>    =20
>     Another git process seems to be running in this repository, e.g.
>     an editor opened by 'git commit'. Please make sure all processes
>     are terminated then try again. If it still fails, a git process
>     may have crashed in this repository earlier:
>     remove the file manually to continue.
>=20
> Is this expected? I'm not sure why the index is coming into play here.
> Is there another method I should be using to extract a tree into a
> directory?

This is expected because when you do a checkout, the timestamps and
other metadata of the files are written into the index.  This is what
makes `git status` work quickly: if the metadata of the files hasn't
changed, Git doesn't have to re-read them to verify their contents.  You
definitely don't want to delete that because you'll likely end up with
corrupt data.

If you want to create multiple worktrees, use `git worktree add`, which
can create multiple worktrees that each have their own index, but share
the object store.  When you're done with it, run `git worktree remove`,
and everything will be cleaned up.

Note that with worktrees, you can have at most one worktree with a given
branch (or detached head) checked out at a time.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Q1+YjFp4ZLQsk40l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY/VcbAAKCRB8DEliiIei
gf52AP9SAGVzI82FldDlguDE2qsDstSUIj09d/44PZWx1VaA9QEA1OgPajurEETJ
Vtz81oVCeMzprsdoCujf0zPCNcJdSAE=
=UbkR
-----END PGP SIGNATURE-----

--Q1+YjFp4ZLQsk40l--
