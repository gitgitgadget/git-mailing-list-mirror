From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 06/22] Export three functions from diff.c
Date: Sat, 24 Jul 2010 23:13:38 +0800
Message-ID: <1279984434-28933-7-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:15:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgRV-0001lN-JY
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab0GXPO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:14:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37530 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab0GXPOy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:14:54 -0400
Received: by pzk26 with SMTP id 26so499991pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ftnL9LhaF6MB80UYto8zS5xGfynUYB8kpBcppYQdwwQ=;
        b=bFrU2KvOmkg89FiH0Il5aLJNZVleGlfjYJZ611lWPBC0mldWP5qqnmi3gigyPzMLbz
         KfMD0ZEV4k6B2DlJQViw85VM2LjaN0BTz3oToC+8jW/9NUQkoB59eY43hUkqg+u2Xi0v
         gmO5JplP8wNwkS7O9BoyQxIgl+82/v9JDiDLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XBUCt7WrVnbjaZ59J0ZGyWqOwWluwBBgTV/LGGkc2Y3Webqm5W0D6P9kuMAgeJt+gO
         LbGb/+FhcCZwsA2uOr4u7PYesLAat0h2EDxSjoGK/wGcmmC78/09folcnt+AXgcExj+Y
         Yw6I963jc/q9QWKJCmP2QcPnyAAz7mzNVvQ/4=
Received: by 10.142.163.8 with SMTP id l8mr5982685wfe.227.1279984488013;
        Sat, 24 Jul 2010 08:14:48 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.14.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:14:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151640>

Use fill_metainfo to fill the line level diff meta data,
emit_line to print out a line and quote_two to quote
paths.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |    6 +++---
 diff.h |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 17873f3..9efca95 100644
--- a/diff.c
+++ b/diff.c
@@ -144,7 +144,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
 
-static char *quote_two(const char *one, const char *two)
+char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
 	int need_two = quote_c_style(two, NULL, NULL, 1);
@@ -325,7 +325,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputc('\n', file);
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
+void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
@@ -2564,7 +2564,7 @@ static int similarity_index(struct diff_filepair *p)
 	return p->score * 100 / MAX_SCORE;
 }
 
-static void fill_metainfo(struct strbuf *msg,
+void fill_metainfo(struct strbuf *msg,
 			  const char *name,
 			  const char *other,
 			  struct diff_filespec *one,
diff --git a/diff.h b/diff.h
index 063d10a..9676ab9 100644
--- a/diff.h
+++ b/diff.h
@@ -12,6 +12,7 @@ struct diff_queue_struct;
 struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
+struct diff_filepair;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -301,4 +302,20 @@ extern size_t fill_textconv(struct userdiff_driver *driver,
 
 extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
 
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
1.7.0.2.273.gc2413.dirty
