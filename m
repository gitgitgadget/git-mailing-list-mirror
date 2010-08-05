From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 06/18] Export three functions from diff.c
Date: Fri,  6 Aug 2010 00:11:45 +0800
Message-ID: <1281024717-7855-7-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:13:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh348-0000oB-4J
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759187Ab0HEQM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:12:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933385Ab0HEQMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:12:54 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so143837pwj.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lfGRuT0X6Bm3S7MILkBeV72TqAFwEEuegGoGk5wXEkc=;
        b=d5wPUtrkYGhNFXnI1WNf0mHzHEHP2DsrRr1IJg6oVEbphJYZEw71Jk5Qnn/+67Qe2O
         3lioZv4LlIBSGvDGfQNn8Vd2IGg4Yr7uK2yUtCClOq6RTGc2t569yhVYCe1+7cbPLzgQ
         RaGP1ebeqCW1Va6OPklqaQU64AlS93IFXDc6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IOf5JugzYGhB+/vrYApxvkqWfTb4cjMcSmVYrkWmQgzxYcoHp6oIpRvz2mBSIoaA2Y
         AYjb6lU7IFNxEWGy7DhPbQFRKIoFsKPpWnPeyLUrxkvExX/fJoYk2nS3Dh5z8DCg0hJa
         FvdiuLMSkb9pbbzMtsB3cO/gxHzYFf47opO6A=
Received: by 10.143.41.17 with SMTP id t17mr9224387wfj.315.1281024774752;
        Thu, 05 Aug 2010 09:12:54 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.12.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:12:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152667>

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
1.7.2.20.g388bbb
