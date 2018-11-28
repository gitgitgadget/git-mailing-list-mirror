Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3381F609
	for <e@80x24.org>; Wed, 28 Nov 2018 09:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeK1UGW (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 15:06:22 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:55680 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727750AbeK1UGW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 15:06:22 -0500
Received: from pc09.procura.nl ([188.202.26.81])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id Rvmggv1Ttfa12Rvmhgevpi; Wed, 28 Nov 2018 10:05:27 +0100
Date:   Wed, 28 Nov 2018 10:05:17 +0100
From:   "H.Merijn Brand" <h.m.brand@xs4all.nl>
To:     git@vger.kernel.org
Subject: in 2.19.2 t0061-run-command FAILs if . is in $PATH
Message-ID: <20181128100517.28d44804@pc09.procura.nl>
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
 boundary="Sig_/2agN2k647nZzROYkA3BX5S8"; protocol="application/pgp-signature"
X-CMAE-Envelope: MS4wfOPr4hciR0NROuh7zdi3VY63IAZ3RDY8pb3GqICvck0z1jexYcNWGcvodbM1FBjjnMxcClkViKonP7nV/+i8OS/ogflNp2lGsm9PBO25tn9rni3M4Cwp
 4TcChqIK/6ffCZFAycShEGN7KDUi+X4Rs9xkw4nfSfgN9CljXXLcGM4h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/2agN2k647nZzROYkA3BX5S8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

the test is explicitely checking that it should not find runnable
scripts outside $PATH, *assuming* $PATH does not have . in it

Having '.' in $PATH can be seen as a bad idea (and it most likely is),
but the tests should either remove '.' from $PATH before testing or
ignore that fail if $PATH does have '.', as it is not illegal

$ git-2.19.2/t 504 > prove -v t0061-run-command.sh
t0061-run-command.sh ..
ok 1 - start_command reports ENOENT (slash)
ok 2 - start_command reports ENOENT (no slash)
ok 3 - run_command can run a command
ok 4 - run_command is restricted to PATH
ok 5 - run_command can run a script without a #! line
ok 6 - run_command does not try to execute a directory
ok 7 - run_command passes over non-executable file
ok 8 - run_command reports EACCES
ok 9 - unreadable directory in PATH
ok 10 - run_command runs in parallel with more jobs available than tasks
ok 11 - run_command runs in parallel with as many jobs as tasks
ok 12 - run_command runs in parallel with more tasks than jobs available
ok 13 - run_command is asked to abort gracefully
ok 14 - run_command outputs
ok 15 - GIT_TRACE with environment variables
# passed all 15 test(s)
1..15
ok
All tests successful.
Files=3D1, Tests=3D15,  1 wallclock secs ( 0.04 usr  0.01 sys +  0.26 cusr =
 0.07 csys =3D  0.38 CPU)
Result: PASS

$ env PATH=3D"$PATH"":." prove -v t0061-run-command.sh
t0061-run-command.sh ..
ok 1 - start_command reports ENOENT (slash)
ok 2 - start_command reports ENOENT (no slash)
ok 3 - run_command can run a command
not ok 4 - run_command is restricted to PATH
#
#               write_script should-not-run <<-\EOF &&
#               echo yikes
#               EOF
#               test_must_fail test-tool run-command run-command should-not=
-run
#
ok 5 - run_command can run a script without a #! line
ok 6 - run_command does not try to execute a directory
ok 7 - run_command passes over non-executable file
ok 8 - run_command reports EACCES
ok 9 - unreadable directory in PATH
ok 10 - run_command runs in parallel with more jobs available than tasks
ok 11 - run_command runs in parallel with as many jobs as tasks
ok 12 - run_command runs in parallel with more tasks than jobs available
ok 13 - run_command is asked to abort gracefully
ok 14 - run_command outputs
ok 15 - GIT_TRACE with environment variables
# failed 1 among 15 test(s)
1..15
Dubious, test returned 1 (wstat 256, 0x100)
Failed 1/15 subtests

Test Summary Report
-------------------
t0061-run-command.sh (Wstat: 256 Tests: 15 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
Files=3D1, Tests=3D15,  1 wallclock secs ( 0.03 usr  0.00 sys +  0.24 cusr =
 0.07 csys =3D  0.34 CPU)
Result: FAIL

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.29   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/2agN2k647nZzROYkA3BX5S8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJb/lpVAAoJEAOhR6E+XcCYS6sIAIw1Pu9od11Mi88+HcD0l0v5
AyNK5wf1lItkNGRHy5DvJRXmc2s73Bn2W7FO04AX0iwfVS4XXr5MWUk1b8n3RR2f
xY9QVVx+yJEv3GoJodjs2aqSp1oRYhAk6D4IGvi9XcL6Mvdaqo04+mwwiPQ95lQK
QsC3YXfoBF9/bxe+bxpoHz1Ppae53hHDBngnepszjekeiayYXVvjLsOYfTbO6nSc
6Im7kU7Mz8qhhSwVv1lPd1vMmLkAISRA87xvMv3WnDeRSrrCqQINZ0e5Ir9SAl3R
V6yGZZfkSgD/Dd1XTFeex6wDzUdR2LOYyCCK7ByTWaBhDAeb+57BpXyfZeZvC0U=
=PF7B
-----END PGP SIGNATURE-----

--Sig_/2agN2k647nZzROYkA3BX5S8--
