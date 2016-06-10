From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 27/44] builtin/apply: rename option parsing functions
Date: Fri, 10 Jun 2016 22:11:01 +0200
Message-ID: <20160610201118.13813-28-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSn6-0003W7-Tc
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbcFJUMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35126 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546AbcFJUMT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id k184so1049654wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7HTc8yLUvrFYl9T0PIEbGu/0pYV4tszOhMIuxUC28eg=;
        b=C1elI8S/1hW+iZ/Uz1JTMH0svX3gUTqp6ntTogUgXPr6UN521LIvRTf/R6SOWFExwm
         i2wKWTr8XBGB3uau2ay0BEPCacG/YMaPGLT2DYbD7+nwY8NeNfzF2P/eKRo/dyZG0qqt
         DmmWAWORMHpzCugcHewLj+QwKpBayJ8g/7+9ZvUshYiOtsusqgAyghgeR6LQDe+B1lWD
         qdn/C3c44lBg9iTHOiA9Kl9Q/AeksGBCGYoldwP9bbg7CxM/dw+SGDFMnWlTJ1yBdpe/
         CD1wSdFbKeLQ9B+FQyYZrOgyiOHhXozpPJwbEI2D5Gsrg97jEqeLXG1y0l8+Qh2VXzP7
         tlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7HTc8yLUvrFYl9T0PIEbGu/0pYV4tszOhMIuxUC28eg=;
        b=IaYs+WmYu+nFKLQdZ7Dwm3D4NQtKMd9Uj3aEENDPqtGeyPKEBF729xCRFFUtwBAErj
         IO9KC9KmKVP0GoJH3br0flKPcUIWxwDeR1HbOP8+tOgVhaah8vXIFXKxykFIam8fHVP3
         3Nc8mn+YvlKXFt9iGtowsDZ2/GIR1YhmYYcafGBqin/d3S4JGliIexIf6kxMCmObMF4t
         0f4IajHMu6E8iu6Fciq3mdiy4CZxNbtMxXpZzpSorVz3eYZ01rewQM5VoX0giT1MzGJ+
         r8TmcMJ2f8MSZ3jF0+xc62rTPDc/ISlpw4krTdinfcQd4VkXzZ8pKoUV+ovJS76R/t1T
         1o/w==
X-Gm-Message-State: ALyK8tLnN9e+W6xCwKx9CZFsmCB+1s4UB0VOFzC5/GBuYfIcxJnVGA1IGymJxvTSmBPntA==
X-Received: by 10.28.94.194 with SMTP id s185mr700790wmb.62.1465589537949;
        Fri, 10 Jun 2016 13:12:17 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:17 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297036>

As these functions are going to be part of the libified
apply api, let's give them a name that is more specific
to the apply api.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f51dc60..c84add0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4566,16 +4566,16 @@ end:
 	return res;
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
@@ -4583,9 +4583,9 @@ static int option_parse_include(const struct option *opt,
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
@@ -4593,8 +4593,8 @@ static int option_parse_p(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_space_change(const struct option *opt,
-				     const char *arg, int unset)
+static int apply_option_parse_space_change(const struct option *opt,
+					   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	if (unset)
@@ -4604,8 +4604,8 @@ static int option_parse_space_change(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_whitespace(const struct option *opt,
-				   const char *arg, int unset)
+static int apply_option_parse_whitespace(const struct option *opt,
+					 const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
@@ -4614,8 +4614,8 @@ static int option_parse_whitespace(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_directory(const struct option *opt,
-				  const char *arg, int unset)
+static int apply_option_parse_directory(const struct option *opt,
+					const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	strbuf_reset(&state->root);
@@ -4729,13 +4729,13 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
@@ -4767,13 +4767,13 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
@@ -4791,7 +4791,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			RECOUNT),
 		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
-			0, option_parse_directory },
+			0, apply_option_parse_directory },
 		OPT_END()
 	};
 
-- 
2.9.0.rc2.362.g3cd93d0
