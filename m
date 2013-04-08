From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: [PATCH 4/4] gitweb: Fix broken blob action parameters on blob/commitdiff pages
Date: Mon, 08 Apr 2013 22:10:21 +0200
Message-ID: <m2vc7wbx76.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 22:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPIOp-0003L5-7p
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 22:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856Ab3DHUKi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 16:10:38 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:57430 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964842Ab3DHUKh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 16:10:37 -0400
Received: by mail-bk0-f52.google.com with SMTP id it16so3255892bkc.39
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=V7eREKInd4+HaRTqDyzuzZ3NyzEmHPpdN/JscQuq6Tc=;
        b=SpCdKhzx4finPiANr1AgaZqQInpDYBemTrIiADEkTDI/oK9DyP03879+aYM1Wl/guq
         U0iktQ7uT0VI85vaTlzh5Gfv/VORB+OOd/kn9xqzg4JTyL7291OLKopFTPDB90sPYDTW
         f2rNPO3ZQi2JC29svpxlZEB8uCkS5abhYv/M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=V7eREKInd4+HaRTqDyzuzZ3NyzEmHPpdN/JscQuq6Tc=;
        b=cwZ27oqYydBnSEQsJLZnsi/N2GYum0OjDB3rjKhHAlTAaRMptl4kKmdvUmC5t5WroT
         BhQCi2LhPGVReGVZdxZebVRIjKI+Oz5gqgUEZTK2zIiezREdaOwJCtBBbBGys9e5+QcJ
         ozDh4oAIsUYPO71FDMcVm9q5xCkN4BV3AH39irFeSeZ6RMK5YRX6Kuf2Clw6xo/j8KHF
         bZUd1R7TfZyxZTOn7162VETNDJLfXU7xwHsB/nYlXrk65icBMI5Hswl17X5VyHxCHwxe
         dDyilfbYVowRNUARng3qBBP8Kd3orT/rQFf7PoNcagLCqx9kj6B52zAu098sLpzBdyoG
         y5Bw==
X-Received: by 10.205.13.138 with SMTP id pm10mr11680659bkb.73.1365451835305;
        Mon, 08 Apr 2013 13:10:35 -0700 (PDT)
Received: from zahir.local (p5083D2BC.dip.t-dialin.net. [80.131.210.188])
        by mx.google.com with ESMTPS id gu14sm13107711bkc.1.2013.04.08.13.10.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 13:10:34 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQmWJJqXmhYVJBATURxUL+/hOKYZl/l1dop/6RIVifp3KkZA2sy85kYy/dgAjai9iOL4bWF2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220510>

=46ix broken blob action parameters on blobdiff and commitdiff pages by
explicitly passing variables instead of relying on global ones.

(The broken parameters on blob links lead to blob pages which show the
blob but with a hash instead of a commit message and have broken
blob_plain (404 - Cannot find file) and tree links (404 - Reading tree
failed))

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1309196..995e8fb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2258,7 +2258,7 @@ sub format_extended_diff_header_line {
=20
 # format from-file/to-file diff header
 sub format_diff_from_to_header {
-	my ($from_line, $to_line, $diffinfo, $from, $to, @parents) =3D @_;
+	my ($from_line, $to_line, $diffinfo, $from, $to, $hash, @parents) =3D=
 @_;
 	my $line;
 	my $result =3D '';
=20
@@ -2324,7 +2324,7 @@ sub format_diff_from_to_header {
=20
 # create note for patch simplified by combined diff
 sub format_diff_cc_simplified {
-	my ($diffinfo, @parents) =3D @_;
+	my ($diffinfo, $hash, @parents) =3D @_;
 	my $result =3D '';
=20
 	$result .=3D "<div class=3D\"diff header\">" .
@@ -3592,7 +3592,8 @@ sub parse_ls_tree_line {
=20
 # generates _two_ hashes, references to which are passed as 2 and 3 ar=
gument
 sub parse_from_to_diffinfo {
-	my ($diffinfo, $from, $to, @parents) =3D @_;
+	my ($diffinfo, $from, $to, $hash, @parents) =3D @_;
+	my ($hash_parent) =3D $parents[0];
=20
 	if ($diffinfo->{'nparents'}) {
 		# combined diff
@@ -5312,7 +5313,7 @@ sub git_patchset_body {
 			if ($is_combined) {
 				while ($to_name ne $diffinfo->{'to_file'}) {
 					print "<div class=3D\"patch\" id=3D\"patch". ($patch_idx+1) ."\">=
\n" .
-					      format_diff_cc_simplified($diffinfo, @hash_parents) .
+					      format_diff_cc_simplified($diffinfo, $hash, @hash_parents) =
=2E
 					      "</div>\n";  # class=3D"patch"
=20
 					$patch_idx++;
@@ -5324,7 +5325,7 @@ sub git_patchset_body {
 			}
=20
 			# modifies %from, %to hashes
-			parse_from_to_diffinfo($diffinfo, \%from, \%to, @hash_parents);
+			parse_from_to_diffinfo($diffinfo, \%from, \%to, $hash, @hash_parent=
s);
=20
 			# this is first patch for raw difftree line with $patch_idx index
 			# we index @$difftree array from 0, but number patches from 1
@@ -5367,7 +5368,7 @@ sub git_patchset_body {
=20
 		print format_diff_from_to_header($last_patch_line, $patch_line,
 		                                 $diffinfo, \%from, \%to,
-		                                 @hash_parents);
+		                                 $hash, @hash_parents);
=20
 		# the patch itself
 	LINE:
@@ -5404,7 +5405,7 @@ sub git_patchset_body {
=20
 		# generate anchor for "patch" links in difftree / whatchanged part
 		print "<div class=3D\"patch\" id=3D\"patch". ($patch_idx+1) ."\">\n"=
 .
-		      format_diff_cc_simplified($diffinfo, @hash_parents) .
+		      format_diff_cc_simplified($diffinfo, $hash, @hash_parents) .
 		      "</div>\n";  # class=3D"patch"
=20
 		$patch_number++;
--=20
1.7.10.4
