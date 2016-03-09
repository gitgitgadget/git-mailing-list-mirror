From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 41/48] builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:09 +0100
Message-ID: <1457545756-20616-42-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJK-0000P4-W8
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933783AbcCIRyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:10 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35068 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933764AbcCIRxw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:52 -0500
Received: by mail-wm0-f48.google.com with SMTP id l68so190254634wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LDjtuls9nm9WSbBGft2KcflU4/YPEz3j01+c3AOxsY4=;
        b=cli8gG0HckOycgTaHQRQfgrc8/0m0YAovNXOqmADi/oBLfMeOUytHe4TYXkisSBSPh
         ZRp37E9GqISXtKRNTTrCIKYPRK1NL1UPZCAzDWqAvkhcGGihbeaxzxJYIPXWxhuZBe21
         PMp0d17nqJRcyjv9LFvjnd77SAw/+kM9zWA3hZsjz6/G/IxGm5fq6T/CN9OyUZXDMF8H
         Ro80Rsq/WIBLkAm2IsyJPKvzxPNy7MBP6WSzP7DQKie3z1YkL2FlNirAO5C57fff9V4D
         AMZrX2LJWLnIHhRfLZqTfhyB/d4HfA0Qn4SGP7cgNVQ6NvYOcX0TPO0FrVKDRKWnFu6T
         5WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LDjtuls9nm9WSbBGft2KcflU4/YPEz3j01+c3AOxsY4=;
        b=jFLWjdnKF9fCOz29f6gw419sEJKc99wn9tGQ8hha56DrTZ/lITR93qnAKE0h4GOmSz
         ZZWWMTZeg8NEQ03Ek7ECPQad68RRBGGu4rzNmTMGprj7MIqrM8RtMdGv6/AItdgZtNje
         3Rg5wD3ZfiK6eGocZKENOPypSfP4SGj65lJxZvzsAJTeVsxtSm2t0xUNKdLzjmXrIsbA
         D4BdT9YPFq+WL6wz4JeRUaLtUcbFWe74T0L5ZHy4j6qljnrs6RvCFENFH4pQJnu8i8eP
         CDZm1KldIO81U61f8QLQmIdtbSZflb6n+gamIx1v9vvHjJZ+9CGoYNt6VbB+H6VyKMFd
         DMdw==
X-Gm-Message-State: AD7BkJJYPkHldJTPQIQQ7HNF5Hz/lKo6mibqn6rgg+SAUYYfJ4G41bxAAKMXDkqJ/KTVPw==
X-Received: by 10.194.120.99 with SMTP id lb3mr43012384wjb.59.1457546030897;
        Wed, 09 Mar 2016 09:53:50 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:50 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288529>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d427c3c..dbb9f0b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -28,6 +28,12 @@ enum ws_error_action {
 	correct_ws_error
 };
 
+
+enum ws_ignore {
+	ignore_ws_none,
+	ignore_ws_change
+};
+
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
@@ -92,6 +98,7 @@ struct apply_state {
 	int applied_after_fixing_ws;
 
 	enum ws_error_action ws_error_action;
+	enum ws_ignore ws_ignore_action;
 };
 
 static const char * const apply_usage[] = {
@@ -99,13 +106,6 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-
-static enum ws_ignore {
-	ignore_ws_none,
-	ignore_ws_change
-} ws_ignore_action = ignore_ws_none;
-
-
 static void parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
@@ -136,16 +136,17 @@ static void parse_whitespace_option(struct apply_state *state, const char *optio
 	die(_("unrecognized whitespace option '%s'"), option);
 }
 
-static void parse_ignorewhitespace_option(const char *option)
+static void parse_ignorewhitespace_option(struct apply_state *state,
+					  const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
 	    !strcmp(option, "none")) {
-		ws_ignore_action = ignore_ws_none;
+		state->ws_ignore_action = ignore_ws_none;
 		return;
 	}
 	if (!strcmp(option, "change")) {
-		ws_ignore_action = ignore_ws_change;
+		state->ws_ignore_action = ignore_ws_change;
 		return;
 	}
 	die(_("unrecognized whitespace ignore option '%s'"), option);
@@ -2508,7 +2509,7 @@ static int match_fragment(struct apply_state *state,
 	 * fuzzy matching. We collect all the line length information because
 	 * we need it to adjust whitespace if we match.
 	 */
-	if (ws_ignore_action == ignore_ws_change) {
+	if (state->ws_ignore_action == ignore_ws_change) {
 		return line_by_line_fuzzy_match(img, preimage, postimage, try, try_lno, preimage_limit);
 	}
 
@@ -4625,12 +4626,13 @@ static int option_parse_p(const struct option *opt,
 }
 
 static int option_parse_space_change(const struct option *opt,
-			  const char *arg, int unset)
+				     const char *arg, int unset)
 {
+	struct apply_state *state = opt->value;
 	if (unset)
-		ws_ignore_action = ignore_ws_none;
+		state->ws_ignore_action = ignore_ws_none;
 	else
-		ws_ignore_action = ignore_ws_change;
+		state->ws_ignore_action = ignore_ws_change;
 	return 0;
 }
 
@@ -4705,10 +4707,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
 			0, option_parse_whitespace },
-		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
+		{ OPTION_CALLBACK, 0, "ignore-space-change", &state, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
-		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
+		{ OPTION_CALLBACK, 0, "ignore-whitespace", &state, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
@@ -4742,13 +4744,14 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.p_context = UINT_MAX;
 	state.squelch_whitespace_errors = 5;
 	state.ws_error_action = warn_on_ws_error;
+	state.ws_ignore_action = ignore_ws_none;
 	strbuf_init(&state.root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
 		parse_whitespace_option(&state, apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
+		parse_ignorewhitespace_option(&state, apply_default_ignorewhitespace);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.0.rc1.49.gca61272
