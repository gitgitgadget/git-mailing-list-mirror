Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7F3201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbdBYTMl (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 14:12:41 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:57198 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbdBYTMk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 14:12:40 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 85032340FC8
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 19:12:39 +0000 (UTC)
Received: (qmail 5369 invoked by uid 10000); 25 Feb 2017 19:12:38 -0000
Date:   Sat, 25 Feb 2017 19:12:38 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: git-clone --config order & fetching extra refs during initial clone
Message-ID: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nzri8VXeXB/g5ayr"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nzri8VXeXB/g5ayr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

TL;DR: git-clone ignores any fetch specs passed via --config.

The documentation for git-clone --config says:
| Set a configuration variable in the newly-created repository; this takes
| effect immediately __AFTER__ the repository is initialized, but __BEFORE__
| the remote history is fetched or any files checked out. [...]
(emphasis added)

However, this doesn't seem be be true, right after the clone, the refs are =
NOT
present, and the next fetch seems to pull the extra refs. This seems to be
because the refspec building for the initial clone doesn't take into account
any fetch lines added to the config.

Testcase to reproduce (confirmed in v2.11.1, not tested 2.12.0 quite yet):
# export REPOURI=3Dhttps://github.com/openstack-dev/sandbox.git DIR=3Dtest
# git clone \
    -c remote.origin.fetch=3D+refs/notes/*:refs/notes/* \
    -c remote.origin.fetch=3D+refs/changes/*:refs/remotes/origin/changes/* \
    $REPOURI $DIR \
  && cd $DIR \
  && git fetch

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--nzri8VXeXB/g5ayr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQJ8BAEBCgBmBQJYsdclXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRDQjJEMjlCMjBCMkM5MUFDQzE2NDk2NkRB
RTcyMjg3ODM3QzU5RjVGAAoJEK5yKHg3xZ9fIAQP/ipf5F35bQE3Hx/leUlQgwQ4
aLCKYdu0deyxcxlUIMln2F7hp8mOykeyEVjNl/k3KpQVKOC55LpC6vxw4Xb9l0lx
wgwcMZnm67igmI9/r/j63nUCHGs/elNMh00d3TJg09omrpsnlVQ4JjXuQKW2dMQv
F6vQ8R/5qbIKRrIWi7TRkt8a8KSkugTp6/Ie9dpoY/DQi4s/vugKnE5k1NSeRfhd
z2DPebp5IynYetmYeQqWfCTSJSGDaDAW5TISBx9zSQls/1QdcSC1x6t6BTT6iLDX
kLHlBmFD0uAqDpE1zc9t5Lhi3xUdn2YTKlNlZh9xjg5f7Ti2AwgG3aTJ1ShHVbLT
RbZ2EorqkCTWlVT1Fxb0EagU7l0KppQz8RwlS9AmugdB+tVoQhi/Cctvc5zq58dz
Yj9DV4VQ5UhwIpD4wugUfcU2Tr/LmLHzSSHrBV5geZ8lLvTus0x4zArx0+FOyyCR
KpFmICzDtsF3/EKCCOk0rfq8jLyaMKp8MKZ5Y/SsegcsFC4dpIMAj/AA7eY0tVEr
XqL6bDoZhHlmOC7cwVZqxCkY4CtB8/Gs8RRWVIiOhL707XUxpXb+TpsacG8DG/qq
XC4mWz7XG7DTYQPtP08WafD9o+GfEIddwDHdmIFX52GeGGXf7vEEMI6y+DaQzJck
Iau91NZBla4vKSdgvM2L
=TBVj
-----END PGP SIGNATURE-----

--nzri8VXeXB/g5ayr--
