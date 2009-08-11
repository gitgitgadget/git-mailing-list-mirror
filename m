From: Thomas Rast <trast@student.ethz.ch>
Subject: blame -M vs. log -p|grep -c ^+ weirdness
Date: Tue, 11 Aug 2009 12:16:00 +0200
Message-ID: <200908111216.05131.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1712671.aeLyNy9cRk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 13:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mapsh-00075p-PJ
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 13:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbZHKLuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 07:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbZHKLuy
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 07:50:54 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:45848 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbZHKLux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 07:50:53 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 11 Aug
 2009 12:16:40 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 11 Aug
 2009 12:16:19 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125515>

--nextPart1712671.aeLyNy9cRk
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all

I think I'm fundamentally misunderstanding something about the blame
code...  The other day I wanted to see how much our local fork of
DOMjudge diverged from their upstream.  You can grab the entire
history at

  git://csa.inf.ethz.ch/domjudge-public.git

if you want to try the commands I ran.

As a first statistic I looked at how many lines are blamed to our
local team (Christoph, Florian and me) by running

  git ls-files | while read f; do git blame -M -- "$f"; done |
  perl -pe 's/^\^?[a-f0-9]* (?:[^(]* )?\(([^2]*?) *20.*/$1/' |
  sort | uniq -c | sort -n

This shows that over 8000 lines are attributed to the three of us:

      1 domjudge                                                           =
       =20
      2 rob                                                                =
       =20
    113 Stijn van Drongelen                                                =
       =20
    126 Jeroen Schot                                                       =
       =20
    149 neus                                                               =
       =20
    866 Peter van de Werken                                                =
       =20
   1245 Thomas Rast                                                        =
       =20
   1752 Christoph Krautz                                                   =
       =20
   5350 Florian Jug                                                        =
       =20
  10293 Thijs Kinkhorst                                                    =
       =20
  20397 Jaap Eldering  =20

However, sanity checking this against the diffs of the single commits
shows quite a different number:

  git log --no-merges -p upstream/2.2.. | grep '^+' | grep -v -c '^+++'

gives only 4943 '+' lines, and you can easily verify with

  git shortlog -sn upstream/2.2..

that indeed all commits in that range are ours.  So why does the blame
think more lines are ours than we even added *in total*?

Bj=C3=B6rn Steinbrink suggested on IRC that I use -M5 -C5 -C5 -C5, which
indeed reduces it to

      1 domjudge                                                           =
       =20
      2 rob                                                                =
       =20
    115 Stijn van Drongelen                                                =
       =20
    116 Jeroen Schot                                                       =
       =20
    149 neus                                                               =
       =20
    390 Florian Jug                                                        =
       =20
    930 Peter van de Werken                                                =
       =20
   1209 Thomas Rast                                                        =
       =20
   1612 Christoph Krautz                                                   =
       =20
  11750 Thijs Kinkhorst                                                    =
       =20
  24020 Jaap Eldering

Note especially the huge drop in Florian's numbers.  What's going on
here?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1712671.aeLyNy9cRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkqBROUACgkQqUud07tmzP1yXACdEjyfmBjLFexDTwDk/z01k9ir
5xIAn13Hv3setT6KyEM7Hmd+S6WCuIud
=PZHD
-----END PGP SIGNATURE-----

--nextPart1712671.aeLyNy9cRk--
