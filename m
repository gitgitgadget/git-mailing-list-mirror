Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D9E82CCE
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjI0Tz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0Tz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:55:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5917F11F
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79f95cd15dfso382728039f.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844553; x=1696449353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXaGbPC9QegDS+5xxfdJtEA4+TpWeLkpFBb18S/QmhA=;
        b=IvS8KVryFHvbdOB28DrOPjDX3mxTKDzM0jj166yGoU9XxshDEtLxFdWVadr+IbeHO1
         Wn6aG+kEuPE4cTPSgnvqSUBSg8n/3PDl6+VL/0NJ/TZvVWI92PQDfk2o44Xnpl/KLjzX
         rvmgbqEhXkiCNOhjqOBrSUMqXlEnKzeEn2pKy33J+FwPweYYeckM03zeRTxxTWClClV5
         DO+lNtELRoahr0OT8AXEkt0qxD4kddaAz/o3QCtYLePFKViNd9pEPiNmPEL0saAJ8LBg
         BZarijM20a4AUtuNi0oR0w6elHPEUjCUEsThK1vzEb9JIgwXjO6oZQaJh7iPLWzJ/iyK
         JEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844553; x=1696449353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXaGbPC9QegDS+5xxfdJtEA4+TpWeLkpFBb18S/QmhA=;
        b=a//s2YdAHCzVBG6TAIMXIhA4DUzUDc5cQzIUKrrvJ9uqaH80b4O4pkszXx2TjyuO2Y
         p0MTiz6Ptdnuu1lIaIy150vTE9Y8s8lbU7FWb9Y1crZbstj1KOA912Cm9oLXrctY49wR
         na5gCn4j3OCeVnjI05I4OY6i9Z5XQbjMlSm4YxCpBWU65zHEHiWvFjMk0XDjEvST+6p/
         ffw0ju+fiH/HEHnKg7lhcs/WJ/BJU5AnK01u1dqIxphIWW63DYXgQMABSRzf+dvpoFxm
         QCn8KzuDV7GmQRs7KD3AORbhg9FwK7EJJNheiVHJwyJmZZNr8e+OZPHHvm4UK/BTiBm+
         7OmA==
X-Gm-Message-State: AOJu0Yzs4jpLYYuJDBlC0wnP8gEuwg9zj68BtTM4WgVCcJlhpSRLvaVh
        KaYRTE1Kyk9FVj4JC68pCEM/+DgFLYZdLw==
X-Google-Smtp-Source: AGHT+IGYkugShUH6OcuzqyfbNmSKCnPslRTRvynNdT7dgFX/DFAZh50njCQ7SUNCdBzoNnVCj1hvOA==
X-Received: by 2002:a5e:8705:0:b0:79f:a25b:51c with SMTP id y5-20020a5e8705000000b0079fa25b051cmr3394919ioj.11.1695844553672;
        Wed, 27 Sep 2023 12:55:53 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:53 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 04/30] repository: add a compatibility hash algorithm
Date:   Wed, 27 Sep 2023 14:55:11 -0500
Message-Id: <20230927195537.1682-4-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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
GIT_HASH_UNKNOWN is passed as the compatibilty hash algorithm
"repo->compat_hash_algo" is set to NULL.

For now, the code always results in "repo->compat_hash_algo" always
being set to NULL, but that will change once a configuration option
is added.

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
index ef9f79b8885e..deb5a33fe9e1 100644
--- a/setup.c
+++ b/setup.c
@@ -1572,6 +1572,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			repo_set_compat_hash_algo(the_repository,
+						  GIT_HASH_UNKNOWN);
 			the_repository->repository_format_worktree_config =
 				repo_fmt.worktree_config;
 			/* take ownership of repo_fmt.partial_clone */
@@ -1665,6 +1667,7 @@ void check_repository_format(struct repository_format *fmt)
 	check_repository_format_gently(get_git_dir(), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
+	repo_set_compat_hash_algo(the_repository, GIT_HASH_UNKNOWN);
 	the_repository->repository_format_worktree_config =
 		fmt->worktree_config;
 	the_repository->repository_format_partial_clone =
-- 
2.41.0

