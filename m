From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 06/10] send-email: minor code refactoring
Date: Wed, 17 Jun 2015 16:18:36 +0200
Message-ID: <1434550720-24130-6-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 16:19:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5EBh-0006Yb-Gv
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 16:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829AbbFQOTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 10:19:19 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:37871 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756419AbbFQOTE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 10:19:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 232852896;
	Wed, 17 Jun 2015 16:19:03 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oIKIn9hqcHU1; Wed, 17 Jun 2015 16:19:03 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 122B426E8;
	Wed, 17 Jun 2015 16:19:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 0C75420DD;
	Wed, 17 Jun 2015 16:19:03 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hf3rSgoVFukA; Wed, 17 Jun 2015 16:19:02 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-475-169.w90-52.abo.wanadoo.fr [90.52.146.169])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 2200C20D1;
	Wed, 17 Jun 2015 16:19:02 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271841>

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
