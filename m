From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 07/22] git-remote-mediawiki: Change style of some regular expressions
Date: Fri,  7 Jun 2013 23:42:08 +0200
Message-ID: <1370641344-4253-8-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4RR-00087U-Ky
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755Ab3FGVnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55293 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756525Ab3FGVnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:09 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57Lh0Ug003254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:00 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57Lh35O029576;
	Fri, 7 Jun 2013 23:43:03 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRi019409;
	Fri, 7 Jun 2013 23:43:03 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:43:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57Lh0Ug003254
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246182.91297@pclMNQb7SYSc5OATA/WwiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226723>

- Remove m modifier when useless (m// and // was used randomly; this ma=
kes the
code more coherent)
- Remove stringy split (split('c', ...) instead of split(/c/, ...))
- Use {}{} instead of /// when slashes are used inside the regexp so as=
 not to
escape it.
A "split ' '" is turned into a "split / /", which changes its behaviour=
: the old
method matched a run of whtespaces (/\s*/), while the new one will matc=
h a
single whitespace, which is what we want here.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   20 ++++++++++---------=
-
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index a5c963b..482cd95 100755
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
@@ -565,7 +565,7 @@ sub mediawiki_smudge {
=20
 sub mediawiki_clean_filename {
 	my $filename =3D shift;
-	$filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
+	$filename =3D~ s{$SLASH_REPLACEMENT}{/}g;
 	# [, ], |, {, and } are forbidden by MediaWiki, even URL-encoded.
 	# Do a variant of URL-encoding, i.e. looks like URL-encoding,
 	# but with _ added to prevent MediaWiki from thinking this is
@@ -579,7 +579,7 @@ sub mediawiki_clean_filename {
=20
 sub mediawiki_smudge_filename {
 	my $filename =3D shift;
-	$filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
+	$filename =3D~ s{/}{$SLASH_REPLACEMENT}g;
 	$filename =3D~ s/ /_/g;
 	# Decode forbidden characters encoded in mediawiki_clean_filename
 	$filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/g=
e;
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
