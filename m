Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5BEC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiCAAJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiCAAJR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:17 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172B9BB84
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:33 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z10-20020a634c0a000000b0036c5eb39076so7421121pga.18
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=t0gS2GJJJ+/nEbuiqRGr4cv3+fBqX6X1h/kU524+UoY=;
        b=rOu7Rj3cXK+0HH8xZEvtI1Kl/OjqaAcfAznzTYAIZ2YWQUubFRmNxWDweRDq5OEbvb
         UFJcZtViLLS5MoN9DFNnUWLuMkCFB4gktqk7oKOVrpo0Cds35F1FFEiYArY2vbGR7JW2
         bU3dxik72Ij+S9l0vsp6TD6l8ehB/a9xNFtin6zkukiuQtj2Zz5Gyim6R92EHLZXM+SI
         +TL9oNyHrhkeSHcEvpFypPPOaf4f7Le1bdjg+N2CuRz+RVDzRCAaWFMEgdpHOOHXNO5T
         vE/BImmunAS3gg9JuEjoKQjXUR2kPDoq6GWyYa7V++gyasgIARBStW0+wZTYo82yPyVl
         8qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=t0gS2GJJJ+/nEbuiqRGr4cv3+fBqX6X1h/kU524+UoY=;
        b=psXfy2sTNC7E1M+rtzOV22gQPfZyBpE6gyFfZvCZYkemvKB0XNQXUF+H4IZCE/Z86y
         tSCUTW5xk9AGRzRYlkS1Akq1iupeC2M5kBFVHfMWRwl8Vrrp6Na8rSGPl1JXErs+mxdS
         JpNc4MQ3Uw5VONir+T82Q+wgyJpYqhH2o2qmW/RubCkiocVb+NRn00t+kdzeMBHh6aJh
         EDKab1MOCf3DtpS1b2KgrVNiJbRckADcVLPEqZzesIghm+m6hLVWMe1G0QZpodUPTxpQ
         KHBA4JQQ4Y3+sS5q8Pci5HkEHW9W4epXhhzpspz+zKd6tRmt0BpR5iQEzM+JYJbC1xzA
         9JTg==
X-Gm-Message-State: AOAM532F0SP8dMDvzlCw1TwkfDXsZSlRw1tDI1yeiIWp1MMgZire/fF7
        LXN+ijgL+u/PkiC5/saz5ekICHbhSGgEDy8ACffd66gZBBNtv60AEVtjnXk9RXMT4FMRWG5hkaT
        wCRHNSSTZ2SV6UouhcbqqUZBZAGyoDeh0l3l7GlwOPFknQO6jfNZA279wkmlB3Ac=
X-Google-Smtp-Source: ABdhPJxoAoIRycQIxdCFIwBD1Lmpkm6QFyniqVApjHS6ijwfX1m8K8GID8hmYLwcb40uhQ7ekOQxscVU4CYukg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:c8e:b0:1bc:3481:b2b7 with SMTP id
 o14-20020a17090b0c8e00b001bc3481b2b7mr19166558pjz.187.1646093312916; Mon, 28
 Feb 2022 16:08:32 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:09 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 06/13] submodule--helper: get remote names from any repository
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
`sync_submodule()`, and also in the next patch, which will require this
functionality.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Helped-by: Glen Choo <chooglen@google.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6b473fc0d2..f934e33c7e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -31,11 +31,14 @@
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
+	int ignore_errno;
+	const char *refname =3D refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
+						      NULL, &ignore_errno);
=20
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -48,7 +51,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
=20
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret =3D xstrdup("origin");
 	else
 		ret =3D dest;
@@ -57,6 +60,19 @@ static char *get_default_remote(void)
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
@@ -1343,9 +1359,8 @@ static void sync_submodule(const char *path, const ch=
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
@@ -1384,21 +1399,15 @@ static void sync_submodule(const char *path, const =
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

