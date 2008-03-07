From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] Revert part of 1abf095 (git-add: adjust to the
 get_pathspec() changes)
Date: Fri,  7 Mar 2008 02:54:45 -0800
Message-ID: <1204887286-32574-2-git-send-email-gitster@pobox.com>
References: <1204887286-32574-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 11:56:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXaF2-0004M2-Oy
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 11:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004AbYCGKzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 05:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757855AbYCGKzH
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 05:55:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757543AbYCGKzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 05:55:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DBD16225D
	for <git@vger.kernel.org>; Fri,  7 Mar 2008 05:55:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3A282225C for <git@vger.kernel.org>; Fri,  7 Mar 2008 05:55:02 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.587.g0bdd73
In-Reply-To: <1204887286-32574-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76473>

When get_pathspec() was originally made absolute-path capable,
we botched the interface to it, without dying inside the function
when given a path that is outside the work tree, and made it the
responsibility of callers to check the condition in a roundabout
way.  This is made unnecessary with the previous patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 820110e..4a91e3e 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -228,18 +228,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		goto finish;
 	}
 
-	if (*argv) {
-		/* Was there an invalid path? */
-		if (pathspec) {
-			int num;
-			for (num = 0; pathspec[num]; num++)
-				; /* just counting */
-			if (argc != num)
-				exit(1); /* error message already given */
-		} else
-			exit(1); /* error message already given */
-	}
