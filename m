Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1598A1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeBUBym (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:54:42 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41906 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUByl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:41 -0500
Received: by mail-pg0-f67.google.com with SMTP id t4so58520pgp.8
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o/drtoAFOPbyykmpn+Vq54ocRtncjPlxI4WcHNa9+C0=;
        b=Ap1XD9MdC2rhXjYrowrKE2LYaXYMSr5nGY1lES8F/Il//QJ4bPjWbulbaYG7Sz3hZa
         T0k/fNmOeYqBt5ImwQlGacrr8jyYByPsmTVJ4f+d2isQFgXAJBGovBxKzpQX0ah7lhqF
         Vfi56d7DRvSACWVYIzR9oF9T5muZXmKdE8TWre1+QqFkNcQ6/Zy56sl22mwtu3Fq4K/I
         +HRyU2sJLdqFUG9/bGi2orknoS5NeHAHsQuy2KWgE+4seGG2ysaHeEiaSaqJMGqC08Ao
         OxA/ok0d9J3BzJDPVczkR3kT3puauNkH324YUKV1HRCINFxYoxS8T7VlziHeslQ5pQB/
         oxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o/drtoAFOPbyykmpn+Vq54ocRtncjPlxI4WcHNa9+C0=;
        b=PMF6KuqrNgpfHUiGfajdV0SUA1dSBFBVEJAWjD+qXyY629aw6Kg2Zt0+a7hfjmTsmv
         qPwDKVUK3apXD5Iv5ZNwYHNahaG45fYZE5WeL5y7x4Q9gOCF5ypeWdBWQJLCvaTxDiQk
         Pi7J+oBdMBOTL0M4qt7zBHyMBIZyh+XMjqwGd6xrZkHFQqkkOil7YJjujYSScjsriTZl
         ZW6IUmFcUlVDdz2UG+B1DNYM//81WHoG150BfxYAZpOJCEVQ4L7coOqAncMxoB4IWilc
         WXbi7YJzE166tqattT3OigqQ2xq4hThBwjd2VH01Fo/jRb+WXuP/61rvJlgR/beV9cYb
         LxnQ==
X-Gm-Message-State: APf1xPBztzxfHcxU6W4LU22NdoIcm/FBnx3jl7zzDqByhDEvpQigJJGo
        HKYmvOL6vYdmDmXZOH00huwd8g==
X-Google-Smtp-Source: AH8x227/zDiJ9xs2a6amVq0U0vCozd9fx0SWAwZsI0YBgnFZ85VWmdAod7pxa8nD9/vxxDx5oOxdPg==
X-Received: by 10.99.110.11 with SMTP id j11mr1335304pgc.294.1519178080581;
        Tue, 20 Feb 2018 17:54:40 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n17sm22270257pfj.67.2018.02.20.17.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/27] repository: introduce raw object store field
Date:   Tue, 20 Feb 2018 17:54:04 -0800
Message-Id: <20180221015430.96054-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The raw object store field will contain any objects needed for
access to objects in a given repository.

This patch introduces the raw object store and populates it with the
`objectdir`, which used to be part of the repository struct.

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
 object-store.h | 15 +++++++++++++++
 object.c       |  5 +++++
 path.c         |  2 +-
 repository.c   | 17 +++++++++++++----
 repository.h   |  7 ++++---
 7 files changed, 42 insertions(+), 11 deletions(-)
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
index 0000000000..cf35760ceb
--- /dev/null
+++ b/object-store.h
@@ -0,0 +1,15 @@
+#ifndef OBJECT_STORE_H
+#define OBJECT_STORE_H
+
+struct raw_object_store {
+	/*
+	 * Path to the repository's object store.
+	 * Cannot be NULL after initialization.
+	 */
+	char *objectdir;
+};
+#define RAW_OBJECT_STORE_INIT { NULL }
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
index 4ffbe9bc94..2255ff657e 100644
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
 
@@ -42,8 +49,8 @@ static void repo_setup_env(struct repository *repo)
 						    !repo->ignore_env);
 	free(repo->commondir);
 	repo->commondir = strbuf_detach(&sb, NULL);
-	free(repo->objectdir);
-	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
+	free(repo->objects.objectdir);
+	repo->objects.objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
 					    "objects", !repo->ignore_env);
 	free(repo->graft_file);
 	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
@@ -209,12 +216,14 @@ void repo_clear(struct repository *repo)
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

