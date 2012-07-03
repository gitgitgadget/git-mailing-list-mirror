From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/3] gitweb: Get rid of unnecessary check of $signoff
Date: Tue,  3 Jul 2012 15:02:55 +0900
Message-ID: <1341295377-22083-2-git-send-email-namhyung@kernel.org>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 08:07:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlwGa-000089-2J
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 08:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933184Ab2GCGHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 02:07:09 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:47075 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486Ab2GCGHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 02:07:08 -0400
X-AuditID: 9c93016f-b7bccae00000345c-a2-4ff28c0ad41a
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id C7.88.13404.A0C82FF4; Tue,  3 Jul 2012 15:07:06 +0900 (KST)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200898>

If $signoff set to 1, the $line would be handled in
the if statement for the both cases. So the outer of
the conditional always sees the $signoff always set
to 0 and no need to check it. Thus we can finally get
rid of it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 gitweb/gitweb.perl |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 55e0e9e..7585e08 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4484,27 +4484,20 @@ sub git_print_log {
 	}
 
 	# print log
-	my $signoff = 0;
 	my $empty = 0;
 	foreach my $line (@$log) {
 		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			$signoff = 1;
 			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
-				next;
-			} else {
-				# remove signoff lines
-				next;
 			}
-		} else {
-			$signoff = 0;
+			next;
 		}
 
 		# print only one empty line
 		# do not print empty line after signoff
 		if ($line eq "") {
-			next if ($empty || $signoff);
+			next if ($empty);
 			$empty = 1;
 		} else {
 			$empty = 0;
-- 
1.7.10.2
