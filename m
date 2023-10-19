Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0120309
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXNVmygP"
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA611705
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:10:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so1296270066b.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697717431; x=1698322231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VViLECbZQZYHOeMi49bgWHX8CBSBKuxlCamKFWqk9v0=;
        b=EXNVmygP5xiLHurCW11rUZUJOoETdHRPEQkSzPTOUs6ZmoJLvOernT3E8ay8EAP4f0
         dc0S/NYZVsbJDarvMoInqiKTiUETVWCynAPPQtBfz8Z3mENXPYxP2RA/So4DQTPHFwqj
         2JhcGkix9eAVCYpgOoQhE68yNW4B27Db/deYQlHdy36BABsco4bnzWcx+Y12j/EIIuru
         TPEWwKXtrDF+ajEaEeA/JZE7I/gRq/MGR2a7b1l8zUqSRGc9ppQFoe6O7Y4L42pKDKrg
         c18ncVWBmh58fel0DhejjMLszXNPVIjEsIXe9NSqsqkqxQbMRkQZnxrr87Ivyuj1g3dH
         n9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697717431; x=1698322231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VViLECbZQZYHOeMi49bgWHX8CBSBKuxlCamKFWqk9v0=;
        b=uLfbhBwNB9o2XUUZzgzLOxhRPPKOxy4HIrwgp/Yh1HWdJhgi2OpKx1qGoI9bnLtmrC
         u3X+CR4yappeUU15I1WULADn9W7FkSoiZkziTmnfDgI66EUFcSJT6XBWfaFqbnGIyHAQ
         CSqL/EaNRnEHoLmi/bPEK/Zepz6P8d83BPRyymE/bo4r20xW72NSBNlW14Ax/AytZfL+
         YQndujjnX/fwzE++1gws3aif5LtYgg/ikNDQcMRmj/x6P4jjsFIa6F7D7gHdPBtQbOCr
         GhivGct4D0B01PzBvwgrVWz4L9xQrCVVki3daUbxrG0+12sPBPwxAor2ylQJJe2Jlyxv
         4VGg==
X-Gm-Message-State: AOJu0Yx6W/DgHj0GtdoKiZqSef/KSFj0IRYDTpExO1JvmQ0Li+uAknAe
	bnWXfqaY6C3bL2/edY4lHMQ=
X-Google-Smtp-Source: AGHT+IGTHzrTSu2vzMWNVRH9wjAfGNfAo8jt0VnhFajAf0T0lyoM4IgPnOio9V3WlRLZQwJ9wjuv+w==
X-Received: by 2002:a17:907:2d0f:b0:9c3:b3cb:29b8 with SMTP id gs15-20020a1709072d0f00b009c3b3cb29b8mr1868527ejc.0.1697717430651;
        Thu, 19 Oct 2023 05:10:30 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:d5ee:6231:6f45:fa9b])
        by smtp.gmail.com with ESMTPSA id oz6-20020a170906cd0600b0099ddc81903asm3469212ejb.221.2023.10.19.05.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:10:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 3/3] rev-list: add commit object support in `--missing` option
Date: Thu, 19 Oct 2023 14:10:24 +0200
Message-ID: <20231019121024.194317-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019121024.194317-1-karthik.188@gmail.com>
References: <20231016103830.56486-1-karthik.188@gmail.com>
 <20231019121024.194317-1-karthik.188@gmail.com>
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
 object.h                    |  4 +-
 revision.c                  | 11 ++++--
 revision.h                  |  2 +
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++++++++++
 6 files changed, 93 insertions(+), 6 deletions(-)
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
index 114d45954d..b76830fce1 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15             22------28
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
@@ -82,7 +82,7 @@ void object_array_init(struct object_array *array);
  * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
  */
-#define FLAG_BITS  28
+#define FLAG_BITS  29
 
 #define TYPE_BITS 3
 
diff --git a/revision.c b/revision.c
index 219dc76716..8100806068 100644
--- a/revision.c
+++ b/revision.c
@@ -1110,7 +1110,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 	struct commit_list *parent = commit->parents;
 	unsigned pass_flags;
 
-	if (commit->object.flags & ADDED)
+	if (commit->object.flags & (ADDED | MISSING))
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
index c73c92ef40..d3c1ca0f4e 100644
--- a/revision.h
+++ b/revision.h
@@ -53,6 +53,8 @@
 #define ANCESTRY_PATH	(1u<<27)
 #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PULL_MERGE)
 
+#define MISSING (1u<<28)
+
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
 
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

