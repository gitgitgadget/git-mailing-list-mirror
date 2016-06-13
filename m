From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 07/40] builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
Date: Mon, 13 Jun 2016 18:09:09 +0200
Message-ID: <20160613160942.1806-8-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURN-0003VW-SY
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424849AbcFMQKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36813 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424605AbcFMQKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so15997441wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TKLCTd0FJ7ttluIqh7JSGhg5OHd2QhmnpLDncWOFH6g=;
        b=GalCtSO6ga0gt+nqEmw3a6wpAFnt8QA502gzHOnVaMl5+XJ/oweJo/RynDoNEY2FLX
         bTL5wZRoIzeyryNNDgTCW6j++Yxcfgw8QE4S3nmgRERH2F356i0q2mRqo3rtIpudDAmS
         Ym9ekP7KRAwqAOzHSJk0PE5Q05fKQd44qVeBBBXBWBTBKsJ5iddicYT+ZghO87H2Zjr6
         0GadWd31Z5AEcDZWnOeROtGbnos0ru6UMmuAjmAuBaZFCBe6IN4X4y8V6Vy7R5mn5+A7
         gOvRVhoqRlwRIG95YX/ykDFUx2IPt4EgRGQeFECt4aBxhT/F5TQrhtLZ0LM90t3GR8r5
         wEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TKLCTd0FJ7ttluIqh7JSGhg5OHd2QhmnpLDncWOFH6g=;
        b=ZUMXkkB//nTT9rIi9u1yUUWocw/CDx6gnZFz0e4S5gYc+jmyMA0V5S0Va/1T5kOtCD
         b7yOQRoywGNauymSgmjy7U6YDXWVwVzGY+ZqLjVTWdvIpPugMb9+KFTVZZ4oMBwfywRJ
         CxLLeMfdUkCbGiapnvlztlO3+3gBGmG+tqBDRv49Y5eG/Y0DkRo3afFX25Fh/11CR+xQ
         Q8SfirSY5rm9RniQxUfoD7kErR4G7RbgR0KHbFykhCpL2A4Vo+LQa5sRRzEv/VMLe//Y
         elvVKor01QN12WnPi7/iQbumrqU+N6f/nugLXSKXtKM+iVAlw03SGSX1tK8rH3T8XbxY
         XVrQ==
X-Gm-Message-State: ALyK8tJljqvsQLqXndizq9pMkPB6BAOZXn5RPI3Ur/SX3yHhRzOpK82M6ro6on+14/8xqA==
X-Received: by 10.194.164.200 with SMTP id ys8mr1869118wjb.79.1465834206640;
        Mon, 13 Jun 2016 09:10:06 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:05 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297196>

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
2.9.0.rc2.411.g3e2ca28
