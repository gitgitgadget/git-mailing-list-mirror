Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5351F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeGFAxp (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:53:45 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38331 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeGFAxn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id c5-v6so8713532qth.5
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SuIRDj1GtYEjEKy6On0tOyojBxKKXq5n1ccRPplAnLk=;
        b=Dpbhx53f3sdlVDnufMyXo09RSrg4OcTBh65+cqSzTjPoLDO01RBkegmTjons9e90Pl
         wNxf1a5aXphmcZxBdUXuIxHFf8Ae1Umzvu6UAOIvWmDtk0+xXvBRHUmTalfUjNr14iNq
         QpI/S23KhBnrgliSuv9t/nQe1vuJuL/p3eTHaM2+yU6xqiQxEPD/6p3ElQG261znOt1g
         7JekutoE8wxCdGQsVUVPBNodRRrSunA3AkNy5+DKyKGlVK7AZvDXTb4T6/4ygSaLass2
         ru5RfSYUrBGghRzELLr6mHurpsCzRPTzyAUduJIC28HargssxUBBxx3Wr+8Eb+Jxl7uU
         WUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SuIRDj1GtYEjEKy6On0tOyojBxKKXq5n1ccRPplAnLk=;
        b=MKHkJ961ZeVeM1mMtI4ZbDoYfC+eraho8BdJDmCxE2BstfQQ6pynn/cIoJzbM51DQr
         b/VnV5QBHm4kxe1SHBMAG3o/YZZBTvpcst4jdWtigCE6PCiSOJCsMSueKBJADRsUdMwc
         a7SLSVjwdHZ7bOmdR0iUVUbhkPy66oludmdssPbpXxs/PcaxCco8bKBn2lJ5N7zvFrMs
         6d5xdwJl4B/2x/M4wAI2q4oz5W/88ICQutfcNFlGqZcf+8ZmHDQaJf0LK4nfmyBNCajk
         iL37Rxx7sh5G77w2Ax+/z8mt4nomNpK+TEO3z2jyI/yIkJWbrSvzBZewuXezHCF0MGKj
         nQWg==
X-Gm-Message-State: APt69E3K9lxD3kLcZcsngJqmfhpWP3sipiV27oFIKC1Eotf3eZsf1OlS
        gS+pgmVgolO9Q62BE+5klhD5YEXx
X-Google-Smtp-Source: AAOMgpc6wzj6a0xzmWMdDx3sckeEjZlc4gRfDb3PFA8tWUt1PZhH+D4686cTS4iE6FkZuNzir0NC3g==
X-Received: by 2002:a0c:b067:: with SMTP id l36-v6mr7185707qvc.176.1530838422268;
        Thu, 05 Jul 2018 17:53:42 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:41 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 08/24] packfile: generalize pack directory list
Date:   Thu,  5 Jul 2018 20:53:05 -0400
Message-Id: <20180706005321.124643-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
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

