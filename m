Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124BE1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeIRDFY (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:24 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36083 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIRDFY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:24 -0400
Received: by mail-pf1-f201.google.com with SMTP id d22-v6so9054085pfn.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N+C9LG44r+za892wkBrqwOOomAK6Va9G9n8tpBcil7o=;
        b=aHXy1WUu05rxg2nTRvtQkR7bBtIHL6cveXEN5eWKfRCQeTCGSr2GCc50I59kTI8ZWl
         6WKpXjpGUVDjPC9c+sKHOLFMc0WVpf77hJSpplrjWfyRaPDZCpRZuov5gtFM2HDaQo48
         FmGbfMdSfymaN/dc29Yf6jxtFhgFBBB1Wv0DroIEKQfIKBo1385F2cO3+Or0DCx213Hb
         mWhUugNC5NXoC3QGMfz7SZqgefnVGO/eFt1k+DGe1T24gavEoxy+5DQ4soIMYBZMJAMG
         4+UfLvCAohlO+vc6mqG+auBRC8cfTdz1JiMkVxSxiFpUFOOx2fceTK4TS4dqXfRAzB6N
         Rxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N+C9LG44r+za892wkBrqwOOomAK6Va9G9n8tpBcil7o=;
        b=EE+a+EdeuxnRBpKG3bqnaHZOewO+oa/fqs30BvzdErn9vXE09aZTyElT5Oh85raGwX
         yNg8GbMLdQ/mxpNyRvFE4cf5Ikj9m4yWtua2wQM62J6ucH9fBXwPufAdKPybs/1TUxVi
         uTHvfZUUsodtcCsaBGoGqZQ5RQ5uSWjgyPKzMni4RuLStaqTaJc8XA2vFanINmkiyEVo
         FHWpsZ9Ml1cTvI+H/aRqobVtqyWppXiBV1QQJ2syBhIObRkX/CdzonGANEjy3cfDPP6V
         OFkbF6Qs9PyzNIxzzLVYNXMbQ3npDIndp5EDyDmTahF9UjC1esLHW0ctlTvpQ3PBZwVs
         e69A==
X-Gm-Message-State: APzg51A1aq+sWi862xD6opamRs1lPEfEMuWT4z6cn52AVwRAoyJbRw51
        xMXNIwPQayWpaWbJb5W2vENinRXwlAYi
X-Google-Smtp-Source: ANB0VdZeLWiGHjWMScVmHTpKsJaLw/yM+eYZwUEsKsZx9HlkWDWL0OSjIsqgRc0FAp1J5hTeiIFQN5QDlebS
X-Received: by 2002:a63:2bd2:: with SMTP id r201-v6mr1184707pgr.116.1537220174764;
 Mon, 17 Sep 2018 14:36:14 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:55 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 5/9] submodule: move global changed_submodule_names into fetch
 submodule struct
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
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
index c6eff7699f3..3520dd76bdf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -24,7 +24,7 @@
 #include "object-store.h"
 
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
2.19.0.397.gdd90340f6a-goog

