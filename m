From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-format-patch: Always add a blank line between headers and body.
Date: Mon, 27 Feb 2006 14:09:56 +0100
Message-ID: <874q2lhrrv.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 27 14:10:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDi8e-0003R2-BI
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 14:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWB0NKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 08:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWB0NKE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 08:10:04 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:48313 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751180AbWB0NKC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 08:10:02 -0500
Received: from adsl-62-167-33-27.adslplus.ch ([62.167.33.27] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FDi8V-0006SE-Vl
	for git@vger.kernel.org; Mon, 27 Feb 2006 07:10:02 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 214CF109F65; Mon, 27 Feb 2006 14:09:56 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 62.167.33.27
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL,SPF_HELO_SOFTFAIL autolearn=no 
	version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16844>

If the second line of the commit message isn't empty, git-format-patch
needs to add an empty line in order to generate a properly formatted
mail. Otherwise git-rebase drops the rest of the commit message.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 git-format-patch.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

dcd0ed6ced98990c92a32416c0acc3ec298f5b91
diff --git a/git-format-patch.sh b/git-format-patch.sh
index eb75de4..2bd2639 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -174,7 +174,7 @@ titleScript='
 process_one () {
 	perl -w -e '
 my ($keep_subject, $num, $signoff, $commsg) = @ARGV;
-my ($signoff_pattern, $done_header, $done_subject, $signoff_seen,
+my ($signoff_pattern, $done_header, $done_subject, $done_separator, $signoff_seen,
     $last_was_signoff);
 
 if ($signoff) {
@@ -228,6 +228,11 @@ while (<FH>) {
 	$done_subject = 1;
 	next;
     }
+    unless ($done_separator) {
+        print "\n";
+        $done_separator = 1;
+        next if (/^$/);
+    }
 
     $last_was_signoff = 0;
     if (/Signed-off-by:/i) {
-- 
1.2.3.gb348-dirty


-- 
Alexandre Julliard
julliard@winehq.org
