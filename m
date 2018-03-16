Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EB41F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeCPT2d (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:28:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39841 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeCPT2J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:28:09 -0400
Received: by mail-lf0-f68.google.com with SMTP id f75-v6so16941713lfg.6
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxKNLs+KolPNVQd6KH6A4xPPdFEEwYokPJ4pM68DbNg=;
        b=b0aObOhAFlEzzgy0yaAfath9Q8Jke/uHsSsr06KHCErugfFt58FaPBP8jAUwQOvTbJ
         tQKXlV00Jt+RfZSNoCELCaVHaiySfiDEKdV6LohY6nmplqKiJ+9lg12bxj/i2KsETYYn
         AFCozfAZVSavivJ9tChar454QJq6AIwnA/0N6SUeX89A5TuLJYOdcmyfwjg05jCf9+1e
         rfo5yrKOCW05MDkEYPwiSuYh9MZHSuiOtUt6eU1OUBq5oMdhOTx+qxBP/WFVgeImvR2K
         vczFtNcGZNN73TD2lqRpuchJ3IePHxhjcVERGe6LiXtEP2vrzr3JkagYK885tim5Zn/e
         hxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxKNLs+KolPNVQd6KH6A4xPPdFEEwYokPJ4pM68DbNg=;
        b=JvnN5JCYrLP4fTA6BpqLDkLYtL702YHPtX2U2lJirGytf4lnSF7WZlKgiGNlE2MZJM
         Gogx0PgjQHpD/2gMwTa8RqJ2GbPlU1OYeVhniQJtkPPOtB2lEaZo7yKyMqi3l7MlbT9q
         yJjU8nhVuNzxBR4D10y1YKKYl9espw1GVtM7xNCF4E7yP45VvgdEFIkpimX0HSkUUyYK
         WkXzECtEMffuG3bH0n1Ob85jEbrmFZbhw7GoxfNDfc5Jyj/T2pQjTHD1iQzg4dAgtVFv
         KjAzHHLL4tzftRLBKmq0QQ9p03w1PqF78Qgdpn+Uj9UOwZAtY7razOg4MsApI2G4vqk1
         bvcw==
X-Gm-Message-State: AElRT7F3agJBsoKhLKv67qQH1G+20cP2H7mkFTpp0hak8gYUcV5AUInf
        IzjCNA/GpO/C37lPh/DCwn0=
X-Google-Smtp-Source: AG47ELttYLOle3FTh0dSOBNm9AfdvtEHnBuw9d4kN8zkqYylcj9KWIHq2idcEedKZ3WyOzT49s+oOg==
X-Received: by 10.46.15.26 with SMTP id 26mr2290001ljp.147.1521228487908;
        Fri, 16 Mar 2018 12:28:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm1766085lja.41.2018.03.16.12.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 12:28:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 2/7] gc: add --keep-base-pack
Date:   Fri, 16 Mar 2018 20:27:40 +0100
Message-Id: <20180316192745.19557-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316192745.19557-1-pclouds@gmail.com>
References: <20180306104158.6541-1-pclouds@gmail.com>
 <20180316192745.19557-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new repack mode that combines everything into a secondary
pack, leaving the largest/base pack alone.

This could help reduce memory pressure. On linux-2.6.git, valgrind
massif reports 1.6GB heap in "pack all" case, and 535MB in "pack
all except the base pack" case. We save roughly 1GB memory by
excluding the base pack.

This should also lower I/O because we don't have to rewrite a giant
pack every time (e.g. for linux-2.6.git that's a 1.4GB pack file)..

PS. The use of string_list here seems overkill, but we'll need it in
the next patch...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-gc.txt |  7 +++++-
 builtin/gc.c             | 47 ++++++++++++++++++++++++++++++++++++----
 t/t6500-gc.sh            | 22 +++++++++++++++++++
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 571b5a7e3c..1717517043 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-base-pack]
 
 DESCRIPTION
 -----------
@@ -78,6 +78,11 @@ automatic consolidation of packs.
 	Force `git gc` to run even if there may be another `git gc`
 	instance running on this repository.
 
+--keep-base-pack::
+	All packs except the base pack and those marked with a `.keep`
+	files are consolidated into a single pack. The largest pack is
+	considered the base pack.
+
 Configuration
 -------------
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 77fa720bd0..362dd537a4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -164,6 +164,24 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
+static void find_base_packs(struct string_list *packs)
+{
+	struct packed_git *p, *base = NULL;
+
+	prepare_packed_git();
+
+	for (p = packed_git; p; p = p->next) {
+		if (!p->pack_local)
+			continue;
+		if (!base || base->pack_size < p->pack_size) {
+			base = p;
+		}
+	}
+
+	if (base)
+		string_list_append(packs, base->pack_name);
+}
+
 static int too_many_packs(void)
 {
 	struct packed_git *p;
@@ -187,7 +205,13 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit < cnt;
 }
 
-static void add_repack_all_option(void)
+static int keep_one_pack(struct string_list_item *item, void *data)
+{
+	argv_array_pushf(&repack, "--keep-pack=%s", basename(item->string));
+	return 0;
+}
+
+static void add_repack_all_option(struct string_list *keep_pack)
 {
 	if (prune_expire && !strcmp(prune_expire, "now"))
 		argv_array_push(&repack, "-a");
@@ -196,6 +220,9 @@ static void add_repack_all_option(void)
 		if (prune_expire)
 			argv_array_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
 	}
+
+	if (keep_pack)
+		for_each_string_list(keep_pack, keep_one_pack, NULL);
 }
 
 static void add_repack_incremental_option(void)
@@ -219,7 +246,7 @@ static int need_to_gc(void)
 	 * there is no need.
 	 */
 	if (too_many_packs())
-		add_repack_all_option();
+		add_repack_all_option(NULL);
 	else if (too_many_loose_objects())
 		add_repack_incremental_option();
 	else
@@ -353,6 +380,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	const char *name;
 	pid_t pid;
 	int daemonized = 0;
+	int keep_base_pack = -1;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -362,6 +390,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
 		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
+		OPT_BOOL(0, "keep-base-pack", &keep_base_pack,
+			 N_("repack all other packs except the base pack")),
 		OPT_END()
 	};
 
@@ -427,8 +457,17 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			 */
 			daemonized = !daemonize();
 		}
-	} else
-		add_repack_all_option();
+	} else {
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+		if (keep_base_pack != -1) {
+			if (keep_base_pack)
+				find_base_packs(&keep_pack);
+		}
+
+		add_repack_all_option(&keep_pack);
+		string_list_clear(&keep_pack, 0);
+	}
 
 	name = lock_repo_for_gc(force, &pid);
 	if (name) {
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 41b0be575d..4136681b47 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -116,6 +116,28 @@ test_expect_success 'background auto gc respects lock for all operations' '
 	test_path_is_file .git/refs/heads/should-be-loose
 '
 
+test_expect_success 'gc --keep-base-pack' '
+	test_create_repo keep-pack &&
+	(
+		cd keep-pack &&
+		for i in 10; do
+			test_commit $i
+		done &&
+		git gc &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 1 pack-list &&
+		BASE_PACK=.git/objects/pack/pack-*.pack &&
+		for i in 10; do
+			test_commit more-$i
+		done &&
+		git gc --keep-base-pack &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 2 pack-list &&
+		test_path_is_file $BASE_PACK &&
+		git fsck
+	)
+'
+
 # DO NOT leave a detached auto gc process running near the end of the
 # test script: it can run long enough in the background to racily
 # interfere with the cleanup in 'test_done'.
-- 
2.16.2.903.gd04caf5039

