Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8060EC433FE
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiCEAP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiCEAPv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:51 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D7244A2B
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dbbb248ca1so84890757b3.14
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=c0NZ1lg7J+sfRCOL5dR0fwLxNk/+aZfgyZK4qhepnd4=;
        b=E8eZ9sdM8OjcbzB7wY6tHodXvaeKqHlA4zewAKT4W0ipFzOHeYeMyMaW78SX1BmBfZ
         0wlAsfRcgCI9+dZ7FWEO4i5dSDrDq+Atgt3ivpYEC2JLxzLLAIXZbECU9+h3sYRnkzsR
         P9zwS1gPtIvyFe4x6UUnfSi8wWtT7v1hoAnktPgg1f6RU1tXB+gnECBuQQl1pqzXCfVy
         5aJ7ROpspPSg5nKwTd7iolfREae0c5YqH54qxdSB2UmVqZbSMsKun4hQ5b9TgZ4o0bbf
         2f6x4Xo8JQTjyBJ+ZaGBvHQG9KXutWDvQdF6bnHDA/0o/Au9s0c9ZiIVKDFnGy2LPdl5
         +Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=c0NZ1lg7J+sfRCOL5dR0fwLxNk/+aZfgyZK4qhepnd4=;
        b=DI337zNtIOQTEhO/hvCLnGUwlaMU86Js4Rciu9OaabtPxhkFPMP7k6bBSYurdz6SlJ
         Jyr/sOA/45e0XHcbQrKyFAsglB5TjYNlpbQ6tw3S7pMAU8+C5iLne5PwN4KqJUUJGOCr
         ot/avOEjiTbEMWzUcu4w+6AHSMHNI4FHMZUe41/v/YUlBS/P+PSQTDcyy4t88J5GbX1E
         gk2lYFj/zCu0qzPYfTfZFgtFbw2AhJrIejnecQaAsqKw+qoX7VIuE6iSpm45BQA/qCc1
         u5AJala+1cO6/F3go6qEx4MMYq9+Bdk+0K4mXBssDrTy4dkZ8kqtfYt/GY6AxXHnDzQY
         KZbw==
X-Gm-Message-State: AOAM531r2ikE6yjMmYA05r/VgYoot64+xda/6sOmBsAj4sXHRz+gk9MA
        acUiW7LlDttZs/s10mpz9CE3q22PTDorUJBBTHDq9QtV23iA4Do2EpdskE0A6HgGCgwb9771Kb/
        cE52KPZE/7Ch/C8Aim5MhXEEXKz90NHMOWMJC7cZ5f3RAYHt5hwlZnddGN87t/ZE=
X-Google-Smtp-Source: ABdhPJzgVFwKaeQ/oPkgZFOxjDPypW+MelzJeEM1zz5cOK5GDTgA1aamlR9dfyYU7b5M6nyrjbakv6pzIW2DPw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:ddc4:0:b0:2dc:4496:378e with SMTP id
 g187-20020a0dddc4000000b002dc4496378emr1046777ywe.299.1646439302260; Fri, 04
 Mar 2022 16:15:02 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:53 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 05/13] submodule--helper: get remote names from any repository
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

`get_default_remote()` retrieves the name of a remote by resolving the
refs from of the current repository's ref store.

Thus in order to use it for retrieving the remote name of a submodule,
we have to start a new subprocess which runs from the submodule
directory.

Let's instead introduce a function called `repo_get_default_remote()`
which takes any repository object and retrieves the remote accordingly.

`get_default_remote()` is then defined as a call to
`repo_get_default_remote()` with 'the_repository' passed to it.

Now that we have `repo_get_default_remote()`, we no longer have to start
a subprocess that called `submodule--helper get-default-remote` from
within the submodule directory.

So let's make a function called `get_default_remote_submodule()` which
takes a submodule path, and returns the default remote for that
submodule, all within the same process.

We can now use this function to save an unnecessary subprocess spawn in
`sync_submodule()`, and also in a subsequent patch, which will require
this functionality.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Helped-by: Glen Choo <chooglen@google.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 38 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 77ca4270f4..b5a2d83029 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -31,11 +31,13 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
=20
-static char *get_default_remote(void)
+static char *repo_get_default_remote(struct repository *repo)
 {
 	char *dest =3D NULL, *ret;
 	struct strbuf sb =3D STRBUF_INIT;
-	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	struct ref_store *store =3D get_main_ref_store(repo);
+	const char *refname =3D refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
+						      NULL);
=20
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -48,7 +50,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
=20
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret =3D xstrdup("origin");
 	else
 		ret =3D dest;
@@ -57,6 +59,19 @@ static char *get_default_remote(void)
 	return ret;
 }
=20
+static char *get_default_remote_submodule(const char *module_path)
+{
+	struct repository subrepo;
+
+	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
+	return repo_get_default_remote(&subrepo);
+}
+
+static char *get_default_remote(void)
+{
+	return repo_get_default_remote(the_repository);
+}
+
 static int print_default_remote(int argc, const char **argv, const char *p=
refix)
 {
 	char *remote;
@@ -1343,9 +1358,8 @@ static void sync_submodule(const char *path, const ch=
ar *prefix,
 {
 	const struct submodule *sub;
 	char *remote_key =3D NULL;
-	char *sub_origin_url, *super_config_url, *displaypath;
+	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
 	struct strbuf sb =3D STRBUF_INIT;
-	struct child_process cp =3D CHILD_PROCESS_INIT;
 	char *sub_config_path =3D NULL;
=20
 	if (!is_submodule_active(the_repository, path))
@@ -1384,21 +1398,15 @@ static void sync_submodule(const char *path, const =
char *prefix,
 	if (!is_submodule_populated_gently(path, NULL))
 		goto cleanup;
=20
-	prepare_submodule_repo_env(&cp.env_array);
-	cp.git_cmd =3D 1;
-	cp.dir =3D path;
-	strvec_pushl(&cp.args, "submodule--helper",
-		     "print-default-remote", NULL);
-
 	strbuf_reset(&sb);
-	if (capture_command(&cp, &sb, 0))
+	default_remote =3D get_default_remote_submodule(path);
+	if (!default_remote)
 		die(_("failed to get the default remote for submodule '%s'"),
 		      path);
=20
-	strbuf_strip_suffix(&sb, "\n");
-	remote_key =3D xstrfmt("remote.%s.url", sb.buf);
+	remote_key =3D xstrfmt("remote.%s.url", default_remote);
+	free(default_remote);
=20
-	strbuf_reset(&sb);
 	submodule_to_gitdir(&sb, path);
 	strbuf_addstr(&sb, "/config");
=20
--=20
2.33.GIT

