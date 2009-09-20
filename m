From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [(resend) PATCH] push: Correctly initialize nonfastforward in transport_push.
Date: Sun, 20 Sep 2009 19:33:20 +0200
Message-ID: <1253468000-11367-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 20 19:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpQIH-0005xu-Rz
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 19:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbZITRdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 13:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbZITRdm
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 13:33:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41032 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724AbZITRdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 13:33:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8KHTF9o001316
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 20 Sep 2009 19:29:15 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MpQI4-00047V-QY; Sun, 20 Sep 2009 19:33:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MpQI4-0002y0-N7; Sun, 20 Sep 2009 19:33:36 +0200
X-Mailer: git-send-email 1.6.5.rc1.11.g2d184.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 20 Sep 2009 19:29:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8KHTF9o001316
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254072558.62537@W+46QvRXCpbfCs2pxEmxTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128851>

The variable is assigned unconditionally in print_push_status, but
print_push_status is not reached by all codepaths. In particular, this
fixes a bug where "git push ... nonexisting-branch" was complaining about
non-fast forward.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Just making sure the patch hasn't been forgotten ... (and changed the
subject from do_push to transport_push)

Regards,

 transport.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index 4cb8077..18db3d3 100644
--- a/transport.c
+++ b/transport.c
@@ -871,6 +871,7 @@ int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   int * nonfastforward)
 {
+	*nonfastforward = 0;
 	verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push)
-- 
1.6.5.rc1.11.g2d184.dirty
