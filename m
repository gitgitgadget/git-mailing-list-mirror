From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH 2/2] git-send-email: use locale encoding for compose
Date: Thu,  4 Oct 2012 00:05:31 +0200
Message-ID: <1349301931-11912-2-git-send-email-krzysiek@podlesie.net>
References: <1349301931-11912-1-git-send-email-krzysiek@podlesie.net>
Cc: Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:01:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtKr-0001DP-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab2JCWNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 18:13:48 -0400
Received: from shrek-modem2.podlesie.net ([83.13.132.46]:38124 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab2JCWNr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 18:13:47 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2012 18:13:47 EDT
Received: from geronimo.kostuchna.emnet (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id C764A7EC;
	Thu,  4 Oct 2012 00:07:05 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.2.2.g1c3c581
In-Reply-To: <1349301931-11912-1-git-send-email-krzysiek@podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206950>

The introduction email (--compose option) use UTF-8 as default encoding.
The current locale encoding is much better default value.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 git-send-email.perl | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 107e814..139bb35 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -590,6 +590,16 @@ sub get_patch_subject {
 	die "No subject line in $fn ?";
 }
 
+sub locale_encoding {
+	my $encoding = "UTF-8";
+	eval {
+		require I18N::Langinfo;
+		I18N::Langinfo->import(qw(langinfo CODESET));
+		$encoding = langinfo(CODESET());
+	};
+	return $encoding;
+}
+
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
@@ -643,7 +653,7 @@ EOT
 		} elsif (/^\n$/) {
 			$in_body = 1;
 			if (!defined $compose_encoding) {
-				$compose_encoding = "UTF-8";
+				$compose_encoding = locale_encoding();
 			}
 			if ($need_8bit_cte) {
 				print $c2 "MIME-Version: 1.0\n",
-- 
1.7.12.2.2.g1c3c581
