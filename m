From: =?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
Subject: [PATCH] gitweb: parse_commit_text encoding fix
Date: Sun,  2 Aug 2009 09:42:24 +0200
Message-ID: <1249198944-19630-1-git-send-email-zfuzesi@eaglet.hu>
References: <9ab80d150908010955l3710c54bp9e2716570fd1d5ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 09:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXVmY-0007rQ-Ph
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 09:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbZHBHqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Aug 2009 03:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbZHBHqy
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 03:46:54 -0400
Received: from mail.icell.hu ([80.99.238.252]:52109 "EHLO mail.icell.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbZHBHqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 03:46:53 -0400
Received: from source.ifleet ([10.1.1.250])
	by mail.icell.hu (8.12.3/8.12.3/Debian-7.2) with ESMTP id n727khFk003990;
	Sun, 2 Aug 2009 09:46:52 +0200
Received: from fuge by source.ifleet with local (Exim 4.69)
	(envelope-from <fuge@source.icell.hu>)
	id 1MXVi7-000577-05; Sun, 02 Aug 2009 09:42:27 +0200
X-Mailer: git-send-email 1.6.4.13.ge6580
In-Reply-To: <9ab80d150908010955l3710c54bp9e2716570fd1d5ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124670>

Call to_utf8 when parsing author and committer names, otherwise they wi=
ll appear
with bad encoding if they written by using chop_and_escape_str.

Signed-off-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
---
 gitweb/gitweb.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fbd5ff..4f05194 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2570,7 +2570,7 @@ sub parse_commit_text {
 		} elsif ((!defined $withparents) && ($line =3D~ m/^parent ([0-9a-fA-=
=46]{40})$/)) {
 			push @parents, $1;
 		} elsif ($line =3D~ m/^author (.*) ([0-9]+) (.*)$/) {
-			$co{'author'} =3D $1;
+			$co{'author'} =3D to_utf8($1);
 			$co{'author_epoch'} =3D $2;
 			$co{'author_tz'} =3D $3;
 			if ($co{'author'} =3D~ m/^([^<]+) <([^>]*)>/) {
@@ -2580,10 +2580,9 @@ sub parse_commit_text {
 				$co{'author_name'} =3D $co{'author'};
 			}
 		} elsif ($line =3D~ m/^committer (.*) ([0-9]+) (.*)$/) {
-			$co{'committer'} =3D $1;
+			$co{'committer'} =3D to_utf8($1);
 			$co{'committer_epoch'} =3D $2;
 			$co{'committer_tz'} =3D $3;
-			$co{'committer_name'} =3D $co{'committer'};
 			if ($co{'committer'} =3D~ m/^([^<]+) <([^>]*)>/) {
 				$co{'committer_name'}  =3D $1;
 				$co{'committer_email'} =3D $2;
--=20
1.6.4.13.ge6580
