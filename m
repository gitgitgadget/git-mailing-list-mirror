Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837748F7E
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGcNXFTD"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE45111
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 00:59:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo2749249a12.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 00:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698393574; x=1698998374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrPGQtSyMdjiYWI125DiYzRzuj11vFsRB9+IrNQKhZU=;
        b=JGcNXFTDBxO0gASJRgOXP6u0VMAUbWUhfNLyOqba31DWJXyQE2GxlZ3R2eCgsjrWDU
         C6usoMIq0SlhSBJpw7bookNxa2YO5WHjqmvaurIAatQzbWkF3EY9vnWMbdS6TCkPUx0t
         Akmy+0tEHsfKIkg2yBZa10/rEqEpuMHlH4dnwUk9tcOXF/6O05N6tdsUNpQtVslnwMSV
         nKTvvQL79JUpAe4U9uWHh7AWsos2xL7kRMQXxdRGcjCFVII6hv8Ec7KVRGpLiNzGnxIV
         3VVt0HxTaJxhCKMNt674cs+ET+kUT/+j5tjp4fyYDULno6aP5LFqNDwxXqyeA5nVApyQ
         IlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393574; x=1698998374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrPGQtSyMdjiYWI125DiYzRzuj11vFsRB9+IrNQKhZU=;
        b=S/0QITZ9N4iTnhZtb9noj/KJil50n7yGnCC1RKiBKojVQ73fBjFnRsQhfIwZ6T4tkl
         +TtrQSF2iX/QzXKgMkMJrlHoL035vfYdJqq6kv9B+uGquGxgz3O9CeWe/5D/gO+tPKny
         gT8rAzofOBZ5Kje2aGs9Aq3x4u1cjVh+bxb+cNYIO1E77KCowKTtKo6909NTj9reIBje
         SW7vyhvyvd+0ORwWiTp82p6gCsne/OKudOoPdgTM/mpB+o7i77P2dAtZmEk5FlKjl/pD
         NG1HBGXwmH29XESQYAX0QVgpILRy1nKkKuJR/OQFf4EdC37uu6UF1tHJkvaSFzNR9tg8
         FPTw==
X-Gm-Message-State: AOJu0YxFVt3r55oX1Pv3P3ZrI4HKdwNjdjfgs79tFw9VubW0I/LEGTbO
	U03Wq/oJhoo/Ey2+a9zz+84=
X-Google-Smtp-Source: AGHT+IEBy5hJTVYu0v9jniRBxUIyau1GMzB7mqohizl+ZMXZIL219K48GiBy8VjPK6oESBAs1MZ0mQ==
X-Received: by 2002:a17:907:9805:b0:9c6:6f65:def1 with SMTP id ji5-20020a170907980500b009c66f65def1mr1892586ejc.35.1698393573800;
        Fri, 27 Oct 2023 00:59:33 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:e163:7c75:d834:f7bc])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906a18900b009ae6a6451fdsm794180ejy.35.2023.10.27.00.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 00:59:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 3/3] rev-list: add commit object support in `--missing` option
Date: Fri, 27 Oct 2023 09:59:29 +0200
Message-ID: <20231027075929.181817-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ZTtXzg4NGJZzAqfS@tanuki>
References: <ZTtXzg4NGJZzAqfS@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--missing` object option in rev-list currently works only with
missing blobs/trees. For missing commits the revision walker fails with
a fatal error.

Let's extend the functionality of `--missing` option to also support
commit objects. This is done by adding a `missing_objects` field to
`rev_info`. This field is an `oidset` to which we'll add the missing
commits as we encounter them. The revision walker will now continue the
traversal and call `show_commit()` even for missing commits. In rev-list
we can then check if the commit is a missing commit and call the
existing code for parsing `--missing` objects.

A scenario where this option would be used is to find the boundary
objects between different object directories. Consider a repository with
a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
repository, using the `--missing=print` option while disabling the
alternate object directory allows us to find the boundary objects
between the main and alternate object directory.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/rev-list.c          |  6 +++
 list-objects.c              |  3 ++
 revision.c                  | 16 +++++++-
 revision.h                  |  4 ++
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100755 t/t6022-rev-list-missing.sh

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 98542e8b3c..181353dcf5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -149,6 +149,12 @@ static void show_commit(struct commit *commit, void *data)
 
 	display_progress(progress, ++progress_counter);
 
+	if (revs->do_not_die_on_missing_objects &&
+	    oidset_contains(&revs->missing_commits, &commit->object.oid)) {
+		finish_object__ma(&commit->object);
+		return;
+	}
+
 	if (show_disk_usage)
 		total_disk_usage += get_object_disk_usage(&commit->object);
 
diff --git a/list-objects.c b/list-objects.c
index 47296dff2f..f4e1104b56 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -389,6 +389,9 @@ static void do_traverse(struct traversal_context *ctx)
 		 */
 		if (!ctx->revs->tree_objects)
 			; /* do not bother loading tree */
+		else if (ctx->revs->do_not_die_on_missing_objects &&
+			 oidset_contains(&ctx->revs->missing_commits, &commit->object.oid))
+			;
 		else if (repo_get_commit_tree(the_repository, commit)) {
 			struct tree *tree = repo_get_commit_tree(the_repository,
 								 commit);
diff --git a/revision.c b/revision.c
index 219dc76716..00d5c29bfc 100644
--- a/revision.c
+++ b/revision.c
@@ -6,6 +6,7 @@
 #include "object-name.h"
 #include "object-file.h"
 #include "object-store-ll.h"
+#include "oidset.h"
 #include "tag.h"
 #include "blob.h"
 #include "tree.h"
@@ -1112,6 +1113,9 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 
 	if (commit->object.flags & ADDED)
 		return 0;
+	if (revs->do_not_die_on_missing_objects &&
+	    oidset_contains(&revs->missing_commits, &commit->object.oid))
+		return 0;
 	commit->object.flags |= ADDED;
 
 	if (revs->include_check &&
@@ -1168,7 +1172,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
 		int gently = revs->ignore_missing_links ||
-			     revs->exclude_promisor_objects;
+			     revs->exclude_promisor_objects ||
+			     revs->do_not_die_on_missing_objects;
 		if (repo_parse_commit_gently(revs->repo, p, gently) < 0) {
 			if (revs->exclude_promisor_objects &&
 			    is_promisor_object(&p->object.oid)) {
@@ -1176,7 +1181,11 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 					break;
 				continue;
 			}
-			return -1;
+
+			if (revs->do_not_die_on_missing_objects)
+				oidset_insert(&revs->missing_commits, &p->object.oid);
+			else
+				return -1; /* corrupt repository */
 		}
 		if (revs->sources) {
 			char **slot = revision_sources_at(revs->sources, p);
@@ -3109,6 +3118,7 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->merge_simplification, free);
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
+	oidset_clear(&revs->missing_commits);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -3800,6 +3810,8 @@ int prepare_revision_walk(struct rev_info *revs)
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
+	oidset_init(&revs->missing_commits, 0);
+
 	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);
 	if (!revs->unsorted_input)
diff --git a/revision.h b/revision.h
index c73c92ef40..94c43138bc 100644
--- a/revision.h
+++ b/revision.h
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "grep.h"
 #include "notes.h"
+#include "oidset.h"
 #include "pretty.h"
 #include "diff.h"
 #include "commit-slab-decl.h"
@@ -373,6 +374,9 @@ struct rev_info {
 
 	/* Location where temporary objects for remerge-diff are written. */
 	struct tmp_objdir *remerge_objdir;
+
+	/* Missing commits to be tracked without failing traversal. */
+	struct oidset missing_commits;
 };
 
 /**
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
new file mode 100755
index 0000000000..40265a4f66
--- /dev/null
+++ b/t/t6022-rev-list-missing.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='handling of missing objects in rev-list'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# We setup the repository with two commits, this way HEAD is always
+# available and we can hide commit 1.
+test_expect_success 'create repository and alternate directory' '
+	test_commit 1 &&
+	test_commit 2 &&
+	test_commit 3
+'
+
+for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+do
+	test_expect_success "rev-list --missing=error fails with missing object $obj" '
+		oid="$(git rev-parse $obj)" &&
+		path=".git/objects/$(test_oid_to_path $oid)" &&
+
+		mv "$path" "$path.hidden" &&
+		test_when_finished "mv $path.hidden $path" &&
+
+		test_must_fail git rev-list --missing=error --objects \
+			--no-object-names HEAD
+	'
+done
+
+for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+do
+	for action in "allow-any" "print"
+	do
+		test_expect_success "rev-list --missing=$action with missing $obj" '
+			oid="$(git rev-parse $obj)" &&
+			path=".git/objects/$(test_oid_to_path $oid)" &&
+
+			# Before the object is made missing, we use rev-list to
+			# get the expected oids.
+			git rev-list --objects --no-object-names \
+				HEAD ^$obj >expect.raw &&
+
+			# Blobs are shared by all commits, so evethough a commit/tree
+			# might be skipped, its blob must be accounted for.
+			if [ $obj != "HEAD:1.t" ]; then
+				echo $(git rev-parse HEAD:1.t) >>expect.raw &&
+				echo $(git rev-parse HEAD:2.t) >>expect.raw
+			fi &&
+
+			mv "$path" "$path.hidden" &&
+			test_when_finished "mv $path.hidden $path" &&
+
+			git rev-list --missing=$action --objects --no-object-names \
+				HEAD >actual.raw &&
+
+			# When the action is to print, we should also add the missing
+			# oid to the expect list.
+			case $action in
+			allow-any)
+				;;
+			print)
+				grep ?$oid actual.raw &&
+				echo ?$oid >>expect.raw
+				;;
+			esac &&
+
+			sort actual.raw >actual &&
+			sort expect.raw >expect &&
+			test_cmp expect actual
+		'
+	done
+done
+
+test_done
-- 
2.42.0

