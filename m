From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] Move print_commit_list to libgit.a
Date: Fri, 26 Oct 2012 22:53:51 +0700
Message-ID: <1351266835-22610-4-git-send-email-pclouds@gmail.com>
References: <20121026120253.GA1455@sigill.intra.peff.net>
 <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:54:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmF1-0000B8-RO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917Ab2JZPyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 11:54:21 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59802 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2JZPyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:54:20 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2860934pbb.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rF2lt1eAIxQjyBhntMnde0EiGo1QTqBMcU5S7x2JsEE=;
        b=NmaCxvEtvKKgJag9s0ItFeVPF6PX8Y7VlxyTQPF6R0MeeiCX/XwLwaadP5YGC7oTtX
         OOtaPId+k5kp5iSkw6jtwFYhsNyNSN6Se6jgKpV6ztObIY1gE2ixIYSXJuPRtKt3ax0+
         ZvE0bMsWd72VpPM6/eGD1BM/IjjLhrI5GGlTiyDyZV/eoiP+9xisw/7o6Gb544QCgcoN
         /7oW+mUK0JdX/gDFsgsSe0X5U1ePbsuhqgujK4fiI7k7qCi4X5VLuxOp4Luzs7/ijCkD
         N3X8U3F9mukxFi3F187UY+7vV9U4UPPdSUV+rAXWT78YIU6Q70ensgIFDUQh479p/+LM
         /coQ==
Received: by 10.68.217.168 with SMTP id oz8mr46638468pbc.90.1351266860106;
        Fri, 26 Oct 2012 08:54:20 -0700 (PDT)
Received: from lanh ([115.74.33.44])
        by mx.google.com with ESMTPS id b6sm1188086pav.33.2012.10.26.08.54.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 08:54:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Oct 2012 22:54:20 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208459>

This is used by bisect.c, part of libgit.a while it stays in
builtin/rev-list.c. Move it to commit.c so that we won't get undefined
reference if a program that uses libgit.a happens to pull it in.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bisect.h           |  4 ----
 builtin/rev-list.c | 10 ----------
 commit.c           | 10 ++++++++++
 commit.h           |  4 ++++
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/bisect.h b/bisect.h
index ec3c3ff..2a6c831 100644
--- a/bisect.h
+++ b/bisect.h
@@ -11,10 +11,6 @@ extern struct commit_list *filter_skipped(struct com=
mit_list *list,
 					  int *count,
 					  int *skipped_first);
=20
-extern void print_commit_list(struct commit_list *list,
-			      const char *format_cur,
-			      const char *format_last);
-
 #define BISECT_SHOW_ALL		(1<<0)
 #define REV_LIST_QUIET		(1<<1)
=20
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index a0ec84e..67701be 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -201,16 +201,6 @@ static void show_edge(struct commit *commit)
 	printf("-%s\n", sha1_to_hex(commit->object.sha1));
 }
=20
-void print_commit_list(struct commit_list *list,
-		       const char *format_cur,
-		       const char *format_last)
-{
-	for ( ; list; list =3D list->next) {
-		const char *format =3D list->next ? format_cur : format_last;
-		printf(format, sha1_to_hex(list->item->object.sha1));
-	}
-}
-
 static void print_var_str(const char *var, const char *val)
 {
 	printf("%s=3D'%s'\n", var, val);
diff --git a/commit.c b/commit.c
index 213bc98..e8eb0ae 100644
--- a/commit.c
+++ b/commit.c
@@ -1347,3 +1347,13 @@ struct commit_list **commit_list_append(struct c=
ommit *commit,
 	new->next =3D NULL;
 	return &new->next;
 }
+
+void print_commit_list(struct commit_list *list,
+		       const char *format_cur,
+		       const char *format_last)
+{
+	for ( ; list; list =3D list->next) {
+		const char *format =3D list->next ? format_cur : format_last;
+		printf(format, sha1_to_hex(list->item->object.sha1));
+	}
+}
diff --git a/commit.h b/commit.h
index 9f21313..c4cd046 100644
--- a/commit.h
+++ b/commit.h
@@ -222,4 +222,8 @@ struct commit *get_merge_parent(const char *name);
=20
 extern int parse_signed_commit(const unsigned char *sha1,
 			       struct strbuf *message, struct strbuf *signature);
+extern void print_commit_list(struct commit_list *list,
+			      const char *format_cur,
+			      const char *format_last);
+
 #endif /* COMMIT_H */
--=20
1.8.0.rc2.23.g1fb49df
