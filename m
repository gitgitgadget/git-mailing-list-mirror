From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/8] Export three functions from diff.c
Date: Tue, 14 Dec 2010 03:03:25 +0100
Message-ID: <4973127c3f9251b92c4836b19d818a340741102a.1292291624.git.trast@student.ethz.ch>
References: <cover.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:04:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKFZ-0008W1-W2
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759078Ab0LNCD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:03:57 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:54357 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759030Ab0LNCDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:03:35 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:29 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:31 +0100
X-Mailer: git-send-email 1.7.3.3.797.g7a32f
In-Reply-To: <cover.1292291624.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163619>

From: Bo Yang <struggleyb.nku@gmail.com>

Use fill_metainfo to fill the line level diff meta data,
emit_line to print out a line and quote_two to quote
paths.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c |    6 +++---
 diff.h |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 6991ed4..a0ea9e5 100644
--- a/diff.c
+++ b/diff.c
@@ -151,7 +151,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
 
-static char *quote_two(const char *one, const char *two)
+char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
 	int need_two = quote_c_style(two, NULL, NULL, 1);
@@ -332,7 +332,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputc('\n', file);
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
+void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
@@ -2583,7 +2583,7 @@ static int similarity_index(struct diff_filepair *p)
 	return p->score * 100 / MAX_SCORE;
 }
 
-static void fill_metainfo(struct strbuf *msg,
+void fill_metainfo(struct strbuf *msg,
 			  const char *name,
 			  const char *other,
 			  struct diff_filespec *one,
diff --git a/diff.h b/diff.h
index 0083d92..165f368 100644
--- a/diff.h
+++ b/diff.h
@@ -12,6 +12,7 @@ struct diff_queue_struct;
 struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
+struct diff_filepair;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -317,4 +318,20 @@ extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
 
 extern int parse_rename_score(const char **cp_p);
 
+/* some output functions line.c need */
+extern void fill_metainfo(struct strbuf *msg,
+			  const char *name,
+			  const char *other,
+			  struct diff_filespec *one,
+			  struct diff_filespec *two,
+			  struct diff_options *o,
+			  struct diff_filepair *p,
+			  int *must_show_header,
+			  int use_color);
+
+extern void emit_line(struct diff_options *o, const char *set, const char *reset,
+		      const char *line, int len);
+
+extern char *quote_two(const char *one, const char *two);
+
 #endif /* DIFF_H */
-- 
1.7.3.3.811.g76615
