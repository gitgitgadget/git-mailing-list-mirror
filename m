Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC27EC433E1
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F79B2078D
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT+Mi4xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGGOVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21912C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so37271822wrs.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aEHwcqpWSzg0KFz1mN1FeZx2rBghdU7iR3zJ8maPHmk=;
        b=uT+Mi4xrhFJkymzC6XIWNhvAk35ZfD9Ntu0QH89epuDaAohuvDjqNPc+Bo2Pu8+fiF
         j8WQuz+wYL5VDfqLHen9tl/34ZtpIitUU72e+TmY4QQZQhAGo7KIMoXSc4PrsNtHfKSc
         X+0N19Mev17hvE1EtAIBjXZzVWFZ7NrBjmLMKjfq5j+qUNsz8NHKj9VcBmLcknWBhT4d
         Khi7lOlFXj1d/P73OUgUAnCaugQhtkUaZ+faf1Yyg+bqNdgX6F21XDJIE+Mx3leFZI21
         hKXmZz2up3CzDQv9FYAN1mWspqAgZAGxxzHKIPcrvAAOWJpyPi0lzTc/msxKnmcJGTLa
         bd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aEHwcqpWSzg0KFz1mN1FeZx2rBghdU7iR3zJ8maPHmk=;
        b=FQQCML0dQVW86uMJ5SRuIzuCPJlvAYTxQxh6x6mFBK388649EbKa71Hv/OdANi1fd9
         L/5xFcSSyJOlwYrr9E5znvNoJov3ihZU3OZp6JGkunqi22ia6hkdEgk6KW+Xbona7WOy
         /VHXsIwawhE3QcMrGruxpzPBLD3EvK0rweDsLaTmNYZl7APlQBJZZxRRBl2zFM29XibT
         92AuNYjzeNd1DIvIlz6kobvDG1U8mn82tZFhidJT/W01csZ1y5rJ00ASi00DHGI6mv1W
         pNKO42F5yNfToVA8i7iuZWEjGcn1N0a9Z/OWsso8Q/RV3LHsuPJr4HJ+rEcLQOU8cb56
         imPQ==
X-Gm-Message-State: AOAM533NZEtOIWtt321jDWiX3lLsoSVMs+ZCtJs4lKPzdAfpl0nw37Dg
        piEMkVQw1YvXyNilqMmT4xubs4qK
X-Google-Smtp-Source: ABdhPJxicaKASpmxolzjPCOjt+8//TRbxqhKgz5T3PO6W7+n0HlT61Qetha54SIQjv394w+pWkD+AQ==
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr57995983wrr.226.1594131697662;
        Tue, 07 Jul 2020 07:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm1461581wrb.59.2020.07.07.07.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:37 -0700 (PDT)
Message-Id: <85dda7db28ddf2099ccd35924eb168964e55cf1f.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:15 +0000
Subject: [PATCH 01/21] gc: use the_repository less often
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In a later change, we will consume several static methods in
builtin/gc.c for another builtin. Before doing so, let's clean up some
uses of the_repository. These specifically are centered around accesses
to the packed_git list.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8e0b9cf41b..5c5e0df5bf 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -192,12 +192,13 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
-static struct packed_git *find_base_packs(struct string_list *packs,
+static struct packed_git *find_base_packs(struct repository *r,
+					  struct string_list *packs,
 					  unsigned long limit)
 {
 	struct packed_git *p, *base = NULL;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = get_all_packs(r); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		if (limit) {
@@ -214,7 +215,7 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 	return base;
 }
 
-static int too_many_packs(void)
+static int too_many_packs(struct repository *r)
 {
 	struct packed_git *p;
 	int cnt;
@@ -222,7 +223,7 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	for (cnt = 0, p = get_all_packs(the_repository); p; p = p->next) {
+	for (cnt = 0, p = get_all_packs(r); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
@@ -334,7 +335,7 @@ static void add_repack_incremental_option(void)
 	argv_array_push(&repack, "--no-write-bitmap-index");
 }
 
-static int need_to_gc(void)
+static int need_to_gc(struct repository *r)
 {
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
@@ -349,18 +350,18 @@ static int need_to_gc(void)
 	 * we run "repack -A -d -l".  Otherwise we tell the caller
 	 * there is no need.
 	 */
-	if (too_many_packs()) {
+	if (too_many_packs(r)) {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
 		if (big_pack_threshold) {
-			find_base_packs(&keep_pack, big_pack_threshold);
+			find_base_packs(r, &keep_pack, big_pack_threshold);
 			if (keep_pack.nr >= gc_auto_pack_limit) {
 				big_pack_threshold = 0;
 				string_list_clear(&keep_pack, 0);
-				find_base_packs(&keep_pack, 0);
+				find_base_packs(r, &keep_pack, 0);
 			}
 		} else {
-			struct packed_git *p = find_base_packs(&keep_pack, 0);
+			struct packed_git *p = find_base_packs(r, &keep_pack, 0);
 			uint64_t mem_have, mem_want;
 
 			mem_have = total_ram();
@@ -523,6 +524,7 @@ static void gc_before_repack(void)
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
+	struct repository *r = the_repository;
 	int aggressive = 0;
 	int auto_gc = 0;
 	int quiet = 0;
@@ -589,7 +591,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc())
+		if (!need_to_gc(r))
 			return 0;
 		if (!quiet) {
 			if (detach_auto)
@@ -623,9 +625,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 		if (keep_base_pack != -1) {
 			if (keep_base_pack)
-				find_base_packs(&keep_pack, 0);
+				find_base_packs(r, &keep_pack, 0);
 		} else if (big_pack_threshold) {
-			find_base_packs(&keep_pack, big_pack_threshold);
+			find_base_packs(r, &keep_pack, big_pack_threshold);
 		}
 
 		add_repack_all_option(&keep_pack);
@@ -652,7 +654,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	gc_before_repack();
 
 	if (!repository_format_precious_objects) {
-		close_object_store(the_repository->objects);
+		close_object_store(r->objects);
 		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
 			die(FAILED_RUN, repack.argv[0]);
 
@@ -678,15 +680,15 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		die(FAILED_RUN, rerere.argv[0]);
 
 	report_garbage = report_pack_garbage;
-	reprepare_packed_git(the_repository);
+	reprepare_packed_git(r);
 	if (pack_garbage.nr > 0) {
-		close_object_store(the_repository->objects);
+		close_object_store(r->objects);
 		clean_pack_garbage();
 	}
 
-	prepare_repo_settings(the_repository);
-	if (the_repository->settings.gc_write_commit_graph == 1)
-		write_commit_graph_reachable(the_repository->objects->odb,
+	prepare_repo_settings(r);
+	if (r->settings.gc_write_commit_graph == 1)
+		write_commit_graph_reachable(r->objects->odb,
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
-- 
gitgitgadget

