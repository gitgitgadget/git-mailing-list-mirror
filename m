From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 6/7] send-email: suppress leading and trailing whitespaces in addresses
Date: Tue,  9 Jun 2015 20:50:03 +0200
Message-ID: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 20:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ObU-0001BB-4c
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbbFISuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:50:18 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:36888 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933072AbbFISuN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 14:50:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1CF5D27F1;
	Tue,  9 Jun 2015 20:50:12 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zcx4UHVupfZF; Tue,  9 Jun 2015 20:50:12 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 06CBA270D;
	Tue,  9 Jun 2015 20:50:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id F0A6420E2;
	Tue,  9 Jun 2015 20:50:11 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zpthmBnoMlA5; Tue,  9 Jun 2015 20:50:11 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-286-96.w82-122.abo.wanadoo.fr [82.122.169.96])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 1391120DC;
	Tue,  9 Jun 2015 20:50:10 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271225>

Remove leading and trailing whitespaces when sanitizing addresses so
that git send-email give the same output when passing arguments like
" jdoe@example.com   " or "\t jdoe@example.com " as with
"jdoe@example.com".

The next commit will introduce a test for this aswell.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index ea03308..3d144bd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -978,6 +978,9 @@ sub sanitize_address {
 	# remove garbage after email address
 	$recipient =~ s/(.*>).*$/$1/;
 
+	# remove leading and trailing whitespace
+	$recipient =~ s/^\s+|\s+$//g;
+
 	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
 
 	if (not $recipient_name) {
-- 
1.9.1
