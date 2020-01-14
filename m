Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C5AC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3775324658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLIwtCJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgANSoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:44:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40524 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgANSoC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:44:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so14962729wmi.5
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0phmocog8B6q0Tw8zeYRgiTpc3ndWE2xf19kROVrxLg=;
        b=bLIwtCJtryDoEOpGYa5F+rLnmmroh9/bMKwY7G0kM8f2jFziMEjCCjgdrbPEWikrwc
         azfAJzfsXkKx9h/PuigMRnh2TzoARVgTXYoQa84Ci7kSOjKI+Fx3f4j3b367Si3mC3wQ
         LDxgzLvT4p7aXCODngA4eQhcrt1UKfaLW8jXx6g6Ft4xsvMHVUKqmEnirticNOQIhM2/
         szPbb9KFUAvSZjo34VRxS/0UjOL3NhLqFgvcvuM4eL2YHEEjXRSmBZHtBHkvAuOV7wsT
         pYgMfUsv8p1mxhZXc0jS8CWZrQQu2fOfPmVmmNMnowO2vr9dvKR/iu8FxUiGe/Bt174R
         HW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0phmocog8B6q0Tw8zeYRgiTpc3ndWE2xf19kROVrxLg=;
        b=B3KxHaVtUNc4/wpIMW3qAehGtCKdVeGzzDeAD1BJUFavdPTz/1f04ntcN2heECKcal
         HFqFQftnJlywsw+QSSCdn36HBg/RcVGKU01Zy/uhSW6OQYY+vJzPMTRG5qJfV7SbB6QK
         uM9VvLo8IzpF7pOp8ir4QqiwoKLCTL3Yoe0zwMBUuPwpzsVKZNu3NZEN1v97mtv7KyxO
         DEiTS8pEt2QSJaYhNMEK2dWYb8JU+tVuPrWphFvvJ3ZW75CG+AA1hzTLaioUPpjS4HlY
         ronHhICSP3hlc0KA+HVEgZGWxAJ4KG3w3RRpygiUwVlR3A3ibySLdd0oXsEOY0OctdVF
         mCnQ==
X-Gm-Message-State: APjAAAWrp80/89vf2yXe2Wc4mmOtqK8wq1MekrG6baqw/GehIaLcqRHO
        0/MWU22LzkDlZ2lDroRijSriHvhk
X-Google-Smtp-Source: APXvYqxYoAi0dyBBdsHbQg+w3GAomPShh3Qv32OWvfbhODW3aakRgL5MpEcRT7fXpdtYIaGxNst4Fg==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr28943902wmi.35.1579027440692;
        Tue, 14 Jan 2020 10:44:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm18824491wmg.22.2020.01.14.10.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:44:00 -0800 (PST)
Message-Id: <8ed4487ae49f5ff416d0dbcfdb7292056c7e3b85.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:50 +0000
Subject: [PATCH v4 07/10] built-in add -p: respect the `interactive.singlekey`
 config setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl version of `git add -p` supports this config setting to allow
users to input commands via single characters (as opposed to having to
press the <Enter> key afterwards).

This is an opt-in feature because it requires Perl packages
(Term::ReadKey and Term::Cap, where it tries to handle an absence of the
latter package gracefully) to work. Note that at least on Ubuntu, that
Perl package is not installed by default (it needs to be installed via
`sudo apt-get install libterm-readkey-perl`), so this feature is
probably not used a whole lot.

In C, we obviously do not have these packages available, but we just
introduced `read_single_keystroke()` that is similar to what
Term::ReadKey provides, and we use that here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c |  2 ++
 add-interactive.h |  1 +
 add-patch.c       | 21 +++++++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 9e4bcb382c..39c3896494 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -60,6 +60,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	FREE_AND_NULL(s->interactive_diff_algorithm);
 	git_config_get_string("diff.algorithm",
 			      &s->interactive_diff_algorithm);
+
+	git_config_get_bool("interactive.singlekey", &s->use_single_key);
 }
 
 void clear_add_i_state(struct add_i_state *s)
diff --git a/add-interactive.h b/add-interactive.h
index 923efaf527..693f125e8e 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -16,6 +16,7 @@ struct add_i_state {
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
 
+	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
 };
 
diff --git a/add-patch.c b/add-patch.c
index 8f2ee8688b..d8dafa8168 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -6,6 +6,7 @@
 #include "pathspec.h"
 #include "color.h"
 #include "diff.h"
+#include "compat/terminal.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
@@ -1149,14 +1150,27 @@ static int run_apply_check(struct add_p_state *s,
 	return 0;
 }
 
+static int read_single_character(struct add_p_state *s)
+{
+	if (s->s.use_single_key) {
+		int res = read_key_without_echo(&s->answer);
+		printf("%s\n", res == EOF ? "" : s->answer.buf);
+		return res;
+	}
+
+	if (strbuf_getline(&s->answer, stdin) == EOF)
+		return EOF;
+	strbuf_trim_trailing_newline(&s->answer);
+	return 0;
+}
+
 static int prompt_yesno(struct add_p_state *s, const char *prompt)
 {
 	for (;;) {
 		color_fprintf(stdout, s->s.prompt_color, "%s", _(prompt));
 		fflush(stdout);
-		if (strbuf_getline(&s->answer, stdin) == EOF)
+		if (read_single_character(s) == EOF)
 			return -1;
-		strbuf_trim_trailing_newline(&s->answer);
 		switch (tolower(s->answer.buf[0])) {
 		case 'n': return 0;
 		case 'y': return 1;
@@ -1396,9 +1410,8 @@ static int patch_update_file(struct add_p_state *s,
 			      _(s->mode->prompt_mode[prompt_mode_type]),
 			      s->buf.buf);
 		fflush(stdout);
-		if (strbuf_getline(&s->answer, stdin) == EOF)
+		if (read_single_character(s) == EOF)
 			break;
-		strbuf_trim_trailing_newline(&s->answer);
 
 		if (!s->answer.len)
 			continue;
-- 
gitgitgadget

