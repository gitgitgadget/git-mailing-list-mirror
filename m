Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F9120248
	for <e@80x24.org>; Fri, 12 Apr 2019 07:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDLHJB (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 03:09:01 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:37840 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfDLHJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 03:09:01 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 35A3D340DFC
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 07:09:00 +0000 (UTC)
Received: (qmail 18767 invoked by uid 10000); 12 Apr 2019 07:08:55 -0000
Date:   Fri, 12 Apr 2019 07:08:55 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: regression AGAIN in output of git-pull --rebase
 --recurse-submodules=yes --quiet
Message-ID: <robbat2-20190412T063235-859985527Z@orbis-terrarum.net>
References: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
 <robbat2-20190410T062730-540884809Z@orbis-terrarum.net>
 <20190410111834.GA25638@ash>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6FinHCQBQ0zFDOqT"
Content-Disposition: inline
In-Reply-To: <20190410111834.GA25638@ash>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6FinHCQBQ0zFDOqT
Content-Type: multipart/mixed; boundary="1ozVqH6bFr/3sC51"
Content-Disposition: inline


--1ozVqH6bFr/3sC51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 06:18:35PM +0700, Duy Nguyen wrote:
> ...

Thanks, I tested, and had good results in almost all of my tests.

Almost all: config setting of 'pull.rebase=3Dpreserve'=20
=3D=3D=3D
$ git submodule foreach --quiet git pull --quiet origin master >/dev/null
Successfully rebased and updated detached HEAD.
Successfully rebased and updated detached HEAD.
$ git pull --rebase --recurse-submodules=3Dyes --quiet >/dev/null
$
=3D=3D=3D
Looking at git-rebase--preserve-merges.sh for this message, I think that
should be a separate patch to make it respect --quiet.

> -- 8< --
(snip patch, please add my DCO signed-off-by)
Tested-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> -- 8< --
>=20
> I'm a bit reluctant to follow up with a proper patch because I can't
> digest the t5572-submodule-pull.sh tests. And we definitely need to
> add a test case about --quiet to make sure it won't happen again.
Find testcase attached. Please submit in a series with your patch

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--1ozVqH6bFr/3sC51
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-submodule-foreach-test-foreach-option-swallowing.patch"
Content-Transfer-Encoding: quoted-printable

=46rom a57994f2d78134936521375ba9798a1b7418e230 Mon Sep 17 00:00:00 2001
=46rom: "Robin H. Johnson" <robbat2@gentoo.org>
Date: Fri, 12 Apr 2019 00:00:07 -0700
Subject: [PATCH] submodule foreach: test foreach option swallowing

Add a testcase for submodule foreach option parsing not knowing where to
stop taking options, and accidently removing options intended for
foreach target commands.

CC: Duy Nguyen <pclouds@gmail.com>
CC: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 t/t7407-submodule-foreach.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 77729ac4aa..706ae762e0 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -411,4 +411,14 @@ test_expect_success 'multi-argument command passed to =
foreach is not shell-evalu
 	test_cmp expected actual
 '
=20
+test_expect_success 'option-like arguments passed to foreach commands are =
not lost' '
+	(
+		cd super &&
+		git submodule foreach "echo be --quiet" > ../expected &&
+		git submodule foreach echo be --quiet > ../actual
+	) &&
+	grep -sq -e "--quiet" expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.21.0


--1ozVqH6bFr/3sC51--

--6FinHCQBQ0zFDOqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlywOYVfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsTkSQ//Snww7OkF6WeVBIb9Y2PQMdssdCQZn9OP8InVMbrmMFPl6jlG3zL0Bf7g
QuKFiP3bM5wJ35u/PDJQntJtXQmY8WZfRbgz/2liwT/dobmD9fGXYW8IpA5TGcx/
WmDqFs79m+MPZcDnp0z8pzJQLMiZg1FJoc3cwlbbnS72D6n037qKuVM0r2SweF1m
0MWPhAESlKFT67Cijst5wyg2PvP2cd9eK55rV2vKh26y37bWZ9KtmoK/xIV9HmqJ
QssCDtzAEfxkv4c4C6mraQtVsKvtAselmYK0TfcyNvujBNqEGFZB+vF4sz9gR/uj
Wa/vvJ9Dq04y01rDlT0WJL6pBzNQ09My/EaCfiaBUcu4L7xiaWI+7QyeRQKVfULh
wa4RsMgNvV3gF/XCgiVlcPztAbFqRgfVveac/pWKV//wGlg8c9i0y7t4hUs2xR/n
ZtitEhb44YLtYMIrf9OccG96f5Nx+xS7JinFH4TuaPJcIDzMJoSsvvAAP9/7gfuP
BgVc9MaR77T/oGVx2BCJCBjw/9D3ia01b2Kqga/vGc7qg16lOl+M88VhKFLdCRHF
RiIxnd7WKbMZX2OWHZdn1ECLtkTd8KKGG/OnM3eXSbqhYxkkNjbD6C0jp9ielwI7
Ar6jdp6kF8EJ4Nm9v/4qkrrkn6DN9IanPLqB6e54pJAWayVp3x4=
=+Ewk
-----END PGP SIGNATURE-----

--6FinHCQBQ0zFDOqT--
