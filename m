From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 4/9] Change the scope of the $cc variable as it is not needed outside of send_message.
Date: Wed, 25 Apr 2007 19:37:18 -0700
Message-ID: <11775550433288-git-send-email-robbat2@gentoo.org>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
 <11775550432104-git-send-email-robbat2@gentoo.org>
 <1177555043272-git-send-email-robbat2@gentoo.org>
 <11775550432268-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:44:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgtyH-0001K2-5u
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbXDZCoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbXDZCoV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:44:21 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:48022 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754688AbXDZCoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:44:12 -0400
Received: (qmail 18719 invoked from network); 26 Apr 2007 02:44:11 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:44:11 +0000
Received: (qmail 18858 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32451 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
In-Reply-To: <11775550432268-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45605>

From: Robin H. Johnson <robbat2@gentoo.org>

$cc is only used inside the send_message scope, so lets clean it out of the global scope.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8af235f..5210a40 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -379,7 +379,7 @@ if (@files) {
 }
 
 # Variables we set as part of the loop over files
-our ($message_id, $cc, %mail, $subject, $reply_to, $references, $message);
+our ($message_id, %mail, $subject, $reply_to, $references, $message);
 
 sub extract_valid_address {
 	my $address = shift;
@@ -420,7 +420,6 @@ sub make_message_id
 
 
 
-$cc = "";
 $time = time - scalar $#files;
 
 sub unquote_rfc2047 {
@@ -448,6 +447,7 @@ sub send_message
 		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
 		$from = "\"$name\"$addr";
 	}
+	my $cc = join(", ", unique_email_list(@cc));
 	my $ccline = "";
 	if ($cc ne '') {
 		$ccline = "\nCc: $cc";
@@ -594,7 +594,6 @@ foreach my $t (@files) {
 		$message = "From: $author_not_sender\n\n$message";
 	}
 
-	$cc = join(", ", unique_email_list(@cc));
 
 	send_message();
 
-- 
1.5.2.rc0.43.g2f4c7
