From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 32/83] builtin/apply: move 'p_value_known' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:32 +0200
Message-ID: <1461504863-15946-33-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCO-00082r-Ce
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbcDXNfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:36 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34995 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbcDXNfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:31 -0400
Received: by mail-wm0-f41.google.com with SMTP id e201so60533610wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B3pBU9QW5NPq4JbGxrfqbK2yhGFvSyXcpfH444zQ1gQ=;
        b=swSTNVRkbi8FAe6dRVrSkESqIiJ8uJuAXyd3kdNT3aoqVWFrXXwPRe8smGWFuOEys0
         +Ps/FUN8pTsLcPHVrkKmTCr/8GQgh7/jU/vKSKk2BSLJZCRPn6m3LB8O4oFPWcLD1m8L
         qeuw5fk5CMPQaBsTqIbgWB2N9e1Yj0wO8lUx+SRxjNH1gNGqamdbPwO4K0heSqJtfan7
         Yak9eA+Q2EsHjQmYxk7Bxp9eJ/bGpyJBpKTDT4gzzYESrheDIR0NJ0Oj94lPBtnVbbpv
         x4OTSdHUy6GV9VXkOsddx7bAOJurASsy9gMW3OtlfJojZC6AyaC70xl+WgRC5RzpLf+L
         xn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B3pBU9QW5NPq4JbGxrfqbK2yhGFvSyXcpfH444zQ1gQ=;
        b=kbwpajDts+z1QAbiSP4sGQhuxSUPe4xX0F3KXRIBWj5BeGct31+xU10OjAPV/ApHso
         vh+wU8dMZ3is5mDqV4blx7+3xcqNnmL+feXs89rUFdFcZ1Vbkl93PAoWKx0BugtzGuul
         mLM3VaJVeYdcR3e79xKMgHk2AMNL20xhgpz9xNA+9Aq2Sv+sZmKFnZBGWW4xyT22Dw2T
         wglqnMyItlnXeMs/yr6pvF8d0NnTjhEHnoQl2IgV8OeyW9eUELvphFm1IQHIhgy3sFHX
         GKV8MO0NoLAGDoYCrPHMnzDr5go8W8tW3uzyZVtN+bLpNaCNXWKjrhbgMwQFuHxBEr2A
         2Lyw==
X-Gm-Message-State: AOPr4FXqCUnGWdQEC2lW3lSp8LWxUkmleMlFultwH+s0pNTDcDIMK0Fyz7IVugn8lhiX/Q==
X-Received: by 10.194.5.101 with SMTP id r5mr30685480wjr.47.1461504930261;
        Sun, 24 Apr 2016 06:35:30 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:29 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292339>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 979849c..fecdb66 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -66,6 +66,7 @@ struct apply_state {
 	int line_termination;
 
 	int p_value;
+	int p_value_known;
 	unsigned int p_context;
 
 	const char *patch_input_file;
@@ -76,8 +77,6 @@ struct apply_state {
 
 static int newfd = -1;
 
-static int p_value_known;
-
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -890,14 +889,14 @@ static void parse_traditional_patch(struct apply_state *state,
 
 	first += 4;	/* skip "--- " */
 	second += 4;	/* skip "+++ " */
-	if (!p_value_known) {
+	if (!state->p_value_known) {
 		int p, q;
 		p = guess_p_value(state, first);
 		q = guess_p_value(state, second);
 		if (p < 0) p = q;
 		if (0 <= p && p == q) {
 			state->p_value = p;
-			p_value_known = 1;
+			state->p_value_known = 1;
 		}
 	}
 	if (is_dev_null(first)) {
@@ -4604,7 +4603,7 @@ static int option_parse_p(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	state->p_value = atoi(arg);
-	p_value_known = 1;
+	state->p_value_known = 1;
 	return 0;
 }
 
-- 
2.8.1.300.g5fed0c0
