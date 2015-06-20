From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 06/10] send-email: minor code refactoring
Date: Sun, 21 Jun 2015 01:17:49 +0200
Message-ID: <1434842273-30945-6-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
 <1434842273-30945-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 01:18:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6S1r-0007nJ-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 01:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbbFTXSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 19:18:13 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:56020 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753929AbbFTXR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jun 2015 19:17:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8E9A736E1;
	Sun, 21 Jun 2015 01:17:57 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7fm9pPxlI8Gf; Sun, 21 Jun 2015 01:17:57 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 7D38536B6;
	Sun, 21 Jun 2015 01:17:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 7986020D9;
	Sun, 21 Jun 2015 01:17:57 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cloU3f77JyPk; Sun, 21 Jun 2015 01:17:57 +0200 (CEST)
Received: from localhost.localdomain (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 1567320D6;
	Sun, 21 Jun 2015 01:17:57 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434842273-30945-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272245>

Group expressions in a single if statement. This avoid checking
multiple time if the variable $sender is defined.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f61449d..a0cd7ff 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -799,9 +799,9 @@ if (!$force) {
 	}
 }
 
-($sender) = expand_aliases($sender) if defined $sender;
-
-if (!defined $sender) {
+if (defined $sender) {
+	($sender) = expand_aliases($sender);
+} else {
 	$sender = $repoauthor || $repocommitter || '';
 }
 
-- 
1.9.1
