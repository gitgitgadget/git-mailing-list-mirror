From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/8] git-remote-mediawiki: use --force when adding notes
Date: Mon, 16 Jul 2012 21:46:39 +0200
Message-ID: <1342468002-31818-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 21:48:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqrH0-0000Td-QS
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab2GPTr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:47:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37294 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab2GPTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:47:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJjX5b014895
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:45:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGM-0001Sg-Ee; Mon, 16 Jul 2012 21:47:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGM-0008IW-Cx; Mon, 16 Jul 2012 21:47:22 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 21:45:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJjX5b014895
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343072735.05519@IFWNoC8rKS1BROMKe0Xn4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201558>

When notes are created to record a push, it normally doesn't exist yet.
However, when a push is interrupted and then restarted, it may happen
that a commit already has notes attached, and we want to reflect the newly
created remote revision, hence use 'git notes add -f' to override the
existing one

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index fb1e9e0..517a4db 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -1263,7 +1263,7 @@ sub mw_push_revision {
 			}
 		}
 		unless ($dumb_push) {
-			run_git("notes --ref=$remotename/mediawiki add -m \"mediawiki_revision: $mw_revision\" $sha1_commit");
+			run_git("notes --ref=$remotename/mediawiki add -f -m \"mediawiki_revision: $mw_revision\" $sha1_commit");
 			run_git("update-ref -m \"Git-MediaWiki push\" refs/mediawiki/$remotename/master $sha1_commit $sha1_child");
 		}
 	}
-- 
1.7.11.2.258.g5ff3cdf.dirty
