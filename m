From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] push: Correctly initialize nonfastforward in do_push.
Date: Wed, 16 Sep 2009 18:37:00 +0200
Message-ID: <1253119020-26547-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 16 18:40:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnxYk-00040X-U1
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 18:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759757AbZIPQkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759749AbZIPQkW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 12:40:22 -0400
Received: from imag.imag.fr ([129.88.30.1]:33367 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704AbZIPQkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 12:40:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n8GGbLDY011702
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 18:37:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MnxVR-0002W7-HN; Wed, 16 Sep 2009 18:37:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MnxVR-0006ur-FV; Wed, 16 Sep 2009 18:37:21 +0200
X-Mailer: git-send-email 1.6.5.rc1.11.g2d184.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 16 Sep 2009 18:37:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128662>

The variable is assigned unconditionally in print_push_status, but
print_push_status is not reached by all codepaths. In particular, this
fixes a bug where "git push ... nonexisting-branch" was complaining about
non-fast forward.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
(I'm the one to blame, sorry for introducing this bug)

 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 3cb1ee4..a73333b 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -140,7 +140,7 @@ static int do_push(const char *repo, int flags)
 		struct transport *transport =
 			transport_get(remote, url[i]);
 		int err;
-		int nonfastforward;
+		int nonfastforward = 0;
 		if (receivepack)
 			transport_set_option(transport,
 					     TRANS_OPT_RECEIVEPACK, receivepack);
-- 
1.6.5.rc1.11.g2d184.dirty
