From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 05/12] export three functions from diff.c
Date: Sat, 26 Jun 2010 06:27:30 -0700
Message-ID: <1277558857-23103-6-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:28:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVQZ-0007lB-4V
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969Ab0FZN2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:28:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58519 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0FZN2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:28:02 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1277102pvg.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Q3XW7QKXXyioDyTDwMVaT8YCAFYxKryy9l5ShQgTODU=;
        b=qfVsEB/Af9vFVFrb1iNUepuqm+EECkHsQM4o+/ldIugYisDW9fqQ9UwA8iRMiF0P1C
         6m55vrebl6E3eKG2ub+u6hpcXZXm4hq8v8Bcbb6pu/Hgzkot+oPPCsOXzxLFWHmmD2lK
         2KQKfNTxsiHAA4mZKxtYW71RZotqooirSEzf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VyDYYzCMQdCA6KaoM4iTYDhcoRxF/WFi+bthSI8rciwkj2S1tVFap8De5QULMQ1GFT
         gKuO2b8eBdL8XhMDadtvIBu6q2GrorCqoSQ1kG7lqdxpEv1+M/8QF0FPYedsUrNuMtj7
         P8FtBDmz6Sqyj7YHKos/lztEOY3zhxLmXPxPE=
Received: by 10.142.4.20 with SMTP id 20mr932084wfd.289.1277558882489;
        Sat, 26 Jun 2010 06:28:02 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.27.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:28:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149747>

Use fill_metainfo to fill the line level diff meta data,
emit_line to print out a line and quote_two to quote
paths.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |    6 +++---
 diff.h |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index c692526..9846fc9 100644
--- a/diff.c
+++ b/diff.c
@@ -148,7 +148,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
 
-static char *quote_two(const char *one, const char *two)
+char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
 	int need_two = quote_c_style(two, NULL, NULL, 1);
@@ -329,7 +329,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputc('\n', file);
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
+void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
@@ -2568,7 +2568,7 @@ static int similarity_index(struct diff_filepair *p)
 	return p->score * 100 / MAX_SCORE;
 }
 
-static void fill_metainfo(struct strbuf *msg,
+void fill_metainfo(struct strbuf *msg,
 			  const char *name,
 			  const char *other,
 			  struct diff_filespec *one,
diff --git a/diff.h b/diff.h
index 48abe7a..5d8449c 100644
--- a/diff.h
+++ b/diff.h
@@ -10,6 +10,8 @@ struct rev_info;
 struct diff_options;
 struct diff_queue_struct;
 struct strbuf;
+struct diff_filespec;
+struct diff_filepair;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -292,4 +294,20 @@ extern void diff_no_index(struct rev_info *, int, const char **, int, const char
 
 extern int index_differs_from(const char *def, int diff_flags);
 
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
1.7.1.577.g36cf0.dirty
