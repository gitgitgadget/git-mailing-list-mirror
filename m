From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 05/20] Notes API: add_note(): Add note objects to the
 internal notes tree structure
Date: Sun, 17 Jan 2010 22:04:22 +0100
Message-ID: <1263762277-31419-6-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:06:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcKR-0007dl-0q
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab0AQVGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765Ab0AQVFL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:11 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56203 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754739Ab0AQVFF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:05 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002JHT8DY850@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:01 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:01 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137342>

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
1.6.6.rc1.321.g0496e
