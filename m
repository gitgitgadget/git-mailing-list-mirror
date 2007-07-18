From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: [PATCH] Proposal for git-svn
Date: Wed, 18 Jul 2007 23:07:42 +0200
Message-ID: <FAFA899D-EC45-4313-98ED-2D0A3FF37669@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-327232086"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 23:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBHUf-0004uZ-RX
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 23:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424AbXGRVze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 17:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbXGRVze
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 17:55:34 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:35869 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbXGRVzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 17:55:33 -0400
X-Greylist: delayed 2851 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2007 17:55:33 EDT
Received: from quanta.tsunanet.net ([82.229.223.213] helo=[192.168.42.100])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IBGkZ-0003b2-Kp
	for git@vger.kernel.org; Wed, 18 Jul 2007 23:07:59 +0200
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52905>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6-327232086
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hello,

I'm importing many SVN repositories in Git and I ran across a problem:
ufloat.h has mode 120000but is not a link

I've read the code and checked-out the revision where the problem  
occured and it turns out that some stupid user commited a broken  
symlink and I think that's where the problem came from.  I'm  
proposing the following trivial change to let git-svn clone continue  
its work:

diff --git a/git-svn.perl b/git-svn.perl
index 01c3904..a82baf4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2555,8 +2555,8 @@ sub close_file {
                 sysseek($fh, 0, 0) or croak $!;
                 if ($fb->{mode_b} == 120000) {
                         sysread($fh, my $buf, 5) == 5 or croak $!;
-                       $buf eq 'link ' or die "$path has mode 120000",
-                                              "but is not a link\n";
+                       $buf eq 'link ' or warn "$path has mode 120000",
+                                              " but is not a link\n";
                 }
                 defined(my $pid = open my $out,'-|') or die "Can't  
fork: $!\n";
                 if (!$pid) {

(I also added a whitespace because "120000but" does not look good :D)
I checked out the problematic revision in git and I see the broken  
symlink just like in SVN so I assume this change is correct.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-6-327232086
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGnoEewwE67wC8PUkRAjLWAJwL5ZooF2lM8I0zhM3dmQEI0ogBagCeKPaF
u0WPP0qq8tkJH19DvRI7zrE=
=CyrI
-----END PGP SIGNATURE-----

--Apple-Mail-6-327232086--
