From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 09/11] i18n: apply: update say_patch_name to give translators complete sentence
Date: Mon, 16 Apr 2012 19:50:01 +0700
Message-ID: <1334580603-11577-10-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:52:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlQ5-0007Si-H6
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab2DPMwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:52:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52864 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab2DPMwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:52:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6309124pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qJ2ftKxtlF2tN3qauJuvPrrTitj0ri7uOYUygxZBce8=;
        b=d9LBoZLRaKqz/AkHprT7TMvXDvlzHrPOceSOepC6FbWEfx7V8tiK4A4gmgGFKVrQA5
         Z7JIab1vCPbkuRHHjCkx1ZZv7e5PCU1hvs7LALqM4rFkEfXH+eqpwA4BPeZZh0LfKJ8G
         1JrPpgTl+mlXCgbtNOKNKqoZ10MWcx804G5hr7sVUoghkY6oEr1h18iG/l75kvF+Zrw4
         h16T+coZpYOJ8Vw+p2C6sdpork22JN3LeVr7RBCikzgFtr1mKHWb3FiY4esHR91RYlFb
         J4b07UYLTXsoxGDzhp7Givn4LxxNlqT5AU0W3g+j66iqhoS2+2+39Wx/lb2HTSHHEbqZ
         greQ==
Received: by 10.68.213.41 with SMTP id np9mr27646532pbc.85.1334580752285;
        Mon, 16 Apr 2012 05:52:32 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id oj5sm289026pbb.74.2012.04.16.05.52.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:52:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:51:41 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195632>

---
 builtin/apply.c |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6e9a02e..87922cf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -335,22 +335,25 @@ static void clear_image(struct image *image)
 	image->len = 0;
 }
 
-static void say_patch_name(FILE *output, const char *pre,
-			   struct patch *patch, const char *post)
+/* fmt must contain _one_ %s and no other substitution */
+static void say_patch_name(FILE *output, struct patch *patch, const char *fmt)
 {
-	fputs(pre, output);
+	struct strbuf sb = STRBUF_INIT;
+
 	if (patch->old_name && patch->new_name &&
 	    strcmp(patch->old_name, patch->new_name)) {
-		quote_c_style(patch->old_name, NULL, output, 0);
-		fputs(" => ", output);
-		quote_c_style(patch->new_name, NULL, output, 0);
+		quote_c_style(patch->old_name, &sb, NULL, 0);
+		strbuf_addstr(&sb, " => ");
+		quote_c_style(patch->new_name, &sb, NULL, 0);
 	} else {
 		const char *n = patch->new_name;
 		if (!n)
 			n = patch->old_name;
-		quote_c_style(n, NULL, output, 0);
+		quote_c_style(n, &sb, NULL, 0);
 	}
-	fputs(post, output);
+	fprintf(output, fmt, sb.buf);
+	fprintf(output, "\n");
+	strbuf_release(&sb);
 }
 
 #define CHUNKSIZE (8192)
@@ -3165,8 +3168,8 @@ static int check_patch_list(struct patch *patch)
 	prepare_fn_table(patch);
 	while (patch) {
 		if (apply_verbosely)
-			say_patch_name(stderr,
-				       "Checking patch ", patch, "...\n");
+			say_patch_name(stderr, patch,
+				       _("Checking patch %s..."));
 		err |= check_patch(patch);
 		patch = patch->next;
 	}
@@ -3530,6 +3533,7 @@ static int write_out_one_reject(struct patch *patch)
 	char namebuf[PATH_MAX];
 	struct fragment *frag;
 	int cnt = 0;
+	struct strbuf sb = STRBUF_INIT;
 
 	for (cnt = 0, frag = patch->fragments; frag; frag = frag->next) {
 		if (!frag->rejected)
@@ -3539,8 +3543,8 @@ static int write_out_one_reject(struct patch *patch)
 
 	if (!cnt) {
 		if (apply_verbosely)
-			say_patch_name(stderr,
-				       "Applied patch ", patch, " cleanly.\n");
+			say_patch_name(stderr, patch,
+				       _("Applied patch %s cleanly."));
 		return 0;
 	}
 
@@ -3551,8 +3555,9 @@ static int write_out_one_reject(struct patch *patch)
 		die(_("internal error"));
 
 	/* Say this even without --verbose */
-	say_patch_name(stderr, "Applying patch ", patch, " with");
-	fprintf(stderr, " %d rejects...\n", cnt);
+	strbuf_addf(&sb, _("Applying patch %%s with %d rejects..."), cnt);
+	say_patch_name(stderr, patch, sb.buf);
+	strbuf_release(&sb);
 
 	cnt = strlen(patch->new_name);
 	if (ARRAY_SIZE(namebuf) <= cnt + 5) {
-- 
1.7.3.1.256.g2539c.dirty
