From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 17/22] Notes API: add_note(): Add note objects to the
 internal notes tree structure
Date: Fri, 09 Oct 2009 12:22:13 +0200
Message-ID: <1255083738-23263-19-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClW-0004PL-5F
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760711AbZJIKYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760704AbZJIKYn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:24:43 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58515 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760703AbZJIKYk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:24:40 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BUHSUD8I20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:01 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:01 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129790>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   11 +++++++++++
 notes.h |    4 ++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index f2bacbb..49a3e86 100644
--- a/notes.c
+++ b/notes.c
@@ -366,6 +366,17 @@ void init_notes(const char *notes_ref, int flags)
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
1.6.4.304.g1365c.dirty
