From: =?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
Subject: [PATCH/RFC] gitweb: parse_commit_text encoding fix
Date: Sat,  1 Aug 2009 10:28:43 +0200
Message-ID: <1249115323-17974-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: giuseppe.bilotta@gmail.com,
	=?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 10:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXAFP-0000Ek-MD
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 10:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbZHAIrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 04:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbZHAIrD
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 04:47:03 -0400
Received: from mail.icell.hu ([80.99.238.252]:52359 "EHLO mail.icell.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbZHAIrC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 04:47:02 -0400
X-Greylist: delayed 836 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Aug 2009 04:47:02 EDT
Received: from source.ifleet ([10.1.1.250])
	by mail.icell.hu (8.12.3/8.12.3/Debian-7.2) with ESMTP id n718X2Fk024860;
	Sat, 1 Aug 2009 10:33:02 +0200
Received: from fuge by source.ifleet with local (Exim 4.69)
	(envelope-from <fuge@source.icell.hu>)
	id 1MX9xN-0004gN-MP; Sat, 01 Aug 2009 10:28:45 +0200
X-Mailer: git-send-email 1.6.4.13.ge6580
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124612>

Call to_utf8 when parsing author and committer names, otherwise they wi=
ll appear
with bad encoding if they written by using chop_and_escape_str.

Signed-off-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
---
 gitweb/gitweb.perl |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fbd5ff..06bbf60 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2570,22 +2570,21 @@ sub parse_commit_text {
 		} elsif ((!defined $withparents) && ($line =3D~ m/^parent ([0-9a-fA-=
=46]{40})$/)) {
 			push @parents, $1;
 		} elsif ($line =3D~ m/^author (.*) ([0-9]+) (.*)$/) {
-			$co{'author'} =3D $1;
+			$co{'author'} =3D to_utf8($1);
 			$co{'author_epoch'} =3D $2;
 			$co{'author_tz'} =3D $3;
 			if ($co{'author'} =3D~ m/^([^<]+) <([^>]*)>/) {
-				$co{'author_name'}  =3D $1;
+				$co{'author_name'}  =3D to_utf8($1);
 				$co{'author_email'} =3D $2;
 			} else {
 				$co{'author_name'} =3D $co{'author'};
 			}
 		} elsif ($line =3D~ m/^committer (.*) ([0-9]+) (.*)$/) {
-			$co{'committer'} =3D $1;
+			$co{'committer'} =3D to_utf8($1);
 			$co{'committer_epoch'} =3D $2;
 			$co{'committer_tz'} =3D $3;
-			$co{'committer_name'} =3D $co{'committer'};
 			if ($co{'committer'} =3D~ m/^([^<]+) <([^>]*)>/) {
-				$co{'committer_name'}  =3D $1;
+				$co{'committer_name'}  =3D to_utf8($1);
 				$co{'committer_email'} =3D $2;
 			} else {
 				$co{'committer_name'} =3D $co{'committer'};
--=20
1.6.4.13.ge6580
