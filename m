Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76DAA1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJZIH0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:26 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37975 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeJZIHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:25 -0400
Received: by mail-qk1-f201.google.com with SMTP id l7-v6so2046147qkd.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=opfxhbaPBWglrWsOqD4QxeriUWyogeJbwgs6SADZz3M=;
        b=g7WM0Y5gr88DP9BeOPSkeKYmbwP3TyHkaMkS59cNzH1tIgPdmfk18wZwzkkZwvWUNE
         XsIrtlrtOOAmNmJTra9OrA3U8TyK8ADV8xoPzp5rraEF4mKNK5E4wiNSZ0R89H+0FI8a
         hUcZeALnsRcse+KPwWIKFgsbkMiuJRoEn7PCtHC9zYDmaILdPUHT/Bygln6YAAUrxCSj
         Ki2BDCQLEQ6cjLke/XBlmz8mJgS1rbcBI2KbSC6RY2nKLPPbZ1aHF2pYN+EPQ9QJDSX3
         9ZKnwEiCSLWZobdXoeVpppR4XSsc/H+KAsYUypeVgbkNsuZ2dl8cCrvl/1xpAoDrc0oP
         htwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=opfxhbaPBWglrWsOqD4QxeriUWyogeJbwgs6SADZz3M=;
        b=FIswfIi/oIIo+FJK3Xb2IR6j9tMWwdiBcM/yG3BDSofcuu4d8dVZLxboMzOcf2bQ/D
         OQEuUH5jWxPN11FPVtacMgMnra/xZkbY8fUct1TSvtbaC3TdpbJ8pjKT359b2+xC4t+v
         TvZIa/dT464Rzyy8dvklD6/+syn6+mRhj5KiQZl9JrODrqLQAIMh/FUdGx5e0SiL2G51
         /ZwIykHNx72zpqL3hmRR9t9Sp820uZKwGl7aKrpKlnMO1qA29JwFMGQwahnZQpYtkZM9
         i7htyx1C/QsTUk1OudQTYSOWk7bomXefmEhfCGcKq6lmbYuLL2pL8pjqGfF04xsKl6m/
         sfjQ==
X-Gm-Message-State: AGRZ1gLTZHCk6zfPuFuSX8TOwnLOHjRPbmwdbxpjeESXTJhiAx6y81s/
        8vZzCezz5aEidTb3hHhDoDjs9hjOMDFM
X-Google-Smtp-Source: AJdET5eb/7IqpPZ1WUhtJ+ng34I5aAClHs9AlZkE/U4t8wOcBzDt8U70/zTDEYBwVG39Ue21eU45X03m6sHv
X-Received: by 2002:a0c:b9a9:: with SMTP id v41mr1092571qvf.43.1540510366723;
 Thu, 25 Oct 2018 16:32:46 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:25 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 04/10] submodule.c: tighten scope of changed_submodule_names struct
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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
index 9fbfcfcfe1..6fb0b9d783 100644
--- a/submodule.c
+++ b/submodule.c
@@ -24,7 +24,6 @@
 #include "object-store.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
-static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
@@ -1124,7 +1123,8 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(void)
+static void calculate_changed_submodule_paths(
+	struct string_list *changed_submodule_names)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
@@ -1162,7 +1162,8 @@ static void calculate_changed_submodule_paths(void)
 			continue;
 
 		if (!submodule_has_commits(path, commits))
-			string_list_append(&changed_submodule_names, name->string);
+			string_list_append(changed_submodule_names,
+					   name->string);
 	}
 
 	free_submodules_oids(&changed_submodules);
@@ -1208,8 +1209,10 @@ struct submodule_parallel_fetch {
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
@@ -1271,7 +1274,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
 			    !string_list_lookup(
-					&changed_submodule_names,
+					&spf->changed_submodule_names,
 					submodule->name))
 				continue;
 			default_argv = "on-demand";
@@ -1363,8 +1366,8 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths();
-	string_list_sort(&changed_submodule_names);
+	calculate_changed_submodule_paths(&spf.changed_submodule_names);
+	string_list_sort(&spf.changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
@@ -1373,7 +1376,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&changed_submodule_names, 1);
+	string_list_clear(&spf.changed_submodule_names, 1);
 	return spf.result;
 }
 
-- 
2.19.0

