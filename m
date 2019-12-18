Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C049C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 01:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043232176D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 01:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncHqH3zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfLRBLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:11:09 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35761 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLRBLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 20:11:08 -0500
Received: by mail-wr1-f51.google.com with SMTP id g17so474770wro.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 17:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+/BN5V6Yu4mULvldocLHPcH3fL1kQGEj+OiJLFy+ONE=;
        b=ncHqH3zjWW+jDu8ftnCW9kZWfCLhgkjR/r1XCzVpATJRnwuKrJOKoOWBJQG9DK/evD
         G/ROQUW6eLPQ4nRCZsL3bs6+ethiVwr2Y4McCg6KYuuH6MrXpsRupH/zbiOGnyPfmZWK
         7SixrhORB5PM6D9IntrG+aKpaYP89R+gWcMvqXhIs6ng/gRPYZh9v9/cIisVUrlzzlSd
         4v8EiMSCIdamEqyt+vduIxnideFJvbOx+ZdDXHbIMXyf5T7XFbd4GcoD/aH2h+ct/+OW
         F3VoFM1cTJjNiAwuvtlFsik6SuBUzFR3rgu3LJLkftaeKOuZIuatxdeOYeOh9waJHUET
         T2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+/BN5V6Yu4mULvldocLHPcH3fL1kQGEj+OiJLFy+ONE=;
        b=XV/KsGOB7rEQYsy9JMHFGp2GaRrL/ErV+4/nIP6OnxTyQyKmoNoI2TSbTSHjR/acrr
         Dbh2+dljxamV8IAQ4sbTj9t/iu46r9Mou2Em5WldivZ9+WKgHN9mZCgOd53FGDyr1yFh
         awvGuv5YV4aTs8+qQhRXXFfTrfmpmRB6K3mOFfgCAfBngH52IVii3MABSWgewQlEXgVa
         xJp3+/1Wl+NYXEpibQJ7AW1CM4HBFg9g6WM0/brEPLMDd6LEV8N0DL2AiIWNZ4aarzYy
         xpgJlOsGiXhNfzBZ3trHwOP6biu4O1+ZnaqbWqlpqxztElZAf/QFMGp3nngEbU3seIMr
         F3lg==
X-Gm-Message-State: APjAAAUYh46SJC+s6lJs0hJBN8ow4a9kMcnkrDEN2sP+ej97lAW9b1Xk
        efLap3OJ9DUz7VyZtia4JNfS8C8S
X-Google-Smtp-Source: APXvYqye8zb9UE7UodmGdZRs+mCl3LYbc5iWcnF1ufXwrtyDfZbUetpQoDuT5ZEn4nUT9tOW+pcjEg==
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr714236wrx.341.1576631465861;
        Tue, 17 Dec 2019 17:11:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm617092wmm.15.2019.12.17.17.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:11:05 -0800 (PST)
Message-Id: <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.git.1576631464.gitgitgadget@gmail.com>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 01:11:04 +0000
Subject: [PATCH 1/1] config: allow user to know scope of config options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

Add new option --show-scope which allows a user to know what the scope
of listed config options are (local/global/system/etc.).

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 builtin/config.c  | 60 ++++++++++++++++++++++++++++++++++++++++-------
 t/t1300-config.sh | 51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..9a9c2d12f2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -29,10 +29,11 @@ static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
-static int end_null;
+static int end_nul;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
+static int show_scope;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -151,10 +152,11 @@ static struct option builtin_config_options[] = {
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
-	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (system, global, local, command line)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
 	OPT_END(),
 };
@@ -178,23 +180,63 @@ static void check_argc(int argc, int min, int max)
 
 static void show_config_origin(struct strbuf *buf)
 {
-	const char term = end_null ? '\0' : '\t';
+	const char term = end_nul ? '\0' : '\t';
 
 	strbuf_addstr(buf, current_config_origin_type());
 	strbuf_addch(buf, ':');
-	if (end_null)
+	if (end_nul)
 		strbuf_addstr(buf, current_config_name());
 	else
 		quote_c_style(current_config_name(), buf, NULL, 0);
 	strbuf_addch(buf, term);
 }
 
+static const char *scope_to_string(enum config_scope scope) {
+	/*
+	 * --local, --global, and --system work the same as --file so there's
+	 * no easy way for the parser to tell the difference when it is
+	 * setting the scope, so we use our information about which options
+	 * were passed
+	 */
+	if (use_local_config || scope == CONFIG_SCOPE_REPO) {
+		return "local";
+	} else if (use_global_config || scope == CONFIG_SCOPE_GLOBAL) {
+		return "global";
+	} else if (use_system_config || scope == CONFIG_SCOPE_SYSTEM) {
+		return "system";
+	} else if (given_config_source.use_stdin ||
+		given_config_source.blob ||
+		given_config_source.file ||
+		scope == CONFIG_SCOPE_CMDLINE) {
+		return "command line";
+	} else {
+		return "unknown";
+	}
+}
+
+static void show_config_scope(struct strbuf *buf)
+{
+	const char term = end_nul ? '\0' : '\t';
+	const char *scope = scope_to_string(current_config_scope());
+
+	strbuf_addch(buf, '(');
+	if (end_nul)
+		strbuf_addstr(buf, N_(scope));
+	else
+		quote_c_style(scope, buf, NULL, 0);
+	strbuf_addch(buf, ')');
+	strbuf_addch(buf, term);
+}
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
-	if (show_origin) {
+	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
-		show_config_origin(&buf);
-		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
+		if (show_scope)
+			show_config_scope(&buf);
+		if (show_origin)
+			show_config_origin(&buf);
+		/* Use fwrite as "buf" can contain \0's if "end_nul" is set. */
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
 	}
@@ -213,6 +255,8 @@ struct strbuf_list {
 
 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
+	if (show_scope)
+		show_config_scope(buf);
 	if (show_origin)
 		show_config_origin(buf);
 	if (show_keys)
@@ -678,7 +722,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.git_dir = get_git_dir();
 	}
 
-	if (end_null) {
+	if (end_nul) {
 		term = '\0';
 		delim = '\n';
 		key_delim = '\n';
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 983a0a1583..098f305bdd 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1766,6 +1766,57 @@ test_expect_success !MINGW '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+
+test_expect_success '--show-scope with --list' '
+	cat >expect <<-EOF &&
+		(global)	user.global=true
+		(global)	user.override=global
+		(global)	include.path=$INCLUDE_DIR/absolute.include
+		(global)	user.absolute=include
+		(local)	user.local=true
+		(local)	user.override=local
+		(local)	include.path=../include/relative.include
+		(local)	user.relative=include
+		(command line)	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success !MINGW '--show-scope with --blob' '
+	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+	cat >expect <<-EOF &&
+		(command line)	user.custom=true
+	EOF
+	git config --blob=$blob --show-scope --list >output &&
+	test_cmp expect output
+'
+test_expect_success '--show-scope with --local' '
+	cat >expect <<-\EOF &&
+		(local)	user.local=true
+		(local)	user.override=local
+		(local)	include.path=../include/relative.include
+	EOF
+	git config --local --list --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-scope with --show-origin' '
+	cat >expect <<-EOF &&
+		(global)	file:$HOME/.gitconfig	user.global=true
+		(global)	file:$HOME/.gitconfig	user.override=global
+		(global)	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
+		(global)	file:$INCLUDE_DIR/absolute.include	user.absolute=include
+		(local)	file:.git/config	user.local=true
+		(local)	file:.git/config	user.override=local
+		(local)	file:.git/config	include.path=../include/relative.include
+		(local)	file:.git/../include/relative.include	user.relative=include
+		(command line)	command line:	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-origin --show-scope >output &&
+	test_cmp expect output
+'
+
 test_expect_success '--local requires a repo' '
 	# we expect 128 to ensure that we do not simply
 	# fail to find anything and return code "1"
-- 
gitgitgadget
