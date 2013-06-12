From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 10/31] git-remote-mediawiki: Change separator of some regexps
Date: Wed, 12 Jun 2013 17:43:27 +0200
Message-ID: <1371051828-12866-11-git-send-email-celestin.matte@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnFh-0008WJ-M0
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab3FLPqE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:46:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43417 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756763Ab3FLPoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:44:14 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFiB3d028667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:44:11 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFiDZ4015004;
	Wed, 12 Jun 2013 17:44:13 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu5t014096;
	Wed, 12 Jun 2013 17:44:12 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 17:44:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227653>

Use {}{} instead of /// when slashes are used inside the regexp so as n=
ot to
escape it.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 7537305..b01d402 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -120,7 +120,7 @@ chomp($dumb_push);
 $dumb_push =3D ($dumb_push eq "true");
=20
 my $wiki_name =3D $url;
-$wiki_name =3D~ s/[^\/]*:\/\///;
+$wiki_name =3D~ s{[^/]*://}{};
 # If URL is like http://user:password@example.com/, we clearly don't
 # want the password in $wiki_name. While we're there, also remove user
 # and '@' sign, to avoid author like MWUser@HTTPUser@host.com
@@ -564,7 +564,7 @@ sub mediawiki_smudge {
=20
 sub mediawiki_clean_filename {
 	my $filename =3D shift;
-	$filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
+	$filename =3D~ s{@{[SLASH_REPLACEMENT]}}{/}g;
 	# [, ], |, {, and } are forbidden by MediaWiki, even URL-encoded.
 	# Do a variant of URL-encoding, i.e. looks like URL-encoding,
 	# but with _ added to prevent MediaWiki from thinking this is
@@ -578,7 +578,7 @@ sub mediawiki_clean_filename {
=20
 sub mediawiki_smudge_filename {
 	my $filename =3D shift;
-	$filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
+	$filename =3D~ s{/}{@{[SLASH_REPLACEMENT]}}g;
 	$filename =3D~ s/ /_/g;
 	# Decode forbidden characters encoded in mediawiki_clean_filename
 	$filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/g=
e;
--=20
1.8.3.rc3.18.g21a7b2c
