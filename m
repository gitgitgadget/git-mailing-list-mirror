From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 3/3] gitweb: Add support to Link: tag
Date: Tue,  3 Jul 2012 15:02:57 +0900
Message-ID: <1341295377-22083-4-git-send-email-namhyung@kernel.org>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 08:07:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlwGa-000089-IY
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 08:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933383Ab2GCGHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 02:07:12 -0400
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:47075 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab2GCGHL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 02:07:11 -0400
X-AuditID: 9c93016f-b7bccae00000345c-d3-4ff28c0d8cfb
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id 6F.88.13404.D0C82FF4; Tue,  3 Jul 2012 15:07:09 +0900 (KST)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200899>

The tip tree is the one of major subsystem tree in the
Linux kernel project. On the tip tree, the Link: tag is
used for tracking the original discussion or context.
Since it's ususally in the s-o-b area, it'd be better
using same style with others.

Also as it tends to contain a message-id sent from git
send-email, a part of the line which has more than 8
(hex-)digit characters would set a wrong hyperlink
like [1]. Fix it by not using format_log_line_html().

[1] git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=08942f6d5d992e9486b07653fd87ea8182a22fa0

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 gitweb/gitweb.perl |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e0701af..d07bcb7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4493,6 +4493,13 @@ sub git_print_log {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 			}
 			next;
+		} elsif ($line =~ m,^ *link[ :](http://[\w/~.@%&=?+-]*),i) {
+			$empty = 0;
+			if (! $opts{'-remove_signoff'}) {
+				print "<span class=\"signoff\">Link: <a href=\"" . esc_html($1) . "\">" .
+					esc_html($1) . "</a></span><br/>\n";
+			}
+			next;
 		}
 
 		# print only one empty line
-- 
1.7.10.2
