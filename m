Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561C51F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758970AbeBPRqh (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:37 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33733 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756614AbeBPRqf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:35 -0500
Received: by mail-pg0-f65.google.com with SMTP id g12so2975885pgs.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hIhVeJ8Vjk7h0iSPqIGvACuJCRhQ8Irh3DAp9HKSUVk=;
        b=O26k6fq4t2rU8OsrzteLUp4fsgc1w+YQhS/EJU045YlStErDemR8aht3xTaHyYkC7r
         Hhnb5/8kgbbZs1TMFfMVZXVxg/D6CWExBPJ0983pP5KsMAJbO7wpC4bf2zW6foyPb6in
         CmQ6HkYv4GoQzUoEgRiDJNYu4ep1C5Nge8a3KK2LHy15n5w1IygxCt1dX4t+BK33nLY3
         8upu/KjBkm5NYEEf17BkIEcKxQRaVqNKX1IRUV53xlQtCZEZkVrv+3Zz6Lv7mBR3PJnO
         QIq4viBdZXlZXkjRuk5+pbpm7VLtiDNkyBkxg50bfJSoNGgTDsOdtVxhisg9MWvCnIUQ
         +26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hIhVeJ8Vjk7h0iSPqIGvACuJCRhQ8Irh3DAp9HKSUVk=;
        b=VjALJjAWO3FMbmM33vByj7cAb+RfmKVWRlmSSPiwrBriZsh1/0oBcwMdHHGJV1OYL9
         2o2jm1UmySRYC0Df0S/hD4AU/D+OA1CrWmIhikehCtPdgBrQGFRqm+0BBE6Z4+MDZh74
         84RJ0li018sphWTPatK1Dbt2U0TjcAYnI7MZanmi08wabtcY9hyrxgJKvpWBlTLzOq1k
         Q5Zj1yOpFivRH9qeCh6dr39cVYB4g2mHvuFF7Q6BAwlqpga9WwEMz3vCFyFYsgWU3Fpi
         Nh9jNwmIPEx41AbX1y28/CRyhFdUGYWkngovpSxz1s8AKWKP9Z3Y3ktv0No1smvh31Uj
         bc6Q==
X-Gm-Message-State: APf1xPCy7LI3Lv9IuEGAdaPyTMqlw0e9yluL3E115MRCp6mNXh9trRDL
        SJFU/UcXwaDDEnOnWfILy3fxlwBflE8=
X-Google-Smtp-Source: AH8x227EOmYF6s6S7RP8l63VWXIfUVk654zrXjaomJyTOQGSG9VFwgwDuZWx6JneO900GXQyGoS+RQ==
X-Received: by 10.101.98.133 with SMTP id f5mr5715835pgv.357.1518803194425;
        Fri, 16 Feb 2018 09:46:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id u90sm23565999pfk.114.2018.02.16.09.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/16] repository: introduce raw object store field
Date:   Fri, 16 Feb 2018 09:46:11 -0800
Message-Id: <20180216174626.24677-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The raw object store field will contain any objects needed for
access to objects in a given repository.

This patch introduces the raw object store and populates it with the
`objectdir`, which used to be part of the repository struct as well as
'ignore_env' which is duplicated from the repository. A later refactoring
(not in this series) will hopefully get rid of that one bit, once all
the construction of repo objects goes through repo_init(). The reason for
duplication now is that the refactoring done in this series allows for
smaller scoped objects in the functions refactored, nameny passing around
the object store instead of the repository object.

As the struct gains members, we'll also populate the function to clear
the memory for these members.

In a later we'll introduce a struct object_parser, that will complement
the object parsing in a repository struct: The raw object parser is the
layer that will provide access to raw object content, while the higher
level object parser code will parse raw objects and keeps track of
parenthood and other object relationships using 'struct object'.
For now only add the lower level to the repository struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/grep.c |  2 +-
 environment.c  |  5 +++--
 object-store.h | 17 +++++++++++++++++
 object.c       |  5 +++++
 path.c         |  2 +-
 repository.c   | 19 +++++++++++++++----
 repository.h   |  7 ++++---
 7 files changed, 46 insertions(+), 11 deletions(-)
 create mode 100644 object-store.h

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d8..0f0c195705 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -432,7 +432,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * object.
 	 */
 	grep_read_lock();
-	add_to_alternates_memory(submodule.objectdir);
+	add_to_alternates_memory(submodule.objects.objectdir);
 	grep_read_unlock();
 
 	if (oid) {
diff --git a/environment.c b/environment.c
index de8431e01e..ec10b062e6 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@
 #include "refs.h"
 #include "fmt-merge-msg.h"
 #include "commit.h"
+#include "object-store.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
@@ -244,9 +245,9 @@ const char *get_git_work_tree(void)
 
 char *get_object_directory(void)
 {
-	if (!the_repository->objectdir)
+	if (!the_repository->objects.objectdir)
 		BUG("git environment hasn't been setup");
-	return the_repository->objectdir;
+	return the_repository->objects.objectdir;
 }
 
 int odb_mkstemp(struct strbuf *template, const char *pattern)
diff --git a/object-store.h b/object-store.h
new file mode 100644
index 0000000000..5959d990fc
--- /dev/null
+++ b/object-store.h
@@ -0,0 +1,17 @@
+#ifndef OBJECT_STORE_H
+#define OBJECT_STORE_H
+
+struct raw_object_store {
+	/*
+	 * Path to the repository's object store.
+	 * Cannot be NULL after initialization.
+	 */
+	char *objectdir;
+
+	unsigned ignore_env : 1;
+};
+#define RAW_OBJECT_STORE_INIT { NULL, 0 }
+
+void raw_object_store_clear(struct raw_object_store *o);
+
+#endif /* OBJECT_STORE_H */
diff --git a/object.c b/object.c
index 9e6f9ff20b..11d904c033 100644
--- a/object.c
+++ b/object.c
@@ -445,3 +445,8 @@ void clear_commit_marks_all(unsigned int flags)
 			obj->flags &= ~flags;
 	}
 }
+
+void raw_object_store_clear(struct raw_object_store *o)
+{
+	free(o->objectdir);
+}
diff --git a/path.c b/path.c
index da8b655730..81a42d9115 100644
--- a/path.c
+++ b/path.c
@@ -382,7 +382,7 @@ static void adjust_git_path(const struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objectdir);
+		replace_dir(buf, git_dir_len + 7, repo->objects.objectdir);
 	else if (git_hooks_path && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, git_hooks_path);
 	else if (repo->different_commondir)
diff --git a/repository.c b/repository.c
index 4ffbe9bc94..3b8f1b91be 100644
--- a/repository.c
+++ b/repository.c
@@ -1,11 +1,18 @@
 #include "cache.h"
 #include "repository.h"
+#include "object-store.h"
 #include "config.h"
 #include "submodule-config.h"
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
+	NULL, NULL,
+	RAW_OBJECT_STORE_INIT,
+	NULL, NULL, NULL,
+	NULL, NULL, NULL,
+	&the_index,
+	&hash_algos[GIT_HASH_SHA1],
+	0, 0
 };
 struct repository *the_repository = &the_repo;
 
@@ -42,9 +49,11 @@ static void repo_setup_env(struct repository *repo)
 						    !repo->ignore_env);
 	free(repo->commondir);
 	repo->commondir = strbuf_detach(&sb, NULL);
-	free(repo->objectdir);
-	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
+	free(repo->objects.objectdir);
+	repo->objects.objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
 					    "objects", !repo->ignore_env);
+	repo->objects.ignore_env = repo->ignore_env;
+
 	free(repo->graft_file);
 	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
 					     "info/grafts", !repo->ignore_env);
@@ -209,12 +218,14 @@ void repo_clear(struct repository *repo)
 {
 	FREE_AND_NULL(repo->gitdir);
 	FREE_AND_NULL(repo->commondir);
-	FREE_AND_NULL(repo->objectdir);
 	FREE_AND_NULL(repo->graft_file);
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
 
+	raw_object_store_clear(&repo->objects);
+	memset(&repo->objects, 0, sizeof(repo->objects));
+
 	if (repo->config) {
 		git_configset_clear(repo->config);
 		FREE_AND_NULL(repo->config);
diff --git a/repository.h b/repository.h
index 0329e40c7f..1f8bc7a7cf 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,8 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
+#include "object-store.h"
+
 struct config_set;
 struct index_state;
 struct submodule_cache;
@@ -21,10 +23,9 @@ struct repository {
 	char *commondir;
 
 	/*
-	 * Path to the repository's object store.
-	 * Cannot be NULL after initialization.
+	 * Holds any information related to the object store.
 	 */
-	char *objectdir;
+	struct raw_object_store objects;
 
 	/*
 	 * Path to the repository's graft file.
-- 
2.16.1.291.g4437f3f132-goog

