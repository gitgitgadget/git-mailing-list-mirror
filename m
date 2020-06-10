Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29CC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C63B2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc6WbVDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFJVTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgFJVTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B17C03E96F
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so3903697wru.12
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mbJAiEaSEyXf4bkBRjwGEELo/gCU2a62k0HO+lNLdUE=;
        b=Sc6WbVDwSaB4cI9qSbwpn4BSsHof+Hj8PN4G9m8IZKKNA5ZUrsI1zFT5EYMExTG+SB
         4fCnPqGP3jMa6LkqLac/WNGq+THeZrjlLoil5FOwurldRQ/TUsnbf9vt95iZhoePOZ+1
         jiPTJckeS4POzxdfBtLSK8CUDVZ8QQ72QkPvSC9dQ6CruW39frwr4Ln9Kn7UaI6+m0s5
         2Zj+MQw9hxkw81c0DXZmMN/x1Uk8TuMuCgXb4plkJEy5xKYbssBPeim7IOzE85IPKPyI
         kXtala0qbiK10Y4YjtbmpoBuC8jKZT42V8U0CYSm7rrXrsNZuzxCVwxNffREdwB+W4Y3
         PASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mbJAiEaSEyXf4bkBRjwGEELo/gCU2a62k0HO+lNLdUE=;
        b=JdRenMShxZDnUp2/vGgsGukES5DA3pDFSadW/HB37y6gZgxSkihGAP3xeLQRbdN5sc
         K8JFkS2qDRFWQg4Xxh+GrL7YXN7u3zcbxvJZW/4WurTAudYGq42JgsQ55Z3HDdhORBLj
         hyd1BTlFclACgrIyjJVvZ0QgclNa0cQtVNtgpYu2T0lAfcPRrdG5o3R2THg+3DEyxsMO
         RjBt/jkRBhi5r3bdbdO+NgSGliUqr8AyoqeGtY/IdZqUwBd7A8rg06UqtaKWbOvxQEJy
         eObbN5r2r7j7JFErItOSo2qBDMrwcDcHqoI8pveRXtRT4JA3zh/5LI6aPaGu9WuHOILC
         LsFA==
X-Gm-Message-State: AOAM533s70pl2hxtWzgRJwQYHOS6IrCWSxa4EWSrdEbJ+zXGS1TnF4tt
        AT2ruWD6yb95G4LdSfGwhbKac6Ns
X-Google-Smtp-Source: ABdhPJxJYPc/dWK2951MlyOmGRMLPgcQVr1J0ip9K96XwiH0ZDA8dEdKrK2jrlfTZvJB0IsYWtjI8g==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr5508595wrs.235.1591823973602;
        Wed, 10 Jun 2020 14:19:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm1655403wrg.9.2020.06.10.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:33 -0700 (PDT)
Message-Id: <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Don Goodman-Wilson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:22 +0000
Subject: [PATCH 1/9] init: allow overriding the default branch name for new
 repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Don Goodman-Wilson <don@goodman-wilson.com>

There is a growing number of projects trying to avoid the non-inclusive
name `master` in their repositories. For existing repositories, this
requires manual work. For new repositories, the only way to do that
automatically is by copying all of Git's template directory, then
hard-coding the desired default branch name into the `.git/HEAD` file,
and then configuring `init.templateDir` to point to those copied
template files.

To make this process much less cumbersome, let's introduce support for
`core.defaultBranchName`. That way, users won't need to keep their
copied template files up to date, and won't interfere with default hooks
installed by their administrators.

While at it, also let users set the default branch name via the
environment variable `GIT_TEST_DEFAULT_BRANCH_NAME`, in preparation for
adjusting Git's test suite to a more inclusive default branch name. As
is common in Git, the `GIT_TEST_*` variable takes precedence over the
config setting.

Note: we use the prefix `core.` instead of `init.` because we want to
adjust also `git clone`, `git fmt-merge-msg` and other commands over the
course of the next commits to respect this setting.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
---
 builtin/init-db.c |  8 +++++---
 refs.c            | 34 ++++++++++++++++++++++++++++++++++
 refs.h            |  6 ++++++
 t/t0001-init.sh   | 20 ++++++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0b7222e7188..99792adfd43 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -258,15 +258,17 @@ static int create_default_files(const char *template_path,
 		die("failed to set up refs db: %s", err.buf);
 
 	/*
-	 * Create the default symlink from ".git/HEAD" to the "master"
-	 * branch, if it does not exist yet.
+	 * Create the default symlink from ".git/HEAD" to the default
+	 * branch name, if it does not exist yet.
 	 */
 	path = git_path_buf(&buf, "HEAD");
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
-		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
+		char *default_ref = git_default_branch_name(0);
+		if (create_symref("HEAD", default_ref, NULL) < 0)
 			exit(1);
+		free(default_ref);
 	}
 
 	initialize_repository_version(fmt->hash_algo);
diff --git a/refs.c b/refs.c
index 224ff66c7bb..8499b3865cb 100644
--- a/refs.c
+++ b/refs.c
@@ -560,6 +560,40 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
 		argv_array_pushf(prefixes, *p, len, prefix);
 }
 
+char *git_default_branch_name(int short_name)
+{
+	const char *branch_name = getenv("GIT_TEST_DEFAULT_BRANCH_NAME");
+	char *from_config = NULL, *prefixed;
+
+	/*
+	 * If the default branch name was not specified via the environment
+	 * variable GIT_TEST_DEFAULT_BRANCH_NAME, retrieve it from the config
+	 * setting core.defaultBranchName. If neither are set, fall back to the
+	 * hard-coded default.
+	 */
+	if (!branch_name || !*branch_name) {
+		if (git_config_get_string("core.defaultbranchname",
+					  &from_config) < 0)
+			die(_("Could not retrieve `core.defaultBranchName`"));
+
+		if (from_config)
+			branch_name = from_config;
+		else
+			branch_name = "master";
+	}
+
+	if (short_name)
+		return from_config ? from_config : xstrdup(branch_name);
+
+	/* prepend "refs/heads/" to the branch name */
+	prefixed = xstrfmt("refs/heads/%s", branch_name);
+	if (check_refname_format(prefixed, 0))
+		die(_("invalid default branch name: '%s'"), branch_name);
+
+	free(from_config);
+	return prefixed;
+}
+
 /*
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is a magic short-hand form
diff --git a/refs.h b/refs.h
index a92d2c74c83..e8d4f6e2f13 100644
--- a/refs.h
+++ b/refs.h
@@ -154,6 +154,12 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
+/*
+ * Retrieves the name of the default branch. If `short_name` is non-zero, the
+ * branch name will be prefixed with "refs/heads/".
+ */
+char *git_default_branch_name(int short_name);
+
 /*
  * A ref_transaction represents a collection of reference updates that
  * should succeed or fail together.
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 1edd5aeb8f0..b144cd8f46b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -464,4 +464,24 @@ test_expect_success MINGW 'redirect std handles' '
 	grep "Needed a single revision" output.txt
 '
 
+test_expect_success 'custom default branch name from config' '
+	git config --global core.defaultbranchname nmb &&
+	GIT_TEST_DEFAULT_BRANCH_NAME= git init custom-config &&
+	git config --global --unset core.defaultbranchname &&
+	git -C custom-config symbolic-ref HEAD >actual &&
+	grep nmb actual
+'
+
+test_expect_success 'custom default branch name from env' '
+	GIT_TEST_DEFAULT_BRANCH_NAME=nmb git init custom-env &&
+	git -C custom-env symbolic-ref HEAD >actual &&
+	grep nmb actual
+'
+
+test_expect_success 'invalid custom default branch name' '
+	test_must_fail env GIT_TEST_DEFAULT_BRANCH_NAME="with space" \
+		git init custom-invalid 2>err &&
+	test_i18ngrep "invalid default branch name" err
+'
+
 test_done
-- 
gitgitgadget

