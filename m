Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC1C1F453
	for <e@80x24.org>; Sat, 22 Sep 2018 10:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIVQfd (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 12:35:33 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:60274 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbeIVQfd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Sep 2018 12:35:33 -0400
Received: from pc09.procura.nl ([188.202.26.81])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id 3fMkgJEG312p23fMlgdb7r; Sat, 22 Sep 2018 12:42:23 +0200
Date:   Sat, 22 Sep 2018 12:42:15 +0200
From:   "H.Merijn Brand" <h.m.brand@xs4all.nl>
To:     git@vger.kernel.org
Subject: Coredump on ls-remote + --sort
Message-ID: <20180922124215.0c8172d1@pc09.procura.nl>
X-Mailer: Claws Mail 3.16.0git170 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
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
 boundary="Sig_/y4ZPWUWkuNBo=WBzs5FtTOZ"; protocol="application/pgp-signature"
X-CMAE-Envelope: MS4wfGhykl2sCEfJb8vpbaj0DSs25pkAMLtVUmszRKQ1n0t4GaijsB9UF4mEStC1H/LnaKSKoGACeNz9p4g9BdRnO31Gyaize1xIV9WrZ3HTkkkU4H9HP9/A
 qecR02zwyr5VHVcEvjkBZaKajmUx92N0fD4SgVfazUeNJp4nEepPt8xG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/y4ZPWUWkuNBo=WBzs5FtTOZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

A small background why I wanted this: I need to build a new version of
some software hosted in git, add a lot of shared/static stuff and
automatically test it. I want to get the most recent *tag* and create a
folder with the tagname in it, go into that folder and clone the repo,
check out the tag, add the rest of the stuff, build and test

As the default outpout of =C2=ABgit ls-remote --tags=C2=BB or =C2=ABgit ls-=
remote=C2=BB is
topologically sorted by tagname, the most recent tag is likely to be in
the middle.

Linux 4.12.14-lp150.12.16-default [openSUSE Leap 15.0]

$ git --version
git version 2.19.0

$ git ls-remote --tags github.com:Tux/App-ccdiff
5e2513ab6dd4a24c8f3a3ace0a3faba6a291d818        refs/tags/0.04
2f7ea0f1e751dc20c1ddb15f6d61c6fa62d5d6f1        refs/tags/0.05
a3802907be5b10383c7438f1d1c660fe13a05d3f        refs/tags/0.06
3e4bfa7cde75fba221650b9d3aa5555b706803df        refs/tags/0.07
05829d1ac5b49bbdd2167bc363b94f8a12e752b3        refs/tags/0.08
9c6e5861ea9c6e50c501663d43c5a9f6d31b54bc        refs/tags/0.09
e815b059f6326da936c3a92272ba67e273b1dc3e        refs/tags/0.10
e6b40e331c945449bb8e71023de4920ca5574adc        refs/tags/0.20
be55e6336b1db5ffad23a6a0a663763e2f5da779        refs/tags/0.21
e283d563f02bb8d2131e8b95852072ac204b28b4        refs/tags/0.22
0d3d1830f542121bfef1d984f21343c6d9c774f8        refs/tags/0.23
d7bf195a92095a4f0b810584810450e4001b1a2c        refs/tags/0.24
5c517cf3f79cb18173714e63bc5b80a3e3f888f1        refs/tags/0.25

Whether or not supported, it should not dump core

$ git ls-remote --tags --sort=3Dauthordate github.com:Tux/App-ccdiff
Segmentation fault (core dumped)

(gdb) where
#0  0x00007ffff74784a6 in __strlen_sse2 () from /lib64/libc.so.6
#1  0x000000000057a956 in for_each_replace_ref ()
#2  0x0000000000596cec in do_lookup_replace_object ()
#3  0x00000000005c14eb in oid_object_info_extended ()
#4  0x000000000058b984 in get_object ()
#5  0x000000000058ddde in populate_value ()
#6  0x000000000058e36b in compare_refs ()
#7  0x000000000061447a in msort_with_tmp.part ()
#8  0x0000000000614505 in msort_with_tmp.part ()
#9  0x0000000000614518 in msort_with_tmp.part ()
#10 0x0000000000614518 in msort_with_tmp.part ()
#11 0x000000000061459e in git_qsort_s ()
#12 0x000000000058ed40 in ref_array_sort ()
#13 0x000000000044ef66 in cmd_ls_remote ()
#14 0x000000000040784f in handle_builtin ()
#15 0x0000000000407bb0 in cmd_main ()
#16 0x0000000000406b04 in main ()

Linux 3.10.0-862.6.3.el7.x86_64 [CentOS Linux 7.5.1804 (Core)]

$ git --version
git version 2.18.0

$ git ls-remote --tags https://github.com/Tux/App-ccdiff
5e2513ab6dd4a24c8f3a3ace0a3faba6a291d818        refs/tags/0.04
2f7ea0f1e751dc20c1ddb15f6d61c6fa62d5d6f1        refs/tags/0.05
a3802907be5b10383c7438f1d1c660fe13a05d3f        refs/tags/0.06
3e4bfa7cde75fba221650b9d3aa5555b706803df        refs/tags/0.07
05829d1ac5b49bbdd2167bc363b94f8a12e752b3        refs/tags/0.08
9c6e5861ea9c6e50c501663d43c5a9f6d31b54bc        refs/tags/0.09
e815b059f6326da936c3a92272ba67e273b1dc3e        refs/tags/0.10
e6b40e331c945449bb8e71023de4920ca5574adc        refs/tags/0.20
be55e6336b1db5ffad23a6a0a663763e2f5da779        refs/tags/0.21
e283d563f02bb8d2131e8b95852072ac204b28b4        refs/tags/0.22
0d3d1830f542121bfef1d984f21343c6d9c774f8        refs/tags/0.23
d7bf195a92095a4f0b810584810450e4001b1a2c        refs/tags/0.24
5c517cf3f79cb18173714e63bc5b80a3e3f888f1        refs/tags/0.25

$ git ls-remote --tags --sort=3Dauthordate https://github.com/Tux/App-ccdiff
Segmentation fault

(gdb) where
#0  0x00007ffff751a67f in __strlen_sse42 () from /lib64/libc.so.6
#1  0x0000000000561c06 in for_each_replace_ref ()
#2  0x000000000057c3fa in do_lookup_replace_object ()
#3  0x00000000005a6aa8 in read_object_file_extended ()
#4  0x00000000005731e5 in get_object ()
#5  0x00000000005749df in populate_value ()
#6  0x0000000000574e9d in compare_refs ()
#7  0x00000000005efe57 in msort_with_tmp.part.0 ()
#8  0x00000000005efe31 in msort_with_tmp.part.0 ()
#9  0x00000000005efe0e in msort_with_tmp.part.0 ()
#10 0x00000000005efe0e in msort_with_tmp.part.0 ()
#11 0x00000000005eff5c in git_qsort_s ()
#12 0x00000000005757e0 in ref_array_sort ()
#13 0x000000000044c6b6 in cmd_ls_remote ()
#14 0x000000000040730e in handle_builtin ()
#15 0x000000000040760e in cmd_main ()
#16 0x0000000000406554 in main ()


--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.29   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/y4ZPWUWkuNBo=WBzs5FtTOZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJbphyOAAoJEAOhR6E+XcCYUc0H+gLHUQr2hqjhdc53mIcifJWE
7+3qbXgU1sorpqCC5XeukALIPCHSCkn0MtnqXVrOoLQunyljyRJAE/caBQmyJfL4
BiNj1Tlr1Wq5UTsSZy72nT8u/96iHMGI4bKU3pMAkfxVxkNB56fzD6iXX3mDbR03
Jo4QYsOzxtW78C2m4srQcaxlSY3kkkjhbsHTji8b9Bt+pybQCQ9ZnDrviiYLj7lt
MWy+HNySIlFyAn0Kf5gSo642D+ayRjmP7Bc4SslPQKFS3yOGQlOjZBO7UKh7FOG3
bA1qgP5OWQkczLCE4XhxI8xp2/udy6BykG3ZQzL22Pw2myR4blDGGN4cXqw+P9Q=
=ccWe
-----END PGP SIGNATURE-----

--Sig_/y4ZPWUWkuNBo=WBzs5FtTOZ--
