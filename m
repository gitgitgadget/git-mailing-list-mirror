Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD1C63777
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE17420773
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlCA/SfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKVXXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 18:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKVXXc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 18:23:32 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA379C0613D3
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 15:23:31 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so16341358wmd.4
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 15:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j7BCmDzGgwjvLopRsreJSrFUlkAwIXlafwC1ZI0e88g=;
        b=RlCA/SfGKrzhES+3w1r7vYoPIrXGwnBa0C6T29bcu0GReDbzDoIlzFAY0Vqvj4GmNz
         2GfCzWWHXNHVF1Je8DQFX7brTsz4gO369lGZbFp2KZ1s4lCvcmHzHeenRV35TVnFvRiD
         ddXRYwRZo86pioFMbkgYZKC4/zNH52e803LvKOJ/cfffYhurptfIEVnqnPSOlcO5Oa1g
         orrz0id/EyLyHmJdry0hRQ4Yh48z3qTGvXRdHgZXD17PERzIn4HXHN2Cu3Z1B14p8wnj
         Tw30sQxfRZORJhcijX/2EY1sJSs8wYc3zeJyToSxbr5sdCYputVTrFh7EZUNDxwatfmk
         fW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j7BCmDzGgwjvLopRsreJSrFUlkAwIXlafwC1ZI0e88g=;
        b=KFOptCjWHxMF5k0J7uJZjXP8FoPRqrbaqMsrSDFJGFFF4i9A4EFXBy77fQWXsrzfl4
         Fls7poMcmABk232VgXVr59iVLSqMDe9P4TwlgkD9IYpLjWMp7MCc9CXhPqv2B/hICBl9
         mHn4t3+dmaBw/mij6ollhENq0WcypU//4KVDsnnHjoSn+kwVRUAuTZc9kCPG+Wfv2Ymp
         gQW5uCiiWoPd8Z3Bq76S7UCrypMiOL2OQk8pdMToVat8VfLIExtDRTpR0EEtPASRkF04
         2eNk/e5QhaU17d9b0hOiJChl9VJLYr/CyDkht+eLH9ech7g2QoCtt3VsoHesTRscsy11
         4S6Q==
X-Gm-Message-State: AOAM530yDCyGYbeyLEBzsvACuIqDWleLgG4MklTcfEcfVmyceEZk6XPO
        50gQM1RoEfnrHg/sylmpFhcbUmrQC54=
X-Google-Smtp-Source: ABdhPJxw1b8lIzNQotH8U7rQ5VRFRN5OmkZSPgkJ1FCXzzhcDIPq8/yJt/HzOqgvinbFdt6bGCc5OA==
X-Received: by 2002:a1c:7202:: with SMTP id n2mr20126379wmc.38.1606087410361;
        Sun, 22 Nov 2020 15:23:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n128sm13538032wmb.46.2020.11.22.15.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 15:23:29 -0800 (PST)
Message-Id: <42f694004322361b5495f2ce1a2eba638644f754.1606087406.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Nov 2020 23:23:25 +0000
Subject: [PATCH 2/3] get_default_branch_name(): prepare for showing some
 advice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index a0841923cf..64b1784011 100644
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
index 01bc648d41..dcc45bef51 100644
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
index 392f0bbf68..8df03122d6 100644
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
index 6695518156..ff05d2e9fe 100644
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
index 8a6dbbb903..bdb88d4b7d 100644
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

