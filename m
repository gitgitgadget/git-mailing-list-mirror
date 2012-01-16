From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 10/10] clone: print advice on checking out detached HEAD
Date: Mon, 16 Jan 2012 16:46:16 +0700
Message-ID: <1326707176-8045-11-git-send-email-pclouds@gmail.com>
References: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:48:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmjAU-0003Dl-1G
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 10:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab2APJru convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 04:47:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55465 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2APJrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 04:47:48 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so2315494iag.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rdgFOdPf3QUlAOOsfOEoQyaeIxT0+38Sd8IAcRKty60=;
        b=jkp7zRtjATGEJs99MOYfFiic3uuEdcY321GhcJF61eXaTPkmu6CnvSBiwuCUniqzlI
         gm4rAMRbApR4d/OZwkquBWhEE2qCTobkoFycDbzcwEb/Qa1XKfGt+3cwhHp5kk85WWuQ
         CzDjTUOAkqxA+XuLPfwJOfLO07JXYbsItnRYw=
Received: by 10.43.46.196 with SMTP id up4mr9752825icb.23.1326707268635;
        Mon, 16 Jan 2012 01:47:48 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id or2sm20412179igc.5.2012.01.16.01.47.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 01:47:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:47:39 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188625>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 advice.c           |   14 ++++++++++++++
 advice.h           |    1 +
 builtin/checkout.c |   16 +---------------
 builtin/clone.c    |    5 ++++-
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/advice.c b/advice.c
index e02e632..3e1a145 100644
--- a/advice.c
+++ b/advice.c
@@ -64,3 +64,17 @@ void NORETURN die_resolve_conflict(const char *me)
 	error_resolve_conflict(me);
 	die("Exiting because of an unresolved conflict.");
 }
+
+void detach_advice(const char *new_name)
+{
+	const char fmt[] =3D
+	"Note: checking out '%s'.\n\n"
+	"You are in 'detached HEAD' state. You can look around, make experime=
ntal\n"
+	"changes and commit them, and you can discard any commits you make in=
 this\n"
+	"state without impacting any branches by performing another checkout.=
\n\n"
+	"If you want to create a new branch to retain commits you create, you=
 may\n"
+	"do so (now or later) by using -b with the checkout command again. Ex=
ample:\n\n"
+	"  git checkout -b new_branch_name\n\n";
+
+	fprintf(stderr, fmt, new_name);
+}
diff --git a/advice.h b/advice.h
index e5d0af7..7bda45b 100644
--- a/advice.h
+++ b/advice.h
@@ -14,5 +14,6 @@ int git_default_advice_config(const char *var, const =
char *value);
 void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
+void detach_advice(const char *new_name);
=20
 #endif /* ADVICE_H */
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f1984d9..5bf96ba 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -514,20 +514,6 @@ static void report_tracking(struct branch_info *ne=
w)
 	strbuf_release(&sb);
 }
=20
-static void detach_advice(const char *old_path, const char *new_name)
-{
-	const char fmt[] =3D
-	"Note: checking out '%s'.\n\n"
-	"You are in 'detached HEAD' state. You can look around, make experime=
ntal\n"
-	"changes and commit them, and you can discard any commits you make in=
 this\n"
-	"state without impacting any branches by performing another checkout.=
\n\n"
-	"If you want to create a new branch to retain commits you create, you=
 may\n"
-	"do so (now or later) by using -b with the checkout command again. Ex=
ample:\n\n"
-	"  git checkout -b new_branch_name\n\n";
-
-	fprintf(stderr, fmt, new_name);
-}
-
 static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
@@ -575,7 +561,7 @@ static void update_refs_for_switch(struct checkout_=
opts *opts,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path && advice_detached_head)
-				detach_advice(old->path, new->name);
+				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
 	} else if (new->path) {	/* Switch branches. */
diff --git a/builtin/clone.c b/builtin/clone.c
index 651b4cc..72eebca 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -563,7 +563,10 @@ static int checkout(void)
 			  "unable to checkout.\n"));
 		return 0;
 	}
-	if (strcmp(head, "HEAD")) {
+	if (!strcmp(head, "HEAD")) {
+		if (advice_detached_head)
+			detach_advice(sha1_to_hex(sha1));
+	} else {
 		if (prefixcmp(head, "refs/heads/"))
 			die(_("HEAD not found below refs/heads!"));
 	}
--=20
1.7.3.1.256.g2539c.dirty
