Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BF71F403
	for <e@80x24.org>; Tue, 12 Jun 2018 01:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933611AbeFLB2k (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 21:28:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37660 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933350AbeFLB2j (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jun 2018 21:28:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0039760129;
        Tue, 12 Jun 2018 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528766918;
        bh=FEiK4TMB7/FY9JEEqjKA3K2nCA9CjgvRZF8S86bIiVY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=S73cWJkY/5bd79YAgFQd18IDgobbsQ71yB4OX0QBNCwboO0czALm6ece2eVvkwOS6
         fv6TKGGqcvID3sKlxHbS3Iaw4honUQ0pivqUi52FP1w43msgdXog6X5ebu8QigK0n6
         MsXrjsYyjiknhEWnFRHKOHfuUSKMCqWJ7Ec2yOkQJK/eYsYETxRaesqIdqQ7h9bs49
         QtOuHQ3SS5mBvR7kSEb2SC+3t7KpSMCN8Yqp3dg6K8meRtLrGbRJ0YRT5nb2OXUz5Y
         9Th3LVydHIAYIGHXe5mLE7PNa5UkQ9OBIIHMuE8KLlV7ctPe5i8DrBXfH66L03C0cO
         8wPr0xJZI2qMOMjPtP0o3+v09iYEdH8FwgVtad+TifyZjWfZ+48Y4i0M5GxiJd2WzT
         3JsiuZep86gOn66WV+yUPS0OeNRcqX0CDE4m/te1HUDGH0XkPwX+UhX5fWMbNC412S
         E/1F1o4uhztbJOhjX99n5C+yGlU9tFm78UjlPWNrThgjiy12XEu
Date:   Tue, 12 Jun 2018 01:28:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: State of NewHash work, future directions, and discussion
Message-ID: <20180612012833.GJ38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <CACsJy8CJrFCUnVMes=3_gQKNTiyHsKkawWNQ1aB_GCvOh1rKcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
In-Reply-To: <CACsJy8CJrFCUnVMes=3_gQKNTiyHsKkawWNQ1aB_GCvOh1rKcw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 08:09:47PM +0200, Duy Nguyen wrote:
> I'm actually thinking that putting the_hash_algo inside struct
> repository is a mistake. We have code that's supposed to work without
> a repo and it shows this does not really make sense to forcefully use
> a partially-valid repo. Keeping the_hash_algo a separate variable
> sounds more elegant.

It can fairly easily be moved out if we want.

> I quickly skimmed through that document. I have two more concerns that
> are less about any specific hash algorithm:
>=20
> - how does larger hash size affects git (I guess you covered cpu
> aspect, but what about cache-friendliness, disk usage, memory
> consumption)
>=20
> - how does all the function redirection (from abstracting away SHA-1)
> affects git performance. E.g. hashcmp could be optimized and inlined
> by the compiler. Now it still probably can optimize the memcmp(,,20),
> but we stack another indirect function call on top. I guess I might be
> just paranoid and this is not a big deal after all.

I would have to run some numbers on this.  I probably won't get around
to doing that until Friday or Saturday.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsfIcEACgkQv1NdgR9S
9ouT6w//cv3LELTGVFzJvIaDa/oEGbN2o2TILGq/0sI2/tUCpc5pYOOjpF+whoOi
XoEav/4TUQSr976lpczmhjQ4JISgtOEBznJFIQQXVTDQ0vdWNtO0491PKJ4NKw5i
n4Y4Y6T5BnrZY735oSdAJWE7CbxrmPuDDypgRe/eM8gJVXq57jeAXGK+62eVvxrV
TYth/61SoMiEXJ3p1j2vGwIiymP45kUQLY7BNGR3ZsDs/jGoXglD+QBqDfaGeLLB
NjTCcjpd5ZZ9lcYTLUvdaCyUSI4pA9UVFvK13m5ZgLNxxQDH+sRFhjqiVdFH2Nnm
02zVmpRXl08wssDGjeraWHwb3p3v4osbes+oBPUPSeEC1S0m2Fm/fP8i/BoMltcW
X0IBldRcNXN5Y5XevqMShazE2z2rKKYbhx3sgXxphCgtrhYg0qekqxq2S3irC5fV
dy5LsL3sSq6bizRiemBV57R/RSOmj8Emic3NVbHw4fi6OSpPoOHrq8tucSWbyckv
+evmeN9rBM8BT5VPqRen83ciOq7hNGSOg1+99EX5oTOBDtp8qmjDOdQ6aCsEePwM
mdgrNNHBunGZsDMfQu+aTsyLqZTC0wQH8OoFNSDRExSbAvv+/a7rsBrykP7TwN9T
cbD/3vrX+T8XfjBW01/xvAVS4teAG4w7pGmGIRGj+76jxB8f/io=
=mywj
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--
