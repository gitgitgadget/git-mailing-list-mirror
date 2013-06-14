From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 09/31] git-remote-mediawiki: Change the behaviour of a split
Date: Fri, 14 Jun 2013 15:50:17 +0200
Message-ID: <1371217839-23017-10-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:53:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnURT-0002gj-3K
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab3FNNww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:52:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44540 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab3FNNu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:50:57 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDosaT020578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:50:54 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDouAe013352;
	Fri, 14 Jun 2013 15:50:56 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqg1016142;
	Fri, 14 Jun 2013 15:50:56 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 14 Jun 2013 15:50:55 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227862>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

A "split ' '" is turned into a "split / /", which changes its behaviour=
: the
old method matched a run of whitespaces (/\s*/), while the new one will=
 match a
single space, which is what we want here. Indeed, in other contexts,
changing split(' ') to split(/ /) could potentially be a regression, ho=
wever,
here, when parsing the output of "rev-list --parents", whose output SHA=
-1's are
each separated by a single space, splitting on a single space is perfec=
tly
correct.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index b65e71c..74344f6 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1168,7 +1168,7 @@ sub mw_push_revision {
 		my %local_ancestry;
 		foreach my $line (@local_ancestry) {
 			if (my ($child, $parents) =3D $line =3D~ /^-?([a-f0-9]+) ([a-f0-9 ]=
+)/) {
-				foreach my $parent (split(' ', $parents)) {
+				foreach my $parent (split(/ /, $parents)) {
 					$local_ancestry{$parent} =3D $child;
 				}
 			} elsif (!$line =3D~ /^([a-f0-9]+)/) {
--=20
1.8.3.rc3.49.g4e74807
