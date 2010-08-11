From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 06/17] Export three functions from diff.c
Date: Wed, 11 Aug 2010 23:03:31 +0800
Message-ID: <1281539022-31616-7-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:05:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCrX-00050d-1y
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab0HKPE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:04:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56122 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab0HKPEy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:04:54 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so73597pzk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/QZo/JNWa3NCxCtTlBYw2Vrl50O85WItm5KRtb2lwAg=;
        b=CosydPMxN8gfg5HBQCDBwMuUJ65Zh72wFwvou+7oe0pUx8MaTT2XwMkZdtn+yP10J6
         zPO7J9Wl4EBmWSQPRr/lMshQ3sKU5VNWY4cxlbBDjVYA5wFQ8L7Kzv+CSoCgdqLw3pMr
         GsFbs2orU6KL8prj5mDPfvyT+A59JeCUEyNk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nc47DRAi5h4YhrCHbeHh75XSJdoHDJeOgARkE+7kgiTgiFM8Ih+bwUWLnPfAOzVSEI
         cO01GxtaMl0MuSwfcqZ+bjIoFel9Fll0Pj2bZaNwwK97KbTW0DMXzthx+qWUcOLxKeZG
         +7glHNCQGehAXwgUAHT/WcUw/3dWFgsj7uMHA=
Received: by 10.114.131.2 with SMTP id e2mr22169360wad.43.1281539094335;
        Wed, 11 Aug 2010 08:04:54 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.04.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:04:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153244>

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
1.7.2.19.g79e5d
