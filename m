From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] [RFC] send-email: honor --suppress-from --signed-off-cc
Date: Tue, 10 Jul 2007 19:02:44 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <11840869671745-git-send-email-ukleinek@informatik.uni-freiburg.de>
References: <11840869641759-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 19:02:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8J74-0000qa-Rf
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 19:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbXGJRC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 13:02:56 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755376AbXGJRCz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 13:02:55 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:50612 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754189AbXGJRCy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 13:02:54 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I8J6z-00025M-83; Tue, 10 Jul 2007 19:02:53 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6AH2pwe025015;
	Tue, 10 Jul 2007 19:02:51 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6AH2pqT025014;
	Tue, 10 Jul 2007 19:02:51 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc0.823.gdedbf
In-Reply-To: <11840869641759-git-send-email-ukleinek@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52094>

=46rom: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de>

---
Not sure, if this is how it should be.  Maybe we need another flag?

Best regards
Uwe

 git-send-email.perl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8b3d450..a03153b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -641,9 +641,11 @@ foreach my $t (@files) {
 			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
 				my $c =3D $2;
 				chomp $c;
-				push @cc, $c;
-				printf("(sob) Adding cc: %s from line '%s'\n",
-					$c, $_) unless $quiet;
+				if (!$suppress_from or $c eq $from) {
+					push @cc, $c;
+					printf("(sob) Adding cc: %s from line '%s'\n",
+						$c, $_) unless $quiet;
+				}
 			}
 		}
 	}
--=20
1.5.3.rc0.823.gdedbf
