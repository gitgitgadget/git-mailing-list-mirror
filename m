From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 57/83] builtin/apply: libify parse_whitespace_option()
Date: Sun, 24 Apr 2016 15:33:57 +0200
Message-ID: <1461504863-15946-58-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKE1-0000Wk-L5
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbcDXNhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:20 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35131 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcDXNgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:07 -0400
Received: by mail-wm0-f45.google.com with SMTP id e201so60542479wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FhfWAtd/jGiwTvzJ+uMAAOpKFmISF2yKxB2o48jOZHE=;
        b=FsS/MS5VtcUxri3VyiVEQRpZtxdzNLASsW2BzvzZJ+EmGlwjX9p7uwFptqloeXzkfP
         QWOjwJNN3dYeI+ZRALzMAurhxrssl0NIgoAtEgSzwnKEYMUe5Uw+D0Hz7hk0eGvy3FyX
         FMMaG13MQAxrNSWlfAmoxuLlG/4Fu0tXmHHTBotFjIPlWHl1vmghM4lL8Tv6GAwqb5Wq
         6uOcYm5Cu9deZvAUDjPh4tvOfJXGC0TZqvq97JvlMOX5M+uCvl6vuI5ZhxrCXdeqeSyc
         hSg4riRBJ7X5pLiFv2dr3FrX2POt8vEghd6Ijyv+ifRtSWYmqUGtYN8gXCpzrfgMdUGn
         Etgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FhfWAtd/jGiwTvzJ+uMAAOpKFmISF2yKxB2o48jOZHE=;
        b=QrQqA9M2UMXwbkLbTV6CaGU9ygj5sw7ncsO7B4MQRrA9NIWaWJeIdGJf91EklZ1RYA
         /JSIT0HoqkIN1fN5R95ykHk98IT/7n3Cin7+yhR6z/l2KDiPj+91ARwSe34mAYJFfa3W
         7f4r5cVUTnKTVKkZhLGTkwlA/wz+pqfDRhd0yMLcPhCTq3SChDn4djEwnUzcYA+HP1VM
         Pcho9u8uTMo+jFvsAVL3FKTQ0eZKQKyg8g0OtgGNsMVD8zXD19s/pzsdI9kYMtII8RB/
         K3vTeR6boMG1UOIz/NVIHYkcHtmavzA5Q95tpHkNGMRZO47O8jrY9NXhbjI/COsHI9Q0
         zBLg==
X-Gm-Message-State: AOPr4FWLJ6mv8NQ0X3vBJwo0B07loDqKSqd++/6/fF6xTufuXD91xCt/bOi4IHezh+L5ew==
X-Received: by 10.194.216.33 with SMTP id on1mr12288784wjc.120.1461504966312;
        Sun, 24 Apr 2016 06:36:06 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:05 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292371>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1c1ac7d..8d96f70 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -27,34 +27,34 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-static void parse_whitespace_option(struct apply_state *state, const char *option)
+static int parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		state->ws_error_action = warn_on_ws_error;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "warn")) {
 		state->ws_error_action = warn_on_ws_error;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "nowarn")) {
 		state->ws_error_action = nowarn_ws_error;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "error")) {
 		state->ws_error_action = die_on_ws_error;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "error-all")) {
 		state->ws_error_action = die_on_ws_error;
 		state->squelch_whitespace_errors = 0;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
 		state->ws_error_action = correct_ws_error;
-		return;
+		return 0;
 	}
-	die(_("unrecognized whitespace option '%s'"), option);
+	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
 static void parse_ignorewhitespace_option(struct apply_state *state,
@@ -4572,7 +4572,8 @@ static int option_parse_whitespace(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
-	parse_whitespace_option(state, arg);
+	if (parse_whitespace_option(state, arg))
+		exit(1);
 	return 0;
 }
 
@@ -4602,8 +4603,8 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
-	if (apply_default_whitespace)
-		parse_whitespace_option(state, apply_default_whitespace);
+	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
+		exit(1);
 	if (apply_default_ignorewhitespace)
 		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
 }
-- 
2.8.1.300.g5fed0c0
