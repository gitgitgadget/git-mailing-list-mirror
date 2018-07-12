Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985A21F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeGLTvT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:19 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34203 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGLTvT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:19 -0400
Received: by mail-qk0-f171.google.com with SMTP id b66-v6so16057212qkj.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SuIRDj1GtYEjEKy6On0tOyojBxKKXq5n1ccRPplAnLk=;
        b=JPsGD1EkPBx/+omJE7/OleGgx1Ze5Ay16Ho+W+bJqp4+4Lxy00QWdd2lEvMZOvtgZW
         7l46DTtXpkCawtjlTdvGF4UNKFJKR18ILUhS5bcPWCQE7aVsY0xQKZ8qDKfG2vLnPm5E
         jQzIniW/lLMqv3ZalzIWKvR8JhK+08lwX1LRthD++Lv/Sr89wpOFDd6c1Q+nOOVRhvAw
         h2ILHVX77FLLplmwky3va5BFLyUpJM6McmHMHFP6I7TuE20tcA51BMmefAUMNNihJBBs
         XXu9kYlC8zbulUlFuA/Y3vkh9pEV9FsHmzxyDquBLZd4Skpj4Vigd2xRN6EDC/ec4q97
         TQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SuIRDj1GtYEjEKy6On0tOyojBxKKXq5n1ccRPplAnLk=;
        b=WvlmCQuDyuQCoUph6EdjRFgNgPfcuymrbeNBodtLnhK643zd6dNQ/u8wUx1HWA0QDk
         /Vae7rAXMKq/c9ZIlY1/yO+wuXrSkyC/vh96dwpOE6mXJKtd0pdo+/NdiF0hZiY52xbA
         Nk/aJagIPQKAtZOUdzfC3vZAY8YrMnshPXy5KkxRmmIwYKJw0B6pV+FcBN51hfQS9L0Z
         PH5SMk0PoWRZm43opYikkh1gz7IRWCfEiiZxXDtjupyRZxAgAjSqFpc8Q4aOSqAO1kJj
         M6QEPOB6dO86gp5Iv8IRcGGF/7vk0hIKmRbDaSyZsSHpy4pgUmlVM9uWSRusiXvFY7f2
         9TEQ==
X-Gm-Message-State: AOUpUlGqM3cR7Ei7GzwdvQZJgm1WaimnzJDrKm5WWmPqGAbjkqLbrclA
        PdRaHP251hQhq+EQ/LkRwTAXJcWUKcE=
X-Google-Smtp-Source: AAOMgpe5NDdaI/ioEsINe9ZJxVvEcdRHIVbFa0VtV9MswRO9sUnc1VC0YMSkIwV26E0EqbJaZmMlPQ==
X-Received: by 2002:a37:4b46:: with SMTP id y67-v6mr2854689qka.207.1531424419072;
        Thu, 12 Jul 2018 12:40:19 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:18 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 08/23] packfile: generalize pack directory list
Date:   Thu, 12 Jul 2018 15:39:25 -0400
Message-Id: <20180712193940.21065-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of sharing the pack directory listing with the
multi-pack-index, generalize prepare_packed_git_one() into
for_each_file_in_pack_dir().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 101 +++++++++++++++++++++++++++++++++--------------------
 packfile.h |   6 ++++
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7cd45aa4b2..ee1ab9b804 100644
--- a/packfile.c
+++ b/packfile.c
@@ -738,13 +738,14 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
+void for_each_file_in_pack_dir(const char *objdir,
+			       each_file_in_pack_dir_fn fn,
+			       void *data)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
 	DIR *dir;
 	struct dirent *de;
-	struct string_list garbage = STRING_LIST_INIT_DUP;
 
 	strbuf_addstr(&path, objdir);
 	strbuf_addstr(&path, "/pack");
@@ -759,53 +760,77 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
 	strbuf_addch(&path, '/');
 	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
-		struct packed_git *p;
-		size_t base_len;
-
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
 
-		base_len = path.len;
-		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
-			/* Don't reopen a pack we already have. */
-			for (p = r->objects->packed_git; p;
-			     p = p->next) {
-				size_t len;
-				if (strip_suffix(p->pack_name, ".pack", &len) &&
-				    len == base_len &&
-				    !memcmp(p->pack_name, path.buf, len))
-					break;
-			}
-			if (p == NULL &&
-			    /*
-			     * See if it really is a valid .idx file with
-			     * corresponding .pack file that we can map.
-			     */
-			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(r, p);
-		}
-
-		if (!report_garbage)
-			continue;
-
-		if (ends_with(de->d_name, ".idx") ||
-		    ends_with(de->d_name, ".pack") ||
-		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep") ||
-		    ends_with(de->d_name, ".promisor"))
-			string_list_append(&garbage, path.buf);
-		else
-			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
+		fn(path.buf, path.len, de->d_name, data);
 	}
+
 	closedir(dir);
-	report_pack_garbage(&garbage);
-	string_list_clear(&garbage, 0);
 	strbuf_release(&path);
 }
 
+struct prepare_pack_data {
+	struct repository *r;
+	struct string_list *garbage;
+	int local;
+};
+
+static void prepare_pack(const char *full_name, size_t full_name_len,
+			 const char *file_name, void *_data)
+{
+	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
+	struct packed_git *p;
+	size_t base_len = full_name_len;
+
+	if (strip_suffix_mem(full_name, &base_len, ".idx")) {
+		/* Don't reopen a pack we already have. */
+		for (p = data->r->objects->packed_git; p; p = p->next) {
+			size_t len;
+			if (strip_suffix(p->pack_name, ".pack", &len) &&
+			    len == base_len &&
+			    !memcmp(p->pack_name, full_name, len))
+				break;
+		}
+
+		if (!p) {
+			p = add_packed_git(full_name, full_name_len, data->local);
+			if (p)
+				install_packed_git(data->r, p);
+		}
+	}
+
+	if (!report_garbage)
+		return;
+
+	if (ends_with(file_name, ".idx") ||
+	    ends_with(file_name, ".pack") ||
+	    ends_with(file_name, ".bitmap") ||
+	    ends_with(file_name, ".keep") ||
+	    ends_with(file_name, ".promisor"))
+		string_list_append(data->garbage, full_name);
+	else
+		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
+}
+
+static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
+{
+	struct prepare_pack_data data;
+	struct string_list garbage = STRING_LIST_INIT_DUP;
+
+	data.r = r;
+	data.garbage = &garbage;
+	data.local = local;
+
+	for_each_file_in_pack_dir(objdir, prepare_pack, &data);
+
+	report_pack_garbage(data.garbage);
+	string_list_clear(data.garbage, 0);
+}
+
 static void prepare_packed_git(struct repository *r);
 /*
  * Give a fast, rough count of the number of objects in the repository. This
diff --git a/packfile.h b/packfile.h
index e0a38aba93..d2ad30300a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -28,6 +28,12 @@ extern char *sha1_pack_index_name(const unsigned char *sha1);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
+typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
+				      const char *file_pach, void *data);
+void for_each_file_in_pack_dir(const char *objdir,
+			       each_file_in_pack_dir_fn fn,
+			       void *data);
+
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
-- 
2.18.0.118.gd4f65b8d14

