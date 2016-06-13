From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 11/40] builtin/apply: make check_apply_state() return -1 instead of die()ing
Date: Mon, 13 Jun 2016 18:09:13 +0200
Message-ID: <20160613160942.1806-12-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSp-0004h1-Kz
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424913AbcFMQKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35843 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424853AbcFMQKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id m124so15997933wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9J5Et5+euU4C561pxUHP1iPhZusiLVpX0nKuBbbSvK4=;
        b=iOJBD385cywWq7NWRfAU79rWD/0nAKE+V+PfNPcQuVCiGukrqAc7mJqo4Iofxp2wAZ
         FSxrXvvSwG+tBpYkUaTxYu+seeInnmjL+YfFK+HepZe3fZBbEYvG59WGQwUum1MZNp8A
         39DVBuoW1K0fzGyMrDdUM3STSzBObCaSwwqdQnu7beLC5JKy/qo2ChP94Cev9Pj6sNMp
         FHMnUHLW9IHjGv/t97sg058MS8CXZB7oUwmTg4phRnFam7iqFvZJ7naEqGgJhrAOYeb0
         bv5bic5KQqGMLJ3yP2i+YwIJJiXTaCowztqCjSRouZkj30sdehu3tILyzxDRaioN7k0z
         gCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9J5Et5+euU4C561pxUHP1iPhZusiLVpX0nKuBbbSvK4=;
        b=k0fvgquxbdXus05QpyyWgL7qbM4D5T6dhQmrXJcuq4276JPijxXOG/y132B2UYo2QM
         P47e7RPg7ukVylSonmmQM9qpmygbrSMzHR9l0XwJYgB2QHow4+SN1Z7rJ4t24f6GM1VO
         yBB9j5JncIvuzypNwx0lRdgrH3lHMsLn+ZWCA5wjJofR+OwJNJffpEQGETSfdmnw3TtD
         6q/wwz/szhXtRXuhh/uuemox+iR3Sp1HcoOTT/UCwQi5gdRi5fRfBK7/F/cS5UoETC34
         BKxhajigqpiTv1X+ASinZawvYP6MdxjTB6ml/BFe4wUDh8X7yWQ85axpBiuotGylBiDy
         8QKQ==
X-Gm-Message-State: ALyK8tJH9gi1v5a7R3DyHpC8KXHx2WHuiNgXjzHFkRDRj6hXQpw1Xwvi1mJ9jE3U1NhR7Q==
X-Received: by 10.28.15.197 with SMTP id 188mr334225wmp.75.1465834212095;
        Mon, 13 Jun 2016 09:10:12 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:11 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297222>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", check_apply_state() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2ae1243..d60ffce 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4541,17 +4541,17 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void check_apply_state(struct apply_state *state, int force_apply)
+static int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		die("--reject and --3way cannot be used together.");
+		return error("--reject and --3way cannot be used together.");
 	if (state->cached && state->threeway)
-		die("--cached and --3way cannot be used together.");
+		return error("--cached and --3way cannot be used together.");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			die(_("--3way outside a repository"));
+			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject)
@@ -4559,16 +4559,18 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		die(_("--index outside a repository"));
+		return error(_("--index outside a repository"));
 	if (state->cached) {
 		if (is_not_gitdir)
-			die(_("--cached outside a repository"));
+			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
 	if (!state->lock_file)
-		die("BUG: state->lock_file should not be NULL");
+		return error("BUG: state->lock_file should not be NULL");
+
+	return 0;
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4734,7 +4736,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	check_apply_state(&state, force_apply);
+	if (check_apply_state(&state, force_apply))
+		exit(1);
 
 	ret = apply_all_patches(&state, argc, argv, options);
 
-- 
2.9.0.rc2.411.g3e2ca28
