From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 05/23] Notes API: add_note(): Add note objects to the
 internal notes tree structure
Date: Wed, 27 Jan 2010 12:51:42 +0100
Message-ID: <1264593120-4428-6-git-send-email-johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Rd-0000MC-0o
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab0A0LwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948Ab0A0LwX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:52:23 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59042 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752769Ab0A0LwV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:52:21 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00FCFMB9FU60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:21 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:21 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
In-reply-to: <1264593120-4428-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138133>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   11 +++++++++++
 notes.h |    4 ++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index 3f4ae35..2c0d14e 100644
--- a/notes.c
+++ b/notes.c
@@ -368,6 +368,17 @@ void init_notes(const char *notes_ref, int flags)
 	load_subtree(&root_tree, &root_node, 0);
 }
 
+void add_note(const unsigned char *object_sha1, const unsigned char *note_sha1)
+{
+	struct leaf_node *l;
+
+	assert(initialized);
+	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
+	hashcpy(l->key_sha1, object_sha1);
+	hashcpy(l->val_sha1, note_sha1);
+	note_tree_insert(&root_node, 0, l, PTR_TYPE_NOTE);
+}
+
 static unsigned char *lookup_notes(const unsigned char *object_sha1)
 {
 	struct leaf_node *found = note_tree_find(&root_node, 0, object_sha1);
diff --git a/notes.h b/notes.h
index 6b52799..5f22852 100644
--- a/notes.h
+++ b/notes.h
@@ -21,6 +21,10 @@
  */
 void init_notes(const char *notes_ref, int flags);
 
+/* Add the given note object to the internal notes tree structure */
+void add_note(const unsigned char *object_sha1,
+		const unsigned char *note_sha1);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.6.6.405.g80ed6
