Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D526E3B
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeRxXUp2"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A42122
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 05:26:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so652850866b.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698150400; x=1698755200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBZQXSTDLYO1AitBwOEQvQDj+mJ9HaUhQvq80UEnYbM=;
        b=UeRxXUp2JwUEZTH12IKornuN3sKJrK95y/lulkO2zYwilkkTmuo3JJnNx2FgtR3ntT
         It3bH+GAber8ZjUtUvMwje0tIqbGoBNqh16GOmv7VG37ojl/H3JRjJXovULThGRYB6w3
         +6oj+HI0ADCW7rGbefIdPujB8PT3yqQCXquSlkxtVmDs3gpw9B/6lvLOuxmX3/UE7dRW
         VryPcT5ZFwtcAP8BM+v/kD6XLhD5ZjtL3h3rF9XBDM/h0tEr1siCqWKicCVWB80afT/q
         WFuGk5P/6iqy15wC2ePskVQd4tNXd/73vUwkc+Fvh57E+pH+2AletaHv4Y+F9oJWkdn3
         BB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150400; x=1698755200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBZQXSTDLYO1AitBwOEQvQDj+mJ9HaUhQvq80UEnYbM=;
        b=Ve1jrzSbhAq8XreRF4dG2nE35ENTcXsDOnWQ5P1mqt+byNCwkkVedv6VjMjAWiiU7K
         StFCGXKJD7sTI21ikeRzAEoHR3Ckc8qD/owNA2eRRmg7GwN0Zxms5gByePIBt3OGcdUW
         Z558rbKPFxrEdhbjzZfYUoKqydc5spbG8wGFZFmy/GgBBfWRuM4FBwY9ODnPI6C6E2Bj
         Z/dtAL8tTBEHYUWQFkS/tV3gpIhnLWKmdS95UtKfpKxVwVkKpUCTxAv/p7vczY6+/x6O
         SpRMGljHNZjCSNKDoTs8GJuH+h5mRd13IJIVqw92Fshh7R2i+T0cxLd/RQ+nuLHbGlpt
         xR1A==
X-Gm-Message-State: AOJu0YxJTLk/DH8R+TUDFg80WsDEB8ObzvfUxQmhjYKvGyWQCbDc1xWC
	Qon13mNFWfZVe0KoyeGx1oDsQ6KcLVth2Q==
X-Google-Smtp-Source: AGHT+IFkRONJ23S5Qu2nLiAYKzOZv4iY0mYfOtmJrvhhuYI9EcEMEpkSycw6NLKBnHpF+2vjfiTKNA==
X-Received: by 2002:a17:907:94ce:b0:9bd:931e:30d8 with SMTP id dn14-20020a17090794ce00b009bd931e30d8mr9302665ejc.14.1698150399943;
        Tue, 24 Oct 2023 05:26:39 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:be13:9408:ebb5:e370])
        by smtp.gmail.com with ESMTPSA id jl24-20020a17090775d800b0099315454e76sm8102726ejc.211.2023.10.24.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:26:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 3/3] rev-list: add commit object support in `--missing` option
Date: Tue, 24 Oct 2023 14:26:31 +0200
Message-ID: <20231024122631.158415-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024122631.158415-1-karthik.188@gmail.com>
References: <20231019121024.194317-1-karthik.188@gmail.com>
 <20231024122631.158415-1-karthik.188@gmail.com>
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
index 98542e8b3c..37b52520b5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -149,6 +149,12 @@ static void show_commit(struct commit *commit, void *data)
 
 	display_progress(progress, ++progress_counter);
 
+	if (revs->do_not_die_on_missing_objects &&
+	    oidset_contains(&revs->missing_objects, &commit->object.oid)) {
+		finish_object__ma(&commit->object);
+		return;
+	}
+
 	if (show_disk_usage)
 		total_disk_usage += get_object_disk_usage(&commit->object);
 
diff --git a/list-objects.c b/list-objects.c
index 47296dff2f..260089388c 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -389,6 +389,9 @@ static void do_traverse(struct traversal_context *ctx)
 		 */
 		if (!ctx->revs->tree_objects)
 			; /* do not bother loading tree */
+		else if (ctx->revs->do_not_die_on_missing_objects &&
+			 oidset_contains(&ctx->revs->missing_objects, &commit->object.oid))
+			;
 		else if (repo_get_commit_tree(the_repository, commit)) {
 			struct tree *tree = repo_get_commit_tree(the_repository,
 								 commit);
diff --git a/revision.c b/revision.c
index 219dc76716..e60646c1a7 100644
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
+		oidset_contains(&revs->missing_objects, &commit->object.oid))
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
+			if (!revs->do_not_die_on_missing_objects)
+				return -1;
+			else
+				oidset_insert(&revs->missing_objects, &p->object.oid);
 		}
 		if (revs->sources) {
 			char **slot = revision_sources_at(revs->sources, p);
@@ -3800,6 +3809,9 @@ int prepare_revision_walk(struct rev_info *revs)
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
+	if (revs->do_not_die_on_missing_objects)
+		oidset_init(&revs->missing_objects, 0);
+
 	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);
 	if (!revs->unsorted_input)
diff --git a/revision.h b/revision.h
index c73c92ef40..f6bf422f0e 100644
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
+	/* Missing objects to be tracked without failing traversal. */
+	struct oidset missing_objects;
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

