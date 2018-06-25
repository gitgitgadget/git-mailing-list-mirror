Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55C01F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934454AbeFYOfJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:09 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40768 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934446AbeFYOfF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id x23-v6so1924497qto.7
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TcHn+W9hCybJ701qFtRDbvbbE/J/3ze90QBNtCy65Nw=;
        b=rZmGGWhIosLP/G3S0Q2Byi/meohdl6bhtim97BYsg3rT6Q7T8oAqZhsWFUnF05Jtxa
         uuqAFom4H3i5AXR93Bzec4Og7tMy8hof7qt53t9GeoL5YvzXJn4FjCT8qmlEOuszwxEZ
         Ld1vHobjbu9DOgrbfX+maY4JaU7bdd8ytsyIPZnRQv6d0lAXFuG4lsnfy/Gr6LJmymwU
         /tuX5uLkscJI2KZ0rVf/3+sFXxKzI7n4uNdMUnoBrWMuc2nP3LP3cZYvA730zhjBtWOV
         4VZp+y2l603zidBapWWp3ovd9jKud88fphIe2AQauiTG6oUq9AkloTl4BAUOFWyy1OYR
         WKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TcHn+W9hCybJ701qFtRDbvbbE/J/3ze90QBNtCy65Nw=;
        b=se5Bf9NCmejLhseRle/wrvUz5AV+guIlh2QtqxLTIcR0iSJVszsWzIEy0h8SVcHdio
         F+sVvqHrDAj4DSzo4r8GG51uarE/uKZdYlpDFDkkzOm7FXrfx4Fa7I7NhN14kYWgyJEg
         cVHjE0MNeWC+g34XlXdUZF0sakbNJ9xLBplYpzV0zHoJcH6LZJq4aRe4zdTjaYd+vCkG
         QASrqKkNUNdOGBHjftJBVVEn94GhFTEzYfSPxHJNW/1AQftUYEVmYikpX4/mqJIWYAoF
         8vxs3w/eV9bjzyflYx0CKmiKl7seiDEYDrRC69g8VExnYmh4kEIDJ2/MDAXQ45oriM/l
         e4ew==
X-Gm-Message-State: APt69E2KElNCLI1nQb4PP9wEIrENw1edXYS6EnYcJ8Kgdwu7DCQfNLQW
        nVJ/Kk8xhG6CenTmKAgu3wYC+7jq
X-Google-Smtp-Source: AAOMgpc2OfFLSbTzt1qpP1fQWe0i5gaV1ib5DqEfWIz9Smc9psnXz2FTyISo/kOOdB7Y7mnYb0CnnQ==
X-Received: by 2002:a0c:8cca:: with SMTP id q10-v6mr11285419qvb.33.1529937304387;
        Mon, 25 Jun 2018 07:35:04 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:03 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 08/24] packfile: generalize pack directory list
Date:   Mon, 25 Jun 2018 10:34:18 -0400
Message-Id: <20180625143434.89044-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of sharing the pack directory listing with the
multi-pack-index, generalize prepare_packed_git_one() into
for_each_file_in_pack_dir().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 103 +++++++++++++++++++++++++++++++++--------------------
 packfile.h |   6 ++++
 2 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7cd45aa4b2..db61c8813b 100644
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
@@ -759,53 +760,79 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
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
 
+struct prepare_pack_data
+{
+	struct repository *r;
+	struct string_list *garbage;
+	int local;
+};
+
+static void prepare_pack(const char *full_name, size_t full_name_len, const char *file_name, void *_data)
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
+		if (p == NULL &&
+		    /*
+		     * See if it really is a valid .idx file with
+		     * corresponding .pack file that we can map.
+		     */
+		    (p = add_packed_git(full_name, full_name_len, data->local)) != NULL)
+			install_packed_git(data->r, p);
+	}
+
+	if (!report_garbage)
+	       return;
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
2.18.0.24.g1b579a2ee9

