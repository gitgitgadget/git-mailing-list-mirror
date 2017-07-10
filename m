Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C56C20357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755029AbdGJWyZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:54:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35442 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755026AbdGJWyY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:54:24 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so14320790pgc.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keRH6BHEvKwLuE2Lkig6db25DdaV8ZNSej4AIJa+8R4=;
        b=eaqzBBGOSI7mdG3Lr2aFRAamZkCux3mAQRZu2eOixxeoZEfHFUMAfTdxax++BDk3Yg
         /lgWjZm8r9JM6QnjR+xaMTUZNV32QvZtkeEWxSCpYOIb/+kzMym3/3p0TKNTIwTA9wLz
         s0IDcgjnZ96r5EmAxWqefF/T0OXTL0WC/YTsI2+q50goEZrrnfpsPm/t5FhKpKv0M6G4
         973G5lSwTb6QrPcdxUgI8UTbRhpej+ObxlRdCyTxLpxquoOQUzq4gaFiYx9fgs+lF0xh
         /pUvDl11a3XYWTEARt3cg3Ma+KSHJFRCJGs9GIn277QA/RTxvvGuH0fjCreJx0PpvesM
         oKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keRH6BHEvKwLuE2Lkig6db25DdaV8ZNSej4AIJa+8R4=;
        b=f5dpU/sxOEiALMd82kzb4pWigHa/MLTi5lYLUssxsCPVmr831T2LurMy6lSxf+CRFx
         E31nDIjOwV8P3eCuqWElL3qA7FrSyGrT/Vyq3BEEyH0Fxz1tuuMnbX54KPYwJ8JlzO+V
         qWGrtYqKn5Yw5eKyYFUMeEB4ZTAzJVvpZdeQinxsrUJsuVqHWruLch1Xxk5syuUcZACB
         JcUIW9hI/g8q/DZ7wFDUVtib+1h3DCgl/kvlyoHUM7CHyxqsfwrAc77Kz89KYtV10tGJ
         28/I12SB6lFVmFiDUr8GC+T4ZYUuSnQy5dHanISjdMzokVPFEUYrjnvn13ReDHU7iNSl
         Nn7g==
X-Gm-Message-State: AIVw110ND3Cr4PQ38fUnL7N25CHl3i8ZZagViVriYRlSpW0p9QWRUhQ1
        Ty7RYLSSaVI+6d9f
X-Received: by 10.84.130.46 with SMTP id 43mr20976229plc.128.1499727263671;
        Mon, 10 Jul 2017 15:54:23 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id o6sm20586774pgs.43.2017.07.10.15.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:54:23 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 2/8] submodule--helper: introduce for_each_submodule_list()
Date:   Tue, 11 Jul 2017 04:24:01 +0530
Message-Id: <20170710225407.29344-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170710225407.29344-1-pc44800@gmail.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
 <20170710225407.29344-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function for_each_submodule_list() and
replace a loop in module_init() with a call to it.

The new function will also be used in other parts of the
system in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7af4de09b..e41572f7a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -14,6 +14,9 @@
 #include "refs.h"
 #include "connect.h"
 
+typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
+				      void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -352,17 +355,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void init_submodule(const char *path, const char *prefix, int quiet)
+static void for_each_submodule_list(const struct module_list list,
+				    submodule_list_func_t fn, void *cb_data)
 {
+	int i;
+	for (i = 0; i < list.nr; i++)
+		fn(list.entries[i], cb_data);
+}
+
+struct init_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+};
+#define INIT_CB_INIT { NULL, 0 }
+
+static void init_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct init_cb *info = cb_data;
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	/* Only loads from .gitmodules, no overlay with .git/config */
-	gitmodules_config();
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(null_sha1, list_item->name);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -374,7 +390,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_active(the_repository, path)) {
+	if (!is_submodule_active(the_repository, list_item->name)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 	}
@@ -416,7 +432,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!info->quiet)
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -445,10 +461,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -473,8 +489,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
 
-	for (i = 0; i < list.nr; i++)
-		init_submodule(list.entries[i]->name, prefix, quiet);
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+
+	gitmodules_config();
+	for_each_submodule_list(list, init_submodule, &info);
 
 	return 0;
 }
-- 
2.13.0

