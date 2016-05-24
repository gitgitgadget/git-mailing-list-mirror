From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 27/49] builtin/apply: move 'p_context' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:04 +0200
Message-ID: <20160524081126.16973-28-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:14:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57UG-0001f6-DL
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbcEXIOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:14:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33438 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664AbcEXIMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id 67so3641551wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+3uDV6Uouc1KAp5iySSRF5Gc/kk+HTefGvtdgjsR9ow=;
        b=vCZLUCYj1YObxOah1X8NJ2T6o6tN4NY4uiaGJ3lYKqZNOa1KqJPwSlcLdWNLDNhN/c
         MxzCE56XqKlQjgqjvw+lu6uVmsG2A4kqefpv6mWGVEMqDYTEwPHAZS03S5uSjAOjokHU
         J9y3Fs3yTo0E16n7DRQxx4KC4eHbAcY7f64t4tus0yomLT8WkfQ4drvTWOw3O8xim57l
         fJyrUc4c81L2Yt/sH/Psv/4Lqqgiy4wovAXhgG/yKSFisTLgYEPjFQaKlI8jIHma+q+Y
         5NPILfotY/xZnGoyYj/IbAQ7SCZJQ5KLe/rEdtwsRYoCqzOfBSOrlbsYSKSInnD/o4sj
         CSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+3uDV6Uouc1KAp5iySSRF5Gc/kk+HTefGvtdgjsR9ow=;
        b=LSl3O+/WoSjtsnaSQiImE22mtHU+UHy30MNp/ZHVE3NTLp9wc3QWMNWGHBbUz6vdXc
         /s5rDneALjO9owTUsSZBKBrO4s9pumsztAltpCKsqAZaUVzqlUMrEpirSFdJV2wgVnEv
         dEozuRaSXW/3kIbUU05EJTvOlDj/p5NvhuogNZSftCUPkTO3iOTp3eW8Xh/a0draYLq+
         mtG7wkMhYMGSseYtslg6kZcgA/5uETeSCVQ2PgEfTe1X7TssIrLqph9btVAFNabjTqNp
         1g9jB3+TQYtY84iiHArU7zidtFNpI5vXWPsK/zAAFVk6VsnCLubYDT0GCDPU/fOCppAn
         cJmw==
X-Gm-Message-State: AOPr4FWkh5EoqOqzBZmy8t84pR6EE6CtcZds7cKlgqmJO52Ivcy8RtFvPM3osyKdQ3u8Mw==
X-Received: by 10.28.161.198 with SMTP id k189mr21843173wme.23.1464077542732;
        Tue, 24 May 2016 01:12:22 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:22 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295457>

To libify the apply functionality the 'p_context' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 59b0f1b..3c9f052 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -49,6 +49,7 @@ struct apply_state {
 	/* Other non boolean parameters */
 	const char *fake_ancestor;
 	int line_termination;
+	unsigned int p_context;
 };
 
 static int newfd = -1;
@@ -56,7 +57,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -2872,7 +2872,7 @@ static int apply_one_fragment(struct apply_state *state,
 			break;
 
 		/* Am I at my context limits? */
-		if ((leading <= p_context) && (trailing <= p_context))
+		if ((leading <= state->p_context) && (trailing <= state->p_context))
 			break;
 		if (match_beginning || match_end) {
 			match_beginning = match_end = 0;
@@ -4566,6 +4566,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->line_termination = '\n';
+	state->p_context = UINT_MAX;
 
 	git_apply_config();
 	if (apply_default_whitespace)
@@ -4628,7 +4629,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state.line_termination,
 			N_("paths are separated with NUL character"), '\0'),
-		OPT_INTEGER('C', NULL, &p_context,
+		OPT_INTEGER('C', NULL, &state.p_context,
 				N_("ensure at least <n> lines of context match")),
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
-- 
2.8.3.443.gaeee61e
