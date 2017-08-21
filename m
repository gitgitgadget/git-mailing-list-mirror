Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FFCD1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbdHUKpg (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:45:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38405 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdHUKpf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:45:35 -0400
Received: by mail-pg0-f65.google.com with SMTP id t3so2884783pgt.5
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8clmqVCUvWXybHY8hicL18Ugu4BDV889iPFs2v6kOKs=;
        b=fkFLXlGpfFp56EbVsfbqyodejv/81J9b3+3EYvyeJ/ErfZTzriUpGWSvjToSp+NThZ
         8FiFk5rrIpMygA2XTszMVUXlGi6lvGZUbuIkBKjkFl9EH1BF/75YHXxArW21aN/hJyg2
         Jp/FlptaAj6aIXX9jr+kQ5c7F4JRUDtA3W2+heqLOCPd8KGjVAGvKI1BVEC3enDODyko
         dMTMbpGooM0P1TGO02XV6nvC4R+x8P/1/K0fecoYo4jpsL60YvevSZLcJ3xKB9Sc2NCh
         H7Y8+ygdjdd2kzf1/Mq3RqdqGvr0oM5Wm5974riMyaIfOCc1RVGzfbeF/mzmYqihbBbO
         2H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8clmqVCUvWXybHY8hicL18Ugu4BDV889iPFs2v6kOKs=;
        b=tmjcA9aMZ6rAHYXsfHnIufLMka1qyANWodzM9vfVFq24HoDXiYHyC4rdOw4Uh1Mz/6
         xb5pATeZurUudySjvJdgFZDvq8cmKmZ9o7cr6ttOdgL1Sf2tAMm80xMP+cM/G6iYUD8T
         bKsVByIfbwnrVjd+SDTBWap/1mAN6OvyebcxC5z2+XEhis2x4rAtXqHK0CkBcZN3bMKn
         K9TKLa0Qi1nnIo1Grizyq3UeQ+fGL4sKpI5B+hYp8JC2RHAo1QAF/KmMj9JkxsWhCyOY
         3KHnhc330WHr6ZIS9iDZ6rRgzygosDagernOiLxiveh0HL0P/tmE+xJ8AfMwPN29mQIG
         1RCw==
X-Gm-Message-State: AHYfb5g3Pgrwf32VnHe4h+Dq2ebUX1CuKv0t03fV6Lw/OmhsMhDlU3B7
        iLjFUpwG6TareMluavk=
X-Received: by 10.98.59.90 with SMTP id i87mr17029859pfa.300.1503312334791;
        Mon, 21 Aug 2017 03:45:34 -0700 (PDT)
Received: from localhost.localdomain ([223.191.53.21])
        by smtp.gmail.com with ESMTPSA id l24sm20445785pgo.43.2017.08.21.03.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 03:45:34 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 2/4] submodule--helper: introduce for_each_submodule_list()
Date:   Mon, 21 Aug 2017 21:45:13 +0530
Message-Id: <20170821161515.23775-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170821161515.23775-1-pc44800@gmail.com>
References: <20170821161515.23775-1-pc44800@gmail.com>
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
index dcdbde963..7803457ba 100644
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
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(&null_oid, list_item->name);
 
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

