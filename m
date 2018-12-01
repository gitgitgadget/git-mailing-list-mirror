Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8A1211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeLBEVK (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 23:21:10 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:59193 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbeLBEVJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Dec 2018 23:21:09 -0500
Received: from pc09.procura.nl ([188.202.26.81])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id T8kTgQxzSfGaRT8kUgaL3Y; Sat, 01 Dec 2018 18:08:10 +0100
Date:   Sat, 1 Dec 2018 18:07:57 +0100
From:   "H.Merijn Brand" <h.m.brand@xs4all.nl>
To:     git@vger.kernel.org
Subject: [PATCH] Do not fail test if '.' is part of $PATH
Message-ID: <20181201180757.0b2d3c89@pc09.procura.nl>
X-Mailer: Claws Mail 3.17.0git137 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/5TWp9C5VB6OGhJ+eNZeEDt3"; protocol="application/pgp-signature"
X-CMAE-Envelope: MS4wfJVPNwgQQg8ZmnwlygglNtztMfdBiL4hH7PV9ZE1mbxBKQwj6XgEVLtmTyc3I6wtr9ji8FrYb292YUWtIDsupc11ozhmisTWoxPSFyMMBMGQMjjeQim+
 nYrDi1rLI47g1LlmfuBhUyV8RFj5mEusVumipzlFxyo9wFERjpMh89f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/5TWp9C5VB6OGhJ+eNZeEDt3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

When $PATH contains the current directory as .:PATH, PATH:., PATH:.:PATH,
or (maybe worse) as :PATH, PATH:, or PATH::PATH - as an empty entry is
identical to having dot in $PATH - this test used to fail

This patch was tested with PATH=3D$PATH, PATH=3D.:$PATH, PATH=3D$PATH:.,
PATH=3D$PATH:.:/bin, PATH=3D:$PATH, PATH=3D$PATH:, and PATH=3D$PATH::/bin

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Tested-by: H.Merijn Brand - Tux <h.m.brand@xs4all.nl>

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index cf932c851..557f87442 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -29,7 +29,14 @@ test_expect_success 'run_command can run a command' '
        test_must_be_empty err
 '

-test_expect_success 'run_command is restricted to PATH' '
+test_lazy_prereq DOT_IN_PATH '
+       case ":$PATH:" in
+       *:.:*|*::*) true  ;;
+       *)          false ;;
+       esac
+'
+
+test_expect_success !DOT_IN_PATH 'run_command is restricted to PATH' '
        write_script should-not-run <<-\EOF &&
        echo yikes
        EOF

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.29   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/5TWp9C5VB6OGhJ+eNZeEDt3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJcAr/4AAoJEAOhR6E+XcCYuQcH/06/As4e3Ako3oIJ14y0FiZa
Lk824/M0fjGIA1E96VfT8hVsenBgzvekfWBA1bsDQ0qXwUu9G3M7Hlf/QvVPfOBT
TOe5uUm2KZcMEvwNnxbnbgpyaZgLJd9/97U3vBE+Y32DBYh2RB5az8l5udzqlkss
i3UdJpsJ3H0x0MqG00XTL76g2oQ5sCvaKchCcnckZ5oSORxLlrIYkPNszNug9FOQ
nAIXkHh5oZyvlURmgDb6CHNoUnakFFgaFgqIeBVn14W6rY+ViqPhXzWyqbERiXBN
LQwwC3NXimlAj2ZCoiyN72FnScCJ7c/Vst6J+70XD+gnZ3a+/UgskUBVUJ3La8Y=
=OhBY
-----END PGP SIGNATURE-----

--Sig_/5TWp9C5VB6OGhJ+eNZeEDt3--
