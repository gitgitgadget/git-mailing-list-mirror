From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 76/83] builtin/apply: rename option parsing functions
Date: Sun, 24 Apr 2016 15:34:16 +0200
Message-ID: <1461504863-15946-77-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDT-0000Cp-03
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbcDXNgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:43 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37010 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbcDXNgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:33 -0400
Received: by mail-wm0-f46.google.com with SMTP id n3so90231338wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ekj+MEBUlbTMggHpM+d8U1Kcf0TO0TL5eFXUjcEIy28=;
        b=y8skqLErH0JmnDfiYFhXNNxgdGfQxRwB3sp34z2PK6NTgqzG5ONH33ZEOaHGNn2y0A
         MiDDW7oZGUiHoB7fV8eY+/Td5o8IXcG8Lamg4GOjQAr6TiWqIqy5AUuMY8MB6RAo6vb0
         JD9Nlgem9oxsDMZxx2c+I9kM98IHHykE8ITfRHd8oDoHnBbYWCpdKM5kDRLWZM7qKRRM
         SUqwc90gWhlxb5qh42qmk/HMpifGtghCPk/rKVYyAXeGDec+t24jxMKxrFTqGVDrf4ib
         Xr7AMMejvMwujQBItLN7DD1dZFmGjH2u71fHnsAd6Jr5xZ/ruzGRruAU/iTk6PVvcNGL
         /VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ekj+MEBUlbTMggHpM+d8U1Kcf0TO0TL5eFXUjcEIy28=;
        b=KQqlvExgDrWa7wx/tfD3HaWVadLK8/3EPGp/9vx5hLZVIpJSyklKf9LAuzb8aW+ouA
         AwnWJRkWkZYxxBREEXtdKPJFtAI9VIS2eo3Uv9smUjGzq9VFYTD2DYgVnVAukk9Cgtgv
         5Z3xdIEKNcWlK9kp1VpLeim9YBzv/VazgjRuI9dRQwLKv+Ucce/qsc4KixpTNfBO2FSh
         gMmfUhwD20JlgMKyhrPIBnlGL0XvSysz4pQFGS0raNjpgSqsUZxQPMIXNCcgiCnC4En6
         dR83WyrzUES/c0lVF8rpAHr/P8L8dU09xe2BTtH2Fp8VsJ+/5RShOtF7IurKpQk9kk8G
         mNaw==
X-Gm-Message-State: AOPr4FUErn05oXTaHdtBmY97vQxYLFFntHAd8UlnuWS80zV7L5MgDz03WxDi2CbvIAhjiw==
X-Received: by 10.28.73.66 with SMTP id w63mr7198959wma.53.1461504991859;
        Sun, 24 Apr 2016 06:36:31 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:30 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292366>

As these functions are going to be part of the libified
apply api, let's give them a name that is more specific
to the apply api.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5bd5154..5910c5c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4549,16 +4549,16 @@ static int apply_patch(struct apply_state *state,
 	return 0;
 }
 
-static int option_parse_exclude(const struct option *opt,
-				const char *arg, int unset)
+static int apply_option_parse_exclude(const struct option *opt,
+				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 1);
 	return 0;
 }
 
-static int option_parse_include(const struct option *opt,
-				const char *arg, int unset)
+static int apply_option_parse_include(const struct option *opt,
+				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 0);
@@ -4566,9 +4566,9 @@ static int option_parse_include(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_p(const struct option *opt,
-			  const char *arg,
-			  int unset)
+static int apply_option_parse_p(const struct option *opt,
+				const char *arg,
+				int unset)
 {
 	struct apply_state *state = opt->value;
 	state->p_value = atoi(arg);
@@ -4576,8 +4576,8 @@ static int option_parse_p(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_space_change(const struct option *opt,
-				     const char *arg, int unset)
+static int apply_option_parse_space_change(const struct option *opt,
+					   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	if (unset)
@@ -4587,8 +4587,8 @@ static int option_parse_space_change(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_whitespace(const struct option *opt,
-				   const char *arg, int unset)
+static int apply_option_parse_whitespace(const struct option *opt,
+					 const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
@@ -4597,8 +4597,8 @@ static int option_parse_whitespace(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_directory(const struct option *opt,
-				  const char *arg, int unset)
+static int apply_option_parse_directory(const struct option *opt,
+					const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	strbuf_reset(&state->root);
@@ -4696,13 +4696,13 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	struct option builtin_apply_options[] = {
 		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
 			N_("don't apply changes matching the given path"),
-			0, option_parse_exclude },
+			0, apply_option_parse_exclude },
 		{ OPTION_CALLBACK, 0, "include", &state, N_("path"),
 			N_("apply changes matching the given path"),
-			0, option_parse_include },
+			0, apply_option_parse_include },
 		{ OPTION_CALLBACK, 'p', NULL, &state, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
-			0, option_parse_p },
+			0, apply_option_parse_p },
 		OPT_BOOL(0, "no-add", &state.no_add,
 			N_("ignore additions made by the patch")),
 		OPT_BOOL(0, "stat", &state.diffstat,
@@ -4734,13 +4734,13 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 				N_("ensure at least <n> lines of context match")),
 		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
-			0, option_parse_whitespace },
+			0, apply_option_parse_whitespace },
 		{ OPTION_CALLBACK, 0, "ignore-space-change", &state, NULL,
 			N_("ignore changes in whitespace when finding context"),
-			PARSE_OPT_NOARG, option_parse_space_change },
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", &state, NULL,
 			N_("ignore changes in whitespace when finding context"),
-			PARSE_OPT_NOARG, option_parse_space_change },
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
 		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
@@ -4758,7 +4758,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			RECOUNT),
 		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
-			0, option_parse_directory },
+			0, apply_option_parse_directory },
 		OPT_END()
 	};
 
-- 
2.8.1.300.g5fed0c0
