Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC121F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCWRqN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:46:13 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41229 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCWRp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id o102-v6so19461911lfg.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvBnRdCsInuRrJnigfEffVKKJEKATZIZCvg4Gs9Fom0=;
        b=E15jzRXhefhp6HP5aowz1/2ypi7+r/2HLzZ3fatOD8X6/FDEpYiid8XRIe8653AgRi
         5x5TrVjy67NGajnfet17BlwDak4wYShoaYnxSjm2EaV2FwLJazk0kIsSj+uJeAoyM9UZ
         YQB8+QGGOF7ItUknXFsQQUvsB5F497LzZohLnowMd+ozz1gix80Kqj9Mdi7MeE7TGSZj
         KhOJkTGD53um8Z6D6m8dDuJEohtaEGAJm7vUEh1Z+E/8gk/v1plVN9a70N+7oIPmx4qv
         jUaq4sEJHd16DmPfx0bXQ2Y5cJRtnCgkxSkS57ubeozN6EBp9iZaDbRRScJPXVtW8GbN
         Uz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvBnRdCsInuRrJnigfEffVKKJEKATZIZCvg4Gs9Fom0=;
        b=IpVyBfh/Na1HFrqikuQTz/a+w2He97XeykH63vNRI2CPWV61YOxZRvBgd+dRE1DYfJ
         mLLtjb3vUkaKEDfEMSdG19y9nmAeeKDyZ45juzHgB7gTriXN8i10iDAOJKuwmaRV1Mb9
         0DPFE3d/KtDdj7SPWenV/Mz3/M1r0b/6OT7sygxuVMBhY7WbZ6T4cu/cgY28M9SklNoC
         eFhdq7/FVkb76tUAH9p36uoHyS/1dhPVfzTo0tE75JdB4qtykSAZ0gYRD1TLxDQFu9p4
         wIv/CS56adcqUthvJWvVTELvGszaY2Yj+CWhgnb/GG4zDMLYZeJ8QdsY3qxSTeANrJJ3
         ME8g==
X-Gm-Message-State: AElRT7H6FqWdezirJq/GALz7Wjk6P4c9mOE++zy6ee2T+arVmm3aYT0G
        2NaTUSI42kF051geFZGJfyI=
X-Google-Smtp-Source: AG47ELvDFGgwhyB3qIKRQWZzhp1wl0KOpw20SeyC8ynDWuPCO/hhf7rkCgnGMJOo5SPD6j5Vfl/UVw==
X-Received: by 2002:a19:dd89:: with SMTP id w9-v6mr21274249lfi.82.1521827157530;
        Fri, 23 Mar 2018 10:45:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/12] packfile: keep prepare_packed_git() private
Date:   Fri, 23 Mar 2018 18:45:27 +0100
Message-Id: <20180323174527.30337-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323174527.30337-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323174527.30337-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reason callers have to call this is to make sure either packed_git
or packed_git_mru pointers are initialized since we don't do that by
default. Sometimes it's hard to see this connection between where the
function is called and where packed_git pointer is used (sometimes in
separate functions).

Keep this dependency internal because now all access to packed_git and
packed_git_mru must go through get_xxx() wrappers.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/count-objects.c  | 3 +--
 builtin/fsck.c           | 2 --
 builtin/gc.c             | 1 -
 builtin/pack-objects.c   | 1 -
 builtin/pack-redundant.c | 2 --
 fast-import.c            | 1 -
 http-backend.c           | 1 -
 pack-bitmap.c            | 1 -
 packfile.c               | 5 ++++-
 packfile.h               | 1 -
 server-info.c            | 1 -
 sha1_name.c              | 2 --
 12 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ea8bd9e2e2..b054713e1a 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -122,8 +122,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct strbuf loose_buf = STRBUF_INIT;
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
-		if (!get_packed_git(the_repository))
-			prepare_packed_git(the_repository);
+
 		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d40a82b702..f9632353d9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -729,8 +729,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			prepare_packed_git(the_repository);
-
 			if (show_progress) {
 				for (p = get_packed_git(the_repository); p;
 				     p = p->next) {
diff --git a/builtin/gc.c b/builtin/gc.c
index a78dad51aa..0a667972ab 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -174,7 +174,6 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	prepare_packed_git(the_repository);
 	for (cnt = 0, p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 491ce433da..2f49b03cb1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3152,7 +3152,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	prepare_packed_git(the_repository);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
 		for (p = get_packed_git(the_repository); p; p = p->next)
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index da6637f7fc..710cd0fb69 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -631,8 +631,6 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prepare_packed_git(the_repository);
-
 	if (load_all_packs)
 		load_all();
 	else
diff --git a/fast-import.c b/fast-import.c
index 47981e6db7..37a44752a8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3473,7 +3473,6 @@ int cmd_main(int argc, const char **argv)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
-	prepare_packed_git(the_repository);
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
diff --git a/http-backend.c b/http-backend.c
index c1b1c2d557..88d2a9bc40 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -519,7 +519,6 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 57fec38f3f..3f2dab340f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -336,7 +336,6 @@ static int open_pack_bitmap(void)
 
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
 			ret = 0;
diff --git a/packfile.c b/packfile.c
index 89bd0d47bf..63c89ee31a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -803,6 +803,7 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
 	strbuf_release(&path);
 }
 
+static void prepare_packed_git(struct repository *r);
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -883,7 +884,7 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects->packed_git_mru);
 }
 
-void prepare_packed_git(struct repository *r)
+static void prepare_packed_git(struct repository *r)
 {
 	struct alternate_object_database *alt;
 
@@ -907,11 +908,13 @@ void reprepare_packed_git(struct repository *r)
 
 struct packed_git *get_packed_git(struct repository *r)
 {
+	prepare_packed_git(r);
 	return r->objects->packed_git;
 }
 
 struct list_head *get_packed_git_mru(struct repository *r)
 {
+	prepare_packed_git(r);
 	return &r->objects->packed_git_mru;
 }
 
diff --git a/packfile.h b/packfile.h
index fe1a6380e6..efda10329c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,6 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void prepare_packed_git(struct repository *r);
 extern void reprepare_packed_git(struct repository *r);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
diff --git a/server-info.c b/server-info.c
index bf5c325867..83460ec0d6 100644
--- a/server-info.c
+++ b/server-info.c
@@ -201,7 +201,6 @@ static void init_pack_info(const char *infofile, int force)
 	objdir = get_object_directory();
 	objdirlen = strlen(objdir);
 
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
diff --git a/sha1_name.c b/sha1_name.c
index e0b62f3c56..31c013ac7e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -196,7 +196,6 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -567,7 +566,6 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
 	struct packed_git *p;
 
-	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

