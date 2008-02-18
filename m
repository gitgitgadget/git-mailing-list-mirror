From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 03/12] mark_blob/tree_uninteresting: check for NULL
Date: Mon, 18 Feb 2008 21:47:54 +0100
Message-ID: <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:48:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCuo-0000Mg-7F
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbYBRUsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761476AbYBRUsH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:07 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40267 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760981AbYBRUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id F03666CF0062;
	Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tox3LaSHSin; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id A228B680C0A5; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74342>

As these functions are directly called with the result
from lookup_tree/blob, they must handle NULL.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 6e85aaa..484e5e7 100644
--- a/revision.c
+++ b/revision.c
@@ -46,6 +46,8 @@ void add_object(struct object *obj,
 
 static void mark_blob_uninteresting(struct blob *blob)
 {
+	if (!blob)
+		return;
 	if (blob->object.flags & UNINTERESTING)
 		return;
 	blob->object.flags |= UNINTERESTING;
@@ -57,6 +59,8 @@ void mark_tree_uninteresting(struct tree *tree)
 	struct name_entry entry;
 	struct object *obj = &tree->object;
 
+	if (!tree)
+		return;
 	if (obj->flags & UNINTERESTING)
 		return;
 	obj->flags |= UNINTERESTING;
-- 
1.5.4.1.g96b77
