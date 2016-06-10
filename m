From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 07/44] builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
Date: Fri, 10 Jun 2016 22:10:41 +0200
Message-ID: <20160610201118.13813-8-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmc-00039B-Ol
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbcFJULy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:11:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33252 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbcFJULu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so1067387wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eHEXxcD0kHo83dfxd21y4IdFHLW7Fip7jupPVmfs10c=;
        b=bpTrmOhWCmy6c11x+wqRMQODt5h9LZwPxSh0ZcdDNC4zOWr09vjhE233xRLT4lNNIN
         vgO/ppz4PCDoh7eXiJAhNWskvOysDCO/Uqqa5ylETuDZZAGlwUwGAeWQm56GrdnYkelj
         kV9k/V64zj9FgvgN8McnT0REJlPbXB1vhhGYft0p2yAEFFVHvtdXZi0YmEvGdWCEpFgX
         RwWXzfZjl3PIXK6mkBak47CG7/WX/eXlCBqAP79s+mRWNyX4Pr1qmBOCbZbQEoYoTqZh
         Bon0NNFjupqjVDf9NqcNJFZGxAtoQd7Bm73J6FLaPbFLjtxEkJDEK36U26On3ZEdj6+u
         ClcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eHEXxcD0kHo83dfxd21y4IdFHLW7Fip7jupPVmfs10c=;
        b=JU15+dVSnMubIJ9KRBF5IZJsmPqu6tIoivhm9S/OLqJpQSy4BTap9N2riFSb0AkNha
         Sc3EYz9FWsPjINF/crXFJj27tppxxo2yE2skGG+4ExTzUN6OLcPq70gy436JbpEkgqW7
         Ivb3ApxSBJ3RCs7VuTxP//gswyYMBNc9+3LeuUQWQJ3Lwxjer9zk1OTA2ul/ihD3PcGT
         IuC6N8IHwQ3zRiY6EDFNB1KSdmE5nvX8+/dZpXWD+gPdb5G43kasRxkPmJ30vLVh05Kv
         TmBsci+G8U32nNtn8MOHGTD1oxvKTFYUVWEsMOU5UxMS3VftBNm0EW7yVDDu4y6/nX9Y
         bV5Q==
X-Gm-Message-State: ALyK8tIE3yLMTGCxO7RuHfrHoJKBnc+e3gqsNgklvflBx/nfnaLlcgxi92dmpzyS+kUeqg==
X-Received: by 10.194.104.102 with SMTP id gd6mr3708884wjb.170.1465589509452;
        Fri, 10 Jun 2016 13:11:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:48 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297025>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_whitespace_option() should return -1 instead
of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2671586..e56e754 100644
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
@@ -4579,7 +4579,8 @@ static int option_parse_whitespace(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
-	parse_whitespace_option(state, arg);
+	if (parse_whitespace_option(state, arg))
+		exit(1);
 	return 0;
 }
 
@@ -4613,8 +4614,8 @@ static void init_apply_state(struct apply_state *state,
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
2.9.0.rc2.362.g3cd93d0
