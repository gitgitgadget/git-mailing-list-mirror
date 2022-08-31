Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A2ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiHaXTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiHaXSw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159DF1037D0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so7465108wrq.10
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A/84xM0zF+mQqXYyVHmSpgTf/ySnQI6v8lZMHTM1K5s=;
        b=Tdgo9ZjFFKHnnRas/hDDR/13ophtAQN7w+o94u08bGRdrQ+9UMTKSmG2Xjh52DlNoc
         i1aLL+iz+OK1QX93ADCsDOMHzNPsK6L8yoGZRb86bcfagjwpDBFn7QxgFyU0RzK0xBNI
         difcNu6g0MZHd03pQPyz+BpVknHPpZeoFq5DzpvcNTkpyFNfwvLad/ay2fpw+tdfxJOv
         a9n5DNp+0DDxhUxYEJG93XebxhD80EvzOCEa1sBwbxY2opRlvfCFUHSNishjqD2oWwOU
         RfGF8t5ZZx1u6tEjO52MnZi+PtFq8slWnnQMMxx2AH1rRnT7J1GeifwB4b5YgiEjY7wg
         6O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A/84xM0zF+mQqXYyVHmSpgTf/ySnQI6v8lZMHTM1K5s=;
        b=62V+3hZEQM1taXKYk0AhdyBtDt7d2bIO7o1LI5oAfsKpsvnHLIpQNZOs4rc1VzfWkF
         D9GI3Ztt2Alm03a5pdLvgmhlNCHbLOYOuhesp4+sHPAe56akpCCJ4+17mqEqljfVtbeF
         OAN+UJXHXE0mUFdPEd/YaFV1iYnIStgsC0q0uTyjcUlOc9zEy4wG9cs3iXJdOwl2PpmL
         XXNhA8aycWCgO0eejx1Jqk3WpMBkwlOQisvueZL1e65DjmZlDgHW11VVFHfCnHaZzNXB
         BxznJV8mPWrAcn0ZDaFf5jMV9TgmwHlX7X9WD7hgbJB9Goym0vyfA413xjlJYKH8PLC1
         wVIA==
X-Gm-Message-State: ACgBeo25U4LUprVxIK9z3MzD7yRRCnBiuovZcLRxmBriOtDFkBSRkRM4
        RzOuACzSiN3J9k7E7RNrxz8O3XNJvOTaxQ==
X-Google-Smtp-Source: AA6agR4Ze6pNZXyixtGOgrMS3pRIrJ6ADmCZ3hQ+qMvkKTl3y1lXyVJEIYP0QiqzgkK1u3DePSqWQQ==
X-Received: by 2002:a5d:47cd:0:b0:220:70a2:5383 with SMTP id o13-20020a5d47cd000000b0022070a25383mr13052393wrc.258.1661987925200;
        Wed, 31 Aug 2022 16:18:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 31/33] submodule--helper: libify more "die" paths for module_update()
Date:   Thu,  1 Sep 2022 01:18:13 +0200
Message-Id: <patch-v4-31.33-a0d71b4e8bb-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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

We can safely remove the "!default_remote" case from sync_submodule(),
because our get_default_remote_submodule() function now returns a
die_message() on failure, so we can have it an dother callers check if
the exit code should be non-zero instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 58 +++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dfd71f0f2b2..9de3a3c921a 100644
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
@@ -2422,9 +2431,16 @@ static int update_submodule(struct update_data *update_data)
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
2.37.3.1420.g76f8a3d556c

