Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0801F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJQCFW (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:05:22 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47122 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCFW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:05:22 -0400
Received: by mail-qk1-f202.google.com with SMTP id f81-v6so24862102qkb.14
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x62wfanp9xsLqfARQY2I/omzlwaVx2Vc9lal1QDVfGA=;
        b=gJTiUcDHjANozH4x2pgczogGZgMQN+GqwFJdEhD0Aj3w5hK1utyTsYUofqGlo31yWd
         xZ1DqKwtY+jJgxIxwYRcfP2SmXqzWNcE/ALZivxdZqJpfUVZc5ZuUuHf4HCWcCOhSGZ7
         /ExnJ0fIKBXu89o/6IA6xMLlo4zpWTTG+8mwOnsENHz1PEdeHs1yVp64UT2uZWHESxlG
         4KfhKRu4UQmlZUMQbjLqJB5A2DxPcl8OXS/Tmq9bRbPYx138jMALBU2ni//+ssYow+gt
         hdWjeTViOkTJ+hM4sFVLVGh3YxvUMxTdvU5eBeO/TiS0G4R1RUp7fLS6yTpoeBqgJ/ti
         soPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x62wfanp9xsLqfARQY2I/omzlwaVx2Vc9lal1QDVfGA=;
        b=L/oTLhmjKUML7WCmb3Yt7aGcyZzQyKmJtyrD8il3vZMpteIXPoK6+voASeJ8guWQCS
         LEOM1gR0IMzgzBvgRm0QTNEuMSggC0yW6ECgaSdLCx9Fw5d3C4xMX01ejwWysr+LARIM
         wKZ/brzJM+qm+9Stthj8fOK0KPsHixRF0PwJ4UsMabiosJPpY2wr9Ugw+qYJLnCCOYS8
         Zl1jz3Hw402ZvfpjczQ8+fV5xDDTi4JRcYeEex5xhEHjv4If7FBU0gtrfhGJEaibNy3f
         0+8R30cKyJTrHyfCf7wXs9NqKLKwsfzW+DLmtgyd9dsnAT+/cbfsS7VqQDf/sNdoE0SW
         D0qQ==
X-Gm-Message-State: ABuFfohd/LoGfA1aF/iDRa57ooZbWe74odEwltQxWXZJi30gnuQ6s1Ey
        cmC/Q9IrrKYmpaPu1Dkkrv739bWCPT4B
X-Google-Smtp-Source: ACcGV63fuQEBSxsk/ie511WDb8o/ZT3s9gvce0ePTXRRuhhqb22G6wCOA9BPteNyr9aFIq2/WZZjqseewwxR
X-Received: by 2002:a37:100a:: with SMTP id a10-v6mr18531214qkh.15.1539713622530;
 Tue, 16 Oct 2018 11:13:42 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:22 -0700
In-Reply-To: <20181016181327.107186-1-sbeller@google.com>
Message-Id: <20181016181327.107186-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 4/9] submodule.c: move global changed_submodule_names into
 fetch submodule struct
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `changed_submodule_names` are only used for fetching, so let's make it
part of the struct that is passed around for fetching submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9fbfcfcfe1..6b4cee82bf 100644
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
@@ -1124,7 +1124,22 @@ void check_for_new_submodule_commits(struct object_id *oid)
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
@@ -1162,7 +1177,8 @@ static void calculate_changed_submodule_paths(void)
 			continue;
 
 		if (!submodule_has_commits(path, commits))
-			string_list_append(&changed_submodule_names, name->string);
+			string_list_append(&spf->changed_submodule_names,
+					   name->string);
 	}
 
 	free_submodules_oids(&changed_submodules);
@@ -1199,18 +1215,6 @@ int submodule_touches_in_range(struct object_id *excl_oid,
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
@@ -1271,7 +1275,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
 			    !string_list_lookup(
-					&changed_submodule_names,
+					&spf->changed_submodule_names,
 					submodule->name))
 				continue;
 			default_argv = "on-demand";
@@ -1363,8 +1367,8 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths();
-	string_list_sort(&changed_submodule_names);
+	calculate_changed_submodule_paths(&spf);
+	string_list_sort(&spf.changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
@@ -1373,7 +1377,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&changed_submodule_names, 1);
+	string_list_clear(&spf.changed_submodule_names, 1);
 	return spf.result;
 }
 
-- 
2.19.0

