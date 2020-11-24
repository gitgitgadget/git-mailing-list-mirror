Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36635C64E7A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE80A20715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu+RPTaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbgKXPHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389084AbgKXPHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 10:07:41 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC4AC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:40 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so3194397wmb.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j7BCmDzGgwjvLopRsreJSrFUlkAwIXlafwC1ZI0e88g=;
        b=Tu+RPTaLvbNR0ohBzho81mT/wT3rDVa4BZEv72NYjnop6KiTE8GlWeL/0KD1K7zG5Z
         qJ27qMa7iQKwlZBqX8phhmmDV6HFFj6Bqnvqw/bDvwP6dUUptmqlg02uUM4kpJ+B4eZY
         pSsuLPg+s++badxxk1hfmbtYSnjHbmdbbwg2exOpiUWge1xNmyVdMxF8qC420IX0pRcr
         hADTkg28xtpAwuODC7Re7jIJ2TZKzCIUSZG33izp62JP+y2QvwRCgjVfNWn4/zgr4A0N
         7na0yqlYqCvHL6TfK2FpjRdH0dkuPFCOp45sRMa3ikSxm5dahuPhZ0qaMqnusetMhY5L
         /29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j7BCmDzGgwjvLopRsreJSrFUlkAwIXlafwC1ZI0e88g=;
        b=Sbat4WI6snwZTO76xIx50afVTEM0HxHz7ajuOq5q1VYkJP4x63HpD8R7yHW1XDT5Vd
         YsFPz3ix5yhn09UYZZCDG+eCsIWaKrN1NmE+yv56bBKnb7UCdQCRjqIS5n/ry8vzG5i4
         dyYHoWYHClibWiYUmNMvf28C4T1kSCYA/gJldYzLpCFhzReYr2GttQV8IjIQmSYM7P7M
         pmQ1cOzINjkruavEhBoG2LZ12rFopvgOMQ9YwcQDI4kQrBjy+T1M53qKYz3CCRBHtbtv
         aZMHaiPu4KlXdQq2MwlQCF1rHpZINzHaBCMEW4zku2T4/ZdO3Cp6tNcHkbExnYymrh7p
         KERQ==
X-Gm-Message-State: AOAM532unNCOMZLP//FV3TR0eGFs0MYzv/s5LchUAO2YAd2rGlB+6g9J
        Y4LPCukD7fFSO8oju53/heaTiK8nTeA=
X-Google-Smtp-Source: ABdhPJxBQ2BDAoMUZiBGd1fQ87FQdYWKeAJowGCOpxb/SbTSaQZPMU/NJqrn8E7LFnoPA5TjOBa0QQ==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr4843295wmm.38.1606230455385;
        Tue, 24 Nov 2020 07:07:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm27106833wrw.15.2020.11.24.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:07:34 -0800 (PST)
Message-Id: <5fc15f7b9adaf64c2fbfd58f6e96768f5b9d7f8b.1606230450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
References: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 15:07:28 +0000
Subject: [PATCH v3 3/4] get_default_branch_name(): prepare for showing some
 advice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

