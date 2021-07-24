Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4FC4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02774606A5
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGXV0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 17:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhGXV02 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 17:26:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D914C06175F
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y8so6296718wrt.10
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O6yuFn11f0SxKGCXo82ef58o5xH+q2dD0HptPT3QZl4=;
        b=NEDzcIgkweM/O2l4vRjRK291eTXlonB4JWdqnx2sj95qk7IlfQlOIv63KCQvwtdf6M
         gB8WiKtvWkkiOD/KnQfibnRfmqpaiMTJ/cI9aGXYIPaZV5/0PPDWVJsgRtNsaEoy+IhE
         qPPfD2WgjRQ0/yNuDbhsein35uxsJQqQ70vt4ao8lPfStZmWKYFDH9Bvg/hTQGgzBTbk
         zB3WZl5ZrCdy2S1grAm27hARdUbVR+dBV3ZUQQpklUoSwD+ghLKjV62DhgZ4BelIbEcP
         5AwhuRMNpHaBH1LBfn/dRBp+3hqdx4eXQgXxWqTBhzfBHIrF5d9v+G2HhKt+nFkvrMYl
         8Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O6yuFn11f0SxKGCXo82ef58o5xH+q2dD0HptPT3QZl4=;
        b=d9ny29/qNz3QS2IV8U8CyW8mv08BWfnM55LYIDkPF3TyvlFixlyF6Z0VSGtbFW/xsT
         XD/H5CD/Z8e4+Ca8gQSRZWZlvCbeJTZPq1kwE7tX2koxB79hEQpgjlXpOUL2vhyaQTIK
         gIRdGVj63IOcJ0qjErnDOj19ixDwXKTRUY2XVRczRRg05aXmfaELDv0HsUW1ZHUWe0pH
         qhd1GTAxukCw0eWDBLuMsZoAJ9L7tbY4TuBkVIGLeVxbpcqAejbsY9zZo+G6X0opa2AK
         oa8j+QNZYqnGeqeVAFieOLoljQUOXsX6vVzUPkKZNr6GRF1PevyjcPJW4N/mK3zsvJgc
         3u3w==
X-Gm-Message-State: AOAM532g3DtBzJAu+Saocms+iNty4KSnkDkC0nTs4051POgt/bBgJ88j
        0pykkbP0/yu8z3EcMphy2D9X4bi7fds=
X-Google-Smtp-Source: ABdhPJxaKPVIDents/pVrkqCWIIxpOWNL8TwCsaNqpfDYvkvVBzSrtG+ukZRti3JWWZSmTFRp7S/tQ==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr11522852wrs.405.1627164418053;
        Sat, 24 Jul 2021 15:06:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm9098294wmj.8.2021.07.24.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:06:57 -0700 (PDT)
Message-Id: <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 22:06:52 +0000
Subject: [PATCH v3 4/5] Use a better name for the function interpolating paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is not immediately clear what `expand_user_path()` means, so let's
rename it to `interpolate_path()`. This also opens the path for
interpolating more than just a home directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/credential-cache.c | 2 +-
 builtin/credential-store.c | 2 +-
 builtin/gc.c               | 2 +-
 cache.h                    | 2 +-
 config.c                   | 8 ++++----
 path.c                     | 4 ++--
 sequencer.c                | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 76a6ba37223..e8a74157471 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -90,7 +90,7 @@ static char *get_socket_path(void)
 {
 	struct stat sb;
 	char *old_dir, *socket;
-	old_dir = expand_user_path("~/.git-credential-cache", 0);
+	old_dir = interpolate_path("~/.git-credential-cache", 0);
 	if (old_dir && !stat(old_dir, &sb) && S_ISDIR(sb.st_mode))
 		socket = xstrfmt("%s/socket", old_dir);
 	else
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index ae3c1ba75fe..62a4f3c2653 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -173,7 +173,7 @@ int cmd_credential_store(int argc, const char **argv, const char *prefix)
 	if (file) {
 		string_list_append(&fns, file);
 	} else {
-		if ((file = expand_user_path("~/.git-credentials", 0)))
+		if ((file = interpolate_path("~/.git-credentials", 0)))
 			string_list_append_nodup(&fns, file);
 		file = xdg_config_home("credentials");
 		if (file)
diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1ac..6ce5ca45126 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1542,7 +1542,7 @@ static char *launchctl_service_filename(const char *name)
 	struct strbuf filename = STRBUF_INIT;
 	strbuf_addf(&filename, "~/Library/LaunchAgents/%s.plist", name);
 
-	expanded = expand_user_path(filename.buf, 1);
+	expanded = interpolate_path(filename.buf, 1);
 	if (!expanded)
 		die(_("failed to expand path '%s'"), filename.buf);
 
diff --git a/cache.h b/cache.h
index ba04ff8bd36..87e4cbe9c5f 100644
--- a/cache.h
+++ b/cache.h
@@ -1246,7 +1246,7 @@ typedef int create_file_fn(const char *path, void *cb);
 int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
 
 int mkdir_in_gitdir(const char *path);
-char *expand_user_path(const char *path, int real_home);
+char *interpolate_path(const char *path, int real_home);
 const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
diff --git a/config.c b/config.c
index f9c400ad306..c17b9797292 100644
--- a/config.c
+++ b/config.c
@@ -137,7 +137,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!path)
 		return config_error_nonbool("include.path");
 
-	expanded = expand_user_path(path, 0);
+	expanded = interpolate_path(path, 0);
 	if (!expanded)
 		return error(_("could not expand include path '%s'"), path);
 	path = expanded;
@@ -185,7 +185,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	char *expanded;
 	int prefix = 0;
 
-	expanded = expand_user_path(pat->buf, 1);
+	expanded = interpolate_path(pat->buf, 1);
 	if (expanded) {
 		strbuf_reset(pat);
 		strbuf_addstr(pat, expanded);
@@ -1270,7 +1270,7 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 {
 	if (!value)
 		return config_error_nonbool(var);
-	*dest = expand_user_path(value, 0);
+	*dest = interpolate_path(value, 0);
 	if (!*dest)
 		die(_("failed to expand user dir in: '%s'"), value);
 	return 0;
@@ -1844,7 +1844,7 @@ void git_global_config(char **user_out, char **xdg_out)
 	char *xdg_config = NULL;
 
 	if (!user_config) {
-		user_config = expand_user_path("~/.gitconfig", 0);
+		user_config = interpolate_path("~/.gitconfig", 0);
 		xdg_config = xdg_config_home("config");
 	}
 
diff --git a/path.c b/path.c
index bf329e535cf..8dc5ad2cb55 100644
--- a/path.c
+++ b/path.c
@@ -724,7 +724,7 @@ static struct passwd *getpw_str(const char *username, size_t len)
  *
  * If real_home is true, strbuf_realpath($HOME) is used in the `~/` expansion.
  */
-char *expand_user_path(const char *path, int real_home)
+char *interpolate_path(const char *path, int real_home)
 {
 	struct strbuf user_path = STRBUF_INIT;
 	const char *to_copy = path;
@@ -811,7 +811,7 @@ const char *enter_repo(const char *path, int strict)
 		strbuf_add(&validated_path, path, len);
 
 		if (used_path.buf[0] == '~') {
-			char *newpath = expand_user_path(used_path.buf, 0);
+			char *newpath = interpolate_path(used_path.buf, 0);
 			if (!newpath)
 				return NULL;
 			strbuf_attach(&used_path, newpath, strlen(newpath),
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38e..007a851804d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1241,7 +1241,7 @@ N_("Your name and email address were configured automatically based\n"
 
 static const char *implicit_ident_advice(void)
 {
-	char *user_config = expand_user_path("~/.gitconfig", 0);
+	char *user_config = interpolate_path("~/.gitconfig", 0);
 	char *xdg_config = xdg_config_home("config");
 	int config_exists = file_exists(user_config) || file_exists(xdg_config);
 
-- 
gitgitgadget

