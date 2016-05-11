From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 57/94] builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
Date: Wed, 11 May 2016 15:17:08 +0200
Message-ID: <20160511131745.2914-58-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4N-00047r-M3
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbcEKNUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35289 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285AbcEKNUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so9409397wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S/mf4drGfRbuJhalumgHuYNDTP9QV5E0JKrNsDWOrUQ=;
        b=KRNSrr4NaWP0+5NFlPVgnbZKKq9y3odP1El2SlVY21hN/3jOven7XkD8OE/zwgzF5/
         TKCsdv3i/ZOitemDGo6NXTdQkG0uTCamETykLEOf+Jz5GqHaOJ64Yn3AP8fEvNr27kOG
         k4YRSM2bYINFYcA1GcGekjrOk+y7Z9pCQ+WJOmieLL5oV/KdhXp0n9QpczMSFOuGFxrX
         98X1/XTSJxLaRPxDj1guTM1FdabqmeA6y1bvqRG93C2SO+2j4JreTE60hVL7k91oN7GG
         ekkPtxgOFUx36Q0LxcpAIdSgHHJzBDig+jLhv4aU487rnx360QcopKqmSTCsbI3NSpVu
         smNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S/mf4drGfRbuJhalumgHuYNDTP9QV5E0JKrNsDWOrUQ=;
        b=GF4ivBzAhVWr6czPbywbI2VMTf9C6vdB0Xhg4uO5x45m1hqhtqTeVy84g2a+ZE49BO
         NBgCgdW4Ackkk4WelomATCfsXkF8gGizexWzLxkB/iemUoe1DX0VE0e92V649oMkP8Lb
         48iehfPVeSU0VIeBWEw97pAuoIwF9tjw3xQHW+yN3JGI1ie6AgmS9ScjetXycFnnsZCB
         XXBuJJ+oVK6Gv21VVr3+yg977ahivgLROsJrXdPRi3dmpxN4tGwQ/huwF6o82mNgAxjb
         GfN/Ry9sJEz4rmgfDikYHrIv7BOR/UwxlgehAF1Qr4BtkaXBvGpA5hhFJZ0ADxjr8xt6
         szog==
X-Gm-Message-State: AOPr4FW61uucjl6v9HX7UZP7eEeUG/YM9PI+xNVMJT8Ws9m2zR2BKmjVPCZtln80xDAddg==
X-Received: by 10.194.153.65 with SMTP id ve1mr3822664wjb.106.1462972823634;
        Wed, 11 May 2016 06:20:23 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:22 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294287>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_whitespace_option() should return -1 using
error() instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e42c8fe..657e986 100644
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
@@ -4578,7 +4578,8 @@ static int option_parse_whitespace(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
-	parse_whitespace_option(state, arg);
+	if (parse_whitespace_option(state, arg))
+		exit(1);
 	return 0;
 }
 
@@ -4612,8 +4613,8 @@ static void init_apply_state(struct apply_state *state,
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
2.8.2.490.g3dabe57
