Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDE1C4167B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24F723EB1
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393065AbgLJXS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393103AbgLJXSR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 18:18:17 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FDBC061257
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:35:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v14so6020364wml.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dDkyjIFzTnF0UfdJyakAAWfV8URHBiRDEGa+zK2AqPY=;
        b=d9k82vE9jHzg9yAbfs83pSFEvOWAUtqmNVaxXrM2qzcB3w0yH7llKpyfzv1DY6Ny2W
         BkQfRKEq/9Ba963yG+fuy7Th4f4vG5gb6mgIkwN9DpRY7IYnMdkJH29qxF8s6gzfojkI
         tnARpbVuFqKlk3lRk6iLvLyBjL6evffizQSTtW5LMToSZq8jJSGoFovO6JrX3ItcgXlZ
         hTRd7CGQ0rHhQnh4ixEn2kydG+VytWvn1dCGGtTDqdkKP2B3qgKdsMt92+FEx05eZuWk
         QxjWInnhjqhRjsCaAua0YINQG6yaT6k7Cg2F4GG2HqJz8FxC3sDq/MugMeKExa13bVgH
         aLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dDkyjIFzTnF0UfdJyakAAWfV8URHBiRDEGa+zK2AqPY=;
        b=gq5jkomqE3XyuJH37JSZdzHvG57iDFXCk0v4AlW32bC1LnrcWdvs92qYt8uj6kO7QU
         YLQerZlNxaFsPQLQ12jY5JbBCKP6f8p81lQbERsXFtnC4aYp8bY4JiRiPvSt8zwA+XeF
         JyRRbqmykYfVzFPabuE/BR6LZrqwBxIZahMyz6e36Pn+vWL8C73OsArzaWo0HP4EPZQ5
         e5M3o9IGNiE3TXb0cJPvdPUG1czqbJSRJvin2saB+C+PPCaPdrIBpY1uKUZVm2WN0gR2
         Vbf2veZ7GTsDR3TLO8XPyYPYsCdYPs8okX+Q7hv2IYV1LiDu4t7vdfwWhmQnNXZhFY76
         19xw==
X-Gm-Message-State: AOAM531ZR6ekJsw7k15qyqWk0Sxmj/uz/9PVQxLhnjfJ2CyOvalBi8XP
        0d1pGnS85COkoQmcx9+b3g5XFuhsNy0=
X-Google-Smtp-Source: ABdhPJwWbMQSpuwsS/80Ys3ehf72y3gUa/CHvay61pyp/LwxloZYg7uW5+sy8V9Ek33QqCxeifMUow==
X-Received: by 2002:a1c:bd87:: with SMTP id n129mr10435407wmf.32.1607637521710;
        Thu, 10 Dec 2020 13:58:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a65sm10172982wmc.35.2020.12.10.13.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:58:41 -0800 (PST)
Message-Id: <5fc15f7b9adaf64c2fbfd58f6e96768f5b9d7f8b.1607637517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
        <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Dec 2020 21:58:35 +0000
Subject: [PATCH v4 3/4] get_default_branch_name(): prepare for showing some
 advice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to introduce a message giving users running `git init` some
advice about `init.defaultBranch`. This will necessarily be done in
`repo_default_branch_name()`.

Not all code paths want to show that advice, though. In particular, the
`git clone` codepath _specifically_ asks for `init_db()` to be quiet,
via the `INIT_DB_QUIET` flag.

In preparation for showing users above-mentioned advice, let's change
the function signature of `get_default_branch_name()` to accept the
parameter `quiet`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/clone.c   | 2 +-
 builtin/init-db.c | 8 +++++---
 refs.c            | 6 +++---
 refs.h            | 4 ++--
 remote.c          | 5 +++--
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a0841923cfe..64b17840112 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1323,7 +1323,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare) {
-			const char *branch = git_default_branch_name();
+			const char *branch = git_default_branch_name(0);
 			char *ref = xstrfmt("refs/heads/%s", branch);
 
 			install_branch_config(0, branch, remote_name, ref);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 01bc648d416..dcc45bef514 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -202,7 +202,8 @@ void initialize_repository_version(int hash_algo, int reinit)
 static int create_default_files(const char *template_path,
 				const char *original_git_dir,
 				const char *initial_branch,
-				const struct repository_format *fmt)
+				const struct repository_format *fmt,
+				int quiet)
 {
 	struct stat st1;
 	struct strbuf buf = STRBUF_INIT;
@@ -267,7 +268,7 @@ static int create_default_files(const char *template_path,
 		char *ref;
 
 		if (!initial_branch)
-			initial_branch = git_default_branch_name();
+			initial_branch = git_default_branch_name(quiet);
 
 		ref = xstrfmt("refs/heads/%s", initial_branch);
 		if (check_refname_format(ref, 0) < 0)
@@ -438,7 +439,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	validate_hash_algorithm(&repo_fmt, hash);
 
 	reinit = create_default_files(template_dir, original_git_dir,
-				      initial_branch, &repo_fmt);
+				      initial_branch, &repo_fmt,
+				      flags & INIT_DB_QUIET);
 	if (reinit && initial_branch)
 		warning(_("re-init: ignored --initial-branch=%s"),
 			initial_branch);
diff --git a/refs.c b/refs.c
index 392f0bbf68b..8df03122d69 100644
--- a/refs.c
+++ b/refs.c
@@ -562,7 +562,7 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
 		strvec_pushf(prefixes, *p, len, prefix);
 }
 
-char *repo_default_branch_name(struct repository *r)
+char *repo_default_branch_name(struct repository *r, int quiet)
 {
 	const char *config_key = "init.defaultbranch";
 	const char *config_display_key = "init.defaultBranch";
@@ -585,12 +585,12 @@ char *repo_default_branch_name(struct repository *r)
 	return ret;
 }
 
-const char *git_default_branch_name(void)
+const char *git_default_branch_name(int quiet)
 {
 	static char *ret;
 
 	if (!ret)
-		ret = repo_default_branch_name(the_repository);
+		ret = repo_default_branch_name(the_repository, quiet);
 
 	return ret;
 }
diff --git a/refs.h b/refs.h
index 66955181569..ff05d2e9fe2 100644
--- a/refs.h
+++ b/refs.h
@@ -170,8 +170,8 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
  * The return value of `repo_default_branch_name()` is an allocated string. The
  * return value of `git_default_branch_name()` is a singleton.
  */
-const char *git_default_branch_name(void);
-char *repo_default_branch_name(struct repository *r);
+const char *git_default_branch_name(int quiet);
+char *repo_default_branch_name(struct repository *r, int quiet);
 
 /*
  * A ref_transaction represents a collection of reference updates that
diff --git a/remote.c b/remote.c
index 8a6dbbb9030..bdb88d4b7dd 100644
--- a/remote.c
+++ b/remote.c
@@ -284,7 +284,7 @@ static void read_branches_file(struct remote *remote)
 	if (frag)
 		*(frag++) = '\0';
 	else
-		frag = (char *)git_default_branch_name();
+		frag = (char *)git_default_branch_name(0);
 
 	add_url_alias(remote, strbuf_detach(&buf, NULL));
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
@@ -2206,7 +2206,8 @@ struct ref *guess_remote_head(const struct ref *head,
 
 	/* If a remote branch exists with the default branch name, let's use it. */
 	if (!all) {
-		char *ref = xstrfmt("refs/heads/%s", git_default_branch_name());
+		char *ref = xstrfmt("refs/heads/%s",
+				    git_default_branch_name(0));
 
 		r = find_ref_by_name(refs, ref);
 		free(ref);
-- 
gitgitgadget

