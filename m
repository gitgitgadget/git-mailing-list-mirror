From: brilliantov@inbox.ru
Subject: [PATCH] git-send-email: Delete additional From message body
Date: Wed, 26 Aug 2015 12:25:20 +0300
Message-ID: <1440581120-14156-1-git-send-email-brilliantov@inbox.ru>
Cc: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 11:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUWwQ-0003KC-FV
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 11:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbbHZJYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 05:24:18 -0400
Received: from mail.byterg.ru ([217.12.248.131]:47892 "EHLO mail.byterg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbbHZJYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 05:24:18 -0400
Received: from [192.168.10.51] (helo=kirill.byterg.ru)
	 by mail.byterg.ru with esmtp  (envelope-from <brilliantov@inbox.ru>)
	 id 1ZUW81-0007dv-4w ; Wed, 26 Aug 2015 12:32:17 +0400
X-Mailer: git-send-email 2.5.0.421.g33f2c4f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276603>

Additional From added to message body if git-send-email run
with --from parameters

Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
---
 git-send-email.perl | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b660cc2..92ec74a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1522,24 +1522,21 @@ foreach my $t (@files) {
 		$subject = quote_subject($subject, $auto_8bit_encoding);
 	}
 
-	if (defined $sauthor and $sauthor ne $sender) {
-		$message = "From: $author\n\n$message";
-		if (defined $author_encoding) {
-			if ($has_content_type) {
-				if ($body_encoding eq $author_encoding) {
-					# ok, we already have the right encoding
-				}
-				else {
-					# uh oh, we should re-encode
-				}
+	if (defined $author_encoding) {
+		if ($has_content_type) {
+			if ($body_encoding eq $author_encoding) {
+				# ok, we already have the right encoding
 			}
 			else {
-				$xfer_encoding = '8bit' if not defined $xfer_encoding;
-				$has_content_type = 1;
-				push @xh,
-				  "Content-Type: text/plain; charset=$author_encoding";
+				# uh oh, we should re-encode
 			}
 		}
+		else {
+			$xfer_encoding = '8bit' if not defined $xfer_encoding;
+			$has_content_type = 1;
+			push @xh,
+			  "Content-Type: text/plain; charset=$author_encoding";
+		}
 	}
 	if (defined $target_xfer_encoding) {
 		$xfer_encoding = '8bit' if not defined $xfer_encoding;
-- 
2.1.4
