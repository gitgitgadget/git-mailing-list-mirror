From: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
Subject: [PATCH 1/5] Introduces for_each_revision() helper
Date: Thu, 26 Apr 2007 16:46:36 -0300
Message-ID: <11776168001048-git-send-email-lcapitulino@mandriva.com.br>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 26 21:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9w8-0000ZF-1t
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbXDZTqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbXDZTqu
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:46:50 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:45826 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbXDZTqt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:46:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 0ECD517D27;
	Thu, 26 Apr 2007 16:46:47 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id rpqwnjeAoPIA; Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 04C3417D3F;
	Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id CC04968B575; Thu, 26 Apr 2007 16:46:40 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.320.g1cf2
In-Reply-To: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45647>

This macro may be used to iterate over revisions, so, instead of
doing:

	struct commit *commit;

	...

	prepare_revision_walk(rev);
	while ((commit = get_revision(rev)) != NULL) {
		...
	}

New code should use:

	struct commit *commit;

	...

	for_each_revision(commit, rev) {
		...
	}

 The only disadvantage is that it's something magical, and the fact that
it returns a struct commit is not obvious.

 On the other hand it's documented, has the advantage of making the walking
through revisions easier and can save some lines of code.

Signed-off-by: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
---
 revision.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/revision.h b/revision.h
index cdf94ad..bb6f475 100644
--- a/revision.h
+++ b/revision.h
@@ -133,4 +133,15 @@ extern void add_object(struct object *obj,
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
 extern void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode);
 
+/* helpers */
+
+/**
+ * for_each_revision	-	iterate over revisions
+ * @commit:	pointer to a commit object returned for each iteration
+ * @rev:	revision pointer
+ */
+#define for_each_revision(commit, rev) \
+	prepare_revision_walk(rev);    \
+	while ((commit = get_revision(rev)) != NULL)
+
 #endif
-- 
1.5.1.1.320.g1cf2
