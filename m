Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF00FC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiHUOAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiHUN7l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA3823BE3
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r16so10290049wrm.6
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fU2rzyWEHsEDGcr/E2aK8pmPuo3K8rSeBwte8OHNQjc=;
        b=QD4b6n5VjvzOF5RNzE5Ale/2QDcX4FlLYaVf4yVARxW+SYta6yAxFGb+H5b5x3iGWC
         t7ts6FqoYLx4yqYNuwG9sQccPco8WAafcfEv/VLZSLCVl9/nhHFBHpVcqUFT8n/PZvgs
         mNSKkubUWcC+Vvjx9+AMkpqYgfKNroFljiEtUga0yZ2pefDnorOSJPn6Ch8Fg/YszXeN
         nBPbEOPCYIjPlYlfTgPtlT+LfEJN5fRcWp++3cyC4keMoGFR8VdlTcL3sJ1Fedkcrgqg
         wnUo/tyk0ZhZm/KPE9XVrUhvwulZaFS7MZvEo0YFrKlVlCZ4fKLxsysXDnXlUtlOQ0U1
         c3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fU2rzyWEHsEDGcr/E2aK8pmPuo3K8rSeBwte8OHNQjc=;
        b=ul96/yrrQtFotzbhRQ/xFwvUVtOS87BZxZObmqKaOLUEUluXYSfkuPVV3aKGVl8BzI
         m6+K296bGDZUqFpkQEgkWhWhN60Mc6cGQDvT171i5XgfrroakMa89534EPNo7E3IT6BI
         KjPi/OBZ0rt/HkXxXOpjGab8zLGigdHIGxVA0sJcQFyKSpsbA9r5Hx+Il75FMzpi3BWm
         oXaCux4d8OcUU00U4LwulsGraASANp/+zbr0p4uqeScnGyWDLyr0A8zmayyT7hegfymU
         8bS7f1pYImRycvaB/CPjM9qsPFkytXuDhGq/Xd7Mp/7c7Smna4nyfs6PJBq86owKGHMu
         TPcQ==
X-Gm-Message-State: ACgBeo34GneUDcyrYt7uKgbuNGKVKYAIjjFaAKYWvrNVf4f4iaUy9A/F
        CoOceqrtaPUF71vND0vT5W93iFXr6cpAh8hL
X-Google-Smtp-Source: AA6agR7OtyHWBpA7UilZI8YExlLyqa7PGtyD2UFVsAPl5L9Td/hFxZ2uiyfw2w7mFd+YASLIv3N/sg==
X-Received: by 2002:a5d:5a9d:0:b0:225:2783:d6f1 with SMTP id bp29-20020a5d5a9d000000b002252783d6f1mr8857747wrb.385.1661090337108;
        Sun, 21 Aug 2022 06:58:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 30/32] submodule--helper: libify more "die" paths for module_update()
Date:   Sun, 21 Aug 2022 15:57:39 +0200
Message-Id: <patch-v3-30.32-15c2490a978-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in a preceding commit the get_default_remote_submodule() and
remote_submodule_branch() functions would invoke die(), and thus leave
update_submodule() only partially lib-ified. Let's address the former
of those cases.

Change the functions to return an int exit code (non-zero on failure),
while leaving the get_default_remote() function for the callers that
still want the die() semantics.

This change addresses 1/2 of the "die" issue in these two lines in
update_submodule():

	char *remote_name = get_default_remote_submodule(update_data->sm_path);
	const char *branch = remote_submodule_branch(update_data->sm_path);

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 58 +++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 88fc01320f3..9e4069b36cb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -31,48 +31,57 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static char *repo_get_default_remote(struct repository *repo)
+static int repo_get_default_remote(struct repository *repo, char **default_remote)
 {
-	char *dest = NULL, *ret;
+	char *dest = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	struct ref_store *store = get_main_ref_store(repo);
 	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
 						      NULL);
 
 	if (!refname)
-		die(_("No such ref: %s"), "HEAD");
+		return die_message(_("No such ref: %s"), "HEAD");
 
 	/* detached HEAD */
-	if (!strcmp(refname, "HEAD"))
-		return xstrdup("origin");
+	if (!strcmp(refname, "HEAD")) {
+		*default_remote = xstrdup("origin");
+		return 0;
+	}
 
 	if (!skip_prefix(refname, "refs/heads/", &refname))
-		die(_("Expecting a full ref name, got %s"), refname);
+		return die_message(_("Expecting a full ref name, got %s"),
+				   refname);
 
 	strbuf_addf(&sb, "branch.%s.remote", refname);
 	if (repo_config_get_string(repo, sb.buf, &dest))
-		ret = xstrdup("origin");
+		*default_remote = xstrdup("origin");
 	else
-		ret = dest;
+		*default_remote = dest;
 
 	strbuf_release(&sb);
-	return ret;
+	return 0;
 }
 
-static char *get_default_remote_submodule(const char *module_path)
+static int get_default_remote_submodule(const char *module_path, char **default_remote)
 {
 	struct repository subrepo;
 
 	if (repo_submodule_init(&subrepo, the_repository, module_path,
 				null_oid()) < 0)
-		die(_("could not get a repository handle for submodule '%s'"),
-		    module_path);
-	return repo_get_default_remote(&subrepo);
+		return die_message(_("could not get a repository handle for submodule '%s'"),
+				   module_path);
+	return repo_get_default_remote(&subrepo, default_remote);
 }
 
 static char *get_default_remote(void)
 {
-	return repo_get_default_remote(the_repository);
+	char *default_remote;
+	int code = repo_get_default_remote(the_repository, &default_remote);
+
+	if (code)
+		exit(code);
+
+	return default_remote;
 }
 
 static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
@@ -1159,6 +1168,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
 	struct strbuf sb = STRBUF_INIT;
 	char *sub_config_path = NULL;
+	int code;
 
 	if (!is_submodule_active(the_repository, path))
 		return;
@@ -1198,10 +1208,9 @@ static void sync_submodule(const char *path, const char *prefix,
 		goto cleanup;
 
 	strbuf_reset(&sb);
-	default_remote = get_default_remote_submodule(path);
-	if (!default_remote)
-		die(_("failed to get the default remote for submodule '%s'"),
-		      path);
+	code = get_default_remote_submodule(path, &default_remote);
+	if (code)
+		exit(code);
 
 	remote_key = xstrfmt("remote.%s.url", default_remote);
 	free(default_remote);
@@ -2420,9 +2429,16 @@ static int update_submodule(struct update_data *update_data)
 				   update_data->displaypath);
 
 	if (update_data->remote) {
-		char *remote_name = get_default_remote_submodule(update_data->sm_path);
-		const char *branch = remote_submodule_branch(update_data->sm_path);
-		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+		char *remote_name;
+		const char *branch;
+		char *remote_ref;
+		int code;
+
+		code = get_default_remote_submodule(update_data->sm_path, &remote_name);
+		if (code)
+			return code;
+		branch = remote_submodule_branch(update_data->sm_path);
+		remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
-- 
2.37.2.1279.g64dec4e13cf

