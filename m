From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] send-email: don't call methods on undefined values
Date: Sun,  8 Sep 2013 20:54:34 +0000
Message-ID: <1378673674-97212-1-git-send-email-sandals@crustytoothpaste.net>
Cc: artagnon@gmail.com, mst@redhat.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 22:54:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm0L-00080Z-7H
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233Ab3IHUyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:54:41 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60147 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203Ab3IHUyl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 16:54:41 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CBD4028074;
	Sun,  8 Sep 2013 20:54:38 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.236.g382490f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234263>

If SSL verification is enabled in git send-email, we could attempt to call a
method on an undefined value if the verification failed, since $smtp would end
up being undef.  Look up the error string in a way that will produce a helpful
error message and not cause further errors.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2162478..3782c3b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1234,7 +1234,7 @@ X-Mailer: git-send-email $gitversion
 				if ($smtp->code == 220) {
 					$smtp = Net::SMTP::SSL->start_SSL($smtp,
 									  ssl_verify_params())
-						or die "STARTTLS failed! ".$smtp->message;
+						or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
 					$smtp_encryption = '';
 					# Send EHLO again to receive fresh
 					# supported commands
-- 
1.8.4.rc3
