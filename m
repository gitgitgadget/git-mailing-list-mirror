From: Joe Perches <joe@perches.com>
Subject: [PATCH] git-send-email.perl: Don't add header "In-Reply-To:" when
 --no-chain-reply-to set
Date: Sat, 16 May 2009 10:15:03 -0700
Message-ID: <1242494103.4070.17.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 16 19:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5NcW-0004pX-Oy
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 19:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbZEPRPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 13:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbZEPRPH
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 13:15:07 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:3246 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZEPRPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 13:15:06 -0400
Received: from [192.168.1.158] ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id KAA16840
	for <git@vger.kernel.org>; Sat, 16 May 2009 10:14:54 -0700
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119365>

using
  git format-patch --thread=shallow -o <foo>
and
  git send-email --no-thread --no-chain-reply-to <foo>

duplicates the headers

  In-Reply-To:
  References: 

Signed-off-by: Joe Perches <joe@perches.com>

`diff --git a/git-send-email.perl b/git-send-email.perl
index cccbf45..b57bce4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1137,7 +1137,7 @@ foreach my $t (@files) {
 	send_message();
 
 	# set up for the next message
-	if ($chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
+	if ($chain_reply_to && (!defined $reply_to || length($reply_to) == 0)) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
