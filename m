From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] push: Correctly initialize nonfastforward in do_push.
Date: Wed, 16 Sep 2009 19:28:27 +0200
Message-ID: <1253122107-31378-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqfxamby33.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 16 19:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnyJI-0005QH-8y
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 19:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683AbZIPR2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 13:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbZIPR2i
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 13:28:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46052 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572AbZIPR2i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 13:28:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8GHPhgG013790
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 19:25:43 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MnyIx-0003PY-Tb; Wed, 16 Sep 2009 19:28:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MnyIx-0008Al-S3; Wed, 16 Sep 2009 19:28:31 +0200
X-Mailer: git-send-email 1.6.5.rc1.11.g2d184.dirty
In-Reply-To: <vpqfxamby33.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Sep 2009 19:25:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8GHPhgG013790
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253726744.79426@WU78VXbmkIXdw2rTErhQqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128667>

The variable is assigned unconditionally in print_push_status, but
print_push_status is not reached by all codepaths. In particular, this
fixes a bug where "git push ... nonexisting-branch" was complaining about
non-fast forward.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
New version initializing nonfastforward inside transport()

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
