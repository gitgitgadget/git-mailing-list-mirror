Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D1F2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbdHGVTW (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:19:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37910 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbdHGVTV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:19:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id h75so1441168pfh.5
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keRH6BHEvKwLuE2Lkig6db25DdaV8ZNSej4AIJa+8R4=;
        b=j0lOQ1F7YZE+hU4OcFt4+yFlGBgehZBkMgjPD0LzMbtn7OCD//MNIHDtdvlaRue11O
         Xj5bVNCWcLhGShhpkMaIDbbBka8uO2uTxHPHYngeM7Y/m+rjmDCJUdLY9s71OwXob8c/
         G9XKIdv5ls8yrpmAzLhhH9iEm6zqodvyJIlxJwDcIDD7+6EOXdtK0ueP3Ryu8jiFBY4C
         ofdlOSAI6E3S6HuogsoDs05zgWk2KQQcJxRQGA9UNxvK7jKRoYN4gZ5jMK6QyzVkCWnH
         s6YWaFxUMfrONvhacRajsz9H+ozSgZ+icqnWJxeDHAUEjFXFK5YkXjMm82SQIJ1FgR40
         b54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keRH6BHEvKwLuE2Lkig6db25DdaV8ZNSej4AIJa+8R4=;
        b=HvbK+1xcgohCy0WHCb71bWCmny4GO+0driMQssZjVj3jEJ+e8ElOJlQVvSIOTFLI+3
         IB38gegyYvZXhTzs3YniXnf9G4/YsBYUiXtRgKxCfdM5/z9zPdiyc7kvLA9mxZXyiwRt
         qH7phgI9ExE+vDlmBS0dVcN/c9aWMNMGFtbiA1UufbS02MKT7t84qUJeStX2Ad01Qavy
         N9JeYa5y+Ceh5DIk19AAG4ndcI1NHoKQGpwZsQgBwLvNZsVfx733mS+qoScqqJVq1n5w
         sUGWIsnZySHq2yMChU5RELdGvZ9GH3KPjhgby50lixPb0oTXQcpb9oSpI3eGOs0aOKI/
         E6vQ==
X-Gm-Message-State: AHYfb5iaHd/4ktgqFPexpwXm9I5i9sL/3moDngtopRz/hu+3rjDLcp7U
        Eq2B+/od9F7YS+bPetI=
X-Received: by 10.99.98.5 with SMTP id w5mr1848749pgb.354.1502140760583;
        Mon, 07 Aug 2017 14:19:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6016:3285:fd77:5453:49e2:f3b5])
        by smtp.gmail.com with ESMTPSA id z127sm15141084pfb.64.2017.08.07.14.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 14:19:19 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 02/13] submodule--helper: introduce for_each_submodule_list()
Date:   Tue,  8 Aug 2017 02:48:49 +0530
Message-Id: <20170807211900.15001-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170807211900.15001-1-pc44800@gmail.com>
References: <20170807211900.15001-1-pc44800@gmail.com>
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

