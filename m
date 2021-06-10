Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83949C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C90613E1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhFJRip (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:38:45 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55864 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFJRio (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 13:38:44 -0400
Received: by mail-pl1-f202.google.com with SMTP id t7-20020a170902bc47b02900fd1eb0b2e8so1463704plz.22
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MRbfA65cmjHdDDLoN90SigmBjVewcwifAC8cv973JT8=;
        b=sYB16Ecn0ozddzEFgxhNdSws8telazz5CYS+++/qSsoBMIlSQR8M+GuujbJLlBoKQR
         MHUVu87OCEYcQE4qdHSk4jf52+Dhgpj9/rN5gdFYHJa3xAvYrjDwJNzH1rl3VD8w4paM
         NqcM6SyfihKwj6FgzBB/cF50F5trrBhVjwF4dSAWjwW0+n0EYQIqOa1HF3eUR4RDKDoa
         zXUbJKN2sXwDDu6QJBbMSr6Y6kh1P2RuS7aEF1OjGcV4AaIqwPQbzqP1vivVN8dhYtKD
         Ft9iDEfLlclh44WjCrsisnRQ+ZhtVr5ikDmMR9y29TW7ctLpuNnQV9zof7N2HqcnfOOF
         mV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MRbfA65cmjHdDDLoN90SigmBjVewcwifAC8cv973JT8=;
        b=bn/OCjk88MQM/cv1+XjH5h7BmaNNdMsaqpNck94on1cdJKTaiP2gXx7QUsbmDJyihl
         j3ts5+fJR/ILW2OA9mMLzb19yjDWA2Oe8INfCSsBPDqn4jVAjO44YCVZ2JJaCgdsqExR
         tMl+qxWYFg7gnOF9QEr3lAuLrNfjcFhRnKou3sMjtklOrA3C/muVhrx0J89Yys+wGdhb
         MN8m4577AitWcBnq8gN5sG0KXszbgfU51BR35RmFrzB5ymPbXeUYLueL8IQuyQwdny+C
         lTgQ00A82Y6BuAcw4qAI/M/ixoLGzE8K2PkDeDJnPm/JDsLzmomEC5jXAvECHmJOZg66
         wa1A==
X-Gm-Message-State: AOAM531hqe3VGNM3rTwTvKLzc6h/cXaz6CLc+z8WxCRoLsitP5tSxTiv
        nPUyn0jGKh2wjPx5DnjwAxbgBsqCQhPjw1S4Txra97ApXGvqkL0LSrHzaBxmfRv2Ce8H6STBZon
        GL5WoE8H5vD8e/qdSjpCIcAna28+AIm/wnIlCYORAQKqqMfciaK0M9yunttW9uefOpmjP4OSXhb
        O3
X-Google-Smtp-Source: ABdhPJx41NhjIG7ItQpriZqU2tcKVZ2C4sRRvJEZWHFboHe+hUSwuFTU1XVeG1wnpyIBVc/TC9k/nfDL31qB4N6lpIr6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b585:b029:f6:5cd5:f128 with
 SMTP id a5-20020a170902b585b02900f65cd5f128mr5904889pls.43.1623346548067;
 Thu, 10 Jun 2021 10:35:48 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:35:39 -0700
In-Reply-To: <cover.1623345496.git.jonathantanmy@google.com>
Message-Id: <255d1122569dabc4654f7521698744bcc0f13a42.1623345496.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623345496.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v3 1/5] repository: move global r_f_p_c to repo struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move repository_format_partial_clone, which is currently a global
variable, into struct repository. (Full support for per-repository
partial clone config will be done in a subsequent commit - this is split
into its own commit because of the extent of the changes needed.)

The new repo-specific variable cannot be set in
check_repository_format_gently() (as is currently), because that
function does not know which repo it is operating on (or even whether
the value is important); therefore this responsibility is delegated to
the outermost caller that knows. Of all the outermost callers that know
(found by looking at all functions that call clear_repository_format()),
I looked at those that either read from the main Git directory or write
into a struct repository. These callers have been modified accordingly
(write to the_repository in the former case and write to the given
struct repository in the latter case).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 promisor-remote.c | 13 +++----------
 promisor-remote.h |  6 ------
 repository.c      |  3 +++
 repository.h      |  3 +++
 setup.c           | 16 +++++++++++-----
 5 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index da3f2ca261..d24081dc21 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -5,13 +5,6 @@
 #include "transport.h"
 #include "strvec.h"
 
-static char *repository_format_partial_clone;
-
-void set_repository_format_partial_clone(char *partial_clone)
-{
-	repository_format_partial_clone = xstrdup_or_null(partial_clone);
-}
-
 static int fetch_objects(const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
@@ -145,15 +138,15 @@ static void promisor_remote_init(void)
 
 	git_config(promisor_remote_config, NULL);
 
-	if (repository_format_partial_clone) {
+	if (the_repository->repository_format_partial_clone) {
 		struct promisor_remote *o, *previous;
 
-		o = promisor_remote_lookup(repository_format_partial_clone,
+		o = promisor_remote_lookup(the_repository->repository_format_partial_clone,
 					   &previous);
 		if (o)
 			promisor_remote_move_to_tail(o, previous);
 		else
-			promisor_remote_new(repository_format_partial_clone);
+			promisor_remote_new(the_repository->repository_format_partial_clone);
 	}
 }
 
diff --git a/promisor-remote.h b/promisor-remote.h
index c7a14063c5..687210ab87 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -32,10 +32,4 @@ int promisor_remote_get_direct(struct repository *repo,
 			       const struct object_id *oids,
 			       int oid_nr);
 
-/*
- * This should be used only once from setup.c to set the value we got
- * from the extensions.partialclone config option.
- */
-void set_repository_format_partial_clone(char *partial_clone);
-
 #endif /* PROMISOR_REMOTE_H */
diff --git a/repository.c b/repository.c
index 448cd557d4..4878c297d9 100644
--- a/repository.c
+++ b/repository.c
@@ -172,6 +172,9 @@ int repo_init(struct repository *repo,
 
 	repo_set_hash_algo(repo, format.hash_algo);
 
+	repo->repository_format_partial_clone = format.partial_clone;
+	format.partial_clone = NULL;
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/repository.h b/repository.h
index a45f7520fd..6fb16ed336 100644
--- a/repository.h
+++ b/repository.h
@@ -139,6 +139,9 @@ struct repository {
 	/* True if commit-graph has been disabled within this process. */
 	int commit_graph_disabled;
 
+	/* Configurations related to promisor remotes. */
+	char *repository_format_partial_clone;
+
 	/* Configurations */
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
diff --git a/setup.c b/setup.c
index 59e2facd9d..fbedfe8e03 100644
--- a/setup.c
+++ b/setup.c
@@ -468,8 +468,6 @@ static enum extension_result handle_extension_v0(const char *var,
 			data->precious_objects = git_config_bool(var, value);
 			return EXTENSION_OK;
 		} else if (!strcmp(ext, "partialclone")) {
-			if (!value)
-				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
 			return EXTENSION_OK;
 		} else if (!strcmp(ext, "worktreeconfig")) {
@@ -566,7 +564,6 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	set_repository_format_partial_clone(candidate->partial_clone);
 	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
@@ -1193,6 +1190,10 @@ int discover_git_directory(struct strbuf *commondir,
 		return -1;
 	}
 
+	the_repository->repository_format_partial_clone =
+		candidate.partial_clone;
+	candidate.partial_clone = NULL;
+
 	clear_repository_format(&candidate);
 	return 0;
 }
@@ -1300,8 +1301,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
+		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			the_repository->repository_format_partial_clone =
+				repo_fmt.partial_clone;
+			repo_fmt.partial_clone = NULL;
+		}
 	}
 	/*
 	 * Since precompose_string_if_needed() needs to look at
@@ -1319,7 +1324,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
-
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
 	clear_repository_format(&repo_fmt);
@@ -1386,6 +1390,8 @@ void check_repository_format(struct repository_format *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
+	the_repository->repository_format_partial_clone =
+		xstrdup_or_null(fmt->partial_clone);
 	clear_repository_format(&repo_fmt);
 }
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

