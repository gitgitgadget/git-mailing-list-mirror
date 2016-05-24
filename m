From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 22/49] builtin/apply: move 'threeway' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:59 +0200
Message-ID: <20160524081126.16973-23-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:15:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57V1-0001xG-29
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbcEXIP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:15:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33333 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbcEXIMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id 67so3640682wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rhMBJh+NqeylPpdGAvaJ5l2C3fNyBWho9lL7m9AmnrI=;
        b=R9hMxl3RvyXn+u55FBSN5foReYNSgsAcwm2ySEVoG6FyDlMyP44/r6YF0KCzd3ETrj
         fXIU8YeNAC8L53iUnkqN4RRRiNA33RU14CRda5syQOFH/KOmz0z73GbI4PYR3rMmrEQD
         INanPj91pF/IhRj2sxHsdnzYbIbchzuU0Y9XunHuCnmFMogmWdPD9zI6h6KfFoidFEc8
         V1OvGHCH7KC4cn/9j9yd18JzKT63vd28PfH89MsFWM9Jo6V3I14+mYsUqwbpY3jJLedR
         Czxb9St/ssqEX6txZ95X/u3jiBbIjZvG0YXuEaIlHtD0T4aHeg2eSY/QxDPz2z0OsLqA
         yofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rhMBJh+NqeylPpdGAvaJ5l2C3fNyBWho9lL7m9AmnrI=;
        b=CTooP9/lF8jS5YPL2bv2HujhGU0id0aARkuroQZAP0lXoucqOsmoTjOOYQr3/4kapD
         nbS/8tKQKrnTtQYpqyhh8rOonaICZYM0LmZ0ggNDUGFPqFQHqv3O7fFoSjMzrykCa8pH
         qQFLy4Kt+uH/t7mkKNCrzShhg46IAlLR/kNfptW+6fKXVMzhvcbc9wvcteW9EauGe68Y
         y/EOFZFDLi5D2Ub68mdGDhrw53Ctw5yoBHcel5sP54vfPccvEjfEAUtAfKwNeuw7c+Qo
         hWcOKf9B39gucTUsQ3VDLYGd6e8Aa1RU+ar+pjf+DLmAV8cIsEyQBx4IYBmVOKgsSfCo
         cgEw==
X-Gm-Message-State: ALyK8tLHsd2nEGywQeGMOtWGPRf8P5M1FgpQpk7Ynz6HYsHnyPfvIsjNj7wISXS5Vss65Q==
X-Received: by 10.194.89.33 with SMTP id bl1mr2791694wjb.43.1464077536498;
        Tue, 24 May 2016 01:12:16 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:15 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295462>

To libify the apply functionality the 'threeway' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f174a42..d00017b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -41,6 +41,7 @@ struct apply_state {
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
+	int threeway;
 	int unidiff_zero;
 };
 
@@ -53,7 +54,6 @@ static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
 static int no_add;
-static int threeway;
 static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -3491,7 +3491,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	if (patch->direct_to_threeway ||
 	    apply_fragments(state, &image, patch) < 0) {
 		/* Note: with --reject, apply_fragments() returns 0 */
-		if (!threeway || try_threeway(state, &image, patch, st, ce) < 0)
+		if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0)
 			return -1;
 	}
 	patch->result = image.buf;
@@ -3786,7 +3786,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
 		int err = check_to_create(state, new_name, ok_if_exists);
 
-		if (err && threeway) {
+		if (err && state->threeway) {
 			patch->direct_to_threeway = 1;
 		} else switch (err) {
 		case 0:
@@ -4620,7 +4620,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("accept a patch that touches outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
-		OPT_BOOL('3', "3way", &threeway,
+		OPT_BOOL('3', "3way", &state.threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
@@ -4664,11 +4664,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	if (state.apply_with_reject && threeway)
+	if (state.apply_with_reject && state.threeway)
 		die("--reject and --3way cannot be used together.");
-	if (state.cached && threeway)
+	if (state.cached && state.threeway)
 		die("--cached and --3way cannot be used together.");
-	if (threeway) {
+	if (state.threeway) {
 		if (is_not_gitdir)
 			die(_("--3way outside a repository"));
 		state.check_index = 1;
-- 
2.8.3.443.gaeee61e
