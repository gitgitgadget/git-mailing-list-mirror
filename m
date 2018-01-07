Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 926AE1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754483AbeAGSPu (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:50 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44244 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754392AbeAGSPP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:15 -0500
Received: by mail-qk0-f194.google.com with SMTP id v188so11712432qkh.11
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tNK7Wn47kPsF1SL9GKeBlkWnLCQCZFzLeM3XYGbaGBI=;
        b=kKLHttN+TRtrYvsbvOa2iAovOA1sFqD5/OJ08Grbb+sguRB/GIg5ShRSnddIRl7lRg
         36/vvyRMdsPejSC1cDgKAKKtn+QxGcI/P9ef1BOImUr1KOk7Am9z0vBteliCkKOTvEvv
         E1k23hA3s8tRAcHcZHkXuP+/HfODXO9HvO6EPhAjx0DnFDt5UtBsQh91tAweVZMCOnS7
         z90Gl2Fa0qmqLbxzkPGC9YXp20tSxD/AcimM0wVYrFEh+2oqBneAYKx5vh0v52XczQwc
         VhNV06/Pdr4v3QFnThzNlk8+3AK3WQ6VfyLQp1CD1X4D+9jddXpyTu4Y3wY1fp3luAPN
         pkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tNK7Wn47kPsF1SL9GKeBlkWnLCQCZFzLeM3XYGbaGBI=;
        b=sRdboVUCQ21IgllDJTXa82eK2/4hFzR1eGTsYBgccrHU2ps5DkUCINJ2X77ZXZhBii
         gstBMfot+b5QHngnGjyomcpa+BxLA/Mk387BCAXW64Du8M9dqM753Xzg27p0/oy/ict5
         TGtYRipASeWLy7QrPBasVIvxIsE0KK/LKBY9bWP/y9vBfOscBESsew3sbWYcpGVBW9Hw
         GbwyfBdFk80aPNkhaPuigrQVNqG1vXyTHCV4gfiw3O6AEojuoVpDjh/nzeLWoPXoAlXZ
         UODbE/s0OcqZNl6/8w38Scnpr6IeXzxpe2Htx5I3UeOtvonFKyqOLsX62leMGJRUCdYD
         TWZA==
X-Gm-Message-State: AKwxytfAY+B94r8ccLqFr5Ly8Q+9TdZnqd5YaszIg0WXEZCfOeHQmmZf
        tXHtrWozKzGFh8eQ3shlOEzUVdYPHoI=
X-Google-Smtp-Source: ACJfBouYjfChvUhzmaMjd2XlTsiU3axC8oqc902+S3ji+cduRR/UY4XxtwboTJ4qXw3XqRrLWIYThg==
X-Received: by 10.55.217.132 with SMTP id q4mr11126533qkl.236.1515348914771;
        Sun, 07 Jan 2018 10:15:14 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:14 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 07/18] midx: teach midx --write to update midx-head
Date:   Sun,  7 Jan 2018 13:14:48 -0500
Message-Id: <20180107181459.222909-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There may be multiple MIDX files in a single pack directory. The primary
file is pointed to by a pointer file "midx-head" that contains an OID.
The MIDX file to load is then given by "midx-<OID>.midx".

This head file will be especially important when the MIDX files are
extended to be incremental and we expect multiple MIDX files at any
point.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-midx.txt | 19 ++++++++++++++++++-
 builtin/midx.c             | 32 ++++++++++++++++++++++++++++++--
 midx.c                     | 31 +++++++++++++++++++++++++++++++
 midx.h                     |  3 +++
 t/t5318-midx.sh            | 33 ++++++++++++++++++++++-----------
 5 files changed, 104 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
index 17464222c1..01f79cbba5 100644
--- a/Documentation/git-midx.txt
+++ b/Documentation/git-midx.txt
@@ -9,7 +9,7 @@ git-midx - Write and verify multi-pack-indexes (MIDX files).
 SYNOPSIS
 --------
 [verse]
-'git midx' --write [--pack-dir <pack_dir>]
+'git midx' --write <options> [--pack-dir <pack_dir>]
 
 DESCRIPTION
 -----------
@@ -26,15 +26,32 @@ OPTIONS
 	If specified, write a new midx file to the pack directory using
 	the packfiles present. Outputs the hash of the result midx file.
 
+--update-head::
+	If specified with --write, update the midx-head file to point to
+	the written midx file.
+
 EXAMPLES
 --------
 
+* Read the midx-head file and output the OID of the head MIDX file.
++
+------------------------------------------------
+$ git midx
+------------------------------------------------
+
 * Write a MIDX file for the packfiles in your local .git folder.
 +
 ------------------------------------------------
 $ git midx --write
 ------------------------------------------------
 
+* Write a MIDX file for the packfiles in your local .git folder and
+* update the midx-head file.
++
+------------------------------------------------
+$ git midx --write --update-head
+------------------------------------------------
+
 * Write a MIDX file for the packfiles in a different folder
 +
 ---------------------------------------------------------
diff --git a/builtin/midx.c b/builtin/midx.c
index 4aae14cf8e..84ce6588a2 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -9,13 +9,17 @@
 #include "midx.h"
 
 static char const * const builtin_midx_usage[] = {
-	N_("git midx --write [--pack-dir <packdir>]"),
+	N_("git midx [--pack-dir <packdir>]"),
+	N_("git midx --write [--update-head] [--pack-dir <packdir>]"),
 	NULL
 };
 
 static struct opts_midx {
 	const char *pack_dir;
 	int write;
+	int update_head;
+	int has_existing;
+	struct object_id old_midx_oid;
 } opts;
 
 static int build_midx_from_packs(
@@ -109,6 +113,22 @@ static int build_midx_from_packs(
 	return 0;
 }
 
+static void update_head_file(const char *pack_dir, const char *midx_id)
+{
+	int fd;
+	struct lock_file lk = LOCK_INIT;
+	char *head_path = get_midx_head_filename(pack_dir);
+
+	fd = hold_lock_file_for_update(&lk, head_path, LOCK_DIE_ON_ERROR);
+	FREE_AND_NULL(head_path);
+
+	if (fd < 0)
+		die_errno("unable to open midx-head");
+
+	write_in_full(fd, midx_id, GIT_MAX_HEXSZ);
+	commit_lock_file(&lk);
+}
+
 static int midx_write(void)
 {
 	const char **pack_names = NULL;
@@ -152,6 +172,9 @@ static int midx_write(void)
 
 	printf("%s\n", midx_id);
 
+	if (opts.update_head)
+		update_head_file(opts.pack_dir, midx_id);
+
 cleanup:
 	if (pack_names)
 		FREE_AND_NULL(pack_names);
@@ -166,6 +189,8 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 			N_("The pack directory containing set of packfile and pack-index pairs.") },
 		OPT_BOOL('w', "write", &opts.write,
 			N_("write midx file")),
+		OPT_BOOL('u', "update-head", &opts.update_head,
+			N_("update midx-head to written midx file")),
 		OPT_END(),
 	};
 
@@ -187,9 +212,12 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 		opts.pack_dir = strbuf_detach(&path, NULL);
 	}
 
+	opts.has_existing = !!get_midx_head_oid(opts.pack_dir, &opts.old_midx_oid);
+
 	if (opts.write)
 		return midx_write();
 
-	usage_with_options(builtin_midx_usage, builtin_midx_options);
+	if (opts.has_existing)
+		printf("%s\n", oid_to_hex(&opts.old_midx_oid));
 	return 0;
 }
diff --git a/midx.c b/midx.c
index 5c320726ed..f4178c1b81 100644
--- a/midx.c
+++ b/midx.c
@@ -34,6 +34,37 @@ char* get_midx_filename_oid(const char *pack_dir,
 	return strbuf_detach(&head_path, NULL);
 }
 
+char *get_midx_head_filename(const char *pack_dir)
+{
+	struct strbuf head_filename = STRBUF_INIT;
+	strbuf_addstr(&head_filename, pack_dir);
+	strbuf_addstr(&head_filename, "/midx-head");
+	return strbuf_detach(&head_filename, NULL);
+}
+
+struct object_id *get_midx_head_oid(const char *pack_dir,
+				    struct object_id *oid)
+{
+	char oid_hex[GIT_MAX_HEXSZ + 1];
+	FILE *f;
+	char *head_filename = get_midx_head_filename(pack_dir);
+
+	f = fopen(head_filename, "r");
+	FREE_AND_NULL(head_filename);
+
+	if (!f)
+		return 0;
+
+	if (!fgets(oid_hex, sizeof(oid_hex), f))
+		die("failed to read midx-head");
+
+	fclose(f);
+
+	if (get_oid_hex(oid_hex, oid))
+		return 0;
+	return oid;
+}
+
 struct pack_midx_details_internal {
 	uint32_t pack_int_id;
 	uint32_t internal_offset;
diff --git a/midx.h b/midx.h
index 4b00463651..9d9ab85261 100644
--- a/midx.h
+++ b/midx.h
@@ -7,6 +7,9 @@
 
 extern char *get_midx_filename_oid(const char *pack_dir,
 				   struct object_id *oid);
+extern char *get_midx_head_filename(const char *pack_dir);
+
+extern struct object_id *get_midx_head_oid(const char *pack_dir, struct object_id *oid);
 
 struct pack_midx_entry {
 	struct object_id oid;
diff --git a/t/t5318-midx.sh b/t/t5318-midx.sh
index 869bbea29c..b66efcdce9 100755
--- a/t/t5318-midx.sh
+++ b/t/t5318-midx.sh
@@ -29,13 +29,16 @@ test_expect_success 'create objects' \
 test_expect_success 'write-midx from index version 1' \
     'pack1=$(git rev-list --all --objects | git pack-objects --index-version=1 ${packdir}/test-1) &&
      midx1=$(git midx --write) &&
-     test_path_is_file ${packdir}/midx-${midx1}.midx'
+     test_path_is_file ${packdir}/midx-${midx1}.midx &&
+     test_path_is_missing ${packdir}/midx-head'
 
 test_expect_success 'write-midx from index version 2' \
     'rm "${packdir}/test-1-${pack1}.pack" &&
      pack2=$(git rev-list --all --objects | git pack-objects --index-version=2 ${packdir}/test-2) &&
-     midx2=$(git midx --write) &&
-     test_path_is_file ${packdir}/midx-${midx2}.midx'
+     midx2=$(git midx --write --update-head) &&
+     test_path_is_file ${packdir}/midx-${midx2}.midx &&
+     test_path_is_file ${packdir}/midx-head &&
+     test $(cat ${packdir}/midx-head) = "$midx2"'
 
 test_expect_success 'Create more objects' \
     'for i in $(test_seq 100)
@@ -49,8 +52,10 @@ test_expect_success 'Create more objects' \
 
 test_expect_success 'write-midx with two packs' \
     'pack3=$(git rev-list --objects commit2 ^commit1 | git pack-objects --index-version=2 ${packdir}/test-3) &&
-     midx3=$(git midx --write) &&
-     test_path_is_file ${packdir}/midx-${midx3}.midx'
+     midx3=$(git midx --write --update-head) &&
+     test_path_is_file ${packdir}/midx-${midx3}.midx &&
+     test_path_is_file ${packdir}/midx-head &&
+     test $(cat ${packdir}/midx-head) = "$midx3"'
 
 test_expect_success 'Add more packs' \
     'for j in $(test_seq 10)
@@ -77,13 +82,17 @@ test_expect_success 'Add more packs' \
      done'
 
 test_expect_success 'write-midx with twelve packs' \
-    'midx4=$(git midx --write) &&
-     test_path_is_file ${packdir}/midx-${midx4}.midx'
+    'midx4=$(git midx --write --update-head) &&
+     test_path_is_file ${packdir}/midx-${midx4}.midx &&
+     test_path_is_file ${packdir}/midx-head &&
+     test $(cat ${packdir}/midx-head) = "$midx4"'
 
 test_expect_success 'write-midx with no new packs' \
-    'midx5=$(git midx --write) &&
+    'midx5=$(git midx --write --update-head) &&
      test_path_is_file ${packdir}/midx-${midx5}.midx &&
-     test "a$midx4" = "a$midx5"'
+     test "a$midx4" = "a$midx5" &&
+     test_path_is_file ${packdir}/midx-head &&
+     test $(cat ${packdir}/midx-head) = "$midx4"'
 
 test_expect_success 'create bare repo' \
     'cd .. &&
@@ -94,7 +103,9 @@ test_expect_success 'create bare repo' \
      baredir=objects/pack'
 
 test_expect_success 'write-midx in bare repo' \
-    'midxbare=$(git midx --write) &&
-     test_path_is_file ${baredir}/midx-${midxbare}.midx'
+    'midxbare=$(git midx --write --update-head) &&
+     test_path_is_file ${baredir}/midx-${midxbare}.midx  &&
+     test_path_is_file ${baredir}/midx-head &&
+     test $(cat ${baredir}/midx-head) = "$midxbare"'
 
 test_done
-- 
2.15.0

