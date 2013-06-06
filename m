From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH 14/18] Don't use quotes for empty strings
Date: Thu,  6 Jun 2013 21:34:19 +0200
Message-ID: <1370547263-13558-15-git-send-email-celestin.matte@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 21:36:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfzC-0002R3-O7
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab3FFTgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:36:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44545 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3FFTfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:35:09 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56JYxVI031954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 21:34:59 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56JZ29o021439;
	Thu, 6 Jun 2013 21:35:02 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56JYTp3023108;
	Thu, 6 Jun 2013 21:35:02 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Jun 2013 21:34:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56JYxVI031954
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371152102.25274@wLx49WoHtjFaDixUX3MvDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226549>

Empty strings are replaced by an $EMPTY constant.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index b7a7012..059bd1a 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -41,6 +41,8 @@ Readonly my $NULL_SHA1 =3D> '000000000000000000000000=
0000000000000000';
 # Used on Git's side to reflect empty edit messages on the wiki
 Readonly my $EMPTY_MESSAGE =3D> '*Empty MediaWiki Message*';
=20
+Readonly my $EMPTY =3D> q{};
+
 if (@ARGV !=3D 2) {
 	exit_error_usage();
 }
@@ -161,11 +163,11 @@ sub parse_commands {
 		mw_list($cmd[1]);
 	} elsif ($cmd[0] eq 'import') {
 		die("Invalid arguments for import\n")
-		    if ($cmd[1] eq "" || defined($cmd[2]));
+		    if ($cmd[1] eq $EMPTY || defined($cmd[2]));
 		mw_import($cmd[1]);
 	} elsif ($cmd[0] eq 'option') {
 		die("Too many arguments for option\n")
-		    if ($cmd[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
+		    if ($cmd[1] eq $EMPTY || $cmd[2] eq $EMPTY || defined($cmd[3]));
 		mw_option($cmd[1],$cmd[2]);
 	} elsif ($cmd[0] eq 'push') {
 		mw_push($cmd[1]);
@@ -556,7 +558,7 @@ sub mediawiki_clean {
 	# Mediawiki does not allow blank space at the end of a page and ends =
with a single \n.
 	# This function right trims a string and adds a \n at the end to foll=
ow this rule
 	$string =3D~ s/\s+$//;
-	if ($string eq "" && $page_created) {
+	if ($string eq $EMPTY && $page_created) {
 		# Creating empty pages is forbidden.
 		$string =3D $EMPTY_CONTENT;
 	}
@@ -567,7 +569,7 @@ sub mediawiki_clean {
 sub mediawiki_smudge {
 	my $string =3D shift;
 	if ($string eq $EMPTY_CONTENT) {
-		$string =3D "";
+		$string =3D $EMPTY;
 	}
 	# This \n is important. This is due to mediawiki's way to handle end =
of files.
 	return "${string}\n";
@@ -993,7 +995,7 @@ sub mw_upload_file {
 	} else {
 		# Don't let perl try to interpret file content as UTF-8 =3D> use "ra=
w"
 		my $content =3D run_git("cat-file blob ${new_sha1}", 'raw');
-		if ($content ne "") {
+		if ($content ne $EMPTY) {
 			mw_connect_maybe();
 			$mediawiki->{config}->{upload_url} =3D
 				"${url}/index.php/Special:Upload";
@@ -1035,7 +1037,7 @@ sub mw_push_file {
 	my $newrevid;
=20
 	if ($summary eq $EMPTY_MESSAGE) {
-		$summary =3D '';
+		$summary =3D $EMPTY;
 	}
=20
 	my $new_sha1 =3D $diff_info_split[3];
@@ -1046,7 +1048,7 @@ sub mw_push_file {
=20
 	my ($title, $extension) =3D $complete_file_name =3D~ /^(.*)\.([^\.]*)=
$/;
 	if (!defined($extension)) {
-		$extension =3D "";
+		$extension =3D $EMPTY;
 	}
 	if ($extension eq 'mw') {
 		my $ns =3D get_mw_namespace_id_for_page($complete_file_name);
@@ -1114,7 +1116,7 @@ sub mw_push {
 		if ($force) {
 			print {*STDERR} "Warning: forced push not allowed on a MediaWiki.\n=
";
 		}
-		if ($local eq "") {
+		if ($local eq $EMPTY) {
 			print {*STDERR} "Cannot delete remote branch on a MediaWiki\n";
 			print {*STDOUT} "error ${remote} cannot delete\n";
 			next;
--=20
1.7.9.5
