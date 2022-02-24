Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EABC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiBXKJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiBXKJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:37 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5CE28ADA1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:07 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r8-20020a638f48000000b0036c6a881088so939192pgn.2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XJ+XxV4dA7bXW/e75TlW5gYEF4MVzcGC4nrAKF0nmD0=;
        b=rUiYDGEiWvP6I+1k2+K40P/mCPhCEYXIuTbTFVQMZRp73FbJqHaCKSZk6gtKBuxAyE
         535lq9FHeBllwVUiwWcycPEcd9d+YSbf5++Qsv9eyybxtQxesrBotodXecmRv2mR+wxB
         rVxJ7PX/x1StgKEuM/SlwZd6cAX48TCelBfqqv735jQBYxKQLxuUKkkvDM2P3eReF0eX
         bbU3gIQ555C3FW05j2lYukql8weJRxFkvA8JkYu12MvHpbxFAMcFelFQi83EcPtunmD5
         zoDAyiLyRKIcHwpyVET3erswkA101aTtZU/hZK/Km/qDvvHZ5iomG2u/QmKh5GLh5MN8
         ljUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XJ+XxV4dA7bXW/e75TlW5gYEF4MVzcGC4nrAKF0nmD0=;
        b=J8NumYWUwlLWRf1izKjtySbFrff+NdfVI1UoQS1YsqUv38jQZvvW2+HIk3HEpBm8kn
         gzjyZMBnEL1MB+ob6aSpU++AHNG0pWG2gmpbj5REVBMuSqBTdaGqM0qG9LYEORDQgoHg
         mJdloe6uUb+XlQNy7ugYqOVKI2v/EiKIfu3YNIWqW7I17gKR/n7yf17i9VSu5PjTFsvX
         /oc/clwE+PrK7waXwDPVf/ZES6NBxphxVUbMLH2eABFwHkKloHsX8YwnMtLu4vbU7iRX
         1r2tuZZplG0mORy1wri+7qHTsqyMjDLFUkDl+4zrUpe7i2FQql3IlQLiHdHm2zGNI/gq
         Vwrg==
X-Gm-Message-State: AOAM530/YWf5F2+5q5yX5gf3BnX4UVjuNFyFnj+OwnxwjQCmnIMYlN1j
        KlmCW2iaU7NfUD+X2Fq/hJZ6tpDig10AIIfP1NTINQ1N4k2Di4NTQi6xuDwJjPXqgDE/+z75vfP
        zr7qF2uO46uf9l8qTqc81Qth6j5I3dcJ8SuYnNiRUt7Ivo/oRWZh1LFRKeEV9OuQ=
X-Google-Smtp-Source: ABdhPJxLrk6GEIWXBIqFP6Z8N3KugkI8gmhmaweigjGOx3FeOx9aE1B8P3Rqcxga7s9sFDiNM7G/1XZ7r7vUbQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:9517:b0:1bc:81ef:79cd with SMTP
 id t23-20020a17090a951700b001bc81ef79cdmr2017752pjo.164.1645697346560; Thu,
 24 Feb 2022 02:09:06 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:39 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 07/10] submodule: extract get_fetch_task()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_next_submodule() configures the parallel submodule fetch by
performing two functions:

* iterate the index to find submodules
* configure the child processes to fetch the submodules found in the
  previous step

Extract the index iterating code into an iterator function,
get_fetch_task(), so that get_next_submodule() is agnostic of how
to find submodules. This prepares for a subsequent commit will teach the
fetch machinery to also iterate through the list of changed
submodules (in addition to the index).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 61 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0b9c25f9d3..988757002a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1389,6 +1389,7 @@ struct fetch_task {
 	struct repository *repo;
 	const struct submodule *sub;
 	unsigned free_sub : 1; /* Do we need to free the submodule? */
+	const char *default_argv;
 
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
@@ -1466,14 +1467,11 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 	return ret;
 }
 
-static int get_next_submodule(struct child_process *cp,
-			      struct strbuf *err, void *data, void **task_cb)
+static struct fetch_task *
+get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 {
-	struct submodule_parallel_fetch *spf = data;
-
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
-		const char *default_argv;
 		struct fetch_task *task;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1493,10 +1491,10 @@ static int get_next_submodule(struct child_process *cp,
 					&spf->changed_submodule_names,
 					task->sub->name))
 				continue;
-			default_argv = "on-demand";
+			task->default_argv = "on-demand";
 			break;
 		case RECURSE_SUBMODULES_ON:
-			default_argv = "yes";
+			task->default_argv = "yes";
 			break;
 		case RECURSE_SUBMODULES_OFF:
 			continue;
@@ -1504,29 +1502,12 @@ static int get_next_submodule(struct child_process *cp,
 
 		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
-			struct strbuf submodule_prefix = STRBUF_INIT;
-			child_process_init(cp);
-			cp->dir = task->repo->gitdir;
-			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
-			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
-			strvec_init(&cp->args);
-			strvec_pushv(&cp->args, spf->args.v);
-			strvec_push(&cp->args, default_argv);
-			strvec_push(&cp->args, "--submodule-prefix");
-
-			strbuf_addf(&submodule_prefix, "%s%s/",
-						       spf->prefix,
-						       task->sub->path);
-			strvec_push(&cp->args, submodule_prefix.buf);
 
 			spf->count++;
-			*task_cb = task;
-
-			strbuf_release(&submodule_prefix);
-			return 1;
+			return task;
 		} else {
 			struct strbuf empty_submodule_path = STRBUF_INIT;
 
@@ -1550,6 +1531,36 @@ static int get_next_submodule(struct child_process *cp,
 			strbuf_release(&empty_submodule_path);
 		}
 	}
+	return NULL;
+}
+
+static int get_next_submodule(struct child_process *cp, struct strbuf *err,
+			      void *data, void **task_cb)
+{
+	struct submodule_parallel_fetch *spf = data;
+	struct fetch_task *task = get_fetch_task(spf, err);
+
+	if (task) {
+		struct strbuf submodule_prefix = STRBUF_INIT;
+
+		child_process_init(cp);
+		cp->dir = task->repo->gitdir;
+		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		cp->git_cmd = 1;
+		strvec_init(&cp->args);
+		strvec_pushv(&cp->args, spf->args.v);
+		strvec_push(&cp->args, task->default_argv);
+		strvec_push(&cp->args, "--submodule-prefix");
+
+		strbuf_addf(&submodule_prefix, "%s%s/",
+						spf->prefix,
+						task->sub->path);
+		strvec_push(&cp->args, submodule_prefix.buf);
+		*task_cb = task;
+
+		strbuf_release(&submodule_prefix);
+		return 1;
+	}
 
 	if (spf->oid_fetch_tasks_nr) {
 		struct fetch_task *task =
-- 
2.33.GIT

