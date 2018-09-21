Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6490F1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeIVE1j (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:39 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:57301 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVE1i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:38 -0400
Received: by mail-yw1-f73.google.com with SMTP id v144-v6so6503221ywa.23
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wHEd51gby15KfcydoxWBo+N4NGlmZgwD+vuLVkHalLM=;
        b=S9LICF+5jxVRszt/Hqh8JrBc50jXrXAW32k5k0oTLiT2+9Q0AGs3Yi32zulbFfXbJw
         XCmAT23hRz56/GUmv7mXEfq5/j5bVTb96+K1nnRwI9HuzRlX0CkwdevAXir8cBhRFM+M
         JW4a8+Zu9imsBDG5VVOY754HjuOKd6fRLg188mJVlC0jY63i8NWoRtzxKVpGdmcgXXMd
         MgHPlyOFlHfKbX8n+U8goTAgVXmHa9WkDC+AXv5VmylX6Egzh2UdNcLYnF6+XSfLBIXd
         z3+uMs0z+AdaAh5tdhhxf6Br+IQ6QXFi0ipwVZ32Vv+UwNxNC+O6Z3TiY/gi5L6NuU4J
         5ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wHEd51gby15KfcydoxWBo+N4NGlmZgwD+vuLVkHalLM=;
        b=MTWGeSAlzx4N9vR9K6Njv+brBEYnZz96fNoNVoyFsWUOp1rOa3qoC/NkT+gn3HVWZH
         p4sFbVYGZmNKvCEy0bDzjmT1lxcxAEFaOYeR+y3BX749N6eXmCnhXnfW0GQN4TEExzt6
         vhAAOX6AFWG2rvImil2tHY8ClVT3ZfZHKV47twKwcEe8hGwG7wJRFXeM+aGYhBDsYd/D
         358MH961KbE4xbW7OOPpE36yCeYnq6KBSyJNlB/00Pdh3XV7M4pgqNauB49EECHxiJjQ
         Y4mzRUNrox4pQUzkpG1JuykxqwdgqkSlpGcghenflvUgzJqycGEBNDs78AsIXzGv1ylZ
         aNVA==
X-Gm-Message-State: APzg51CwiFK0Iu0ho6nBQq8DQh3GqlA+Wcls3p8J5zk6iw5BWYyFHT5R
        1sOz7X+EKIRo+2wCFxAxkTukHf94JsHXK2vysYbYDekjhziSmEHlVZFkoY8zaszD6m0+mWLw0MI
        reNu2jiMJvzaaPOnsyB4vTNg4N820Agvn+SsfBy/ygf+vxesx2Fw5vcf0avdl
X-Google-Smtp-Source: ANB0VdZgfhVmK2B399khe5l5RXTtbv5hjXsO61Nq70IO0m1tFFmaiEfP2l5lR2knxiIn51NlWBl388ffaM+T
X-Received: by 2002:a81:2988:: with SMTP id p130-v6mr4107697ywp.25.1537569402073;
 Fri, 21 Sep 2018 15:36:42 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:54 -0700
In-Reply-To: <20180921223558.65055-1-sbeller@google.com>
Message-Id: <20180921223558.65055-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 4/8] submodule: move global changed_submodule_names into fetch
 submodule struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `changed_submodule_names` are only used for fetching, so let's make it
part of the struct that is passed around for fetching submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2f5c19d0aac..7b4d136849b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -25,7 +25,7 @@
 #include "commit-reach.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
-static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
+
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
@@ -1111,7 +1111,22 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(void)
+struct submodule_parallel_fetch {
+	int count;
+	struct argv_array args;
+	struct repository *r;
+	const char *prefix;
+	int command_line_option;
+	int default_option;
+	int quiet;
+	int result;
+
+	struct string_list changed_submodule_names;
+};
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
+
+static void calculate_changed_submodule_paths(
+	struct submodule_parallel_fetch *spf)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
@@ -1149,7 +1164,8 @@ static void calculate_changed_submodule_paths(void)
 			continue;
 
 		if (!submodule_has_commits(path, commits))
-			string_list_append(&changed_submodule_names, name->string);
+			string_list_append(&spf->changed_submodule_names,
+					   name->string);
 	}
 
 	free_submodules_oids(&changed_submodules);
@@ -1186,18 +1202,6 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 	return ret;
 }
 
-struct submodule_parallel_fetch {
-	int count;
-	struct argv_array args;
-	struct repository *r;
-	const char *prefix;
-	int command_line_option;
-	int default_option;
-	int quiet;
-	int result;
-};
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
-
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
 {
@@ -1258,7 +1262,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
 			    !string_list_lookup(
-					&changed_submodule_names,
+					&spf->changed_submodule_names,
 					submodule->name))
 				continue;
 			default_argv = "on-demand";
@@ -1350,8 +1354,8 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths();
-	string_list_sort(&changed_submodule_names);
+	calculate_changed_submodule_paths(&spf);
+	string_list_sort(&spf.changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
@@ -1360,7 +1364,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&changed_submodule_names, 1);
+	string_list_clear(&spf.changed_submodule_names, 1);
 	return spf.result;
 }
 
-- 
2.19.0.444.g18242da7ef-goog

