From: =?utf-8?q?Adam=20Pi=C4=85tyszek?= <ediap@users.sourceforge.net>
Subject: [PATCH] git-send-email.perl: check for lines longer than 998 characters
Date: Fri, 18 Jan 2008 08:47:38 +0100
Message-ID: <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net>
References: <20080117153252.GD2816@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?utf-8?q?Adam=20Pi=C4=85tyszek?= <ediap@users.sourceforge.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 08:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFm51-0006vM-K5
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 08:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbYARHzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 02:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYARHzb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 02:55:31 -0500
Received: from ananke.et.put.poznan.pl ([150.254.29.121]:50312 "EHLO
	ananke.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbYARHza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 02:55:30 -0500
Received: from cygnus.et.put.poznan.pl (cygnus.et.put.poznan.pl [150.254.29.66])
	by ananke.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0I7o4qq010212;
	Fri, 18 Jan 2008 08:50:04 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from lespaul (pc1077.et.put.poznan.pl [150.254.11.77])
	by cygnus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with SMTP id m0I7lce22520;
	Fri, 18 Jan 2008 08:47:38 +0100 (MET)
Received: by lespaul (sSMTP sendmail emulation); Fri, 18 Jan 2008 08:47:38 +0100
X-Mailer: git-send-email 1.5.4.rc3.4.g1633
In-Reply-To: <20080117153252.GD2816@coredump.intra.peff.net>
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.17.233600
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_900_999 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __STOCK_PHRASE_7 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70972>

According to RFC2822 (Internet Message Format), each line of a message
must be no more than 998 characters. This patch adds a check for the
length of each body line of a message and dies if the length exceeds
the limit.

Signed-off-by: Adam Pi=C4=85tyszek <ediap@users.sourceforge.net>
---
 git-send-email.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e47994a..6d623ea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -748,6 +748,9 @@ foreach my $t (@files) {
 				$header_done =3D 1;
 			}
 		} else {
+			if (length($_) > 998) {
+				die "(msg) This message contains lines longer than 998 characters,=
\nwhich can not be correctly send as plain text using SMTP.\n";
+			}
 			$message .=3D  $_;
 			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
 				my $c =3D $2;
--=20
1.5.4.rc3.4.g1633
