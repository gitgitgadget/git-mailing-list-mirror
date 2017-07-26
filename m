Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A712047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbdGZXaJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:30:09 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35136 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdGZXaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 19:30:08 -0400
Received: by mail-pg0-f50.google.com with SMTP id v190so90189109pgv.2
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=plLgZHQv/F3WeeDoSFDM5OzsEOLntA2i/MHYbVnPvoo=;
        b=DNMw8rXurUNCq4B0vshUe4engET7Poo542FYz0OG9pk06S8CCNDtdrWvYOPlJcgvyS
         1Q5Pdu48ZNtveJk5pQIzGsDTc9AuiSALwE9/KzHP8hJU2+0CzXWYuc7ehjitEfnpA7UP
         FHAWjS0Ya4+PDBk9TORW6WW4at70HYbcB83gBbryXHt9iGsibi52HHjzrT8xBcIGgc1q
         FIsbciPfZDH2W2d9qX9YRaLRns52m8kBL+pnmUiUxH47DLU7tPKPtBx62VSzZumeCFoy
         k1TsStQ8U2LuODNwMR60qnTtHOac5lKyTDxbTWQDywn0V71twhFBJ9/RXmXidlP5a3Gw
         Mshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=plLgZHQv/F3WeeDoSFDM5OzsEOLntA2i/MHYbVnPvoo=;
        b=QkCBr4IWQk/kVNHTEECN/UsbL6qpH1k1MoGPY9q2s95gNCe4Q7NDf+a6a8Co0b+XCY
         2lI6qSWNNq3gdrkmzRTJAppJxzJxBWQFxIFlrJ1DzYTGSfNfGuLi9iB120lVWDNU4QSW
         EE5Y2sKLZbsQLiFcpisFq1JmgUNggLb5aE5DljCwk06gfsA0V8IPdHvNYMccVCdSU5by
         3jfXy9DV7SAVPraLkSXFZ/RwVd5YkvYwJsYKFOur1BbXEFyOXOdQ6+Ol4OnZjAxna8nu
         AaLbldM4MlmH3XyMxq0KfaGaEXDI3oJd5KDEamc5Rq4hKsg7iZr9SVzFtER0Po5S1lSu
         9BPQ==
X-Gm-Message-State: AIVw110mjchmS5fe6k+b3upkDjACTexkGaqO3amJnBX21rJtxNK5vMJs
        LTIENt2GUvxUw9jpcfZXHQ==
X-Received: by 10.101.85.79 with SMTP id t15mr2258896pgr.95.1501111807170;
        Wed, 26 Jul 2017 16:30:07 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e131sm299668pfc.93.2017.07.26.16.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 16:30:06 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [RFC PATCH 1/4] environment, fsck: introduce lazyobject extension
Date:   Wed, 26 Jul 2017 16:29:59 -0700
Message-Id: <75766ee26264e50b7fcb3c7a8cc5808907586799.1501111615.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
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

Introduce a new repository extension option "extensions.lazyobject", of
data type string. If this is set in a repository, Git will tolerate
objects being missing in that repository.  When Git needs those objects,
it will invoke the command in that option.

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
index 00ad37986..39e362543 100644
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
+When the config key `extensions.lazyObject` is set to a string, Git
+tolerates objects being missing in the repository. This string contains
+the command to be run whenever a missing object is needed.
diff --git a/builtin/fsck.c b/builtin/fsck.c
index fb0947009..1cfb8d98c 100644
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
2.14.0.rc0.400.g1c36432dff-goog

