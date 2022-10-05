Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE7C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 22:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJEWUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 18:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJEWUE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 18:20:04 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203C6471
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 15:20:02 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AC01D5A111;
        Wed,  5 Oct 2022 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665008401;
        bh=E/weNGGSmvXZrPf5xwoUrMRP3OC4Q+rQUBjW+pQyks8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GuEkqX5fZzNBajaVLWXVevaHSNnqxxykw9AUfDCTjSlRaGAu1HuYxIYbys5JxTfjh
         nBTl1+QtxPIcDbN3SlNiwHDKBg/jtLUYFkH1gKJsecwHDkP2cGLHOt+Pkb3PGe4oF6
         mPXVsgptD+JxIcWgvCrdOazLB+Qy3FSgGUBSZHZM18zI+cvxNF5Q0CG+xAzJYkFmyK
         Ij14wRX0F2V1h1pfuB+ONUHKdIcqeFLcIv+lI+gW/ryszmQxiKe3NGlIk0ByCLgEUO
         Ox+8ch3wdOuqswDaW3pJsIJzcZnxYm859l7Xf0z8S39j6yUBqoQj97+QAL+zd6DEOq
         5qPM/BckiANDTBLgolVA04IEcPwa8/fgkGCZxRLvYGQJZ12V6pOwQA2d9cxsZ6gn7D
         dl/yTes1gGIcr+GJMk9VDWmlnXU1BkfR0Tkz4ieRpr8Xg65GY+es7C6MC0aMmyRemE
         vKEukzQiUsVFI/T9DfPY//roEtId40/ggJyyVRKCtQDQJoTCoxa
Date:   Wed, 5 Oct 2022 22:19:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alireza <rezaxm@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request for a "connected mode" -- server-side command execution
Message-ID: <Yz4DDxe6oGCOH0hI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza <rezaxm@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAD9n_qiXZ9xDkJsG0mMmYoVpM8LXrZB+nyjHK_vSsRT3FgjAqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NodVax3604eiBBu4"
Content-Disposition: inline
In-Reply-To: <CAD9n_qiXZ9xDkJsG0mMmYoVpM8LXrZB+nyjHK_vSsRT3FgjAqw@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NodVax3604eiBBu4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-05 at 11:23:00, Alireza wrote:
> There are a few mechanisms already to improve perf in big repositories
> but they all need a change in usage flow. I had this idea for a while
> now and I'd appreciate your feedback on it.
>=20
> The "connected mode" essentially means to run all git commands on the
> server and only download relevant stuff locally. To demonstrate the
> usage flow:
>=20
> git clone --connected <url> # new repo
> git config fetch.connected true # existing repo
>=20
> From there, git is to decide whether or not a command should be sent
> to the server. For instance, if all required refs are present locally,
> it's run on the machine, otherwise it's sent to the server, collecting
> the result and possibly a minimum set of new objects. From the user's
> perspective, all commands are run on the latest revision without an
> explicit (possibly extensive) fetch.
>=20
> This would make a --connected clone implicitly shallow, but new data
> can be downloaded on demand. User flow is not changed in any other
> ways.

I think you may be interested in partial clone (e.g., a clone with
`--filter=3Dblob:none`), which can download the commits and trees but not
the blobs for a repository.  The blobs are then automatically downloaded
=66rom the remote on demand.

There are other partial clone filters, but that particular one is the
most common and the best supported.  Note that in this case, the history
is complete and the repository is not shallow; only the blobs are
missing.

As for performing the work on the server side, I feel like that is
unlikely to happen, since it's very hard to account for the security
concerns running arbitrary commands as well as the potential unbounded
computational cost.  Therefore, it's not likely that most providers
would implement a feature if it were added.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--NodVax3604eiBBu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYz4DDwAKCRB8DEliiIei
gYlcAPkB0Jg9GVMT4QEldNMH0MmQHSgufMjxs7hZCPurWH9FBgEAwcQ/IQisFMRN
0mVqWF4YkmZWJrjwIyLbv4AQJ21aug0=
=X5mu
-----END PGP SIGNATURE-----

--NodVax3604eiBBu4--
