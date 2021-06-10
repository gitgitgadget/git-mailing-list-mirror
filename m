Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8308C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF7D613E9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFJRjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:39:03 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:34548 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhFJRjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 13:39:01 -0400
Received: by mail-yb1-f201.google.com with SMTP id x187-20020a25e0c40000b029052a5f0bf9acso479110ybg.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LGXGM//1Kj1bmhp2Je6sCwChdFI8inBUJ2Xnb++2U18=;
        b=HWaage/G5/0WLMjWnuRuZM3N2IvETFAKiF1QQE0+ZIa8Jx+aZutwltzwnGl1zLwF5F
         fKv2/AO5ZOFIDREMlQphgrCDeTkJijwrAy3EROrcEKvcl3SWV1JOjq73j/o6ro6xAri9
         uD49YqLIfIJEJmkd8PmLi6Zj6vKPMAuLBDCsCMXJ1at7v+Ua+gLZS9F4CLm9WfqLAkFG
         59rwYgWIXlsM14d6jQssI2SC2E9fYUBNmPqfS5TMX3E1qFgT04fvmikvUZQriPLXKAqq
         u3niUmJlDqMw4Z3eTgwMxRVTgxoWw6dVFyyCzSXXUcFTrUN3QPKVw5lvlEvEUS12M8WV
         cOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LGXGM//1Kj1bmhp2Je6sCwChdFI8inBUJ2Xnb++2U18=;
        b=M6Ni/9C7B2IBgmnVi/4pImL9bYnwk7+sHIAszmEOjRLcXxDqb16oQAW85u03BWjtUM
         e5U5LKKwRZbic9g/l6Q6ZnConV2nhmEMfMbHNUWs1mmQd5KJ387dQz+ic4BwtomzPmQz
         kUXRqkg2bePpRV8DFZhxg+NwGVZXKn2uxx+1i/KnPw4d5N3Pl4hcWuqeEEHuH0m9RmKK
         10MsUpXL0+SZ+EtAXfJJGn8yQiYyBkth6bmjLiPn9S5njlMOravvgIJs97u8kTTVLxFN
         tKZkzHKmbFOZC1tPRmQK/vPwxyzNFyn1DderGot4Y15r6eQy4bBdjjtmtJ+bRkUb2zrO
         3QzQ==
X-Gm-Message-State: AOAM533jsjNIsZxCPvqRoVN4epdtPJehpmiozESTmU/a955m47YNvwJJ
        dTs+R2TKDhd4N34F5tkYWlTJj82ffSNNK0FJ7ZEgFLLKmqUzf8D0rueYyOmZiw9omPGm075xlDE
        Xb2zU6RjN6tTuv7jMLIDBLeFBU5Ce52o3dAOVonNwE8gTD9xCYUKPZGfsVXU4Og4iEGz21b7i0F
        DM
X-Google-Smtp-Source: ABdhPJwcNl2Z1FOtpCAmpMppGQ9p5m4U+mUewgkIWzr9/ZJm/h5lpyzdbG5Y/ggB5yBj9Fwmxc+B12lzTn+jgWIctBRE
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:9a04:: with SMTP id
 x4mr9073501ybn.440.1623346553017; Thu, 10 Jun 2021 10:35:53 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:35:42 -0700
In-Reply-To: <cover.1623345496.git.jonathantanmy@google.com>
Message-Id: <fd6907822cf4cb12023999a61682676de193bff9.1623345496.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623345496.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v3 4/5] run-command: refactor subprocess env preparation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

submodule.c has functionality that prepares the environment for running
a subprocess in a new repo. The lazy-fetching code (used in partial
clones) will need this in a subsequent commit, so move it to a more
central location.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 run-command.c | 12 ++++++++++++
 run-command.h | 10 ++++++++++
 submodule.c   | 18 ++----------------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index be6bc128cd..549a94a6a4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1892,3 +1892,15 @@ int run_auto_maintenance(int quiet)
 
 	return run_command(&maint);
 }
+
+void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
+{
+	const char * const *var;
+
+	for (var = local_repo_env; *var; var++) {
+		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
+		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
+			strvec_push(env_array, *var);
+	}
+	strvec_pushf(env_array, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
+}
diff --git a/run-command.h b/run-command.h
index d08414a92e..92f1c00b11 100644
--- a/run-command.h
+++ b/run-command.h
@@ -483,4 +483,14 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
 			       task_finished_fn, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label);
 
+/**
+ * Convenience function which prepares env_array for a command to be run in a
+ * new repo. This adds all GIT_* environment variables to env_array with the
+ * exception of GIT_CONFIG_PARAMETERS (which cause the corresponding
+ * environment variables to be unset in the subprocess) and adds an environment
+ * variable pointing to new_git_dir. See local_repo_env in cache.h for more
+ * information.
+ */
+void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
+
 #endif
diff --git a/submodule.c b/submodule.c
index f09031e397..8e611fe1db 100644
--- a/submodule.c
+++ b/submodule.c
@@ -484,28 +484,14 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
 	strbuf_release(&sb);
 }
 
-static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
-{
-	const char * const *var;
-
-	for (var = local_repo_env; *var; var++) {
-		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
-		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
-			strvec_push(out, *var);
-	}
-}
-
 void prepare_submodule_repo_env(struct strvec *out)
 {
-	prepare_submodule_repo_env_no_git_dir(out);
-	strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
-		     DEFAULT_GIT_DIR_ENVIRONMENT);
+	prepare_other_repo_env(out, DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
 static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
 {
-	prepare_submodule_repo_env_no_git_dir(out);
-	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+	prepare_other_repo_env(out, ".");
 }
 
 /*
-- 
2.32.0.rc1.229.g3e70b5a671-goog

