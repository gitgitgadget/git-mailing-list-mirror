From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 36/49] builtin/apply: move 'whitespace_option' into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:13 +0200
Message-ID: <20160524081126.16973-37-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:14:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57TS-0001Qk-Be
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbcEXIMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33959 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbcEXIMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so3661655wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8GUgHLcPY7PNceiEdqTlmU5nV9Ui0c4q0G/ML0auQDU=;
        b=mVoXfQKQd12THBkYtBQ2csolhId25Hvyqo4mnNM+7X83Fq1hxQ18YJ24aS8tkwJCNC
         AkjKq5JH4p3SGHsMrI12bi9QFLMT2nxaN0Z3EWjOH5wi72AboSdTqE1PAHgcTXLTixEX
         8YbRhJP/UxrsPX1NKG8H6TWuWLP2gKZW38ZMEd748uwaSRp6JRwjAHzm9lmXz560dxuZ
         OeYB/7cHWYFjwh5cEXpHIZYZ0JmD+i72tMOBKic83i+lj1iK5EHjsweaU4Mpnhbl2UgD
         RONCx8NPsdo90QlJ4CCnZo7Pk1isRheOFh9SSHJ/QRRJ12eGLD9Qe7KbFij6J0MlW7BK
         3r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GUgHLcPY7PNceiEdqTlmU5nV9Ui0c4q0G/ML0auQDU=;
        b=R2MChufBfK8MddIiKTIQjHuvU1XoWgIhunfmnwvMiYvHakqVltLhCYOICNt2HPLomP
         6eM6CUugD522Q1EtvdeurUgylnixojSwbGXSgWSFL/6Gaeqfro0bkSpFHHV/9Y5NenGH
         ETrcps0fsW8ergRSYQurotYZnCLkgtrRJNKYWSn0mhG45SoaLRnU6pTsZ8/6IRfukau6
         fs1TkZbRi4UH5ifPogHPW7oyywlPCiYBaQF8C8+n84fhCMUnZu8mMLPlDOs3UeFwwkQq
         C401phVxxhZcq3WrPs/FCfLbGpCsBrQH0a0gCL15Lu6MM7Be3SXjYsFHeusIz+MAhyNt
         Begw==
X-Gm-Message-State: ALyK8tKvWwrcZgUuZqeflnnF8ze0dTcACqsXTLCNWVlLhRqOjcR6s8KfOD3z3946O3PKjg==
X-Received: by 10.194.95.104 with SMTP id dj8mr2770110wjb.138.1464077554784;
        Tue, 24 May 2016 01:12:34 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:33 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295451>

This will enable further refactoring, and it is more coherent and
simpler if all the option_parse_*() functions are passed a
'struct apply_state' instance in opt->value.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 44717b2..78205f8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -61,6 +61,7 @@ struct apply_state {
 	int has_include;
 
 	/* These control whitespace errors */
+	const char *whitespace_option;
 	int whitespace_error;
 };
 
@@ -4619,9 +4620,9 @@ static int option_parse_space_change(const struct option *opt,
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
@@ -4670,8 +4671,6 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	int read_stdin = 1;
 	struct apply_state state;
 
-	const char *whitespace_option = NULL;
-
 	struct option builtin_apply_options[] = {
 		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
 			N_("don't apply changes matching the given path"),
@@ -4711,7 +4710,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &state.p_context,
 				N_("ensure at least <n> lines of context match")),
-		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
+		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
 			0, option_parse_whitespace },
 		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
@@ -4786,11 +4785,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
2.8.3.443.gaeee61e
