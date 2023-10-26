Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC82D035
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsT5NtIA"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE9E199
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:11:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so1028160a12.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698315078; x=1698919878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw4eL4pZl2JC2fGSO8prTOg3Z+MMbr2ebm7wPd0jjV4=;
        b=HsT5NtIAY3QmxyQx1pTJVBr2a2hSCgLAWQotYEMoOXGZNL692iH41Y6n8Js7tnWGYd
         2OwSZPmO6buRw7mbfpBumf1aDz+NPqsmpCfbv3FlV90d13F8DvLRmDSkwnNrPKINsRZs
         lyGntucjnkNiN2aMmtVJGScGMjbuUOqcrxGSZ2ysmYAAP3IHfWEZ6603ORITuCViOArt
         1pqmCoI+WA5SAF0ndBO45J9VqlqT6cPk7+3l5qMCYSZs/HKVUcg40Y5uKDW6uda9w83a
         wv2mQKGCAgHyqjrq5itpnbK+A5why6hRSFjNdOuFa7+OOM6bKkVd9VkhfVZLS9fJcJId
         4wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315078; x=1698919878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yw4eL4pZl2JC2fGSO8prTOg3Z+MMbr2ebm7wPd0jjV4=;
        b=bdd0BIoWCgSpKem1kD/1Y0DYPBHJP1mkrYCkWsWbljsQBnKMsvaj8VlMV7xR1AEPqH
         x7tmmfD2ej6gB1zKFAg3ZQDU6hYVMmtz8oHS5UlgSV6LAS3r9TRlB/n4Bev7tavRJqVQ
         +OLAYOlxpqSkqEMlYuurLaf3qCrRLIJGAQNZ1NFqLxK6fLwNab4UecWcEV649vR+7OCO
         pQOEgq8GQyjRWFS+lZMhh5hsUG1MNX7HfMHDtjGBzSbj1obkv8yncT6xH65CDy4LFZjB
         iuumn8vqdDqr1+RKNCMfCfqVnuqe08zCQUD3v8Vt9kIIoNijYZn4+qfLr4pnguiM05nG
         h5Ww==
X-Gm-Message-State: AOJu0YwMP1ya0J2PwcUYzvxMZoLssN0zYWWFC+R1kNJN+83Uza6v1Lwt
	tJTd31Jm6jfDz0dBzcDAhOKnV0Y6vRow+g==
X-Google-Smtp-Source: AGHT+IE2CSFLqqmMPNS9srQTfQA51KCK+VeUkGnJOLCP3T4+pw/CYhY3LuQq+Kk2l97vFp9Ct3cgqQ==
X-Received: by 2002:a17:907:26c2:b0:9ae:6ffd:bdf7 with SMTP id bp2-20020a17090726c200b009ae6ffdbdf7mr13636198ejc.39.1698315077626;
        Thu, 26 Oct 2023 03:11:17 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:561:c52d:5ce2:b147])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709065fcf00b00997d7aa59fasm11635390ejv.14.2023.10.26.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:11:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 3/3] rev-list: add commit object support in `--missing` option
Date: Thu, 26 Oct 2023 12:11:09 +0200
Message-ID: <20231026101109.43110-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026101109.43110-1-karthik.188@gmail.com>
References: <20231024122631.158415-1-karthik.188@gmail.com>
 <20231026101109.43110-1-karthik.188@gmail.com>
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
 revision.c                  | 17 ++++++++-
 revision.h                  |  4 ++
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 2 deletions(-)
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
index 219dc76716..738bacad08 100644
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
@@ -3800,6 +3810,9 @@ int prepare_revision_walk(struct rev_info *revs)
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
+	if (revs->do_not_die_on_missing_objects)
+		oidset_init(&revs->missing_commits, 0);
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

