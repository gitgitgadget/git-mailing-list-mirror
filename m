Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FFE91F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeCWRqD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:46:03 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41208 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeCWRpt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id o102-v6so19461280lfg.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZD5ccSrtbBVKBPBiWvH4jEL5cjEYe2lLuUorI9uuUAU=;
        b=bj89Qzcu4bPTrvqxy2bQgrU94gKq/yJgCpK0/QQv6dhF3iaDWGhz3EkngCjJMvKhJ3
         VbHy+Jexlg7yES7sA0GDLNpgmMJQIIqWMPijY9lnxjem/LAifa9hHV1cddxueA45wjTN
         KyEfZ8M7ujneDJFd5nm5qtupA1LGHmw+w435g6bup2GWQS3V15UtveMyrQwh4cnZJMoa
         ebWAZEA5dz1kD+zps2eQKf/uryVV8g0p6AJPO9RdEPYdMfp2rQaojvEhLvzYik4RrC+/
         CneUZrqNAIURDPaqJQN1AvbcpNfjSb3fIhyzrB/+SeeVAeubqxgcQfgN3VyzOXIm77jI
         ArDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZD5ccSrtbBVKBPBiWvH4jEL5cjEYe2lLuUorI9uuUAU=;
        b=AAjSFCxrZaEIRh/wBCHPGAE5VNLgF6hA9fMz64n1tE++vDz8EsGelxS6Bv8LvgwovE
         VfI9Zx/SsAH5CpvBAUyRs7HZXyQ+TFcY0JmpqBE6uMG0f0iwGPIdW3Hr0a48eFbBTPMt
         kzq7CWKivyew9U4tp4bYuLCN+TXP/xeNLmPcdOJahAec9fqoLGKUtWreSdw0lReLlAAm
         DeeIVxuQFSDk6u8622eU9Hr89IyeIcSyUo1u+glkSbFc5EIFW8Hek8PjAfkezqTeltvh
         HY6OXXIUA5Sm1HN9xTAyGHaDBBDjBhMpVv7zn8c8kvQlxdguaVnWnCazkPIL1odeyPEw
         3hUA==
X-Gm-Message-State: AElRT7EkoWyql2EkXIoBOIOhS2uZesJ3/PPLgeLehvrNGc3qxHq+cNrZ
        eGkmJWgS2d3Qx7fyiFkt71c=
X-Google-Smtp-Source: AG47ELvto1Ud0G+WyiP5KLM/+uvPsBNA7K25rRvd3len0rEZ26qJj0/E2GH+unIEUEbIbxK4Ih6L2A==
X-Received: by 10.46.137.138 with SMTP id c10mr9107140lji.0.1521827147608;
        Fri, 23 Mar 2018 10:45:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 05/12] packfile: add repository argument to prepare_packed_git
Date:   Fri, 23 Mar 2018 18:45:20 +0100
Message-Id: <20180323174527.30337-6-pclouds@gmail.com>
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

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow prepare_packed_git callers to be
more specific about which repository to handle. See commit "sha1_file:
add repository argument to link_alt_odb_entry" for an explanation of
the #define trick.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/count-objects.c  |  2 +-
 builtin/fsck.c           |  2 +-
 builtin/gc.c             |  2 +-
 builtin/pack-objects.c   |  2 +-
 builtin/pack-redundant.c |  2 +-
 fast-import.c            |  2 +-
 http-backend.c           |  2 +-
 pack-bitmap.c            |  2 +-
 packfile.c               | 10 +++++-----
 packfile.h               |  3 ++-
 server-info.c            |  2 +-
 sha1_name.c              |  4 ++--
 12 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index b28ff00be2..ea8bd9e2e2 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -123,7 +123,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 		if (!get_packed_git(the_repository))
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3ef25fab97..d40a82b702 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -729,7 +729,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 
 			if (show_progress) {
 				for (p = get_packed_git(the_repository); p;
diff --git a/builtin/gc.c b/builtin/gc.c
index b00238cd5d..4c7409946e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -174,7 +174,7 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (cnt = 0, p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 223f2d9fc0..491ce433da 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3152,7 +3152,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
 		for (p = get_packed_git(the_repository); p; p = p->next)
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index b5b007e706..da6637f7fc 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -631,7 +631,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 
 	if (load_all_packs)
 		load_all();
diff --git a/fast-import.c b/fast-import.c
index ae4ced3ae1..47981e6db7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3473,7 +3473,7 @@ int cmd_main(int argc, const char **argv)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
diff --git a/http-backend.c b/http-backend.c
index 64dde78c1b..c1b1c2d557 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -519,7 +519,7 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 22cd425788..57fec38f3f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -336,7 +336,7 @@ static int open_pack_bitmap(void)
 
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
 			ret = 0;
diff --git a/packfile.c b/packfile.c
index 0e5fa67526..bb090f8a29 100644
--- a/packfile.c
+++ b/packfile.c
@@ -817,7 +817,7 @@ unsigned long approximate_object_count(void)
 		unsigned long count;
 		struct packed_git *p;
 
-		prepare_packed_git();
+		prepare_packed_git(the_repository);
 		count = 0;
 		for (p = the_repository->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
@@ -884,7 +884,7 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects->packed_git_mru);
 }
 
-void prepare_packed_git(void)
+void prepare_packed_git_the_repository(void)
 {
 	struct alternate_object_database *alt;
 
@@ -903,7 +903,7 @@ void reprepare_packed_git(void)
 {
 	the_repository->objects->approximate_object_count_valid = 0;
 	the_repository->objects->packed_git_initialized = 0;
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 }
 
 struct packed_git *get_packed_git(struct repository *r)
@@ -1854,7 +1854,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (!the_repository->objects->packed_git)
 		return 0;
 
@@ -1908,7 +1908,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects->packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
diff --git a/packfile.h b/packfile.h
index 77442172f0..3f59456e7e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,8 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void prepare_packed_git(void);
+#define prepare_packed_git(r) prepare_packed_git_##r()
+extern void prepare_packed_git_the_repository(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
diff --git a/server-info.c b/server-info.c
index 75a8b65e47..bf5c325867 100644
--- a/server-info.c
+++ b/server-info.c
@@ -201,7 +201,7 @@ static void init_pack_info(const char *infofile, int force)
 	objdir = get_object_directory();
 	objdirlen = strlen(objdir);
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
diff --git a/sha1_name.c b/sha1_name.c
index 4325f74e0c..e0b62f3c56 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -196,7 +196,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -567,7 +567,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = get_packed_git(the_repository); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

