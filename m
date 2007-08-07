From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] send-email: don't add sender to Cc: if --suppress-from is given.
Date: Tue,  7 Aug 2007 15:12:37 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <1186492357499-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 15:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIOrk-0008Kl-5r
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 15:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762015AbXHGNMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 7 Aug 2007 09:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761594AbXHGNMm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 09:12:42 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:49100 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761189AbXHGNMl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 09:12:41 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IIOrY-0003qN-1X
	for git@vger.kernel.org; Tue, 07 Aug 2007 15:12:40 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l77DCbbe012993
	for <git@vger.kernel.org>; Tue, 7 Aug 2007 15:12:37 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l77DCbuC012992
	for git@vger.kernel.org; Tue, 7 Aug 2007 15:12:37 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc3.13.g7ab3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55251>

Up to now the sender is added to the Cc: list for Signed-off-by and Cc
lines even if --suppress-from is requested.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.=
de>
---
Hello,

Maybe the address should be added for a Cc: line, but not for
Signed-off-by?

Best regards
Uwe

 git-send-email.perl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 39e433b..9d7f6a8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -646,9 +646,11 @@ foreach my $t (@files) {
 			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
 				my $c =3D $2;
 				chomp $c;
-				push @cc, $c;
-				printf("(sob) Adding cc: %s from line '%s'\n",
-					$c, $_) unless $quiet;
+				if (not $suppress_from or unquote_rfc2047($c) eq $from) {
+					push @cc, $c;
+					printf("(sob) Adding cc: %s from line '%s'\n",
+						$c, $_) unless $quiet;
+				}
 			}
 		}
 	}
--=20
1.5.3.rc3.13.g7ab3
