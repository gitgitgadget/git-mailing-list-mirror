From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/10] clone: print advice on checking out detached HEAD
Date: Tue, 10 Jan 2012 16:57:07 +0700
Message-ID: <1326189427-20800-11-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYTo-0005p9-GB
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab2AJJ6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:58:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48718 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939Ab2AJJ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:58:49 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so664914iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8jP2aCjwREiyCzZMSjKI5fZeXCeR/QwS3rLqbO0n7qk=;
        b=nbgM6NLFtxotaXK6Q7EU4iOJAbtBsCGzDcnFGpZzvLGWynmJDCSc8TkTT2AxDreg7s
         AzyJkWe5x06thi1gG5F/BT9h7eWb451tIUCNh8xo7aLFTIWkX+28/+ei4oZRZY60GadF
         RMRKcwqqa69CSdaXd8Jlw821syGbrOTNBLKvc=
Received: by 10.50.159.131 with SMTP id xc3mr1327486igb.27.1326189529601;
        Tue, 10 Jan 2012 01:58:49 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id py4sm1971631igc.2.2012.01.10.01.58.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:58:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:58:41 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188242>

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
index ed18c1a..70f0280 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -502,7 +502,10 @@ static int checkout(void)
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
