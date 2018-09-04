Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADBA1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeIED3g (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:36 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:53090 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeIED3g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:36 -0400
Received: by mail-vk0-f73.google.com with SMTP id t7-v6so2025501vke.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OnDqQJQVhwP1mjAws1mWGqC6iF9uKZwnsmBBCP+Zwlg=;
        b=jLIz4NNF9NlJEBNX/33a7dfCDgHEMmmlKp9B+IgG3GvgP9qxNJXU7z+3eMCO8GlUhF
         qgVJ/oFADf8+6LcBurBPSOgSJ0IQ1o2+5NDgWTOL1Xk4Bh7TenDTh9RRrljknVcX8RkD
         Heigp6mrC9ncZt7AOZYIhFMqoeT/uiSaDHH4ZKh35rDBULSinLvwaoLNZhWroRjeQ4wq
         pXuC/ZUopqyJivOX10NxTP4o59wiGxJJEKBxtWEibZ4qWvSYWQfgTR/DQQApsRAnW7IX
         GabeYDjNrdxpzYbSh/YL4A7DYRWBZfoI1ScG1YPsdCeCa8qPbIw5vJl7dNZIbdeNg7LC
         jEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OnDqQJQVhwP1mjAws1mWGqC6iF9uKZwnsmBBCP+Zwlg=;
        b=Iq7UH3KXcz8oMx54OoCrvPHYlgYcMWRO529UsN7K2lbUZkzzVIJ/hOQlagilWaTmHd
         qNe1rRKVRIXSyKDLFEvXZk5C2S1vdIk7AHQ+p1uXvF3CNWxDUreFetAzO0miOePQd+km
         yfOrnlilR41S0Pz2X2OWuXD/MVRYRBXg1BQn3xVAtxAHIzKUMejfA1YPYzVwLLMWmBLE
         GgJQLcReTKPJDdfk8luRGYvtOOaway8kdxP7FvPOQdPzTVmHgJdbumTX37oezyMnE5ip
         jbr1LM9V/18/i6/CHjmrhEh+1L0vKXWPsPmqFENDhRTlISS+QDGs3HrTGGwmRa8vDwXH
         kvBg==
X-Gm-Message-State: APzg51ALE9vB50OzaH3Mjndf0Tz208nRkxey0I2FajX9mr4SDMu/3W8S
        3c0GyW5D3c5jsGYRekaM42EKtmoOb2Zo8RQIGXXEDKFC81sCb0dY/44+E8qrrgCXmNhmsmSsHwY
        3EFFdiqrYtbPWvox1IgXWa93Flu3GW4ajXJb71Bcl6lQwtxGihzGET81nIMod
X-Google-Smtp-Source: ANB0VdaQyZauQzK/87tVm1TMzA01WP12+CPtEuN6CD58p1HDbkBQaM4KaA5jTMN/wVdLn4JfsodK1nOvuoSq
X-Received: by 2002:a9f:3aca:: with SMTP id q10-v6mr14204711uag.31.1536102138738;
 Tue, 04 Sep 2018 16:02:18 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:47 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-10-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 09/11] submodule: fetch in submodules git directory instead of
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
index 0efe6711a8c..8b67f086895 100644
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
@@ -1273,16 +1298,12 @@ static int get_next_submodule(struct child_process *cp,
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
@@ -1294,8 +1315,6 @@ static int get_next_submodule(struct child_process *cp,
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
2.19.0.rc1.350.ge57e33dbd1-goog

