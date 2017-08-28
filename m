Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6721D1F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 11:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdH1L43 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 07:56:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34995 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdH1L41 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 07:56:27 -0400
Received: by mail-pg0-f68.google.com with SMTP id r133so208973pgr.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PbRCT3IRBqpvi8w+1l51AmE0gyRzOK5w9DZhf1brNCE=;
        b=HX7ZRhhtP+XXGrBmSOrBWu72/sJWH+h96PyJWXQ8rRrrsM+nohl8pqfNvrtvmxJsSQ
         99EJ27+bprTu5nr/C8A5y7QTtukMXmQuqIMwpdBK1s0cicxw8X2NjD7V2JNE9XUWji2B
         uQK/QtSvujSfcctBF5dAOWtyn9Oy1jwGbHYmxi0id4OgesHljAc9x8//7lFc3Vyfk510
         FQ1oYE2PyMTLGHezooP4ufec04iiRsbTBSU1n4733qJCfYy4/0E5oPsYokxmTjQNQuNl
         rhopEkAr+LEqoUUno/F524rM62v2iHQ60nCjnRYolEGlFoOwYM6qkf3brdYgN/Xh2B/X
         bDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PbRCT3IRBqpvi8w+1l51AmE0gyRzOK5w9DZhf1brNCE=;
        b=X/EQfagm6dz4n0KFh99rXIJCCyCPP4b/B8F2PojOWqxwdwa0GG6Z6tqNQsGRPEumc/
         iJR92eaEZNwdwQ1Tdztr3phD0uiUD0hVS3Mvg23bfu2JGRjHLOvyXK+MnfltZteluUV4
         7gosCjggwLOtArFmYj9FmDY1coS5Apj0EO/ocVKKgjee77P9VOpERjSY8tAcDHRW24ND
         NVIhN+cbELZgwgjetINsTtTTbhoDSTBP6inHW69iyBpAE2qclw/933IOQBxxzzTE4+WW
         xVTtopa2QcpGXsOtZTZdjbxSIPHQb1fThcylm31tJjfNtY6yReSnvLQA0FTNNfvTGOCt
         Ii7w==
X-Gm-Message-State: AHYfb5gNwRaROIuQxPnpXZlpXovJrLQlIWcHdjUnexQ7BwGadyKTxTWT
        tnyvta8E9L0YLA==
X-Received: by 10.98.11.87 with SMTP id t84mr220806pfi.183.1503921387271;
        Mon, 28 Aug 2017 04:56:27 -0700 (PDT)
Received: from localhost.localdomain ([223.176.49.60])
        by smtp.gmail.com with ESMTPSA id h70sm748608pfc.92.2017.08.28.04.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 04:56:26 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v4 2/4] submodule--helper: introduce for_each_listed_submodule()
Date:   Mon, 28 Aug 2017 17:25:56 +0530
Message-Id: <20170828115558.28297-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170828115558.28297-1-pc44800@gmail.com>
References: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
 <20170828115558.28297-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function for_each_listed_submodule() and replace a loop
in module_init() with a call to it.

The new function will also be used in other parts of the
system in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e25854371..ea99d8e39 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -14,6 +14,9 @@
 #include "refs.h"
 #include "connect.h"
 
+typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
+				  void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -351,15 +354,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void init_submodule(const char *path, const char *prefix, int quiet)
+static void for_each_listed_submodule(const struct module_list *list,
+				      each_submodule_fn fn, void *cb_data)
+{
+	int i;
+	for (i = 0; i < list->nr; i++)
+		fn(list->entries[i], cb_data);
+}
+
+struct init_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+};
+#define INIT_CB_INIT { NULL, 0 }
+
+static void init_submodule(const struct cache_entry *list_item, void *cb_data)
 {
+	struct init_cb *info = cb_data;
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(&null_oid, list_item->name);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -371,7 +389,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_active(the_repository, path)) {
+	if (!is_submodule_active(the_repository, list_item->name)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 		strbuf_reset(&sb);
@@ -413,7 +431,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!info->quiet)
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -442,10 +460,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -470,8 +488,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
 
-	for (i = 0; i < list.nr; i++)
-		init_submodule(list.entries[i]->name, prefix, quiet);
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+
+	for_each_listed_submodule(&list, init_submodule, &info);
 
 	return 0;
 }
-- 
2.13.0

