Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BB9C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiCCA6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiCCA6l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:41 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF25B1520E2
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:57:53 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o41-20020a17090a0a2c00b001bf06e5badfso794834pjo.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=w0wuH61vxN7cIGWnPgt2xDcm4NacL81PL7lHRDWTnoI=;
        b=Rj1JWp/BkcRWZfG5IRIsJZstejV1LG4yc3y34sQ39GNCmyZ23D1dXBCOKLjrGxdtOw
         Lm/j7QhDyg2vhRN/z30Vbo45cdofFDIyESMrOQXL46Vi/faxQcb2GLWq6yDa/5wE7KLd
         oniulLMP1Xc8DJnmYQaDnqfom3bee3MQWxj9TV8VUwVxNOxjFRtxCWiwHXl8m90TvpWT
         VIGpPA6LxCtm/oHVt7T3Md8JQYzZhOzJHZ5rM0e882RCVAXn6YMkl9xJla8J7FOzmjli
         EP+epyIhTKh9OG+qvKD+D++Ii0zcJ09V5bsKcL4imaMCX+xLAE6vcZti2e/rN0mCvrCD
         DV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=w0wuH61vxN7cIGWnPgt2xDcm4NacL81PL7lHRDWTnoI=;
        b=gALIQRyyCibM0axFgFydVKb8ZRyCP4206ICZvFCvNS0eiufU4ihRIo90jAOApu1dw5
         XItyxzriYQeJuNLz9kcnG2NFRTFNfCdodTxsqX+oIT7k2SqAB68a+30+WsByWJHGdwJl
         s1CvGBF8SwPkyDJhCf4pgzMK0Xq9Wq/EvZX51CnECSuAyUigGmlFNGUIaYN82mCfuyOT
         nKuv02izVmaY3VIJlNNR85SqF5WhAJbS7cuDqebG9MZF0lV03mYayy/rLv2lsRnjNbKc
         UmiE8v/tU1p5GEAJudjp+0w5HO6bTwx9rHvwt63bxKfZOMAanftS79r0v3zIjYU4/pz6
         9gmA==
X-Gm-Message-State: AOAM532xOnY+8dcFnIVJSucMLWG6a3/z5E69kbXIocHnDpPJZ99+uYCc
        Nz3GRx4hVlHJcrzhU90Te8GNEjnYNG5/Efjq5NNmGZYH75nTvELgub3ZJ6v509sm5Qg1FPwNFA7
        KBLlbEmcPoenL7YqH85qqkw5tKy1nnxnm8MP0MKPtvyd3XaOX37acozxOF0gsv24=
X-Google-Smtp-Source: ABdhPJyj28vISOVM99/CNwCXeLNiT+bC2F7hQ6xYgSBtas0ow6WlKQ8HBDNYUom46hUrxeQ48x07sjafiGA+bw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:a887:b0:1bc:388a:329f with SMTP
 id h7-20020a17090aa88700b001bc388a329fmr2602786pjq.17.1646269073377; Wed, 02
 Mar 2022 16:57:53 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:20 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 06/13] submodule--helper: get remote names from any repository
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
index 6b473fc0d2..a58df3e007 100644
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

