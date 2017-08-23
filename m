Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2EC520899
	for <e@80x24.org>; Wed, 23 Aug 2017 18:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932530AbdHWSTk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 14:19:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34045 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdHWSTi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 14:19:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id p14so237954pgd.1
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=32m9Ne+IQkCbx0UET7LePGzD1e1fUjkheTysHwsJwRw=;
        b=K5ifTRWTnT9MZaxC3oSzYvyohXJ4g/wmNV0kW2wunqMyG8RBcYV9hj6nExxPC2QlaQ
         4Oq8QIy8e8lRjWFjRMUf1KsMb65XMT8749F/FJu3qREz1DyxCIDBKjXWLENx9pKxT5vT
         l4RDKppmmVcdwzwE62P4XOwi2kEwxYqhbH9i9anqybWsF2B1MKLWzM11J03Z6UuItZE/
         qFTZ1j8sdnIlbx8hLTBAiDkrdsr++AEdXLANJMmeg0fbMQ3LWZlZLxIRvAvLcoGockgo
         No+qQL0JmffTzeDELHQFVK2f0zxQOPEc352iz8jae0UB98ARxIc5/upDKScwj7KJjQgx
         XYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=32m9Ne+IQkCbx0UET7LePGzD1e1fUjkheTysHwsJwRw=;
        b=cisTMBKbqP9qoKm+n6xpm8PmATYl5+uX8jM+TRFhjQuWgYJ7EYYX7JX+DbQhl3i6Qi
         qEu/bI9SNxSdHkBIiQCM2nNpWTYDqdOFY5nxAqosOVXqRGkjcJuGH7dstWwkRYLBewfc
         NJ8ix4hLWtmrT8FUB5O+wqiKfWjT8EzggCCMSA17XjsOfVMSfTpfxHzVg8OeJq8Y5PGl
         TVPgCxD7++fopSaUcZY4LTU9RCWbZauKlRr7DSbxX93tHHfNdwceVM/jai9u6qlMJgC4
         L+FYk1RYWqfHC/CcjwoJXD867mfy6chRyxOeH9nNYIlXH01RmajjPVk/UuTtBelCK4K2
         Psxw==
X-Gm-Message-State: AHYfb5hMY/dDA+rk37/AfmAsNOl/D0dEy6BhBDDmYx5Shj5KBnc3yPqd
        SuuvMMlLYQJewQ==
X-Received: by 10.99.140.75 with SMTP id q11mr3584803pgn.159.1503512377499;
        Wed, 23 Aug 2017 11:19:37 -0700 (PDT)
Received: from localhost.localdomain ([27.63.165.170])
        by smtp.gmail.com with ESMTPSA id 74sm5007812pfk.58.2017.08.23.11.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Aug 2017 11:19:36 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v2 2/4] submodule--helper: introduce for_each_submodule()
Date:   Wed, 23 Aug 2017 23:45:04 +0530
Message-Id: <20170823181506.8557-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170823181506.8557-1-pc44800@gmail.com>
References: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com>
 <20170823181506.8557-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function for_each_submodule() and replace a loop
in module_init() with a call to it.

The new function will also be used in other parts of the
system in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e666f84ba..847fba854 100644
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
@@ -353,17 +356,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void init_submodule(const char *path, const char *prefix, int quiet)
+static void for_each_submodule(const struct module_list *list,
+			       submodule_list_func_t fn, void *cb_data)
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
 
-	/* Only loads from .gitmodules, no overlay with .git/config */
-	gitmodules_config();
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(&null_oid, list_item->name);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -375,7 +391,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_active(the_repository, path)) {
+	if (!is_submodule_active(the_repository, list_item->name)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 		strbuf_reset(&sb);
@@ -417,7 +433,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!info->quiet)
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -446,10 +462,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -474,8 +490,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
 
-	for (i = 0; i < list.nr; i++)
-		init_submodule(list.entries[i]->name, prefix, quiet);
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+
+	gitmodules_config();
+	for_each_submodule(&list, init_submodule, &info);
 
 	return 0;
 }
-- 
2.13.0

