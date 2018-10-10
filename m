Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9E61F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeJKFO2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:14:28 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:51823 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:14:28 -0400
Received: by mail-qk1-f201.google.com with SMTP id x75-v6so6242599qka.18
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eZ+1/Zj9J2LmeHnKPnCj7udopPQcSJzE0rZTARKQ0OA=;
        b=oPjd27PvDHSHZ2R3YyN31C/Gceq5H+r4j/bR1ag5SGOJ76ybP8o+ftElhFnchySrVz
         qyQRjlJPEK544jGQhQIA5ZpdNlzqrfjmWpKdyMFGj0xk7VVHVMmeC/bNxUlGhUAahCrq
         ZBB6IwcT1nIaA5wnEpV1Drv8VSnsScHMVFvvEeDpXhF3wz/oT26/2wF++/h8maiNHUVY
         gPzmrlWlOlyjWLkiizOyNIrFS/aFkPYflN9HRYsSW763WchBITBd2B4IMXmPp+FCkHYC
         /DJOSgOzWTgrdvTliyes9zdLtAVsMRose/AbwFzWPpNhiiyZpTlWg3iK1/qwS5r8TEgU
         4GPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eZ+1/Zj9J2LmeHnKPnCj7udopPQcSJzE0rZTARKQ0OA=;
        b=fP1EeAyVQvGx0iKP3Me3c4Y99uT8PCRxqhwo8LyJtpb03ZFEcUGCtFWdCbXAQHdKSV
         hxCWQKq3mlBxJh/Z0lvhVcm+KYgd2vQU/JgxObyyPiHb7eOWKz1b4ZpEavyeqie9TiE4
         KBylEKtwGFcVZRZIf85J4Ip4TynWdk8rACYNlbxylRCxV3gNq7ffU1v5YbPZf4gtFJej
         cIUdQo7PcfxyfiGAbne3t0evvmK4hLYbCpjcotfgKGtvqkkB0gKDzdAIHgit9acaxlzi
         gE4H3ZccRlgpSWTYZAO0bMSRWRFjWwh6oaTwN13mYTjsSsTv3KpX5VGSpf68bp+Tg7MM
         bbaQ==
X-Gm-Message-State: ABuFfoiOa615lhVFbnAfG+BDR2ph53tvvbnA5jrCGGYrFkgEC6Wq4JNl
        lWLY+a5ke2ZgwkWdunPecYJYdsF0uiN6cgYmnM9J2fpuXg1l1qhFVrvsyaUtH3/o90889KJDkDc
        ggUcRfJjR8ie/pCijTsSEGbxhIAeUA+we+bxIhYk3Ud7lyeXB1gTzPhUUe7oR
X-Google-Smtp-Source: ACcGV62hwK5LM6WEJROyvN3VBZ0mmiPtIHcK8k6TpLSc+4t8EY+MS4phJAMS43N4PzeXoWDaGA+axZhQBIlX
X-Received: by 2002:a37:6687:: with SMTP id a129-v6mr1800624qkc.7.1539208221960;
 Wed, 10 Oct 2018 14:50:21 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:03 -0700
In-Reply-To: <20181010215008.233529-1-sbeller@google.com>
Message-Id: <20181010215008.233529-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181010215008.233529-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 4/9] submodule.c: move global changed_submodule_names into
 fetch submodule struct
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
index 22c64bd855..17103379ba 100644
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
@@ -1110,7 +1110,22 @@ void check_for_new_submodule_commits(struct object_id *oid)
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
@@ -1148,7 +1163,8 @@ static void calculate_changed_submodule_paths(void)
 			continue;
 
 		if (!submodule_has_commits(path, commits))
-			string_list_append(&changed_submodule_names, name->string);
+			string_list_append(&spf->changed_submodule_names,
+					   name->string);
 	}
 
 	free_submodules_oids(&changed_submodules);
@@ -1185,18 +1201,6 @@ int submodule_touches_in_range(struct object_id *excl_oid,
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
@@ -1257,7 +1261,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
 			    !string_list_lookup(
-					&changed_submodule_names,
+					&spf->changed_submodule_names,
 					submodule->name))
 				continue;
 			default_argv = "on-demand";
@@ -1349,8 +1353,8 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths();
-	string_list_sort(&changed_submodule_names);
+	calculate_changed_submodule_paths(&spf);
+	string_list_sort(&spf.changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
@@ -1359,7 +1363,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&changed_submodule_names, 1);
+	string_list_clear(&spf.changed_submodule_names, 1);
 	return spf.result;
 }
 
-- 
2.19.0

