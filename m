From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] git-send-email.perl: Really add angle brackets to In-Reply-To if necessary
Date: Sun,  9 Dec 2007 18:17:28 +0100
Message-ID: <1197220648-20433-1-git-send-email-mh@glandium.org>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 18:17:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Pmt-0003i7-Ek
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 18:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbXLIRRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 12:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbXLIRRb
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 12:17:31 -0500
Received: from smtp28.orange.fr ([80.12.242.101]:57311 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbXLIRRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 12:17:30 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2816.orange.fr (SMTP Server) with ESMTP id 90974700009B
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 18:17:29 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2816.orange.fr (SMTP Server) with ESMTP id 746C8700008D;
	Sun,  9 Dec 2007 18:17:29 +0100 (CET)
X-ME-UUID: 20071209171729476.746C8700008D@mwinf2816.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1PmS-0005Jz-JF; Sun, 09 Dec 2007 18:17:28 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <1197219900-19334-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67634>

3803bcea tried to fix this, but it only adds the branckes when the given
In-Reply-To begins and ends with whitespaces. It also didn't do anything
to the --in-reply-to argument.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

I just got bitten by this...

 git-send-email.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 76baa8e..1434eb2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -367,10 +367,11 @@ if ($thread && !defined $initial_reply_to && $prompting) {
 	} while (!defined $_);
 
 	$initial_reply_to = $_;
-	$initial_reply_to =~ s/^\s+<?/</;
-	$initial_reply_to =~ s/>?\s+$/>/;
 }
 
+$initial_reply_to =~ s/^\s*\<?/\</;
+$initial_reply_to =~ s/>?\s*$/>/;
+
 if (!defined $smtp_server) {
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
 		if (-x $_) {
-- 
1.5.3.7
