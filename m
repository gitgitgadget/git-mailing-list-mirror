From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 3/5] Export three functions from diff.c
Date: Thu, 7 Jun 2012 12:23:27 +0200
Message-ID: <3d2d6819e02104dc954bd56be996e664dba90c54.1339063659.git.trast@student.ethz.ch>
References: <cover.1339063659.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 12:24:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScZsn-0000jN-1h
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 12:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417Ab2FGKXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 06:23:44 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19074 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756839Ab2FGKXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 06:23:34 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 12:23:28 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 12:23:29 +0200
X-Mailer: git-send-email 1.7.11.rc1.243.gbf4713c
In-Reply-To: <cover.1339063659.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199388>

From: Bo Yang <struggleyb.nku@gmail.com>

Use fill_metainfo to fill the line level diff meta data,
emit_line to print out a line and quote_two to quote
paths.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c |  6 +++---
 diff.h | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 77edd50..f9673f3 100644
--- a/diff.c
+++ b/diff.c
@@ -220,7 +220,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static char *quote_two(const char *one, const char *two)
+char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
 	int need_two = quote_c_style(two, NULL, NULL, 1);
@@ -410,7 +410,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputc('\n', file);
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
+void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
@@ -2925,7 +2925,7 @@ static int similarity_index(struct diff_filepair *p)
 	return p->score * 100 / MAX_SCORE;
 }
 
-static void fill_metainfo(struct strbuf *msg,
+void fill_metainfo(struct strbuf *msg,
 			  const char *name,
 			  const char *other,
 			  struct diff_filespec *one,
diff --git a/diff.h b/diff.h
index e027650..4a7d085 100644
--- a/diff.h
+++ b/diff.h
@@ -14,6 +14,7 @@
 struct userdiff_driver;
 struct sha1_array;
 struct commit;
+struct diff_filepair;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -329,6 +330,22 @@ extern size_t fill_textconv(struct userdiff_driver *driver,
 
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
 extern int print_stat_summary(FILE *fp, int files,
 			      int insertions, int deletions);
 
-- 
1.7.11.rc1.243.gbf4713c
