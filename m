From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 11/16] Create a note for every imported commit containing svn metadata
Date: Mon, 20 Aug 2012 23:52:17 +0200
Message-ID: <1345499542-15536-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:54:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZvG-0000MP-IQ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab2HTVxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:55 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43593 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab2HTVxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:25 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so4177354wey.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NIK+GBl+kvzB6CXtl0d2pw33C59BlO9dI/1g7Q7N+8Q=;
        b=gxlo6+pnASS7m1P3uXj1ZflI8DpNImFCycIlHbFfyxamxGtiDkPagvnoPPdzfdBiQh
         bf+KxPg7GnYpMdO8PenSn24C8wZ+JhlFmQiDIaNh9TFmDdLgcUt7mDLNCSSsiz1mIK3L
         hvBMO0/M9pH/4NfhyoRNdGLlwLvz19Lqk7nh5nvvMaCBnb3PDbj7NNwtWiFddfmBmAm2
         ch7j7sMAnAQrRN1nCENk5B6jWlfVdm5peDPd/ogGw5rx51WRTDg7q0EKxz8YR5RKs5Y+
         C0MTJoHGXdxlG9fwgIgsj1s38SbeXtY6MfZ0xRpB7Q3mxoN97KsMzvvuyWQOjf5TGVaA
         5Nlg==
Received: by 10.216.133.148 with SMTP id q20mr7311061wei.201.1345499604773;
        Mon, 20 Aug 2012 14:53:24 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.23
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203891>

To provide metadata from svn dumps for further processing, e.g.
branch detection, attach a note to each imported commit that stores
additional information.  The notes are currently hard-coded in
refs/notes/svn/revs.  Currently the following lines from the svn dump
are directly accumulated in the note. This can be refined as needed.

 - "Revision-number"
 - "Node-path"
 - "Node-kind"
 - "Node-action"
 - "Node-copyfrom-path"
 - "Node-copyfrom-rev"

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 vcs-svn/fast_export.c |   14 ++++++++++++--
 vcs-svn/fast_export.h |    2 ++
 vcs-svn/svndump.c     |   21 +++++++++++++++++++--
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 1ecae4b..df51c59 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -3,8 +3,7 @@
  * See LICENSE for details.
  */
 
-#include "git-compat-util.h"
-#include "strbuf.h"
+#include "cache.h"
 #include "quote.h"
 #include "fast_export.h"
 #include "repo_tree.h"
@@ -68,6 +67,17 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
+void fast_export_begin_note(uint32_t revision, const char *author,
+		const char *log, unsigned long timestamp)
+{
+	size_t loglen = strlen(log);
+	printf("commit refs/notes/svn/revs\n");
+	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local", timestamp);
+	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
+	fwrite(log, loglen, 1, stdout);
+	fputc('\n', stdout);
+}
+
 void fast_export_note(const char *committish, const char *dataref)
 {
 	printf("N %s %s\n", dataref, committish);
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 9b32f1e..c2f6f11 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -10,6 +10,8 @@ void fast_export_deinit(void);
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
 void fast_export_note(const char *committish, const char *dataref);
+void fast_export_begin_note(uint32_t revision, const char *author,
+		const char *log, unsigned long timestamp);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,
 			const char *url, unsigned long timestamp, const char *local_ref);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 288bb42..cd65b51 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -48,7 +48,7 @@ static struct {
 static struct {
 	uint32_t revision;
 	unsigned long timestamp;
-	struct strbuf log, author;
+	struct strbuf log, author, note;
 } rev_ctx;
 
 static struct {
@@ -77,6 +77,7 @@ static void reset_rev_ctx(uint32_t revision)
 	rev_ctx.timestamp = 0;
 	strbuf_reset(&rev_ctx.log);
 	strbuf_reset(&rev_ctx.author);
+	strbuf_reset(&rev_ctx.note);
 }
 
 static void reset_dump_ctx(const char *url)
@@ -310,8 +311,15 @@ static void begin_revision(const char *remote_ref)
 
 static void end_revision()
 {
-	if (rev_ctx.revision)
+	struct strbuf mark = STRBUF_INIT;
+	if (rev_ctx.revision) {
 		fast_export_end_commit(rev_ctx.revision);
+		fast_export_begin_note(rev_ctx.revision, "remote-svn",
+				"Note created by remote-svn.", rev_ctx.timestamp);
+		strbuf_addf(&mark, ":%"PRIu32, rev_ctx.revision);
+		fast_export_note(mark.buf, "inline");
+		fast_export_buf_to_data(&rev_ctx.note);
+	}
 }
 
 void svndump_read(const char *url, const char *local_ref)
@@ -358,6 +366,7 @@ void svndump_read(const char *url, const char *local_ref)
 				end_revision();
 			active_ctx = REV_CTX;
 			reset_rev_ctx(atoi(val));
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Node-path"):
 			if (constcmp(t, "Node-"))
@@ -369,10 +378,12 @@ void svndump_read(const char *url, const char *local_ref)
 					begin_revision(local_ref);
 				active_ctx = NODE_CTX;
 				reset_node_ctx(val);
+				strbuf_addf(&rev_ctx.note, "%s\n", t);
 				break;
 			}
 			if (constcmp(t + strlen("Node-"), "kind"))
 				continue;
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			if (!strcmp(val, "dir"))
 				node_ctx.type = REPO_MODE_DIR;
 			else if (!strcmp(val, "file"))
@@ -383,6 +394,7 @@ void svndump_read(const char *url, const char *local_ref)
 		case sizeof("Node-action"):
 			if (constcmp(t, "Node-action"))
 				continue;
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			if (!strcmp(val, "delete")) {
 				node_ctx.action = NODEACT_DELETE;
 			} else if (!strcmp(val, "add")) {
@@ -401,11 +413,13 @@ void svndump_read(const char *url, const char *local_ref)
 				continue;
 			strbuf_reset(&node_ctx.src);
 			strbuf_addstr(&node_ctx.src, val);
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Node-copyfrom-rev"):
 			if (constcmp(t, "Node-copyfrom-rev"))
 				continue;
 			node_ctx.srcRev = atoi(val);
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Text-content-length"):
 			if (constcmp(t, "Text") && constcmp(t, "Prop"))
@@ -475,6 +489,7 @@ static void init(int report_fd)
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
 	strbuf_init(&rev_ctx.author, 4096);
+	strbuf_init(&rev_ctx.note, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
 	reset_dump_ctx(NULL);
@@ -506,6 +521,8 @@ void svndump_deinit(void)
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
+	strbuf_release(&rev_ctx.author);
+	strbuf_release(&rev_ctx.note);
 	strbuf_release(&node_ctx.src);
 	strbuf_release(&node_ctx.dst);
 	if (buffer_deinit(&input))
-- 
1.7.9.5
