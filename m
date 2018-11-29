Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED201F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeK2Lbi (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:38 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37784 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeK2Lbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:38 -0500
Received: by mail-qt1-f202.google.com with SMTP id h17so190542qto.4
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gqLB1myZxel5xx7uyxBgqY5OupazpyBAhfKOVin3hXs=;
        b=YGnT3RFL2qwk3o7GDfTHq7o7QW7jWSs81O3MQ3WYfWC/b5bTD+vhv547zAyu4B7Uyj
         KbzLJGsfHcMQmbHo/Y+/QJABzV/+0Xeg78CVihuqkP7h9HwWnT08lrrsufwbldks+uA4
         /JmCzy+fasfapjYKXIeMr3PeTgz7ErnlwoDc1aVLrTFbOluixOFcugoRysL3q7x6VBB3
         wG0p9WhDNGIGIO9GhGNm9C8vakBetqXDHOx1e7HwRbqN80o75BZTb1lQ7t7YFW5fQ4aa
         YsLHbGWIlPVkwVf3nUmyoFxQcCfkfq5Ft3m8q5R7CCFkLs8oXo1gFATDmIy3AchQGI0r
         gJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gqLB1myZxel5xx7uyxBgqY5OupazpyBAhfKOVin3hXs=;
        b=n4xWgW3NNn6DV8E5QiJpUSXxfe9yQw8rv+P1fx2KQh9hMuD4lqUvCx6hCunUwb7aaZ
         0SDHGhhEKWbWmotCqjxyVJny55gYStWYl/z8tinxCEEnYpkpBhIzBldzJrsd9pjDsyCn
         1UaEFwrFrBW7vjMG6eLXN1dkRH4yLGZl+l4PmNLb/tDuPdOLN0ls0RHflEII4RlXN/1F
         5uM+SFNZ12zKiZDAZpYr+m+s+LTrKJaBqexxCMPHIcUQA6qB4nJH/HXfgu2Itpg+h+H8
         9lI0lpSOIyA6s2uPTQ7rkl2Pen3IZDpcufE5puSJV4SSif2UPISb8mN/SVO7ScYA7qAP
         Lflw==
X-Gm-Message-State: AA+aEWaMMYMlBXTEIT135MplS8Av+P/y8vcXCdn5ZnFMQlphUWoxMMvN
        WUocU34wORPy0Aqjxrkrrb0vlGYsmgRcfP4mlKe2r3H2J2Fq73pZaf4Wg5NbnhSvz/J9M3cgx5q
        kUReDl2ah6lUha5NY8ODQMAfZo71DdYdDy6HONYnnFE9aINqc2G0Aw4H7aXAg
X-Google-Smtp-Source: AFSGD/XIMDu3am1lmwVMpvmsGT4GN8gVGo8DYY6tzQf5xQIQeoQOP43eMbN8MVg3GHpssvjwJ29K6rmv8B1D
X-Received: by 2002:ac8:4046:: with SMTP id j6mr5262147qtl.29.1543451290013;
 Wed, 28 Nov 2018 16:28:10 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:51 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 4/9] submodule.c: tighten scope of changed_submodule_names struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `changed_submodule_names` are only used for fetching, so let's make it
part of the struct that is passed around for fetching submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3c388f85cc..f93f0aff82 100644
--- a/submodule.c
+++ b/submodule.c
@@ -25,7 +25,6 @@
 #include "commit-reach.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
-static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
@@ -1136,7 +1135,8 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(struct repository *r)
+static void calculate_changed_submodule_paths(struct repository *r,
+		struct string_list *changed_submodule_names)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
@@ -1174,7 +1174,8 @@ static void calculate_changed_submodule_paths(struct repository *r)
 			continue;
 
 		if (!submodule_has_commits(r, path, commits))
-			string_list_append(&changed_submodule_names, name->string);
+			string_list_append(changed_submodule_names,
+					   name->string);
 	}
 
 	free_submodules_oids(&changed_submodules);
@@ -1221,8 +1222,10 @@ struct submodule_parallel_fetch {
 	int default_option;
 	int quiet;
 	int result;
+
+	struct string_list changed_submodule_names;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
 
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
@@ -1284,7 +1287,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
 			    !string_list_lookup(
-					&changed_submodule_names,
+					&spf->changed_submodule_names,
 					submodule->name))
 				continue;
 			default_argv = "on-demand";
@@ -1376,8 +1379,8 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths(r);
-	string_list_sort(&changed_submodule_names);
+	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
+	string_list_sort(&spf.changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
@@ -1386,7 +1389,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&changed_submodule_names, 1);
+	string_list_clear(&spf.changed_submodule_names, 1);
 	return spf.result;
 }
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

