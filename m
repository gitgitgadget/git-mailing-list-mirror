Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A0D2047F
	for <e@80x24.org>; Sun, 24 Sep 2017 12:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdIXMJX (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 08:09:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37371 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbdIXMJU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 08:09:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id e69so2457288pfg.4
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f0iZXtutsl3y+IKcQPWO8VzSCnVktTt04i9K3OzYkFc=;
        b=XhFRTtJIQ0jGpgwTsXLss62PYwNvxt575/WxWQiqlwVcYgcyM9NXpueNEPlojSzkII
         OPwvxuydmtVI5baTWnW6cVRefMuVHxdxFl68PjNlLh3vBk85Yk8Bt6+kb0sbcQeG0/JW
         g9+k4KQjF8TMof+LMsURRJI7ep0NKVVfLLjMJJN9A4T/UqIVX27vL7Tylwe3CtgjJcxH
         N/6ecMGRxmlTzzfKEJ/ANc8dNHe241+Spj2gohlzDkbP44nSQYPVPuKZL9nW8HhbG3HV
         T34qRqLn8Lmat8590AnW+Aq52NdE6Q9rrSYvUzeJ6IEkvnZSSWPN7rfWzdnt/5MZPJAu
         9YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f0iZXtutsl3y+IKcQPWO8VzSCnVktTt04i9K3OzYkFc=;
        b=c0WMgjE2uhfe0Ki08p0C1UYyzUpTpU6hwdB4QsKAyDibH0yTDbONFZCzgGGOYIq8I9
         fTZi2WxHY0kNhAaHsR94FEyWWofD+XGogpAG8MIb4hVgRJEBQd0Pa2RjsS9vDsV6LqLi
         J/KYZO4Ak0XK8X6/TOPGOTGQlnvKbChpxzlHf6as4Q0ltSoJbo/3b3hvhd2dk+DhP8RM
         dEMzP1PiazvEgkhymxmWZcIj4m9xs/o9H49xAUtIdWXu+etmy7EMkSFRKdQi21WNmcPC
         kXzMNpiOg4oeAF6odD1SVs2VkDVoHh0ndowiyKcjArxESQPBYDjzNmS7IhtVb5EG6vpr
         X9dA==
X-Gm-Message-State: AHPjjUgluwS3bFFo36SlVbq1vUAH+PZYMHhHb3XSXcQMJ4pXDPwR9ilS
        c1Pe9B1ot8X0Z/2k8INDMXI=
X-Google-Smtp-Source: AOwi7QDL0sxOcgFluu4aOt70NUIn4IkHWdQOUmC87SsNtQl5pBIvClqITbZ3BTjKKqaFsyZesJTFog==
X-Received: by 10.84.150.101 with SMTP id g92mr4633061plg.168.1506254959952;
        Sun, 24 Sep 2017 05:09:19 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.87])
        by smtp.gmail.com with ESMTPSA id 65sm6908123pgh.31.2017.09.24.05.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Sep 2017 05:09:19 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     hanwen@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        pc44800@gmail.com, sbeller@google.com
Subject: [PATCH v5 2/4] submodule--helper: introduce for_each_listed_submodule()
Date:   Sun, 24 Sep 2017 17:38:56 +0530
Message-Id: <20170924120858.26813-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170924120858.26813-1-pc44800@gmail.com>
References: <20170921161059.11750-1-hanwen@google.com>
 <20170924120858.26813-1-pc44800@gmail.com>
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
index d24ac9028..d12790b5c 100644
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
@@ -352,15 +355,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
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
@@ -372,7 +390,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_active(the_repository, path)) {
+	if (!is_submodule_active(the_repository, list_item->name)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 		strbuf_reset(&sb);
@@ -414,7 +432,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!info->quiet)
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -443,10 +461,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -471,8 +489,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
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

