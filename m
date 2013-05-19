From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/9] for-each-ref: add %(tracking[:upstream]) for tracking info
Date: Sun, 19 May 2013 17:27:11 +0700
Message-ID: <1368959235-27777-6-git-send-email-pclouds@gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 12:26:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0pD-0006XP-9d
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab3ESK0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:26:43 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:57001 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3ESK0m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:26:42 -0400
Received: by mail-da0-f51.google.com with SMTP id h15so3282776dan.38
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TjPE8HUV/BF6B9Po62NQATSqW5O36qgloifJHvcGYQI=;
        b=PIu7Hg4l/wzWonfatBPmqZrXok6AQIqSAyq2ODTl8iQ1TUFN5EdNreExtyx6Z7j2AI
         B7Xw2MZYWkbmTBiwnxcKFWziI585zZi3nNe5Rm6eI+T+xK75IritoCPv+84kFPKOhDPe
         90fijTWjR9uefrPdpC+Q5mZQ7HxyyaKYAM+DmnX6oiMQMSo2CZhMnofdltD+cHL9dJi1
         wkfn/HBpZGVWKhXACWXxwfckecNjUnjR+QnlOFZetkeiwHU5Z6ioJ8CUHQtnSr3M3zuE
         vhwQiZmT9JnVt/uHSGn2NUe7zg1qv95U2ye7LOEWjaADkAi3bW5f/lX4YxLnqYwawFgE
         KsQA==
X-Received: by 10.66.90.41 with SMTP id bt9mr55609462pab.197.1368959201491;
        Sun, 19 May 2013 03:26:41 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id b7sm19201148pba.39.2013.05.19.03.26.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:26:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:27:51 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224842>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c       |  4 ++--
 builtin/for-each-ref.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..7d084da 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -416,8 +416,8 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
=20
-static void fill_tracking_info(struct strbuf *stat, const char *branch=
_name,
-		int show_upstream_ref)
+void fill_tracking_info(struct strbuf *stat, const char *branch_name,
+			int show_upstream_ref)
 {
 	int ours, theirs;
 	char *ref =3D NULL;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 498d703..b10d48a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -76,6 +76,8 @@ static struct {
 	{ "symref" },
 	{ "flag" },
 	{ "current" },
+	{ "tracking" },
+	{ "tracking:upstream" },
 };
=20
 /*
@@ -615,6 +617,8 @@ static inline char *copy_advance(char *dst, const c=
har *src)
 	return dst;
 }
=20
+extern void fill_tracking_info(struct strbuf *stat, const char *branch=
_name,
+			       int show_upstream_ref);
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -689,6 +693,20 @@ static void populate_value(struct refinfo *ref)
 				v->s =3D " ";
 			continue;
 		}
+		else if (!strcmp(name, "tracking") &&
+			 !prefixcmp(ref->refname, "refs/heads/")) {
+			struct strbuf sb =3D STRBUF_INIT;
+			fill_tracking_info(&sb, ref->refname + 11, 0);
+			v->s =3D sb.buf;
+			continue;
+		}
+		else if (!strcmp(name, "tracking:upstream") &&
+			 !prefixcmp(ref->refname, "refs/heads/")) {
+			struct strbuf sb =3D STRBUF_INIT;
+			fill_tracking_info(&sb, ref->refname + 11, 1);
+			v->s =3D sb.buf;
+			continue;
+		}
 		else
 			continue;
=20
--=20
1.8.2.83.gc99314b
