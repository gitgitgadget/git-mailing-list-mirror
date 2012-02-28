From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] rev-list: remove BISECT_SHOW_TRIED flag
Date: Tue, 28 Feb 2012 20:59:59 +0700
Message-ID: <1330437600-9425-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 15:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Nbw-0004gR-9w
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 15:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab2B1OA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 09:00:56 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42290 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab2B1OAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 09:00:55 -0500
Received: by daed14 with SMTP id d14so2367465dae.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 06:00:55 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.132.229 as permitted sender) client-ip=10.68.132.229;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.132.229 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.132.229])
        by 10.68.132.229 with SMTP id ox5mr54230029pbb.65.1330437655277 (num_hops = 1);
        Tue, 28 Feb 2012 06:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=9EBry6r5mnaIgC2oet4nq4zRBM6rwH5Ksc/t1G9KXpE=;
        b=ubskYniy4xEfrTm91obf7IqMZkJaIow/CV6Gz2T+LPhwdolEWAzwjzqfno0QNsi/z5
         +XF/4JbnyRVYwiwC8F7dZ5N0phs9nRbqS001QpplALPbAUIeIraEZfMoQHvf05S1Fa7O
         oClCNqfFk0exa7CtRBXqYYEEJkgBpWCC0sckU=
Received: by 10.68.132.229 with SMTP id ox5mr45791552pbb.65.1330437654189;
        Tue, 28 Feb 2012 06:00:54 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.56.186])
        by mx.google.com with ESMTPS id l1sm15752211pbe.54.2012.02.28.06.00.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 06:00:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Feb 2012 21:00:00 +0700
X-Mailer: git-send-email 1.7.9.2.304.g93efc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191733>

Since c99f069 (bisect--helper: remove "--next-vars" option as it is
now useless - 2009-04-21), this flag has always been off. Remove the
flag and all related code.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bisect.h           |    1 -
 builtin/rev-list.c |   12 +-----------
 2 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/bisect.h b/bisect.h
index 22f2e4d..b06949e 100644
--- a/bisect.h
+++ b/bisect.h
@@ -17,7 +17,6 @@ extern void print_commit_list(struct commit_list *lis=
t,
=20
 /* bisect_show_flags flags in struct rev_list_info */
 #define BISECT_SHOW_ALL		(1<<0)
-#define BISECT_SHOW_TRIED	(1<<1)
=20
 struct rev_list_info {
 	struct rev_info *revs;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 264e3ae..7a3f820 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -242,13 +242,6 @@ void print_commit_list(struct commit_list *list,
 	}
 }
=20
-static void show_tried_revs(struct commit_list *tried)
-{
-	printf("bisect_tried=3D'");
-	print_commit_list(tried, "%s|", "%s");
-	printf("'\n");
-}
-
 static void print_var_str(const char *var, const char *val)
 {
 	printf("%s=3D'%s'\n", var, val);
@@ -266,7 +259,7 @@ static int show_bisect_vars(struct rev_list_info *i=
nfo, int reaches, int all)
 	struct commit_list *tried;
 	struct rev_info *revs =3D info->revs;
=20
-	if (!revs->commits && !(flags & BISECT_SHOW_TRIED))
+	if (!revs->commits)
 		return 1;
=20
 	revs->commits =3D filter_skipped(revs->commits, &tried,
@@ -294,9 +287,6 @@ static int show_bisect_vars(struct rev_list_info *i=
nfo, int reaches, int all)
 		printf("------\n");
 	}
=20
-	if (flags & BISECT_SHOW_TRIED)
-		show_tried_revs(tried);
-
 	print_var_str("bisect_rev", hex);
 	print_var_int("bisect_nr", cnt - 1);
 	print_var_int("bisect_good", all - reaches - 1);
--=20
1.7.8.36.g69ee2
