From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH 02/18] Change style of some regular expressions to make them clearer
Date: Thu,  6 Jun 2013 21:34:07 +0200
Message-ID: <1370547263-13558-3-git-send-email-celestin.matte@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 21:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfxY-0000aO-BR
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab3FFTex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:34:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44521 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab3FFTev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:34:51 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56JYk6h031887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 21:34:46 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56JYnep021391;
	Thu, 6 Jun 2013 21:34:49 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56JYTop023108;
	Thu, 6 Jun 2013 21:34:49 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Jun 2013 21:34:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56JYk6h031887
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371152087.14379@gE6mXvN0oKCSnCnefok/3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226535>

- Remove m modifier when useless (m// and // was used randomly; this ma=
kes the
code more coherent)
- Remove stringy split (split('c', ...) instead of split(/c/, ...))
- Use {}{} instead of /// when slashes or used inside the regexp so as =
not to
escape it.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 83cf292..482cd95 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -121,7 +121,7 @@ chomp($dumb_push);
 $dumb_push =3D ($dumb_push eq "true");
=20
 my $wiki_name =3D $url;
-$wiki_name =3D~ s/[^\/]*:\/\///;
+$wiki_name =3D~ s{[^/]*://}{};
 # If URL is like http://user:password@example.com/, we clearly don't
 # want the password in $wiki_name. While we're there, also remove user
 # and '@' sign, to avoid author like MWUser@HTTPUser@host.com
@@ -762,7 +762,7 @@ sub get_more_refs {
 	my @refs;
 	while (1) {
 		my $line =3D <STDIN>;
-		if ($line =3D~ m/^$cmd (.*)$/) {
+		if ($line =3D~ /^$cmd (.*)$/) {
 			push(@refs, $1);
 		} elsif ($line eq "\n") {
 			return @refs;
@@ -1168,11 +1168,11 @@ sub mw_push_revision {
 		my @local_ancestry =3D split(/\n/, run_git("rev-list --boundary --pa=
rents $local ^$parsed_sha1"));
 		my %local_ancestry;
 		foreach my $line (@local_ancestry) {
-			if (my ($child, $parents) =3D $line =3D~ m/^-?([a-f0-9]+) ([a-f0-9 =
]+)/) {
-				foreach my $parent (split(' ', $parents)) {
+			if (my ($child, $parents) =3D $line =3D~ /^-?([a-f0-9]+) ([a-f0-9 ]=
+)/) {
+				foreach my $parent (split(/ /, $parents)) {
 					$local_ancestry{$parent} =3D $child;
 				}
-			} elsif (!$line =3D~ m/^([a-f0-9]+)/) {
+			} elsif (!$line =3D~ /^([a-f0-9]+)/) {
 				die "Unexpected output from git rev-list: $line";
 			}
 		}
@@ -1190,10 +1190,10 @@ sub mw_push_revision {
 		# history (linearized with --first-parent)
 		print STDERR "Warning: no common ancestor, pushing complete history\=
n";
 		my $history =3D run_git("rev-list --first-parent --children $local")=
;
-		my @history =3D split('\n', $history);
+		my @history =3D split(/\n/, $history);
 		@history =3D @history[1..$#history];
 		foreach my $line (reverse @history) {
-			my @commit_info_split =3D split(/ |\n/, $line);
+			my @commit_info_split =3D split(/[ \n]/, $line);
 			push(@commit_pairs, \@commit_info_split);
 		}
 	}
@@ -1272,7 +1272,7 @@ sub get_mw_namespace_id {
 		# Look at configuration file, if the record for that namespace is
 		# already cached. Namespaces are stored in form:
 		# "Name_of_namespace:Id_namespace", ex.: "File:6".
-		my @temp =3D split(/[\n]/, run_git("config --get-all remote."
+		my @temp =3D split(/\n/, run_git("config --get-all remote."
 						. $remotename .".namespaceCache"));
 		chomp(@temp);
 		foreach my $ns (@temp) {
--=20
1.7.9.5
