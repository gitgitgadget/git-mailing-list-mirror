Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA54C1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeCXHoG (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:44:06 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33208 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeCXHne (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:43:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id x205-v6so21410349lfa.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rLxCTpJtzXLM9ysgY5oX9H4tOjuAD31wrZm2EVgs5c=;
        b=GMcx7oRjxlFg6toYiaPkkEjbdPmxoZ7zWk603D82onhnNPKc6ccjZZwztx2REjqlUY
         lagt6JpbYFcggiioB3D7dReRLw6bleuSEkYPa2MdrPFwuIcOWUJRlcGlNPlqW1yJn3dG
         gngoa/8lgl6noE+gTFBvEMOjvnhKKgT/WlK1OEdzjB9+w2RAYYfwaLOV0IPywDWzdg8Z
         MXQHZM+7JMHDFZOnZ5nMi0kGaDFVxTk4zoxudhbuDTDG7dmN13doJ25d+/1+rvu3MPFE
         gvVoXvVN+hRbEIlJYKjaqAixg2F+Z23Yy2pe7gZLdViGSVVtfHUvpLYGeSzr0Gj4u85g
         WRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rLxCTpJtzXLM9ysgY5oX9H4tOjuAD31wrZm2EVgs5c=;
        b=RupUXlckyuRE+RRbj9qHmK+3XP9QCmAtrPFJMsy3wptVIItxY9Mfx8/IlUxNCQm3Ol
         RL4T43v0P2ivslYOY7Ts8EAYlhSAL7/ionmqW5NdnBz0b8YEnCH6Fd/gcFWWxG8zmVPN
         gRl2LrbI8BMZxdNPks9aXlKnvKbeq289BzJ7hq0mx67Dt5zOZDQJa510yqgN53WtL8O1
         vSyBFbgfl5YpTBLNA67/5AwXj2ZvccQMCkl3CWDW3kmhEV78v7qj0w6OBZU0Ft8T5rUX
         wafgFNAOcTMfCWaj8vBWEwH+B3me+H+58cz5vDB/0WxDgI4LST4yGMuVU1zHYXmN+KH4
         lpsA==
X-Gm-Message-State: AElRT7FYiIZmM7tflhXSoUotbV8X4KNI/zRvxed4G7WGOGyxjvBpmkus
        IAOGyD7nb9GNTEk45OeHp3E=
X-Google-Smtp-Source: AG47ELvzpcpX+mzs9NfPgQLu9+HHlb43nmbIH0oL2mJgtcsyWX6MnXMXXInqfdWcU/nxXb2Bqe+KVg==
X-Received: by 2002:a19:8f91:: with SMTP id s17-v6mr22363772lfk.56.1521877412543;
        Sat, 24 Mar 2018 00:43:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o132-v6sm2642867lfe.91.2018.03.24.00.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:43:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/7] gc: add --keep-largest-pack option
Date:   Sat, 24 Mar 2018 08:42:30 +0100
Message-Id: <20180324074308.18934-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074308.18934-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074308.18934-1-pclouds@gmail.com>
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

