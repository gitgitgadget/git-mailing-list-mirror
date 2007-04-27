From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 1/5] Introduces for_each_revision() helper
Date: Fri, 27 Apr 2007 14:00:08 -0300
Message-ID: <1177693212202-git-send-email-lcapitulino@mandriva.com.br>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Apr 27 19:01:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhTp5-0001j2-2L
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 19:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbXD0RBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756137AbXD0RBA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 13:01:00 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:47020 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139AbXD0RAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 13:00:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 58286181B1;
	Fri, 27 Apr 2007 14:00:20 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Iw+L3PwYvfMc; Fri, 27 Apr 2007 14:00:13 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id CA638181B4;
	Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id 8906268B575; Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.372.g4342
In-Reply-To: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45733>

From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

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

This version was suggested by Andy Whitcroft.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 revision.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/revision.h b/revision.h
index cdf94ad..7be3fc7 100644
--- a/revision.h
+++ b/revision.h
@@ -133,4 +133,15 @@ extern void add_object(struct object *obj,
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
 extern void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode);
 
+/* helpers */
+
+/**
+ * for_each_revision	- iterate over revisions
+ * @commit:	pointer to a commit object returned for each iteration
+ * @rev:	revision pointer
+ */
+#define for_each_revision(commit, rev) \
+	for (prepare_revision_walk(rev); \
+		  (commit = get_revision(rev)) != NULL; )
+
 #endif
-- 
1.5.1.1.372.g4342
