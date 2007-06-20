From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] git-send-email: RFC2822 compliant Message-ID
Date: Wed, 20 Jun 2007 07:25:01 -0600
Message-ID: <11823459011323-git-send-email-michael@ndrix.org>
Cc: Michael Hendricks <michael@ndrix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 15:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I10BQ-00050X-Vm
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 15:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbXFTNZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 09:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbXFTNZH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 09:25:07 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44738 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786AbXFTNZE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2007 09:25:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 828EC1904
	for <git@vger.kernel.org>; Wed, 20 Jun 2007 09:25:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 20 Jun 2007 09:25:03 -0400
X-Sasl-enc: 9khZl5TVmRiLte7dREy1Sz2iUcwI/qBVqeEhr2yCAQ3y 1182345903
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id 276B321CAA;
	Wed, 20 Jun 2007 09:25:03 -0400 (EDT)
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: 20070620.034202.35337858.davem@davemloft.net
References: 20070620.034202.35337858.davem@davemloft.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50559>

RFC 2822 section 3.6.4 suggests that a "good method" for generating a
Message-ID is to put the domain name of the host on the right-side of
the "@" character.  Use Perl's Sys::Hostname to do the heavy lifting.
This module has been in the Perl core since version 5.
---
 git-send-email.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7c0c90b..2259f4b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -21,6 +21,7 @@ use warnings;
 use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
+use Sys::Hostname;
 use Git;
 
 package FakeTerm;
@@ -411,9 +412,9 @@ sub extract_valid_address {
 # a random number to the end, in case we are called quicker than
 # 1 second since the last time we were called.
 
-# We'll setup a template for the message id, using the "from" address:
-my $message_id_from = extract_valid_address($from);
-my $message_id_template = "<%s-git-send-email-$message_id_from>";
+# We'll setup a template for the message id, using the hostname:
+my $hostname = hostname();
+my $message_id_template = "<%s-git-send-email\@$hostname>";
 
 sub make_message_id
 {
-- 
1.5.2.2.238.g7cbf2f2
