Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9205E20281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbdI2UNA (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:13:00 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:49983 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdI2UMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:20 -0400
Received: by mail-pf0-f175.google.com with SMTP id l188so335041pfc.6
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bnLErNjLIh46k4mLkH2JKwd762MONVgOOl6ytNlgB/c=;
        b=DAIaGGqs5haSJV4a4QeLFhDnMSoQxRVHkEC6+/gVYUWkmUAW8i2WJo97u/15PIWfdz
         +uc4bgwhZLlDsc9WEp7ZN/mgDQbyaGLZDrp+2EqidjhrZYOZb50JtcnNNFgLfoTXiHV6
         EOjomXOl+N3mlML/nFuLY/XDonHar8b0aYrsgPEhMjMq/L6x6h0qQTbxIRtbbY0VAu70
         U5cs9EEPDelCxA0mUcfArtBkSo8tEf0RA6olNT7JPHRB2dWPQm8PSaeeKAovY5Uv5qCR
         rBHz+B3ivWpWMRT+ez0/zTSOS3CZzjJ7SnGUXPnNk5dX3Vfjf0VCU+/l36gNrFO63zUs
         nnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bnLErNjLIh46k4mLkH2JKwd762MONVgOOl6ytNlgB/c=;
        b=RV91ziZmS3Fdjcip3oLBHULRDWAavyaICKz9qU8/WIrNw2LuE/tYfa4cSldbeMlD1A
         esUFbwLrO+AJ0OzV7BPKoSrBtH2rIzMR63QjwJluVM2Dv1Tts5drOWjRM408GKA0Eksu
         PNfMBTF3nMtWNVSaabYjXLV/8whvnARwDz1l1416MkWp9KxsGLmO1t+NTq1osn4AJ9Fu
         v38rPp6iROfauFoJx+FFpf7QO8y0656rS93P+nXFs1gVbOVfdvwcZlInZFImaqYW1tbk
         Ndt8d6B+AYCsDXIHr7hy90/as5eV9K3ouu2hS5QmpnYLCpT/d+A9jDg6msR9pz9dL2vM
         lRsw==
X-Gm-Message-State: AHPjjUj43DPSPR1d46amJZD0wPufgDbkPnYpPMYSN5kbgDxrhNk1CKiJ
        RWEXZgqYnCXbWmDBWQNxAQvhRmH0/jk=
X-Google-Smtp-Source: AOwi7QBpswGC/eF1VbE4yg7ZowfZiI0UpYYB3s+QQTJDcm02tWXDcCStbR7rMOErquztTKRah6Msrw==
X-Received: by 10.98.28.210 with SMTP id c201mr8803801pfc.269.1506715939377;
        Fri, 29 Sep 2017 13:12:19 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 09/18] gc: do not repack promisor packfiles
Date:   Fri, 29 Sep 2017 13:11:45 -0700
Message-Id: <75be6a3b191753d14c5e10caf24ecf6926a7f544.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach gc to stop traversal at promisor objects, and to leave promisor
packfiles alone. This has the effect of only repacking non-promisor
packfiles, and preserves the distinction between promisor packfiles and
non-promisor packfiles.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/gc.c             |  3 +++
 builtin/pack-objects.c   | 10 ++++++++++
 builtin/prune.c          |  7 +++++++
 builtin/repack.c         |  7 +++++--
 t/t0410-partial-clone.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c22787ac7..7a9632bba 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -458,6 +458,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			argv_array_push(&prune, prune_expire);
 			if (quiet)
 				argv_array_push(&prune, "--no-progress");
+			if (repository_format_partial_clone)
+				argv_array_push(&prune,
+						"--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
 				return error(FAILED_RUN, prune.argv[0]);
 		}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a57b4f058..958822bf4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -73,6 +73,8 @@ static int use_bitmap_index = -1;
 static int write_bitmap_index;
 static uint16_t write_bitmap_options;
 
+static int exclude_promisor_objects;
+
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
 static unsigned long cache_max_small_delta_size = 1000;
@@ -2952,6 +2954,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
+			 N_("do not pack objects in promisor packfiles")),
 		OPT_END(),
 	};
 
@@ -2997,6 +3001,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		argv_array_push(&rp, "--unpacked");
 	}
 
+	if (exclude_promisor_objects) {
+		use_internal_rev_list = 1;
+		fetch_if_missing = 0;
+		argv_array_push(&rp, "--exclude-promisor-objects");
+	}
+
 	if (!reuse_object)
 		reuse_delta = 0;
 	if (pack_compression_level == -1)
diff --git a/builtin/prune.c b/builtin/prune.c
index cddabf26a..be34645dc 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -101,12 +101,15 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct progress *progress = NULL;
+	int exclude_promisor_objects = 0;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned objects")),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("expire objects older than <time>")),
+		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
+			 N_("limit traversal to objects outside promisor packfiles")),
 		OPT_END()
 	};
 	char *s;
@@ -139,6 +142,10 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		show_progress = isatty(2);
 	if (show_progress)
 		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	if (exclude_promisor_objects) {
+		fetch_if_missing = 0;
+		revs.exclude_promisor_objects = 1;
+	}
 
 	mark_reachable_objects(&revs, 1, expire, progress);
 	stop_progress(&progress);
diff --git a/builtin/repack.c b/builtin/repack.c
index f17a68a17..f43317bb5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -83,7 +83,8 @@ static void remove_pack_on_signal(int signo)
 
 /*
  * Adds all packs hex strings to the fname list, which do not
- * have a corresponding .keep file.
+ * have a corresponding .keep or .promisor file. These packs are not to
+ * be kept if we are going to pack everything into one file.
  */
 static void get_non_kept_pack_filenames(struct string_list *fname_list)
 {
@@ -101,7 +102,8 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 
 		fname = xmemdupz(e->d_name, len);
 
-		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
+		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)) &&
+		    !file_exists(mkpath("%s/%s.promisor", packdir, fname)))
 			string_list_append_nodup(fname_list, fname);
 		else
 			free(fname);
@@ -232,6 +234,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
 	argv_array_push(&cmd.args, "--indexed-objects");
+	argv_array_push(&cmd.args, "--exclude-promisor-objects");
 	if (window)
 		argv_array_pushf(&cmd.args, "--window=%s", window);
 	if (window_memory)
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 3ca6af5cd..071736c7b 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -11,13 +11,15 @@ delete_object () {
 pack_as_from_promisor () {
 	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
 	>repo/.git/objects/pack/pack-$HASH.promisor
+	echo $HASH
 }
 
 promise_and_delete () {
 	HASH=$(git -C repo rev-parse "$1") &&
 	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
 	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
-	git -C repo tag -d my_annotated_tag &&
+	# tag -d prints a message to stdout, so redirect it
+	git -C repo tag -d my_annotated_tag >/dev/null &&
 	delete_object repo "$HASH"
 }
 
@@ -261,6 +263,54 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
 '
 
+test_expect_success 'gc does not repack promisor objects' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
+	HASH=$(printf "$TREE_HASH\n" | pack_as_from_promisor) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo gc &&
+
+	# Ensure that the promisor packfile still exists, and remove it
+	test -e repo/.git/objects/pack/pack-$HASH.pack &&
+	rm repo/.git/objects/pack/pack-$HASH.* &&
+
+	# Ensure that the single other pack contains the commit, but not the tree
+	ls repo/.git/objects/pack/pack-*.pack >packlist &&
+	test_line_count = 1 packlist &&
+	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
+	grep "$(git -C repo rev-parse HEAD)" out &&
+	! grep "$TREE_HASH" out
+'
+
+test_expect_success 'gc stops traversal when a missing but promised object is reached' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
+	HASH=$(promise_and_delete $TREE_HASH) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo gc &&
+
+	# Ensure that the promisor packfile still exists, and remove it
+	test -e repo/.git/objects/pack/pack-$HASH.pack &&
+	rm repo/.git/objects/pack/pack-$HASH.* &&
+
+	# Ensure that the single other pack contains the commit, but not the tree
+	ls repo/.git/objects/pack/pack-*.pack >packlist &&
+	test_line_count = 1 packlist &&
+	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
+	grep "$(git -C repo rev-parse HEAD)" out &&
+	! grep "$TREE_HASH" out
+'
+
 LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
-- 
2.14.2.822.g60be5d43e6-goog

