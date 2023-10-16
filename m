Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98350224FB
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMYLZs5e"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AF0E8
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:38:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso305122466b.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697452724; x=1698057524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86imHDVmdTpFlF6Ru4qRiI5dVgFaPxgnx/oYtQjs1Vw=;
        b=fMYLZs5eY/gsqE1d80r70ySEER6b9MVPvuoXxeALRpQyNgedhGeojsArBzDaiweQGd
         J3DuVTLWSPWjeWd+86SphqHmAM9aW57+DmCFFGDUmXasz6+6zoLex3z3W1MK+cjrsZxV
         eygPkpCWgu05u91IwOBInpeWze9Feuxd1Aq/Gu/BnQOAEOdZyWlXt9MRGCkkhSJ6jhG6
         xVOmWodmpehwNfGtzNrpuEbXs51JNskMYTeICW5rp3dcKjESmApI9O/J5FOO9wQngisn
         URh6D769fuel6LRK2rha9OPBmdxU31fxp+BHnfgjJzXPQOc8LBFuUPuxguDmvzSnuy/M
         Mj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452724; x=1698057524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86imHDVmdTpFlF6Ru4qRiI5dVgFaPxgnx/oYtQjs1Vw=;
        b=J3hx0xvsmufeLDnlEV1eH7E5tMvD9jHO+SH2VdfRcgMQ7oCEc7Abn6YqeQrvZ1I88c
         YmF58YIqnbXVoPNqaTMk8e3LzTV+o8w/RnxVReAwc4y7hZQkKnJPfeBxlbEi7tRPYVnJ
         6Tfi1LrBpfYNMeBf5mSGqpo1rE0mRfXIBaeALWBjlJbkEus2boXll8vUIHrZ4MMtfgxv
         EpONFFFKJlm4lN60ahQ7OUtgErQKJiyOtJTbPkxr4STptvGN5xjQ36E3RI9+R/ZZtaYR
         iA3N0b2xsCKp3nqJp4EyAZqyl9bEDzz+2ddenrGLUSOdQAPuNEgxjbtgvLneB/wKf3uX
         T37A==
X-Gm-Message-State: AOJu0YyK5BdLPrfIsbGLwWEkrEx++IpMSF0xHR3jQrwienCoDsVV10Rc
	jMJLXz1/EB+ay+BKGLjo3dk=
X-Google-Smtp-Source: AGHT+IGDU6nrBMmTQR6Lh4GPpaQb0BLWW8NUZVnL58ay6mBDQFmXJMULQvPf4WtWYs4wlldixy0vUg==
X-Received: by 2002:a17:907:31c2:b0:9be:30c2:b8ff with SMTP id xf2-20020a17090731c200b009be30c2b8ffmr6594077ejb.61.1697452723926;
        Mon, 16 Oct 2023 03:38:43 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:b15b:356c:2a07:7b52])
        by smtp.gmail.com with ESMTPSA id jx17-20020a170907761100b009ad875d12d7sm3784390ejc.210.2023.10.16.03.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:38:43 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 3/3] rev-list: add commit object support in `--missing` option
Date: Mon, 16 Oct 2023 12:38:30 +0200
Message-ID: <20231016103830.56486-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016103830.56486-1-karthik.188@gmail.com>
References: <20231009105528.17777-1-karthik.188@gmail.com>
 <20231016103830.56486-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The `--missing` object option in rev-list currently works only with
missing blobs/trees. For missing commits the revision walker fails with
a fatal error.

Let's extend the functionality of `--missing` option to also support
commit objects. This is done by adding a new `MISSING` flag that the
revision walker sets whenever it encounters a missing tree/commit. The
revision walker will now continue the traversal and call `show_commit()`
even for missing commits. In rev-list we can then check for this flag
and call the existing code for parsing `--missing` objects.

A scenario where this option would be used is to find the boundary
objects between different object directories. Consider a repository with
a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
repository, using the `--missing=print` option while disabling the
alternate object directory allows us to find the boundary objects
between the main and alternate object directory.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/rev-list.c          |  6 +++
 list-objects.c              |  2 +-
 object.h                    |  2 +-
 revision.c                  | 11 ++++--
 revision.h                  |  3 ++
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++++++++++
 6 files changed, 93 insertions(+), 5 deletions(-)
 create mode 100755 t/t6022-rev-list-missing.sh

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 98542e8b3c..604ae01d0c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -149,6 +149,12 @@ static void show_commit(struct commit *commit, void *data)
 
 	display_progress(progress, ++progress_counter);
 
+	if (revs->do_not_die_on_missing_objects &&
+	    commit->object.flags & MISSING) {
+		finish_object__ma(&commit->object);
+		return;
+	}
+
 	if (show_disk_usage)
 		total_disk_usage += get_object_disk_usage(&commit->object);
 
diff --git a/list-objects.c b/list-objects.c
index 47296dff2f..60c5533721 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -387,7 +387,7 @@ static void do_traverse(struct traversal_context *ctx)
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
-		if (!ctx->revs->tree_objects)
+		if (!ctx->revs->tree_objects || commit->object.flags & MISSING)
 			; /* do not bother loading tree */
 		else if (repo_get_commit_tree(the_repository, commit)) {
 			struct tree *tree = repo_get_commit_tree(the_repository,
diff --git a/object.h b/object.h
index 114d45954d..12913e6116 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15             22------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
diff --git a/revision.c b/revision.c
index e789834dd1..d147e0f611 100644
--- a/revision.c
+++ b/revision.c
@@ -1110,7 +1110,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 	struct commit_list *parent = commit->parents;
 	unsigned pass_flags;
 
-	if (commit->object.flags & ADDED)
+	if (commit->object.flags & ADDED || commit->object.flags & MISSING)
 		return 0;
 	commit->object.flags |= ADDED;
 
@@ -1168,7 +1168,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
 		int gently = revs->ignore_missing_links ||
-			     revs->exclude_promisor_objects;
+			     revs->exclude_promisor_objects ||
+			     revs->do_not_die_on_missing_objects;
 		if (repo_parse_commit_gently(revs->repo, p, gently) < 0) {
 			if (revs->exclude_promisor_objects &&
 			    is_promisor_object(&p->object.oid)) {
@@ -1176,7 +1177,11 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 					break;
 				continue;
 			}
-			return -1;
+
+			if (!revs->do_not_die_on_missing_objects)
+				return -1;
+			else
+				p->object.flags |= MISSING;
 		}
 		if (revs->sources) {
 			char **slot = revision_sources_at(revs->sources, p);
diff --git a/revision.h b/revision.h
index c73c92ef40..07906bc3bc 100644
--- a/revision.h
+++ b/revision.h
@@ -41,6 +41,9 @@
 /* WARNING: This is also used as REACHABLE in commit-graph.c. */
 #define PULL_MERGE	(1u<<15)
 
+/* WARNING: This is also used as NEEDS_BITMAP in pack-bitmap.c. */
+#define MISSING         (1u<<22)
+
 #define TOPO_WALK_EXPLORED	(1u<<23)
 #define TOPO_WALK_INDEGREE	(1u<<24)
 
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
2.41.0

