Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71341F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdGaVC6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:02:58 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35098 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdGaVC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:02:56 -0400
Received: by mail-pg0-f44.google.com with SMTP id v189so13526961pgd.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=moBtJvdEi1g58ZaO0zxNmFVPMmU/X4hcTkISB2AsJ/s=;
        b=q5H33ZEWy1TN9ciUSHsnnDE2J4ej1HzYwBaMS+2jRQUHkr3uXKp/XLjjCEq5L9ofNJ
         LDWZQjcuyJ2LLmPfoM+XbBjHc+xkPiV46SJPrFjCsZ6xshGCZjCZiRv2SqOvJw/K4d8z
         YoDLmi17klZ2+c242JF29FP4X0mu5H5ekqd0VeQpybpbdn4jNVITwQ3fi5wcccIQCRbg
         9zJf6PD5vlAHByFaZTFGILJKzGqZ8DiFJKtIKG48bD5c2kZBr6H6CSV7bRxTRUNbemiP
         AuJW22HHUPs4utGoFH6MYGBUggfBZb32+DcJXlO0SXbMy4Lc1Dn/OMdMonJccTMOlkGX
         xKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=moBtJvdEi1g58ZaO0zxNmFVPMmU/X4hcTkISB2AsJ/s=;
        b=c4rPCr6gKu+CZhhwkeKVTezGh2GbDqbIwfOKS1J0F8SfkTDYfm5iD4ZRJJpqm5nm8p
         CqDrt1HsRsz6fXjG/A7tOaUwKmrQoY0+waumPQNyWtHNKq38d/lI09RohWCfCIPiW30a
         GoM6SNF+yLySC197no3k4eN+lKDjfxxcHnCHrKnDI0qzC5ne/D7mXb9T+c8f4DB6bT/1
         WcpaY6H8aftV/2vkmEmX6UDog89rDf0RrIjMN3yN1APZGqaixzn1yXJ2iMr32SMiwerc
         2Yj2UHbH5VPNx/Rn0UIflpVONd0LSUuWbQvV6s/Nxf65WJzTyWVExOT/kK1UGbkU8eEG
         SUJg==
X-Gm-Message-State: AIVw113hWqU+oD+DGg9gXaQ69HznGkoZN0YOguh2HOBM/U3P3emQz4fU
        5hCoSPC6BZZeK7phwEUang==
X-Received: by 10.99.107.3 with SMTP id g3mr17060146pgc.172.1501534975626;
        Mon, 31 Jul 2017 14:02:55 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k185sm53231673pgc.31.2017.07.31.14.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 14:02:54 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peartben@gmail.com, christian.couder@gmail.com
Subject: [PATCH v2 1/5] environment, fsck: introduce lazyobject extension
Date:   Mon, 31 Jul 2017 14:02:43 -0700
Message-Id: <ffb734d277132802bcc25baa13e8ede3490af62a.1501532294.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501532294.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com> <cover.1501532294.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git does not support repos with very large numbers of objects
or repos that wish to minimize manipulation of certain blobs (for
example, because they are very large) very well, even if the user
operates mostly on part of the repo, because Git is designed on the
assumption that every referenced object is available somewhere in the
repo storage.

Introduce a new repository extension option `extensions.lazyObject`.
When it is set, Git does not treat missing objects as errors. The value
of `extensions.lazyObject` must be a string, naming the command used to
make a missing object appear whenever it is needed.

Teach fsck about the new state of affairs. In this commit, teach fsck
that missing objects referenced from the reflog are not an error case;
in future commits, fsck will be taught about other cases.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/repository-version.txt |  7 ++++++
 builtin/fsck.c                                 |  2 +-
 cache.h                                        |  2 ++
 environment.c                                  |  1 +
 setup.c                                        |  7 +++++-
 t/t0410-lazy-object.sh                         | 32 ++++++++++++++++++++++++++
 6 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100755 t/t0410-lazy-object.sh

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad37986..f0482cae4 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,10 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`lazyObject`
+~~~~~~~~~~~~~~~~~
+
+When the config key `extensions.lazyObject` is set, Git does not treat missing
+objects as errors. The value of `extensions.lazyObject` must be a string,
+naming the command used to make a missing object appear whenever it is needed.
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a92f44818..b7e245654 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -402,7 +402,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
 			obj->flags |= USED;
 			mark_object_reachable(obj);
-		} else {
+		} else if (!repository_format_lazy_object) {
 			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
 		}
diff --git a/cache.h b/cache.h
index 6c8242340..9e6bc0a21 100644
--- a/cache.h
+++ b/cache.h
@@ -853,10 +853,12 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
+extern char *repository_format_lazy_object;
 
 struct repository_format {
 	int version;
 	int precious_objects;
+	char *lazy_object;
 	int is_bare;
 	char *work_tree;
 	struct string_list unknown_extensions;
diff --git a/environment.c b/environment.c
index 3fd4b1084..cd8ef2897 100644
--- a/environment.c
+++ b/environment.c
@@ -27,6 +27,7 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
+char *repository_format_lazy_object;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/setup.c b/setup.c
index 860507e1f..94cfde3cc 100644
--- a/setup.c
+++ b/setup.c
@@ -425,7 +425,11 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
-		else
+		else if (!strcmp(ext, "lazyobject")) {
+			if (!value)
+				return config_error_nonbool(var);
+			data->lazy_object = xstrdup(value);
+		} else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
 		data->is_bare = git_config_bool(var, value);
@@ -468,6 +472,7 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	}
 
 	repository_format_precious_objects = candidate.precious_objects;
+	repository_format_lazy_object = candidate.lazy_object;
 	string_list_clear(&candidate.unknown_extensions, 0);
 	if (!has_common) {
 		if (candidate.is_bare != -1) {
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
new file mode 100755
index 000000000..36442531f
--- /dev/null
+++ b/t/t0410-lazy-object.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='lazy object'
+
+. ./test-lib.sh
+
+delete_object () {
+	rm $1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40)
+}
+
+test_expect_success 'fsck fails on lazy object in reflog' '
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch mybranch "$A" &&
+	git -C repo branch -f mybranch "$B" &&
+	delete_object repo "$A" &&
+
+	test_must_fail git -C repo fsck
+'
+
+test_expect_success '...but succeeds if lazyobject is set' '
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_done
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

