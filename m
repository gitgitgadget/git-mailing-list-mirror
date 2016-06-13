From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 27/40] builtin/apply: rename option parsing functions
Date: Mon, 13 Jun 2016 18:09:29 +0200
Message-ID: <20160613160942.1806-28-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURv-0003vv-Q2
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424956AbcFMQKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35248 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424931AbcFMQKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so16028784wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YvNKbmiyueEoSrfkC8fmotpAyUAYdq4Lq3NaUASneA8=;
        b=VTLnEZHv8l6VnES2l8OhOa/MS/QWigfUeBjUlSVYKs7WjUbtMmXcwK0jdxXHwkjExA
         h/4TOhi3X89RcZDgWgKE72n5WCpIC6mmq9Y4jAZpe+2zkhLt1FDxEO9Y38ldauY1c+QM
         u/xeONeXGCbsCF41coqrgNxpKSNNT8nbw0SXnf045BwsPNTxkVuMfOa7rashtd9i6kp5
         uA5LrHzLcIpx5G47lxIfCpfSNP6KZPnT65nAscsxm2YxI2Cnj9T6Vg02RQrOKw7MJy/M
         +r6jM/LDZYUpeOeasgbsK5vGAn/K66tPRQ4mDvPG9LQh/kbggZiSNgtX4NDTXxNpvPy8
         7ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YvNKbmiyueEoSrfkC8fmotpAyUAYdq4Lq3NaUASneA8=;
        b=W7KPPJmpaImabPidZQ7Qmj3SDSO8ZOTBu2rte5kmAZ4eylZOu2Wp5wyWLVH4yDCRx5
         Z1060/QWbha3H2pz+0yrKvBIdVRsj7qXcsJSSi+iqdR+TtI7Mvg5+JXUBQXiysGxQf0M
         e2JSa5Agk80R4BU2S8nLAnf9qob6ZCU62jnTw02tWI9PVeoNRIOUIGlgObYud58ERgyg
         rpHrgRlTy8TYxtbZTfCDjT53HhuU6cn22KQFEYB+GswxwWwvrohvZQKYkPXvR/133hF0
         t3rBse/KoI0u5y9Mbsegfz/DnAq97as5u1o3g4Ooffd9JYA+31aot18GyK/f24PPGNhz
         D9+g==
X-Gm-Message-State: ALyK8tLykr/QTAgRTMQqsoDL96oofUVofDS1hp9wl9wOQtjlrIIxW95DTdF9NSpPaz+etQ==
X-Received: by 10.28.95.196 with SMTP id t187mr333548wmb.89.1465834233706;
        Mon, 13 Jun 2016 09:10:33 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:32 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297204>

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
2.9.0.rc2.411.g3e2ca28
