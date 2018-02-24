Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69811F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeBXAsC (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:02 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33777 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeBXAsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:01 -0500
Received: by mail-pf0-f196.google.com with SMTP id q13so4193924pff.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fO6ZVhE+FszAEbkxUhDsmdtJmjAny0MYQBmnEzbgWss=;
        b=jO1Fq1JO01M3u/NQKb2oQNPFEDGvwrSAYDqTDev6L5ZNKp3bhBLuUp3aMnw4NkextB
         RRXgqhHIG2G8P8AlJn/q1WDFw7Vo4VDhtxcOOzQeWdIguqiFzBGyX0/Z8WoQdqlbq0nQ
         f05HEQIoKOnqVUL9y50r8ZEljqxal1AcaZJZgFFkw3mrCV6/3gokQinBytAy1ZGqjBEE
         qfmiuKMlU2qcJvHGXwoXqqDkYh+1810+rhwa5HN+TpXT+RbBIbtm2zc8oAEsZ70R2Yq+
         G9jv93Zltj57P+T+jnui+KVr4wREr3FyPakV35YWRw6qlvfhv6ww43eD7HzCrV9tbmYP
         YDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fO6ZVhE+FszAEbkxUhDsmdtJmjAny0MYQBmnEzbgWss=;
        b=kpdm+nEc82ELnb+YLv+qIt7+7SFE5xAiRjs2KWeKvgAOcHhOgm1qEgsrPFxbfAwsMQ
         wVGrB9nfe66ksFflw5NY/VejtamUm9qkisSZoo6XMyX5CRcsfNICxzixW5xKOUIWA5v0
         eXtHzhdDBIxL9zDHfPGErPWF77KzloSV/Z3EUchfNCjEZ1CgTOnWRSvWGcFsyD8TlWWg
         bnJIvhFMSSA7YkAt6GqJPRb4Uo9NHq0kIVwyRxSgJS5nOndmltyFAGQoHS7VCKtM85r2
         nr8wzN229HYtU2kU4PBRXTO8veae4zwX1arMi0Uec6CR9Xu69n+yD5Ko+S3NjFVnjJJV
         hL9Q==
X-Gm-Message-State: APf1xPDUQcg9s/VsSwYIzWf7lyZtuouE6ymf1ElyMwVnt0vkxueoAQel
        aI+gRzIPlmcHTW2RFG/ydOnYHA==
X-Google-Smtp-Source: AH8x225QBE8UJ8t0/nOl0B5oRBIncfpuS/0LX0RxCCG9QdMJFLJ50DR0pfJ9lz5neRE112OMDFGMFg==
X-Received: by 10.101.76.204 with SMTP id n12mr2789869pgt.249.1519433280522;
        Fri, 23 Feb 2018 16:48:00 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n67sm7173508pfh.150.2018.02.23.16.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:47:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 01/27] repository: introduce raw object store field
Date:   Fri, 23 Feb 2018 16:47:28 -0800
Message-Id: <20180224004754.129721-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
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
 repository.c   | 19 ++++++++++++++-----
 repository.h   |  7 ++++---
 7 files changed, 43 insertions(+), 12 deletions(-)
 create mode 100644 object-store.h

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d8c..0f0c195705f 100644
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
index de8431e01e7..ec10b062e68 100644
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
index 00000000000..cf35760ceb6
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
index 9e6f9ff20b0..a2acdee1405 100644
--- a/object.c
+++ b/object.c
@@ -445,3 +445,8 @@ void clear_commit_marks_all(unsigned int flags)
 			obj->flags &= ~flags;
 	}
 }
+
+void raw_object_store_clear(struct raw_object_store *o)
+{
+	FREE_AND_NULL(o->objectdir);
+}
diff --git a/path.c b/path.c
index da8b655730d..81a42d91155 100644
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
index 4ffbe9bc94e..fb65e8072d5 100644
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
 
@@ -42,9 +49,10 @@ static void repo_setup_env(struct repository *repo)
 						    !repo->ignore_env);
 	free(repo->commondir);
 	repo->commondir = strbuf_detach(&sb, NULL);
-	free(repo->objectdir);
-	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
-					    "objects", !repo->ignore_env);
+	raw_object_store_clear(&repo->objects);
+	repo->objects.objectdir =
+		git_path_from_env(DB_ENVIRONMENT, repo->commondir,
+				  "objects", !repo->ignore_env);
 	free(repo->graft_file);
 	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
 					     "info/grafts", !repo->ignore_env);
@@ -209,12 +217,13 @@ void repo_clear(struct repository *repo)
 {
 	FREE_AND_NULL(repo->gitdir);
 	FREE_AND_NULL(repo->commondir);
-	FREE_AND_NULL(repo->objectdir);
 	FREE_AND_NULL(repo->graft_file);
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
 
+	raw_object_store_clear(&repo->objects);
+
 	if (repo->config) {
 		git_configset_clear(repo->config);
 		FREE_AND_NULL(repo->config);
diff --git a/repository.h b/repository.h
index 0329e40c7f5..fa73ab8e938 100644
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
+	 * Holds any information related to accessing the raw object content.
 	 */
-	char *objectdir;
+	struct raw_object_store objects;
 
 	/*
 	 * Path to the repository's graft file.
-- 
2.16.1.291.g4437f3f132-goog

