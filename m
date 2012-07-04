From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 2/3] gitweb: Handle other types of tag in git_print_log
Date: Wed,  4 Jul 2012 11:47:25 +0900
Message-ID: <1341370046-19913-2-git-send-email-namhyung@kernel.org>
References: <1341370046-19913-1-git-send-email-namhyung@kernel.org>
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 04:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmFhE-0004Xj-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 04:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511Ab2GDCwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 22:52:00 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:47898 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495Ab2GDCve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 22:51:34 -0400
X-AuditID: 9c930197-b7b49ae0000027b8-45-4ff3afb37b69
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE7Q.lge.com (Symantec Brightmail Gateway) with SMTP id DF.7D.10168.3BFA3FF4; Wed,  4 Jul 2012 11:51:31 +0900 (KST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1341370046-19913-1-git-send-email-namhyung@kernel.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200980>

There are many types of tags used in S-o-b area [1].
Update the regex to handle them properly. It requires
the tag should be started by a capital letter and ended
by '-by: ' or '-By: '. The only exception is 'Cc: '.

[1] http://lwn.net/Articles/503829/

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 82c5da7..362784d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4486,7 +4486,7 @@ sub git_print_log {
 	# print log
 	my $skip_blank_line = 0;
 	foreach my $line (@$log) {
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+		if ($line =~ m/^\s*([A-Z][-A-Za-z]*-[Bb]y|C[Cc]): /) {
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 				$skip_blank_line = 1;
-- 
1.7.10.4
