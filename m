From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 06/13] export three functions from diff.c
Date: Wed, 30 Jun 2010 23:25:19 +0800
Message-ID: <1277911526-12105-6-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzEL-0000R8-IY
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082Ab0F3P3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:29:36 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:41178 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0F3P3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:29:35 -0400
Received: by pxi8 with SMTP id 8so416503pxi.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XzkfwrySWXM3jA4lupQhYKVxudS8I2mx9KR9+dgEfZc=;
        b=S3BdT2p8iREIlDNEqAUkkoPD7/sWbxF95zXkC16ZelKgVI7bhxp1L2yISknnjxTL2L
         OAB4E4Y+JCUoUAXYFyVOPn0BiE0Vpt5EoCsiIb3Nr/Htafr0zNCRp534VDgRN+jiYtY7
         R1BPm6TBz0/9ulMGAJC3tC6nPAUpIQa0RBHpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Upj5RWFRaf9Pg/HSfjl2waTtJanavpMCbBJRiHp3kPcb4ch0q6ynnbWXXbQJemkqwS
         kNYcwRE2SSziWxKrKiUnoMHu4Q47tVVr0Lz9Lw0lImm7o0Dtgi8jBeC0g0CCtiv25NpH
         mpMbk/CbhD2A6k5mDaGXtW+Q1bPF11wGHAOWI=
Received: by 10.114.33.8 with SMTP id g8mr9932183wag.225.1277911774981;
        Wed, 30 Jun 2010 08:29:34 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:29:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149969>

Use fill_metainfo to fill the line level diff meta data,
emit_line to print out a line and quote_two to quote
paths.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c |    6 +++---
 diff.h |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 2332fa6..a370a1c 100644
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
