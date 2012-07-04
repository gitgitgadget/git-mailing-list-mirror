From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 3/3] gitweb: Add support to Link: tag
Date: Wed,  4 Jul 2012 11:47:26 +0900
Message-ID: <1341370046-19913-3-git-send-email-namhyung@kernel.org>
References: <1341370046-19913-1-git-send-email-namhyung@kernel.org>
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 04:52:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmFha-0005Bt-0E
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 04:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725Ab2GDCwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 22:52:01 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:47898 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757501Ab2GDCvf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 22:51:35 -0400
X-AuditID: 9c930197-b7b49ae0000027b8-47-4ff3afb3842b
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE7Q.lge.com (Symantec Brightmail Gateway) with SMTP id 40.8D.10168.3BFA3FF4; Wed,  4 Jul 2012 11:51:31 +0900 (KST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1341370046-19913-1-git-send-email-namhyung@kernel.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200982>

The tip tree is the one of major subsystem tree in the
Linux kernel project. On the tip tree, the Link: (or
similar Buglink:) tag is used for tracking the original
discussion or context. Since it's ususally in the S-o-b
area, it'd be better using same style with others.

Also as it tends to contain a message-id sent from git
send-email, a part of the line would set a wrong hyperlink
like [1]. Fix it by not using format_log_line_html().

[1] git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=08942f6d5d992e9486b07653fd87ea8182a22fa0

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 gitweb/gitweb.perl |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 362784d..3d6a705 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4494,6 +4494,16 @@ sub git_print_log {
 			next;
 		}
 
+		if ($line =~ m,\s*([a-z]*link): (https?://\S+),i) {
+			if (! $opts{'-remove_signoff'}) {
+				print "<span class=\"signoff\">" . esc_html($1) . ": " .
+					"<a href=\"" . esc_html($2) . "\">" . esc_html($2) . "</a>" .
+					"</span><br/>\n";
+				$skip_blank_line = 1;
+			}
+			next;
+		}
+
 		# print only one empty line
 		# do not print empty line after signoff
 		if ($line eq "") {
-- 
1.7.10.4
