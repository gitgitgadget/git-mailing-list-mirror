From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 35/83] builtin/apply: move 'whitespace_option' into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:35 +0200
Message-ID: <1461504863-15946-36-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEc-0000nx-8M
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbcDXNh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:59 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36530 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbcDXNff (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:35 -0400
Received: by mail-wm0-f54.google.com with SMTP id v188so69565135wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h+UstZk3rb4xieNi6RtZtfHC6y3KugpHrROoby16gmg=;
        b=kg0R8OfQUC2coeOitsjNNJi30C02I9GLcLCLnpO9/YD2VDK/xTW9N90t9KiNG1/+SY
         EwAVCfK32HOKn6KabOrmHG/3/19Q4CCx+rtw2xilT2Q/INBhQuQrTGTAjOTDADGDictZ
         uj9M2xzOY0bCcByd8VYFUVseJrWyOFEVqYybU0Ba1TDetgUnBYcgizeESxpEo8yrkSZ5
         NWEU7AnPQdxW5vmsm30Mkzl7aXJilWZORi8U6c3EqifH0CzwDlkUZT4R4/+scOTGgjwm
         YdtAdMIY3ZXHTow19VlhjUe3pYP6rpOOD1SNFjfsn7HV7FyjJENJsNqlroCKJAsXzFUq
         aXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h+UstZk3rb4xieNi6RtZtfHC6y3KugpHrROoby16gmg=;
        b=PtxEVoL1SsYFzzjdADXZ45MazEJ2c+vox2R42HMHHvk3TCvVje69vFCRqYHHxpCDDC
         fF9P/9HiLsWqiXqdCkouyOGJq94W0jAOtM1wPtgngzuz7jXwXxmMismOSdIAzEo47Ee9
         MrZCYPj2LbfsSGG28FYOuzYkre6mTr43YNXFi0chJxYLat5AV8dRoyJqryjBZDw9Xnq9
         2iKHGB5bxujJt0WBz7q8eB1D2NPrWoDaXqTXOi60q6xBcMLigxj1a+XI0725VbwEdZ0I
         y7Phe3e4auO0GOrYDrjhoSgdHwjpVYmOFMlTOhjD0x+7Sm++CQG3pk9LAUy7nM/nINDV
         Metg==
X-Gm-Message-State: AOPr4FXXQ7nWmB7TPMIw7tSxqfX374u4u9yotw9UJ8/PkxJaNwHViRQXHurfgZONPjm7Qg==
X-Received: by 10.28.14.77 with SMTP id 74mr6694365wmo.15.1461504934578;
        Sun, 24 Apr 2016 06:35:34 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:33 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292381>

This will enable further refactoring.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9c4f67f..64bc3e9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -76,6 +76,7 @@ struct apply_state {
 
 	struct strbuf root;
 
+	const char *whitespace_option;
 	int whitespace_error;
 };
 
@@ -4635,9 +4636,9 @@ static int option_parse_space_change(const struct option *opt,
 static int option_parse_whitespace(const struct option *opt,
 				   const char *arg, int unset)
 {
-	const char **whitespace_option = opt->value;
+	struct apply_state *state = opt->value;
 
-	*whitespace_option = arg;
+	state->whitespace_option = arg;
 	parse_whitespace_option(arg);
 	return 0;
 }
@@ -4662,8 +4663,6 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int read_stdin = 1;
 	struct apply_state state;
 
-	const char *whitespace_option = NULL;
-
 	struct option builtin_apply_options[] = {
 		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
 			N_("don't apply changes matching the given path"),
@@ -4703,7 +4702,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &state.p_context,
 				N_("ensure at least <n> lines of context match")),
-		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
+		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
 			0, option_parse_whitespace },
 		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
@@ -4791,11 +4790,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		if (fd < 0)
 			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
-		set_default_whitespace_mode(&state, whitespace_option);
+		set_default_whitespace_mode(&state, state.whitespace_option);
 		errs |= apply_patch(&state, fd, arg, options);
 		close(fd);
 	}
-	set_default_whitespace_mode(&state, whitespace_option);
+	set_default_whitespace_mode(&state, state.whitespace_option);
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
 	if (state.whitespace_error) {
-- 
2.8.1.300.g5fed0c0
