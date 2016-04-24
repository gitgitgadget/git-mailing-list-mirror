From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 45/83] builtin/apply: move 'state' init into init_apply_state()
Date: Sun, 24 Apr 2016 15:33:45 +0200
Message-ID: <1461504863-15946-46-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEQ-0000hf-7D
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbcDXNhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:48 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38487 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbcDXNfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:51 -0400
Received: by mail-wm0-f49.google.com with SMTP id u206so89941381wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3xQVZddbucFzmbD4Tw9zRRoCMcqRJvSbk5YAQOmBRNM=;
        b=rZK1XlmUv5leOIxhrmkfzN4N1lpBwv043Eq5+GFztHzJ2Nl4GublQ33BP3H1SPU1co
         khyNjDKyV8wFiUjqF6fm+211QtXaSgBguFGVysXqAWrsDJ5DF/K6/n5Sqq7xe/S3e5dZ
         TXZv6JaxIdCYY+m8hftkFa1gVKGXwuNBtzpQXGx0XIf4g2E9Drbuof2dIRHSnkbHXqdR
         yOmFBmRv1lB9cvSejYM+yVEblYAB1Abc32YqAALqTBwG2scMD8TlP018nzNyxBGINEZc
         O0xh2rjwVssJVaJWyw3/E7Uv/ItB4Xoe/AdcGBhT5sBMsYeJY2CUyEj3ycr5Q58/4ww/
         xNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3xQVZddbucFzmbD4Tw9zRRoCMcqRJvSbk5YAQOmBRNM=;
        b=HZVEVG0Jce/I/n5YPXcrFp9gBFe2cHMVR4VKPG0WJe0suEJiz9XwLb5XNCc0X6cUXG
         jm/Qg4lk7sLibdbbW1gKQJ+GAfbl9IcqpJQL9Q3UQQ7GtsXnfx7pdiTCB563VTmtsUcI
         WzBXoJZwsVJyWjtnBINiF4MAZeGAn5uwe8DbIEeqnDcvqxo07HJVc9W58fjGm04nSolh
         dXHlV3s2afMjsnhSKQBysyPmRbbXuooqjrQzLzTwYUnXOpFWE/ZLhLDFioOmjRGnCqMU
         ox0ERPTB1yJ5wCtSDlmeTASvA7Ync3AF5MnzGxL/LOmfNQMInOhImPVzcoIwx9pRpvL6
         EXXg==
X-Gm-Message-State: AOPr4FVLDJ8IKcDXhq1dKtyn5dW3R3HE9RKXTZrQXqLRleNQpOOYnqytDeQx6eEIseU6Ig==
X-Received: by 10.28.93.85 with SMTP id r82mr7471991wmb.77.1461504949955;
        Sun, 24 Apr 2016 06:35:49 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:49 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292378>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8508607..f2dffa9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4670,6 +4670,28 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
+static void init_apply_state(struct apply_state *state, const char *prefix_)
+{
+	memset(state, 0, sizeof(*state));
+	state->prefix = prefix_;
+	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->apply = 1;
+	state->line_termination = '\n';
+	state->p_value = 1;
+	state->p_context = UINT_MAX;
+	state->squelch_whitespace_errors = 5;
+	state->ws_error_action = warn_on_ws_error;
+	state->ws_ignore_action = ignore_ws_none;
+	state->linenr = 1;
+	strbuf_init(&state->root, 0);
+
+	git_apply_config();
+	if (apply_default_whitespace)
+		parse_whitespace_option(state, apply_default_whitespace);
+	if (apply_default_ignorewhitespace)
+		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
+}
+
 int cmd_apply(int argc, const char **argv, const char *prefix_)
 {
 	int i;
@@ -4749,24 +4771,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_END()
 	};
 
-	memset(&state, 0, sizeof(state));
-	state.prefix = prefix_;
-	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
-	state.apply = 1;
-	state.line_termination = '\n';
-	state.p_value = 1;
-	state.p_context = UINT_MAX;
-	state.squelch_whitespace_errors = 5;
-	state.ws_error_action = warn_on_ws_error;
-	state.ws_ignore_action = ignore_ws_none;
-	state.linenr = 1;
-	strbuf_init(&state.root, 0);
-
-	git_apply_config();
-	if (apply_default_whitespace)
-		parse_whitespace_option(&state, apply_default_whitespace);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(&state, apply_default_ignorewhitespace);
+	init_apply_state(&state, prefix_);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.1.300.g5fed0c0
