Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A204A1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 08:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfHEICz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 04:02:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38824 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfHEICy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 04:02:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so83381986wrr.5
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3/sUp5KwJIqExdm0cmEMLVPzfoPml6hpvWqPKiiQpQ=;
        b=jzaNKeaMZloMxzVgifE03o1jluK2uKmvCvhw1MxQYAK4bxokePcvUfib7RSSRosHXr
         mTS4gVgWWScgjEPxBY8YV2hfSSVGvIdW3shMvN6DjnEDhAkrQNT4XXPtyYRkg+khNevl
         R5It1EjrVlnSDBM+/6bSsevsJ3VCggeToTMJs7Sqag6lXsFD8hYIn8H/vIIV05EsGBZa
         Onu8An78SEKj3DL+fEgcZXrcNZT5edwzVMeCxft9dAKJv3aTneozPPK7fROmavo4CQw8
         R4R8zFUcM43jad2JWQrUSDNjjsaNVlFymz9OB7ZkWa1RyYSaGTcNNK+T0Lo5E7V7UjwZ
         T66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3/sUp5KwJIqExdm0cmEMLVPzfoPml6hpvWqPKiiQpQ=;
        b=Jq4wdxtbLVqfaqLiileXC35DSGwEEH/WN/0JBNNzZObQX/5UhzPibXPQgzp/AU2Vqi
         U3PTRmwy6CtDF2UBih/3qWdflaXDZKoOy8jku/8TZ447XnEZRKKMd2PSG6yORKYYexSD
         NUFLtmWbeC2u4PSTQTIo0zG8aFw+Rl8KZRZxQsWEZlPYjj1NCx8OYGgK5QBVG+Va/asQ
         GnEkBU38vvwank24bZdBHd+ge9neffI9r1MbfhcAC/trYERrgSL/vECqR3xOxACE9D0w
         tREikvyj2UwcB0IhCytf64/U06A0sIAXdLfohDH1OP1vF5DhOFrNbxHiVBXB31B9s5WG
         P/kA==
X-Gm-Message-State: APjAAAVgunIIynYEp7oXsue6KbnLtdVw4bI2iTXuUyvYYeB+lL/wmZ0f
        Edhoruz8H9CfooTVfXDw6/7Xae3grkE=
X-Google-Smtp-Source: APXvYqwYBWimrwMrkLc3T9TrPY/m9iMplxiIYcUruGDTn5mrfRkK7HcDgcQIGVXDua9hK3MmBqoE5Q==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr24400628wrv.63.1564992172913;
        Mon, 05 Aug 2019 01:02:52 -0700 (PDT)
Received: from localhost.localdomain (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id v124sm89514573wmf.23.2019.08.05.01.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 01:02:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] commit-graph: turn a group of write-related macro flags into an enum
Date:   Mon,  5 Aug 2019 10:02:39 +0200
Message-Id: <20190805080240.30892-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.309.g896d8c5f5f
In-Reply-To: <20190805080240.30892-1-szeder.dev@gmail.com>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/commit-graph.c |  6 +++---
 builtin/gc.c           |  2 +-
 commit-graph.c         | 11 ++++++-----
 commit-graph.h         | 13 ++++++++-----
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 38027b83d9..64eccde314 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -154,7 +154,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list *commit_hex = NULL;
 	struct string_list lines;
 	int result = 0;
-	unsigned int flags = COMMIT_GRAPH_PROGRESS;
+	enum commit_graph_write_flags flags = COMMIT_GRAPH_WRITE_PROGRESS;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -192,9 +192,9 @@ static int graph_write(int argc, const char **argv)
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 	if (opts.append)
-		flags |= COMMIT_GRAPH_APPEND;
+		flags |= COMMIT_GRAPH_WRITE_APPEND;
 	if (opts.split)
-		flags |= COMMIT_GRAPH_SPLIT;
+		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 
 	read_replace_refs = 0;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index c18efadda5..305fb0f45a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -687,7 +687,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (gc_write_commit_graph &&
 	    write_commit_graph_reachable(get_object_directory(),
-					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
+					 !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					 NULL))
 		return 1;
 
diff --git a/commit-graph.c b/commit-graph.c
index b3c4de79b6..04324a4648 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1133,7 +1133,8 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
+int write_commit_graph_reachable(const char *obj_dir,
+				 enum commit_graph_write_flags flags,
 				 const struct split_commit_graph_opts *split_opts)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
@@ -1750,7 +1751,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       unsigned int flags,
+		       enum commit_graph_write_flags flags,
 		       const struct split_commit_graph_opts *split_opts)
 {
 	struct write_commit_graph_context *ctx;
@@ -1771,9 +1772,9 @@ int write_commit_graph(const char *obj_dir,
 	if (len && ctx->obj_dir[len - 1] == '/')
 		ctx->obj_dir[len - 1] = 0;
 
-	ctx->append = flags & COMMIT_GRAPH_APPEND ? 1 : 0;
-	ctx->report_progress = flags & COMMIT_GRAPH_PROGRESS ? 1 : 0;
-	ctx->split = flags & COMMIT_GRAPH_SPLIT ? 1 : 0;
+	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
+	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
+	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->split_opts = split_opts;
 
 	if (ctx->split) {
diff --git a/commit-graph.h b/commit-graph.h
index df9a3b20e4..ae4db87fb5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -71,9 +71,11 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
  */
 int generation_numbers_enabled(struct repository *r);
 
-#define COMMIT_GRAPH_APPEND     (1 << 0)
-#define COMMIT_GRAPH_PROGRESS   (1 << 1)
-#define COMMIT_GRAPH_SPLIT      (1 << 2)
+enum commit_graph_write_flags {
+	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
+	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
+	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2)
+};
 
 struct split_commit_graph_opts {
 	int size_multiple;
@@ -87,12 +89,13 @@ struct split_commit_graph_opts {
  * is not compatible with the commit-graph feature, then the
  * methods will return 0 without writing a commit-graph.
  */
-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
+int write_commit_graph_reachable(const char *obj_dir,
+				 enum commit_graph_write_flags flags,
 				 const struct split_commit_graph_opts *split_opts);
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       unsigned int flags,
+		       enum commit_graph_write_flags flags,
 		       const struct split_commit_graph_opts *split_opts);
 
 #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
-- 
2.23.0.rc1.309.g896d8c5f5f

