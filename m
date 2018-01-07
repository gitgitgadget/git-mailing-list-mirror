Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9594F1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbeAGSPl (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:41 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37877 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754456AbeAGSP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:28 -0500
Received: by mail-qk0-f194.google.com with SMTP id p13so11730783qke.4
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DCr1jhulXWMK7JcM8jTGVjwrId4OErqjL1MI5MHF5LY=;
        b=XsylxrIHvaeunxD0oXeFKimEAR9f11RmQAeqT00mQvJts6b375LJyGxadr0LkZQ1SI
         bxhP9w0NZ8BHrlO4A2NL9a6af6VLiBKPzBhzNSoG9wG5T0mfF1MNtZX4bIo2nPpOc7M2
         h+CpReeTPe4e/j+9Ps4fFZv+jtU6ut5YbDgjJ/7QvXDNit+i8uxvB6zIwlI+QsTG0bmZ
         P3DgJYZ793aX1UtpI/V5TJpoS5ewfWya21AfDqV5hDywPK9L1srhNjGGQZI8YmksYwXU
         Xks8AtTKUrzIyimnedbUxdliJJET1yWtYAyre1omo1VVw21YW5W9Ht+5sd0yrGZp/JKY
         Z9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DCr1jhulXWMK7JcM8jTGVjwrId4OErqjL1MI5MHF5LY=;
        b=jY7GZSbYqMdmWyB/KvJ4B9lg1Evea6QZp+ikYCYWfR5nR+9G2RdVnqOVWQKuWFE7PC
         3IHgF59TFX2XNnpPk0Ngs+PSd45r9FJbS3arpGpsnSy5xKsOPSSbEdI7CCEXHChEIgwH
         Ls8dUI9EAKgkdv98cPT/1kYj4a62dpk8DCkoHx1DcKLGXE+I5P0Z2MrVjw5eJKUNOu/W
         8W+tCfzPjof3njg72bDjBXIa+Vnh+7WC8mEq4JTC+LSqOBnLU7t0KEBtaTCQ5SG+Dhj3
         psP1tkB9a0LVoWepVKJDAU3CZWhTD/PDtgYS7yF+chig4r8JpYcBmEnKGnsnI09qfhZF
         ZGoA==
X-Gm-Message-State: AKwxytfOiKSEnp+uXNPElbfF5RjNlYStK753ALwglEkA+cF1qAVFW7bL
        VMjUkU0Ci9hUxCkxEE6IdwUt2n+E9Vs=
X-Google-Smtp-Source: ACJfBou2TxuMq2MPGhlQFqTn+zgBU+eF2Gye8wrsSWDIpNVyPiqggVHyK6U9ugDMv2RlkflkfInabg==
X-Received: by 10.55.162.140 with SMTP id l134mr13246395qke.124.1515348927189;
        Sun, 07 Jan 2018 10:15:27 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:26 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 14/18] midx: load midx files when loading packs
Date:   Sun,  7 Jan 2018 13:14:55 -0500
Message-Id: <20180107181459.222909-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace prepare_packed_git() with prepare_packed_git_internal(use_midx) to
allow some consumers of prepare_packed_git() with a way to load MIDX files.
Consumers should only use the new method if they are prepared to use the
midxed_git struct alongside the packed_git struct.

If a packfile is found that is not referenced by the current MIDX, then add
it to the packed_git struct. This is important to keep the MIDX useful after
adding packs due to "fetch" commands and when third-party tools (such as
libgit2) add packs directly to the repo.

If prepare_packed_git_internal is called with use_midx = 0, then unload the
MIDX file and reload the packfiles in to the packed_git struct.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c     | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.h     |  6 ++++--
 packfile.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 packfile.h |  1 +
 4 files changed, 117 insertions(+), 11 deletions(-)

diff --git a/midx.c b/midx.c
index 3ce2b736ea..a66763b9e3 100644
--- a/midx.c
+++ b/midx.c
@@ -22,6 +22,9 @@
 
 #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
+/* MIDX-git global storage */
+struct midxed_git *midxed_git = 0;
+
 char* get_midx_filename_oid(const char *pack_dir,
 			    struct object_id *oid)
 {
@@ -197,6 +200,45 @@ struct midxed_git *get_midxed_git(const char *pack_dir, struct object_id *oid)
 	return m;
 }
 
+static char* get_midx_filename_dir(const char *pack_dir)
+{
+	struct object_id oid;
+	if (!get_midx_head_oid(pack_dir, &oid))
+		return 0;
+
+	return get_midx_filename_oid(pack_dir, &oid);
+}
+
+static int prepare_midxed_git_head(char *pack_dir, int local)
+{
+	struct midxed_git *m = midxed_git;
+	char *midx_head_path = get_midx_filename_dir(pack_dir);
+
+	if (!core_midx)
+		return 1;
+
+	if (midx_head_path) {
+		midxed_git = load_midxed_git_one(midx_head_path, pack_dir);
+		midxed_git->next = m;
+		FREE_AND_NULL(midx_head_path);
+		return 1;
+	}
+
+	return 0;
+}
+
+int prepare_midxed_git_objdir(char *obj_dir, int local)
+{
+	int ret;
+	struct strbuf pack_dir = STRBUF_INIT;
+	strbuf_addstr(&pack_dir, obj_dir);
+	strbuf_add(&pack_dir, "/pack", 5);
+
+	ret = prepare_midxed_git_head(pack_dir.buf, local);
+	strbuf_release(&pack_dir);
+	return ret;
+}
+
 struct pack_midx_details_internal {
 	uint32_t pack_int_id;
 	uint32_t internal_offset;
@@ -677,3 +719,18 @@ int close_midx(struct midxed_git *m)
 
 	return 1;
 }
+
+void close_all_midx(void)
+{
+	struct midxed_git *m = midxed_git;
+	struct midxed_git *next;
+
+	while (m) {
+		next = m->next;
+		close_midx(m);
+		free(m);
+		m = next;
+	}
+
+	midxed_git = 0;
+}
diff --git a/midx.h b/midx.h
index 27d48163e9..d8ede8121c 100644
--- a/midx.h
+++ b/midx.h
@@ -27,7 +27,7 @@ struct pack_midx_header {
 	uint32_t num_packs;
 };
 
-struct midxed_git {
+extern struct midxed_git {
 	struct midxed_git *next;
 
 	int midx_fd;
@@ -81,9 +81,10 @@ struct midxed_git {
 
 	/* something like ".git/objects/pack" */
 	char pack_dir[FLEX_ARRAY]; /* more */
-};
+} *midxed_git;
 
 extern struct midxed_git *get_midxed_git(const char *pack_dir, struct object_id *oid);
+extern int prepare_midxed_git_objdir(char *obj_dir, int local);
 
 struct pack_midx_details {
 	uint32_t pack_int_id;
@@ -118,5 +119,6 @@ extern const char *write_midx_file(const char *pack_dir,
 				   uint32_t nr_objects);
 
 extern int close_midx(struct midxed_git *m);
+extern void close_all_midx(void);
 
 #endif
diff --git a/packfile.c b/packfile.c
index c36420b33f..1c0822878b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -8,6 +8,7 @@
 #include "list.h"
 #include "streaming.h"
 #include "sha1-lookup.h"
+#include "midx.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -309,10 +310,22 @@ void close_pack(struct packed_git *p)
 void close_all_packs(void)
 {
 	struct packed_git *p;
+	struct midxed_git *m;
+
+	for (m = midxed_git; m; m = m->next) {
+		int i;
+		for (i = 0; i < m->num_packs; i++) {
+			p = m->packs[i];
+			if (p && p->do_not_close)
+				BUG("want to close pack marked 'do-not-close'");
+			else if (p)
+				close_pack(p);
+		}
+	}
 
 	for (p = packed_git; p; p = p->next)
 		if (p->do_not_close)
-			die("BUG: want to close pack marked 'do-not-close'");
+			BUG("want to close pack marked 'do-not-close'");
 		else
 			close_pack(p);
 }
@@ -748,6 +761,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
 		struct packed_git *p;
+		struct midxed_git *m;
 		size_t base_len;
 
 		if (is_dot_or_dotdot(de->d_name))
@@ -758,15 +772,23 @@ static void prepare_packed_git_one(char *objdir, int local)
 
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
+			strbuf_setlen(&path, base_len + 1);
+			strbuf_add(&path, "pack", 4);
+
 			/* Don't reopen a pack we already have. */
+			for (m = midxed_git; m; m = m->next)
+				if (!memcmp(m->pack_dir, path.buf, dirnamelen - 1) &&
+				    contains_pack(m, path.buf + dirnamelen))
+					break;
 			for (p = packed_git; p; p = p->next) {
-				size_t len;
-				if (strip_suffix(p->pack_name, ".pack", &len) &&
-				    len == base_len &&
-				    !memcmp(p->pack_name, path.buf, len))
+				if (!strcmp(p->pack_name, path.buf))
 					break;
 			}
-			if (p == NULL &&
+
+			strbuf_setlen(&path, base_len + 1);
+			strbuf_add(&path, "idx", 3);
+
+			if (m == NULL && p == NULL &&
 			    /*
 			     * See if it really is a valid .idx file with
 			     * corresponding .pack file that we can map.
@@ -872,21 +894,45 @@ static void prepare_packed_git_mru(void)
 }
 
 static int prepare_packed_git_run_once = 0;
-void prepare_packed_git(void)
+static int prepare_midxed_git_run_once = 0;
+void prepare_packed_git_internal(int use_midx)
 {
 	struct alternate_object_database *alt;
+	char *obj_dir;
+
+	if (prepare_midxed_git_run_once) {
+		if (!use_midx) {
+			prepare_midxed_git_run_once = 0;
+			close_all_midx();
+			reprepare_packed_git();
+		}
+		return;
+	}
 
 	if (prepare_packed_git_run_once)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+
+	obj_dir = get_object_directory();
+
+	if (use_midx)
+		prepare_midxed_git_objdir(obj_dir, 1);
+	prepare_packed_git_one(obj_dir, 1);
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next)
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		if (use_midx)
+			prepare_midxed_git_objdir(alt->path, 0);
 		prepare_packed_git_one(alt->path, 0);
+	}
 	rearrange_packed_git();
 	prepare_packed_git_mru();
 	prepare_packed_git_run_once = 1;
+	prepare_midxed_git_run_once = use_midx;
 }
 
+void prepare_packed_git(void)
+{
+	prepare_packed_git_internal(0);
+}
 void reprepare_packed_git(void)
 {
 	approximate_object_count_valid = 0;
diff --git a/packfile.h b/packfile.h
index 7cf4771029..25bac91efb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -32,6 +32,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
+extern void prepare_packed_git_internal(int use_midx);
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
-- 
2.15.0

