Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0021F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeHIAkH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:40:07 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:44018 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:40:06 -0400
Received: by mail-oi0-f73.google.com with SMTP id e23-v6so3637885oii.10
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zeQ/J13WYNV9TZYelWVrBN4ZpVd+C7eZXvB03VE+Lo4=;
        b=lt44EFlixmqkcc2osvNbhanGuRu6FXVvDc1NVmV364TUf6MeUCiO5wZT9xJYC4VepB
         kYkIq5JI0t0lvHdFXtT1UZuPwQPa0ocwVD12fkQV49mqyJ9+J6M8pu9JSVHRmg+jybOt
         waySMRKNRkcTwtNsMdMgGw9jL/lcUSpB2cl5PiPN9y6xXrV0QInV0dX9lgSwDxVKnDSm
         VJAP3tug2H63Jfv1rzPVHbkehfJC9Fk4h2Nk8LKJaXHUTTj/c2ncLzhMpWw90AXHagO6
         AIZ7SpoPM0i8QFm+xp5a0Yx9FZF5Wki7dp0vLZ3qghwkdN9ayj3BXbV7IF9jHi4M64ch
         d1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zeQ/J13WYNV9TZYelWVrBN4ZpVd+C7eZXvB03VE+Lo4=;
        b=nGV/mMRkLm2ymxbtZWTA02hcymF91Soj8GnGYSCcDzat/1dtTVCw0YzJuTNixNlp3e
         ZytZeJMrqNUN2H3GdLabpkpAlPe67cnfjnWRRowPZIUml3/ETjH+z0KUdX08Pji23IIo
         uCbWNg53dujC3kjvGUWt/xujkfjPRAdNeX8MexNtqOaiz8jkOprrUXB4Jdg8PaoMDxna
         X1IiWrgOAw3PbGf5lpeggqxkF7YP4ay510xz+TnAxX/7KKGWr1XGmxBz7LKbbZeqC8Aq
         Z53CtY8vpIOYs65HY6dk9C0Vc1Ptx4nbnjlHJ+8NhHUd8IorgPSoOqy0wo5G/3T6XbUs
         zvDA==
X-Gm-Message-State: AOUpUlFw47wMIApCfEH0TBvpDtVnMseO0ME9mdJdkFwGw8E9PT9mjP8y
        wF6GSG+E/UGzCVpCEYz/FAFPiexx877+/cMdC8U4qvHN4GF6BOUGiw2tiPPb4+MD3/zkWWbtkyC
        PoQnUJpfOwCmi8/Tp5if7fRmnroZ/WUp3nr9cYTMtqM/lLql1yEXuGOTXL8z4
X-Google-Smtp-Source: AA+uWPymFldbdM+hG2CjzNYvdg0sxRhxN5PcBdO1WZ6PX/b6GnFzzqPXPyMX2i5i4pUNc+LRIXNapYMwDm06
X-Received: by 2002:aca:5550:: with SMTP id j77-v6mr2676916oib.75.1533766705217;
 Wed, 08 Aug 2018 15:18:25 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:49 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 07/10] submodule: move global changed_submodule_names into
 fetch submodule struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
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
index 89a46b8af50..92988239f6b 100644
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
@@ -1256,7 +1260,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule || !string_list_lookup(
-					&changed_submodule_names,
+					&spf->changed_submodule_names,
 					submodule->name))
 				continue;
 			default_argv = "on-demand";
@@ -1348,8 +1352,8 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths();
-	string_list_sort(&changed_submodule_names);
+	calculate_changed_submodule_paths(&spf);
+	string_list_sort(&spf.changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
@@ -1358,7 +1362,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&changed_submodule_names, 1);
+	string_list_clear(&spf.changed_submodule_names, 1);
 	return spf.result;
 }
 
-- 
2.18.0.597.ga71716f1ad-goog

