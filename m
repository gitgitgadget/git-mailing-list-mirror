From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] notes: make expand_notes_ref globally accessible
Date: Mon, 7 Mar 2011 18:39:56 -0500
Message-ID: <20110307233956.GA20912@sigill.intra.peff.net>
References: <20110307233902.GA20447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 00:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwk26-0005g5-Sr
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 00:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab1CGXkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 18:40:03 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54050 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab1CGXkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 18:40:02 -0500
Received: (qmail 9689 invoked by uid 111); 7 Mar 2011 23:40:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 23:40:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 18:39:56 -0500
Content-Disposition: inline
In-Reply-To: <20110307233902.GA20447@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168621>

This function is useful for other commands besides "git
notes" which want to let users refer to notes by their
shorthand name.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/notes.c |   10 ----------
 notes.c         |   10 ++++++++++
 notes.h         |    3 +++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 0aab150..f2ccb75 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -100,16 +100,6 @@ struct msg_arg {
 	struct strbuf buf;
 };
 
-static void expand_notes_ref(struct strbuf *sb)
-{
-	if (!prefixcmp(sb->buf, "refs/notes/"))
-		return; /* we're happy */
-	else if (!prefixcmp(sb->buf, "notes/"))
-		strbuf_insert(sb, 0, "refs/", 5);
-	else
-		strbuf_insert(sb, 0, "refs/notes/", 11);
-}
-
 static int list_each_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1, char *note_path,
 		void *cb_data)
diff --git a/notes.c b/notes.c
index a013c1b..f6b9b6a 100644
--- a/notes.c
+++ b/notes.c
@@ -1285,3 +1285,13 @@ int copy_note(struct notes_tree *t,
 
 	return 0;
 }
+
+void expand_notes_ref(struct strbuf *sb)
+{
+	if (!prefixcmp(sb->buf, "refs/notes/"))
+		return; /* we're happy */
+	else if (!prefixcmp(sb->buf, "notes/"))
+		strbuf_insert(sb, 0, "refs/", 5);
+	else
+		strbuf_insert(sb, 0, "refs/notes/", 11);
+}
diff --git a/notes.h b/notes.h
index 83bd6e0..60bdf28 100644
--- a/notes.h
+++ b/notes.h
@@ -307,4 +307,7 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob);
 void string_list_add_refs_from_colon_sep(struct string_list *list,
 					 const char *globs);
 
+/* Expand inplace a note ref like "foo" or "notes/foo" into "refs/notes/foo" */
+void expand_notes_ref(struct strbuf *sb);
+
 #endif
-- 
1.7.4.31.g76e18
