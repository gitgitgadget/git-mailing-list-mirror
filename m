Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A82C433EF
	for <git@archiver.kernel.org>; Sat, 25 Jun 2022 11:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiFYLtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jun 2022 07:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFYLtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jun 2022 07:49:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91CE165AC
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 04:49:48 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BF9845A485;
        Sat, 25 Jun 2022 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1656157787;
        bh=sboZFVdevJdNaLDJNpRuWRSte8U5QvZKrcVtrsFsU9c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Fhjmv7Xe6p2ERRbDiHpD5KrbWXLWJcKdi6lOXK9gc5Ipvyfrp/zRKUphDcwAZaOBj
         SHdCdUvlzDCM7I//hcMjvoR4SVzT9+ta5lQ8Nd4bPk39wkpArAay5mhBWqroDdQiLb
         ueoK0bpwrQy4fOkhI6m2o7XrI9XWONhHINmzw2T2gH3/BMMCnYfg+0fjs9GZRw0J22
         e3Szh/2S+ZYE0y2CoYn9IZIxBg6QIJEejUAoETy4nTDTKLDBQP8NvLZ7b+qtEriobP
         z/rlv4CBGfZlX7vzDDyj4wO2RmnEVmQlRQzssNOxPtp6A/gnSS9Dtm7YcF38Mrin4O
         d2f6pf3H14w1ZG6BH9/E9+nBGtfzIGoGkqzljFH+9ZRhfEHtCNd/2OeH1790HOhA1b
         v6YrpdEog78UUpLi9S+zVYawzB8w18TR+SE710ctQM1wHlHbc3rSkB1cSYWKG4ByJz
         SZblorym8pce6vqQ9IpW0uVfoUTyzpubDdaVYlzkHe7Vbt7QJ+6
Date:   Sat, 25 Jun 2022 11:49:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Danil Pristupov <danil@danil.cz>
Cc:     git@vger.kernel.org
Subject: Re: Diff for unmerged files always misses the `\ No newline at end
 of file` mark
Message-ID: <Yrb2Wv92eLmXY6NV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Danil Pristupov <danil@danil.cz>, git@vger.kernel.org
References: <CAKdzDnn7KkRpXta1LiHcDPCztPcPRTFv8zTW_v+GpBAuSTW6yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aGSRgSRkHySa16G4"
Content-Disposition: inline
In-Reply-To: <CAKdzDnn7KkRpXta1LiHcDPCztPcPRTFv8zTW_v+GpBAuSTW6yg@mail.gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aGSRgSRkHySa16G4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-23 at 15:39:07, Danil Pristupov wrote:
> Some time ago I reported a bug there, but got no response. I hope it's
> OK if I post it again.
>=20
> Diff for unmerged files always misses the `\ No newline at end of file` m=
ark.
>=20
> I was able to reproduce this with all git versions on all platforms.
>=20
> Steps to reproduce (macOS, 2.32.0 (Apple Git-132)):
>=20
> ```
> git init
> echo "line1\nline2" > eol.txt
> echo -n "line1\nline2" > noeol.txt
> git add .
> git commit -m "initial"
> git branch br1
> echo "line11\nline2" > eol.txt
> echo -n "line11\nline2" > noeol.txt
> git add .
> git commit -m "line1"
> git checkout br1
> echo "line12\nline2" > eol.txt
> echo -n "line12\nline2" > noeol.txt
> git add .
> git commit -m "line2"
> git merge master
> git diff -- eol.txt > eol.diff
> git diff -- noeol.txt > noeol.diff
> ```

Thanks for the report.  I think this is indeed a bug, but maybe someone
more familiar with things than I am can confirm.

=46rom a preliminary examination, it looks like the --cc and regular modes
render diffs completely differently, and code similar to what's at the
end of emit_rewrite_lines belongs at the end of dump_sline as well.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--aGSRgSRkHySa16G4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrb2WgAKCRB8DEliiIei
gVgCAQDQevljhpaW0DvuHlRl+nxi8k3m4W5Hl51Leq+V1wC5IgEAlL0AEAXOiaQ1
ZhYq5EbUM4jEKY7NuO5/QFsm3u+KRwc=
=//vz
-----END PGP SIGNATURE-----

--aGSRgSRkHySa16G4--
