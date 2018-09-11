Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F491F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeILEvu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:51:50 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:42809 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeILEvt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:49 -0400
Received: by mail-ua1-f73.google.com with SMTP id g10-v6so47384uap.9
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N+C9LG44r+za892wkBrqwOOomAK6Va9G9n8tpBcil7o=;
        b=If8fl565zplg58gC3i7WgmWCgg1BSxZslYn06vBgS6Dtr/oBxUHkz/HGQdA6aOo+9/
         ZXV+xRZbCemfhrWiz4ouAB1O3OeptQpUmiaSXsnQCzlAF6HtON+udt/8yNEHbgEhaO8K
         rNxLB864bNwF5NIlNn624/fzyQID0DNF5m/mDcVDwSvuU+ObV1PW5LhNAjWAxVV6eWom
         A0azdsbJLwGVmbCqxIVDedqYbY5BWJJBWonvbC0mEWuZfSKTuOQi7nY5JAs3k0dUfXpL
         k2yfHq03CL0A7fjmhO8WG115dBQ21W6p7wFkiMKPKnkldWcckstSlCinYnkXcikFQ2W6
         K1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N+C9LG44r+za892wkBrqwOOomAK6Va9G9n8tpBcil7o=;
        b=ORifrV2+OCego3hrcvt+tMN0MNyNOj7VVw9hYDvvyRq7uc8LQsZEBuVBntqI5J0ZiB
         LTqJqlWBOCVE07vECv35lPOoVgHX39xPps4yOLarANVLht6QGgXHDLQ0w8Fc3vpKrAbz
         3PcD9btFZUP/2mp7+bK/nctPaMNgsd+j6iEjnDPg8rt2o8XsoxVb9qVS4S1zkQElNU6G
         PzroK90suNjDs5RQqZI/K2rRUJ7iQDm0AV/6w3nterRYCs01cTOu8gHdcJQmu8itTblp
         YaQr0/KiNAYxW9De89PPuqa5Mx6fMEwgqpncAffXos8f0IOSMv7Rw95M3lv6H6xdV9fK
         qHzA==
X-Gm-Message-State: APzg51BzVHQKLIzzSqMbefWccU1rYeegIt9thVbJq5RRwBxpB/yckL3E
        jTCOUugnuStJb2AI2JJycwgYxAZXsQQ4bsXDRGeJwczadd6jwboxvoHK3am8Ypv84nfj3Qc0swS
        twYde2oe0JOK2mdxGpnB0zLx9dk13ikGc9BlSRZxCkHg1M7qyNkhCRHCrn1Gb
X-Google-Smtp-Source: ANB0VdauSAQCzduNR+Hl79XJmH8lf6vuQL2w/Tf61z7YnEQbd8O3z/g7erjb4rq5t74T9KY4ehp2OIvxqH7t
X-Received: by 2002:a9f:3190:: with SMTP id v16-v6mr5801004uad.1.1536709810597;
 Tue, 11 Sep 2018 16:50:10 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:47 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180911234951.14129-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 5/9] submodule: move global changed_submodule_names into fetch
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

