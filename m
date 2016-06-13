From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 12/40] builtin/apply: move check_apply_state() to apply.c
Date: Mon, 13 Jun 2016 18:09:14 +0200
Message-ID: <20160613160942.1806-13-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:12:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUT4-0004vN-CM
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425009AbcFMQLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33367 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424868AbcFMQKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so16042477wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s639Uj5OegZt3+xwS0j5mJQxDwt/38WdZ6CfKScHZDc=;
        b=lx/mohLxakUcmjhNVPELE3zC6ss9lf+St9GlRZ8BXukNJclcwMAv4Ojyy1JaCeB8lK
         cMTr6ne9pNitKwzd1KL/AfzKjgJUZaehQZJvToGrTe1rP+411KcXu2hCLhjDdoRNW0ED
         pMd2DDX7CL4bvUC+1n3LcjHsXuuoQbnMsVPl+sM04WTrpPW+P/S9JZJO4VQvPifPhLGi
         SjSEdNk5wuUoksAlhn436Yylyg4Or6rFEECY/T+AF12+MjGsL/0wHnqH6+97NtzR+t85
         WZm6nQup0bdR36wt4GUWmwghRyENFmB07vkVlvUp2sJJnNwjBA3zGdCpamtzlscw5MLK
         892w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s639Uj5OegZt3+xwS0j5mJQxDwt/38WdZ6CfKScHZDc=;
        b=Hu4rYYEUCJDQfMX/L/2JqPxRFRnd1pNLjBDqWaBGf6KWep9XRTV5CjIJIYmgUUR9MB
         FN7T9qcAIssct2ykUSJf78CQ5kgP7lG7eKn/HHazhNZYOKHuV284dEN8lkC6ApJPcj8L
         EEveP1SKAMB8HdCX+TH9ocp7MAT3Nm5zXkrokPSTtJI1p2DV7xhbd3Hp1H8am/yZs0X7
         V3f1HmWCcobJ2efuruYBzvisshkiScFHChHG43SUZqI+xHaC/QDk2i8UYmZ6cSWxifkr
         E9ou7zTkOs5/wpKm6DwJO1seAloFHfWYlB8Kc89UqB79Kyard91hYJgVu/LzgjsJ5jDq
         0zTg==
X-Gm-Message-State: ALyK8tKJ+vuu54X0AIKeDkmsIyixsGswn7KJ6b44sMsTyE5qwE1r/xKvJieLihoqJ41GNA==
X-Received: by 10.28.11.143 with SMTP id 137mr335763wml.92.1465834213451;
        Mon, 13 Jun 2016 09:10:13 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:12 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297229>

To libify `git apply` functionality we must make check_apply_state()
usable outside "builtin/apply.c".

Let's do that by moving it into "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 32 ++++++++++++++++++++++++++++++++
 apply.h         |  1 +
 builtin/apply.c | 32 --------------------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/apply.c b/apply.c
index c5a9ee2..84dae3d 100644
--- a/apply.c
+++ b/apply.c
@@ -90,3 +90,35 @@ void clear_apply_state(struct apply_state *state)
 
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
+
+int check_apply_state(struct apply_state *state, int force_apply)
+{
+	int is_not_gitdir = !startup_info->have_repository;
+
+	if (state->apply_with_reject && state->threeway)
+		return error("--reject and --3way cannot be used together.");
+	if (state->cached && state->threeway)
+		return error("--cached and --3way cannot be used together.");
+	if (state->threeway) {
+		if (is_not_gitdir)
+			return error(_("--3way outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->apply_with_reject)
+		state->apply = state->apply_verbosely = 1;
+	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
+		state->apply = 0;
+	if (state->check_index && is_not_gitdir)
+		return error(_("--index outside a repository"));
+	if (state->cached) {
+		if (is_not_gitdir)
+			return error(_("--cached outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->check_index)
+		state->unsafe_paths = 0;
+	if (!state->lock_file)
+		return error("BUG: state->lock_file should not be NULL");
+
+	return 0;
+}
diff --git a/apply.h b/apply.h
index 7d3a03b..1f2277e 100644
--- a/apply.h
+++ b/apply.h
@@ -106,5 +106,6 @@ extern int init_apply_state(struct apply_state *state,
 			    const char *prefix,
 			    struct lock_file *lock_file);
 extern void clear_apply_state(struct apply_state *state);
+extern int check_apply_state(struct apply_state *state, int force_apply);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index d60ffce..a27fdd3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4541,38 +4541,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static int check_apply_state(struct apply_state *state, int force_apply)
-{
-	int is_not_gitdir = !startup_info->have_repository;
-
-	if (state->apply_with_reject && state->threeway)
-		return error("--reject and --3way cannot be used together.");
-	if (state->cached && state->threeway)
-		return error("--cached and --3way cannot be used together.");
-	if (state->threeway) {
-		if (is_not_gitdir)
-			return error(_("--3way outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->apply_with_reject)
-		state->apply = state->apply_verbosely = 1;
-	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
-		state->apply = 0;
-	if (state->check_index && is_not_gitdir)
-		return error(_("--index outside a repository"));
-	if (state->cached) {
-		if (is_not_gitdir)
-			return error(_("--cached outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->check_index)
-		state->unsafe_paths = 0;
-	if (!state->lock_file)
-		return error("BUG: state->lock_file should not be NULL");
-
-	return 0;
-}
-
 static int apply_all_patches(struct apply_state *state,
 			     int argc,
 			     const char **argv,
-- 
2.9.0.rc2.411.g3e2ca28
