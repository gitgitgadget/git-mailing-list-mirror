Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C3D202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 10:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934898AbdCJKHZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 05:07:25 -0500
Received: from kolab.intevation.de ([212.95.107.133]:54580 "EHLO
        kolab.intevation.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934489AbdCJKHX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 05:07:23 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Mar 2017 05:07:22 EST
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id CDD64628F1
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 11:00:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at intevation.de
Received: from kolab.intevation.de ([127.0.0.1])
        by localhost (kolab.intevation.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wiRh2EYszPNP for <git@vger.kernel.org>;
        Fri, 10 Mar 2017 11:00:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id C3E4B6294D
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 11:00:15 +0100 (CET)
Received: from ploto.hq.intevation.de (ploto.hq.intevation.de [192.168.11.18])
        (Authenticated sender: bernhard.reiter@intevation.de)
        by kolab.intevation.de (Postfix) with ESMTPSA id 9C520628F1;
        Fri, 10 Mar 2017 11:00:15 +0100 (CET)
From:   "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
To:     git@vger.kernel.org
Subject: Stable GnuPG interface, git should use GPGME
Date:   Fri, 10 Mar 2017 11:00:07 +0100
User-Agent: KMail/1.9.10 (enterprise35 20150610.75555ff)
Cc:     gnupg-devel@gnupg.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2944136.yvmxf56zql";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201703101100.15214.bernhard.reiter@intevation.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart2944136.yvmxf56zql
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear Git-Devs,

git uses an pipe-and-exec approach to running a GnuPG binary=20
as writen in the documentation [1]:

    gpg.program
           Use this custom program instead of "gpg" found on $PATH when mak=
ing
           or verifying a PGP signature. The program must support the same
           command-line interface as GPG

please consider using libgpgme interfacing to GnuPG, because the gpg=20
command-line interface is not considered an official API to GnuPG by the=20
GnuPG-devs and thus potentially unstable.=20

=3D=3D Details

I'm involved in GnuPG development. For most applications using libgpgme is =
the=20
way what GnuPG-devs would recommend, also see=20

  https://wiki.gnupg.org/APIs .

GnuPG devs are making a good effort of trying to keep the command-line=20
interface stable, though it is not for sure. Git is only using a small part=
=20
of the interface, so the risk when keeping the current way is small.=20
Still I believe git's stability and usability would profit when moving to=20
libgpgme, especially with the coming move to GnuPG 2.2, better diagnosing=20
messages and for cross-plattform usage.

=3D=3D Usability problem with `gpg2` vs `gpg`

My use case today was signing and git by default found the `gpg` binary by=
=20
default and the command failed. The reason is that I have `gpg2` installed=
=20
and most applications use it right away. So git failed signing because=20
the .gnupg configuration of the user was not ready for the old `gpg` which =
is=20
still installed on Debian GNU/Linux for purposes of the operating system. I=
f=20
git would have used libgpgme, gpgme would have choosen the most uptodate=20
version of `gpg` available (or configured) without me intervening via=20
gpg.program. Now because of this problem you could adding a check for `gpg2=
`=20
and fallback to `gpg`, but even better would be to move to libgpgme. >:)

Best Regards and thanks for maintaining Git as Free Software,
Bernhard

=3D=3D how to respond

ps: Please copy me on replies as I am not on git@vger.kernel.org.=20
pps: I've copied gnupg-devel@ so they can see I've send this report, you do=
n't=20
have to.


[1]=20
https://github.com/git/git/blob/3bc53220cb2dcf709f7a027a3f526befd021d858/Do=
cumentation/config.txt
search for 'gpg.program'.

=2D-=20
www.intevation.de/~bernhard (CEO)     +49 541 33 508 3-3
Intevation GmbH, Osnabr=FCck, Germany; Amtsgericht Osnabr=FCck, HRB 18998
Owned and run by Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart2944136.yvmxf56zql
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJYwnknAAoJEDxD9Mjv9dQqkn8IAJ81Ttzm4bgwI98Brf/jgUNr
0kTlCCH0QsM195f11AUAahRG6FvShYGqKeFVwALbRp9TffTbUDgKXZiqk4eFVZdR
F4ACSahfwZHfzk0saCzfrm9poVP/Abt19frPpgu4+cHOSsaREgfWrIibqFg+gOgj
JCFF2mLU6OzNtRWb+BaDokmQpKyRJZB17Sjohc/EChPDTlFer0ZXV9O2QKChZbrj
mFRqQ8E/illqcki8DoUxEbr243TkU2WMfOnQNGtxhiofGzYpm3Lt8Kdu4O5xVZK5
ezRpNMBfGvYnmevYiYWX0JoNvW1Qxh7jjJ2yD1f1EsvokE2mjS/Elh7k0LbeFTY=
=x/su
-----END PGP SIGNATURE-----

--nextPart2944136.yvmxf56zql--
