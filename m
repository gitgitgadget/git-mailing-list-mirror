Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C59E1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeCXHZY (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:25:24 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44791 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeCXHZV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:25:21 -0400
Received: by mail-lf0-f65.google.com with SMTP id g203-v6so21327889lfg.11
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rLxCTpJtzXLM9ysgY5oX9H4tOjuAD31wrZm2EVgs5c=;
        b=EWu1Pk+UK5CPVMfKNVaPddopqglftLiISE28gGpPA6a6eqwO54wlKVpNFt5Tz8M/6e
         /F9rcasYON08RsKUKymb1W6XLIaGWBJhZFontmZf890R8ZV/3Pohl2sk1oLpyPB2u5Ye
         3FN7e9u6Krdr0QKEUuPQ2spfGpxZp31sQ+bV5kLzvnyssY9UfSIWQ0afwfy9AOZIk/54
         VIyXRdp8BF4zEhOyTeTsYaD1VnNrSzy2Rwc5I6F0yhiPYkaBS2n9n+kMhEi8vKue245x
         1NYN2j3pmw3qjRz97KF7H14sDHRsVtIMqYZExgCC8c9JaqZ+Ah/ThfcuGMb/uU+sPwdQ
         gd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rLxCTpJtzXLM9ysgY5oX9H4tOjuAD31wrZm2EVgs5c=;
        b=Cxm5Xb6ylf7cOkUPEBAKoPq4f7dgGrTTV7wDKhV2lzRbejsYtw5/JzXJMBmYZ/9ieB
         RdnlRL+tgdr+1VeBd5IxkT6s9HSOG75RZccyHdx8tMxrU2YjYtL3Jae7ked4wHwQ32tz
         uGbotsG8RSip1S9RtqBBItRFwaaMo5Tmm2FWnQGM2vkKAKjXYVJUAUKiytN391a8rDly
         EbKf2NmA9cyWoUnN7z6fbbqlE0KGiZC7lBCnlzYeKTThlqSo8H6skHaKrHwRMgGM3wnX
         RADE5C0QcvoVxnk2LqUPsUjAdPjbypQCzDzvvTp9g+/jOM4nCgd38ZzF1Vtrxd6Jl9Tg
         /hIQ==
X-Gm-Message-State: AElRT7EDyVKU0SsZQP0aUsSb7UXrfS97+meamsVZkP10R3OAWQm1JkIP
        1mm7fnbfX26Wqv8qAuhabWoX3A==
X-Google-Smtp-Source: AG47ELtxSWkfHMQ1e5PswQOyqQ37D2DAP9HToxEMqGPTojPx1g8gWe9zCPJ3YWV3UQrhUTsOclCk4Q==
X-Received: by 2002:a19:7b12:: with SMTP id w18-v6mr22268761lfc.104.1521876319876;
        Sat, 24 Mar 2018 00:25:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b67-v6sm2684028lfh.26.2018.03.24.00.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:25:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 3/7] gc: add --keep-largest-pack option
Date:   Sat, 24 Mar 2018 08:25:03 +0100
Message-Id: <20180324072507.21059-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324072507.21059-1-pclouds@gmail.com>
References: <20180316192745.19557-1-pclouds@gmail.com>
 <20180324072507.21059-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new repack mode that combines everything into a secondary
pack, leaving the largest pack alone.

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
 Documentation/git-gc.txt |  6 ++++-
 builtin/gc.c             | 47 ++++++++++++++++++++++++++++++++++++----
 t/t6500-gc.sh            | 25 +++++++++++++++++++++
 3 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 571b5a7e3c..bf81b8de30 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
 
 DESCRIPTION
 -----------
@@ -78,6 +78,10 @@ automatic consolidation of packs.
 	Force `git gc` to run even if there may be another `git gc`
 	instance running on this repository.
 
+--keep-largest-pack::
+	All packs except the largest pack and those marked with a
+	`.keep` files are consolidated into a single pack.
+
 Configuration
 -------------
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 77fa720bd0..9a09cf53b0 100644
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
+		OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
+			 N_("repack all other packs except the largest pack")),
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
index 41b0be575d..a95969af2a 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -43,6 +43,31 @@ test_expect_success 'gc is not aborted due to a stale symref' '
 	)
 '
 
+test_expect_success 'gc --keep-largest-pack' '
+	test_create_repo keep-pack &&
+	(
+		cd keep-pack &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		git gc &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 1 pack-list &&
+		BASE_PACK=.git/objects/pack/pack-*.pack &&
+		test_commit four &&
+		git repack -d &&
+		test_commit five &&
+		git repack -d &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 3 pack-list &&
+		git gc --keep-largest-pack &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 2 pack-list &&
+		test_path_is_file $BASE_PACK &&
+		git fsck
+	)
+'
+
 test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
 	test_config gc.auto 3 &&
 	test_config gc.autodetach false &&
-- 
2.17.0.rc0.348.gd5a49e0b6f

