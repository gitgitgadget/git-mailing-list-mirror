Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AEDE784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjJBCkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJBCkq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6C1C9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:43 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a2a3fb0713so16445539f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214443; x=1696819243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoAjroQO1iVmfkizqGV2J0Hl4Oax5kmQ5faEhmWaBNI=;
        b=Tw2Nt6pKJaxNKvJiv7KoTfJaLuIjoWskYGERpeO7jSst7FZuSHxSKCPd+HlDB9nQ5v
         yd5schl4kEcr554UMPsOqX1mGva5/laCmP4tYhgb/OZRZXF8a+m4EQzjH/t0PmzPUxGt
         VC8U42bYbeyAdkOejAB7pVFPS1Zj6Wl1nk05Y2PbLtFevS5ZCQY0SZMEXAHBdrEXEczU
         zH0RIXR6w2zn9juP303nnGMpaDsAQkEPmIxKxpU4JHhLfYYCxSk8GuYLuMtUcn/2er/u
         s/g5WtZVTmulrpogXlmsrragCrf33SAEq7hY6T6DCTwZE2JFygsBvsHMwvKThrXoseA+
         3FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214443; x=1696819243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoAjroQO1iVmfkizqGV2J0Hl4Oax5kmQ5faEhmWaBNI=;
        b=aoD7bn+Ile8TpeYKkIYuOhpfljY5e2BpD+HEhtmQwpEfUZ0c2Vvo9uRBhiaOhK6v3k
         KsCkzw1pM1PrDp7bZyOIyK8D6A4jSalaIgIXeFBc6LqP+cy/bYeQtLJwHczUuitcGo7C
         XTx7gHFxGZL5LFxJO26D6B5gJ6Xr2t0pRwlKKsOF4c8pmZ1AQ2svS4rrw2Oye/WqPssh
         BRruUdfeYc5Y/oBigbw/kNsKqLo1u/np68BT+h9ihne/MO7tuw0Ikhj7b4ZX7NVJviy+
         7ImjhQcoC3QKT0ogJmrlimq9woQNPstn/4rh5V7xIQQDaGcKDU0ZRR+zO7SlzK5axnjk
         HlBg==
X-Gm-Message-State: AOJu0YyeKrGJ1MgDigNNaXPfsuXqwzZgazz0zZ2SBJ4+ArjGabsBfQhI
        lS++I+c4R7BR8gcJwBcKazy19cB71U9UDQ==
X-Google-Smtp-Source: AGHT+IFjaVdBIAyPY5SVk/2vzddHvW+CfyjaiTh7IEiCzdhbq6xHMqk5OZym+rOSMxA0PUp+hwhVcg==
X-Received: by 2002:a6b:e211:0:b0:795:1c40:a24e with SMTP id z17-20020a6be211000000b007951c40a24emr11655394ioc.12.1696214443271;
        Sun, 01 Oct 2023 19:40:43 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:42 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 04/30] repository: add a compatibility hash algorithm
Date:   Sun,  1 Oct 2023 21:40:08 -0500
Message-Id: <20231002024034.2611-4-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

We currently have support for using a full stage 4 SHA-256
implementation.  However, we'd like to support interoperability with
SHA-1 repositories as well.  The transition plan anticipates a
compatibility hash algorithm configuration option that we can use to
implement support for this.  Let's add an element to the repository
structure that indicates the compatibility hash algorithm so we can use
it when we need to consider interoperability between algorithms.

Add a helper function repo_set_compat_hash_algo that takes a
compatibility hash algorithm and sets "repo->compat_hash_algo".  If
GIT_HASH_UNKNOWN is passed as the compatibility hash algorithm
"repo->compat_hash_algo" is set to NULL.

For now, the code results in "repo->compat_hash_algo" always being set
to NULL, but that will change once a configuration option is added.

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 repository.c | 8 ++++++++
 repository.h | 4 ++++
 setup.c      | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/repository.c b/repository.c
index a7679ceeaa45..80252b79e93e 100644
--- a/repository.c
+++ b/repository.c
@@ -104,6 +104,13 @@ void repo_set_hash_algo(struct repository *repo, int hash_algo)
 	repo->hash_algo = &hash_algos[hash_algo];
 }
 
+void repo_set_compat_hash_algo(struct repository *repo, int algo)
+{
+	if (hash_algo_by_ptr(repo->hash_algo) == algo)
+		BUG("hash_algo and compat_hash_algo match");
+	repo->compat_hash_algo = algo ? &hash_algos[algo] : NULL;
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -184,6 +191,7 @@ int repo_init(struct repository *repo,
 		goto error;
 
 	repo_set_hash_algo(repo, format.hash_algo);
+	repo_set_compat_hash_algo(repo, GIT_HASH_UNKNOWN);
 	repo->repository_format_worktree_config = format.worktree_config;
 
 	/* take ownership of format.partial_clone */
diff --git a/repository.h b/repository.h
index 5f18486f6465..bf3fc601cc53 100644
--- a/repository.h
+++ b/repository.h
@@ -160,6 +160,9 @@ struct repository {
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
 
+	/* Repository's compatibility hash algorithm. */
+	const struct git_hash_algo *compat_hash_algo;
+
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
 
@@ -199,6 +202,7 @@ void repo_set_gitdir(struct repository *repo, const char *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
+void repo_set_compat_hash_algo(struct repository *repo, int compat_algo);
 void initialize_the_repository(void);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
diff --git a/setup.c b/setup.c
index 18927a847b86..aa8bf5da5226 100644
--- a/setup.c
+++ b/setup.c
@@ -1564,6 +1564,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			repo_set_compat_hash_algo(the_repository,
+						  GIT_HASH_UNKNOWN);
 			the_repository->repository_format_worktree_config =
 				repo_fmt.worktree_config;
 			/* take ownership of repo_fmt.partial_clone */
@@ -1657,6 +1659,7 @@ void check_repository_format(struct repository_format *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
+	repo_set_compat_hash_algo(the_repository, GIT_HASH_UNKNOWN);
 	the_repository->repository_format_worktree_config =
 		fmt->worktree_config;
 	the_repository->repository_format_partial_clone =
-- 
2.41.0

