From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 06/10] send-email: minor code refactoring
Date: Tue, 30 Jun 2015 14:16:47 +0200
Message-ID: <1435666611-18429-7-git-send-email-Matthieu.Moy@imag.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 14:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9uTT-0005Va-WC
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbbF3MRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:17:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39686 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbbF3MRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:17:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCGxKE015333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 14:16:59 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCH0E4022751;
	Tue, 30 Jun 2015 14:17:00 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9uTE-00051G-Bt; Tue, 30 Jun 2015 14:17:00 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 30 Jun 2015 14:16:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UCGxKE015333
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436271420.90204@7KeospG8WhiLE6FTv5fgyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273046>

From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

Group expressions in a single if statement. This avoid checking
multiple time if the variable $sender is defined.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index da1d4a4..49fc275 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -805,9 +805,9 @@ if (!$force) {
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
2.5.0.rc0.10.g7792c2a
