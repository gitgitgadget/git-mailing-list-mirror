Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4631F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeILEv4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:51:56 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:48761 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeILEvz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:55 -0400
Received: by mail-vk0-f73.google.com with SMTP id g71-v6so7310vke.15
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KItobHqCCVzmLBPJnMnC50u9fHZIScwfPEg4MpAgDDw=;
        b=HF/0mrY246tz8b1AMZ8UHnHFNQywArDNVnq9YH04pVd4R7Z9RPsRE5OL6o4bOnfVAo
         R9yt9ht/tol0tQNUp1lSPDDYQK1vpvfTzw/RUj/Tq1uGlNGWH/mRCamT4cCWdMkSMnWt
         VK2QEpAv39cDMxHYZ/v/TcqZVy4C4Dl8ohhQJxTjlYXrlUqtRlspkaoTBTnhxqyiQThg
         Fihmcay3p/KjQMu3Gim+hnTENiO6qm1/6cu/jug1rG9SRBoUgQhQHybaCoDjnATEMwkP
         Q1+dFkif7V5xDBoPUYAqqAX3B2jNbZ6xlT2SiuUckaaskSqOkBkJgHAY3aI7QDsbkyif
         oUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KItobHqCCVzmLBPJnMnC50u9fHZIScwfPEg4MpAgDDw=;
        b=aa7rB1/0eUFOub6nL3d7rCLUPhhj9R3+rxFBT6kvnIc55ArW9873eqDBfdAZwBWgKK
         p5I6W+ev+4FqYX0RxFX0F8xrRuXBm8AlzWqj6CMDb4Ib9OCz98BnrW+pm2+Gmj02phbu
         OUxcZ1qhXkHaUJPJPGDaO6cYZN/jmrDLlFhJM1AWk4FmqpkwaRM0d+AFEAmEqO2FgJm5
         DLOn7MMMjEPo6o9jtuxMPRsfebreo2ETijpazZS2RqyD1MLwkIL95XKrdYUz/gK4wH8i
         886mXN1AA4m92d9n49ogT0nZQx/gdDrF9yOFVbjh3AROmvZvT8aNW0waqRPA1/u39Z82
         oXdg==
X-Gm-Message-State: APzg51Cm32KeW5dBykuen+Of7AAEFT06/7YzZvRbVpgT79zk1HWYkDXs
        OcSHOxYqqgkgqmX8cyRgz0TYZmoF16uwiUm7VX81bPZsqdf4PFdoVWIGCFJKz7rCk/RxvbSKzW8
        GHKfv2Sj5CyJ1YTDGFdxxCwvQBgixFJFOMwWcOkS3Au1dL/txO7CYRFDYRgsw
X-Google-Smtp-Source: ANB0VdZBnhBK7wsR6uxuLehlRhH2R1Hdk9ysUszV1KNligQyiqdNELKRoTzuQgYun0rVjYQWCovnmkYKq9vw
X-Received: by 2002:a1f:b781:: with SMTP id h123-v6mr4540618vkf.31.1536709815950;
 Tue, 11 Sep 2018 16:50:15 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:49 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180911234951.14129-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 7/9] submodule: fetch in submodules git directory instead of
 in worktree
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch started as a refactoring to make 'get_next_submodule' more
readable, but upon doing so, I realized that git-fetch actually doesn't
need to be run in the worktree. So let's run it in the git dir instead.

That should pave the way towards fetching submodules that are currently
not checked out.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                 | 43 ++++++++++++++++++++++++++-----------
 t/t5526-fetch-submodules.sh |  7 +++++-
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/submodule.c b/submodule.c
index 00a9a3c6b12..1e6781504f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -481,6 +481,12 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1227,6 +1233,27 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+static const char *get_submodule_git_dir(struct repository *r, const char *path)
+{
+	struct repository subrepo;
+	const char *ret;
+
+	if (repo_submodule_init(&subrepo, r, path)) {
+		/* no entry in .gitmodules? */
+		struct strbuf gitdir = STRBUF_INIT;
+		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", path);
+		if (repo_init(&subrepo, gitdir.buf, NULL)) {
+			strbuf_release(&gitdir);
+			return NULL;
+		}
+	}
+
+	ret = xstrdup(subrepo.gitdir);
+	repo_clear(&subrepo);
+
+	return ret;
+}
+
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
@@ -1234,8 +1261,6 @@ static int get_next_submodule(struct child_process *cp,
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_path = STRBUF_INIT;
-		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *git_dir, *default_argv;
@@ -1274,16 +1299,12 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
-		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		git_dir = read_gitfile(submodule_git_dir.buf);
-		if (!git_dir)
-			git_dir = submodule_git_dir.buf;
-		if (is_directory(git_dir)) {
+		git_dir = get_submodule_git_dir(spf->r, ce->name);
+		if (git_dir) {
 			child_process_init(cp);
-			cp->dir = strbuf_detach(&submodule_path, NULL);
-			prepare_submodule_repo_env(&cp->env_array);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = git_dir;
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1295,8 +1316,6 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_push(&cp->args, submodule_prefix.buf);
 			ret = 1;
 		}
-		strbuf_release(&submodule_path);
-		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6c2f9b2ba26..42692219a1a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -566,7 +566,12 @@ test_expect_success 'fetching submodule into a broken repository' '
 
 	test_must_fail git -C dst status &&
 	test_must_fail git -C dst diff &&
-	test_must_fail git -C dst fetch --recurse-submodules
+
+	# git-fetch cannot find the git directory of the submodule,
+	# so it will do nothing, successfully, as it cannot distinguish between
+	# this broken submodule and a submodule that was just set active but
+	# not cloned yet
+	git -C dst fetch --recurse-submodules
 '
 
 test_expect_success "fetch new commits when submodule got renamed" '
-- 
2.19.0.397.gdd90340f6a-goog

