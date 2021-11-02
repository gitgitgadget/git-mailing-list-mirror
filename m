Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A855BC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B3761052
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 16:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhKBQuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhKBQuu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 12:50:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E26C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 09:48:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso2596648wmf.0
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ob61+8toor8D2HDdu1gMRySXYu6e3orQvaxp2IZ62Eg=;
        b=GsJe1kNorDZOe3sC3VUDU5SJyOKm3ggmMU6U9F5jGDtSAnCmxppspPPG8LsnCJYO21
         KuYs50NCfoto75CXoBcHfpbXdKBLHPmo22ob8vult1KGBTKtVEucw3U+nBRMLgLfdeyX
         P/sy9CrFciWNsHszbDd/fZl7Li8L3zF4iebKujTcx1Ww9g3P9cyK3+Y5kEWSMNA670Lf
         PDYdiPGVP9WMcDUbA7cwykBEhg5j0EtUcr+9IXQkKtd7mRBTLpwW/PNdsEqxYVZ2iLjJ
         oRcrSPNt2KlSozdz5vmGqizJ7HTc5D+eDASsfl/7i/E8b9nGfC5+CsfRJaninn5+QFN0
         iuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ob61+8toor8D2HDdu1gMRySXYu6e3orQvaxp2IZ62Eg=;
        b=TxH2Bh4b9BYvuZF7ocyzeBbr1Mmg0PEwPB2jiJS+BOZxd4LFAXKYZ1xTaxXt8ONWEH
         ZW66umUUloaCFcCWRAqeCNfvWq0MLoNrTUQE1Otw8STOxSBZyTTwEh1AvZhiIqktj8/l
         Cru7UPloIfGtbepkNEY0HXhUTzH7+d6Z4rO7n2cUnV3ynONDq0jdvf8qCeJ4NaMiOoYB
         xfW/HF5eHj9+SK0xRITaUlsJ6PvtaiIFI22653nrPt9JOphsEHtCLC+VFzzrxpUVQmN7
         OFvuzOytBJGK6fPNd9G9zTlXR8nGduAyGnIjDJo6PIZgqHGCruYZrbCFywvmsFtL7Gk4
         r++g==
X-Gm-Message-State: AOAM5323Cw9WeWVn1BEoi/1EgLmgYKLhoSyaQBaIwpTVbfZZShr85ixS
        z9qBKF8+L340hpMey7zdUJlj0ZfwZ6AT1A==
X-Google-Smtp-Source: ABdhPJyAiy8FrDvTATwVJYf2JzzhCdV9tsK04VmPV4rVfkJDDC7KD781nwvv48NQ0oRIJxyhYVwXXw==
X-Received: by 2002:a1c:5414:: with SMTP id i20mr7574878wmb.88.1635871693641;
        Tue, 02 Nov 2021 09:48:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17203188wrs.19.2021.11.02.09.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:48:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] prompt.c: split up the password and non-password handling
Date:   Tue,  2 Nov 2021 17:48:09 +0100
Message-Id: <patch-1.2-ce5bea43f03-20211102T155046Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
References: <20190524062724.GC25694@sigill.intra.peff.net> <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than pass PROMPT_ASKPASS and PROMPT_ECHO flags to git_prompt()
let's split it up into git_prompt_echo() and git_prompt_noecho()
functions, the latter only ever needs to be called from credential.c,
and the same goes for the previous password-only codepath in
git_prompt(), which is now exposed as a git_prompt_password().

Doing this paves the way towards addressing some of the issues brought
up in 97387c8bdd9 (am: read interactive input from stdin, 2019-05-20).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                 |  1 +
 builtin/bisect--helper.c |  5 ++-
 credential.c             | 17 ++++++----
 help.c                   |  2 +-
 prompt-password.c        | 63 ++++++++++++++++++++++++++++++++++
 prompt-password.h        |  7 ++++
 prompt.c                 | 73 ++++++----------------------------------
 prompt.h                 |  7 ++--
 8 files changed, 97 insertions(+), 78 deletions(-)
 create mode 100644 prompt-password.c
 create mode 100644 prompt-password.h

diff --git a/Makefile b/Makefile
index 12be39ac497..e8815860e22 100644
--- a/Makefile
+++ b/Makefile
@@ -967,6 +967,7 @@ LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
 LIB_OBJS += promisor-remote.o
+LIB_OBJS += prompt-password.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
 LIB_OBJS += protocol-caps.o
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..30533a70b53 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -370,7 +370,7 @@ static int decide_next(const struct bisect_terms *terms,
 		 * translation. The program will only accept English input
 		 * at this point.
 		 */
-		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
+		yesno = git_prompt_echo(_("Are you sure [Y/n]? "));
 		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
 			return -1;
 		return 0;
@@ -838,8 +838,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 	 * translation. The program will only accept English input
 	 * at this point.
 	 */
-	yesno = git_prompt(_("Do you want me to do it for you "
-			     "[Y/n]? "), PROMPT_ECHO);
+	yesno = git_prompt_echo(_("Do you want me to do it for you [Y/n]? "));
 	res = tolower(*yesno) == 'n' ?
 		-1 : bisect_start(terms, empty_strvec, 0);
 
diff --git a/credential.c b/credential.c
index e7240f3f636..5509de382a5 100644
--- a/credential.c
+++ b/credential.c
@@ -5,6 +5,7 @@
 #include "run-command.h"
 #include "url.h"
 #include "prompt.h"
+#include "prompt-password.h"
 #include "sigchain.h"
 #include "urlmatch.h"
 
@@ -169,11 +170,11 @@ static void credential_format(struct credential *c, struct strbuf *out)
 	}
 }
 
-static char *credential_ask_one(const char *what, struct credential *c,
-				int flags)
+static char *credential_ask_one(struct credential *c, unsigned int password)
 {
 	struct strbuf desc = STRBUF_INIT;
 	struct strbuf prompt = STRBUF_INIT;
+	const char *what = password ? "Password" : "Username";
 	char *r;
 
 	credential_describe(c, &desc);
@@ -182,7 +183,11 @@ static char *credential_ask_one(const char *what, struct credential *c,
 	else
 		strbuf_addf(&prompt, "%s: ", what);
 
-	r = git_prompt(prompt.buf, flags);
+	/* We'll try "askpass" for both usernames and passwords */
+	r = git_prompt_askpass(prompt.buf);
+	if (!r)
+		r = password ? git_prompt_noecho(prompt.buf)
+			     : git_prompt_echo(prompt.buf);
 
 	strbuf_release(&desc);
 	strbuf_release(&prompt);
@@ -192,11 +197,9 @@ static char *credential_ask_one(const char *what, struct credential *c,
 static void credential_getpass(struct credential *c)
 {
 	if (!c->username)
-		c->username = credential_ask_one("Username", c,
-						 PROMPT_ASKPASS|PROMPT_ECHO);
+		c->username = credential_ask_one(c, 0);
 	if (!c->password)
-		c->password = credential_ask_one("Password", c,
-						 PROMPT_ASKPASS);
+		c->password = credential_ask_one(c, 1);
 }
 
 int credential_read(struct credential *c, FILE *fp)
diff --git a/help.c b/help.c
index 973e47cdc30..6eebc26fbeb 100644
--- a/help.c
+++ b/help.c
@@ -644,7 +644,7 @@ const char *help_unknown_cmd(const char *cmd)
 			char *answer;
 			struct strbuf msg = STRBUF_INIT;
 			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
-			answer = git_prompt(msg.buf, PROMPT_ECHO);
+			answer = git_prompt_echo(msg.buf);
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||
 			      starts_with(answer, "Y")))
diff --git a/prompt-password.c b/prompt-password.c
new file mode 100644
index 00000000000..5fa00363d6c
--- /dev/null
+++ b/prompt-password.c
@@ -0,0 +1,63 @@
+#include "cache.h"
+#include "prompt-password.h"
+#include "strbuf.h"
+#include "run-command.h"
+#include "prompt.h"
+
+static char *do_askpass(const char *cmd, const char *prompt)
+{
+	struct child_process pass = CHILD_PROCESS_INIT;
+	const char *args[3];
+	static struct strbuf buffer = STRBUF_INIT;
+	int err = 0;
+
+	args[0] = cmd;
+	args[1]	= prompt;
+	args[2] = NULL;
+
+	pass.argv = args;
+	pass.out = -1;
+
+	if (start_command(&pass))
+		return NULL;
+
+	strbuf_reset(&buffer);
+	if (strbuf_read(&buffer, pass.out, 20) < 0)
+		err = 1;
+
+	close(pass.out);
+
+	if (finish_command(&pass))
+		err = 1;
+
+	if (err) {
+		error("unable to read askpass response from '%s'", cmd);
+		strbuf_release(&buffer);
+		return NULL;
+	}
+
+	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
+
+	return buffer.buf;
+}
+
+char *git_prompt_askpass(const char *prompt)
+{
+	const char *askpass;
+	char *r = NULL;
+
+	askpass = getenv("GIT_ASKPASS");
+	if (!askpass)
+		askpass = askpass_program;
+	if (!askpass)
+		askpass = getenv("SSH_ASKPASS");
+	if (askpass && *askpass)
+		r = do_askpass(askpass, prompt);
+
+	return r;
+}
+
+char *git_prompt_noecho(const char *prompt)
+{
+	return git_prompt(prompt, 0);
+}
diff --git a/prompt-password.h b/prompt-password.h
new file mode 100644
index 00000000000..84933d2b7c5
--- /dev/null
+++ b/prompt-password.h
@@ -0,0 +1,7 @@
+#ifndef PROMPT_PASSWORD_H
+#define PROMPT_PASSWORD_H
+
+char *git_prompt_askpass(const char *prompt);
+char *git_prompt_noecho(const char *prompt);
+
+#endif
diff --git a/prompt.c b/prompt.c
index 5ded21a017f..458d6637506 100644
--- a/prompt.c
+++ b/prompt.c
@@ -1,78 +1,27 @@
 #include "cache.h"
 #include "config.h"
-#include "run-command.h"
 #include "strbuf.h"
 #include "prompt.h"
 #include "compat/terminal.h"
 
-static char *do_askpass(const char *cmd, const char *prompt)
+char *git_prompt(const char *prompt, unsigned int echo)
 {
-	struct child_process pass = CHILD_PROCESS_INIT;
-	const char *args[3];
-	static struct strbuf buffer = STRBUF_INIT;
-	int err = 0;
-
-	args[0] = cmd;
-	args[1]	= prompt;
-	args[2] = NULL;
-
-	pass.argv = args;
-	pass.out = -1;
-
-	if (start_command(&pass))
-		return NULL;
-
-	strbuf_reset(&buffer);
-	if (strbuf_read(&buffer, pass.out, 20) < 0)
-		err = 1;
-
-	close(pass.out);
-
-	if (finish_command(&pass))
-		err = 1;
+	char *r = NULL;
 
-	if (err) {
-		error("unable to read askpass response from '%s'", cmd);
-		strbuf_release(&buffer);
-		return NULL;
+	if (git_env_bool("GIT_TERMINAL_PROMPT", 1)) {
+		r = git_terminal_prompt(prompt, echo);
+		if (!r)
+			die_errno("could not read");
+	} else {
+		die("could not read terminal prompts disabled");
 	}
 
-	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
-
-	return buffer.buf;
+	return r;
 }
 
-char *git_prompt(const char *prompt, int flags)
+char *git_prompt_echo(const char *prompt)
 {
-	char *r = NULL;
-
-	if (flags & PROMPT_ASKPASS) {
-		const char *askpass;
-
-		askpass = getenv("GIT_ASKPASS");
-		if (!askpass)
-			askpass = askpass_program;
-		if (!askpass)
-			askpass = getenv("SSH_ASKPASS");
-		if (askpass && *askpass)
-			r = do_askpass(askpass, prompt);
-	}
-
-	if (!r) {
-		const char *err;
-
-		if (git_env_bool("GIT_TERMINAL_PROMPT", 1)) {
-			r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
-			err = strerror(errno);
-		} else {
-			err = "terminal prompts disabled";
-		}
-		if (!r) {
-			/* prompts already contain ": " at the end */
-			die("could not read %s%s", prompt, err);
-		}
-	}
-	return r;
+	return git_prompt(prompt, 1);
 }
 
 int git_read_line_interactively(struct strbuf *line)
diff --git a/prompt.h b/prompt.h
index e294e93541c..f4d38178bc4 100644
--- a/prompt.h
+++ b/prompt.h
@@ -1,11 +1,8 @@
 #ifndef PROMPT_H
 #define PROMPT_H
 
-#define PROMPT_ASKPASS (1<<0)
-#define PROMPT_ECHO    (1<<1)
-
-char *git_prompt(const char *prompt, int flags);
-
+char *git_prompt(const char *prompt, unsigned int echo);
+char *git_prompt_echo(const char *prompt);
 int git_read_line_interactively(struct strbuf *line);
 
 #endif /* PROMPT_H */
-- 
2.33.1.1570.g069344fdd45

