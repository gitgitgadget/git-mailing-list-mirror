From: Holger =?utf-8?B?V2Vpw58=?= <holger@zedat.fu-berlin.de>
Subject: [PATCH] gitweb: Fix snapshots requested via PATH_INFO
Date: Tue, 31 Mar 2009 18:16:36 +0200
Organization: Freie =?utf-8?Q?Universit=C3=A4t?= Berlin
Message-ID: <20090331161636.GV30233737@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 18:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loh3R-0007cV-Gx
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759566AbZCaQlm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 12:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbZCaQlm
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:41:42 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54909 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753522AbZCaQll (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 12:41:41 -0400
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2009 12:41:41 EDT
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1Logdj-0007p2-Bp>; Tue, 31 Mar 2009 18:16:39 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1Logdg-0008A3-Kp>; Tue, 31 Mar 2009 18:16:36 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1Logdg-02F3Iv-Hs>; Tue, 31 Mar 2009 18:16:36 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115282>

=46ix the detection of the requested snapshot format, which failed for
PATH_INFO URLs since the references to the hashes which describe the
supported snapshot formats weren't dereferenced appropriately.

Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33ef190..3f99361 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -688,10 +688,10 @@ sub evaluate_path_info {
 		# extensions. Allowed extensions are both the defined suffix
 		# (which includes the initial dot already) and the snapshot
 		# format key itself, with a prepended dot
-		while (my ($fmt, %opt) =3D each %known_snapshot_formats) {
+		while (my ($fmt, $opt) =3D each %known_snapshot_formats) {
 			my $hash =3D $refname;
 			my $sfx;
-			$hash =3D~ s/(\Q$opt{'suffix'}\E|\Q.$fmt\E)$//;
+			$hash =3D~ s/(\Q$opt->{'suffix'}\E|\Q.$fmt\E)$//;
 			next unless $sfx =3D $1;
 			# a valid suffix was found, so set the snapshot format
 			# and reset the hash parameter
--=20
1.6.2.1
