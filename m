Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCA81F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIED3b (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:31 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:53024 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:31 -0400
Received: by mail-qt0-f201.google.com with SMTP id s1-v6so5936144qte.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0M4/Q3N4JzPOueIBAkU7dpx9l4XCuJ3JbnpRf8oz12o=;
        b=eFBVyopYvme6y/5B4KezCoM07ASRBG7eGSo9wD7GlC8KTXfq3gO27PWqlaADO4sLfR
         b6OC7v5pqwcUKPmpNP4nviOyB8o0xqEU8/fjC0PokFI0lrEVKwPopVp2GHx+xXL2okg0
         Ki1H/AjdAJGODTupemBkPP0GQSvTZ2y9zG7mivw+jUMELM8sx2GapMpW02M32CB15HVo
         8gT8Fxftt6SpNted9blRDe/8A0gwxr0/OkTS5OPhWYOj7KqXOWeVosLOhC39lFVCkv9u
         5U+xagCqizpSLPlBd3oWDTFvlteVCa9XLDwbqgCy/nTNqSPHVd5NNvm/pv5tCGzVPtoL
         ZVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0M4/Q3N4JzPOueIBAkU7dpx9l4XCuJ3JbnpRf8oz12o=;
        b=Zw2WS599e2X67JU6SeYhHxjxBug5w/l9oAYYWzpH+bCZK2bY/WVpp/l01KcJ5PE3XW
         OKpiHXcQFAKyXdXUGbFHG1LoZq+00Lt84Ac0dXvRmxG5+cQizc5CkSr+OrtVsdswGrfr
         blijAvp3QWb/94WXmOwQqvavd12c8OxZh8ERn6tyDL2btRN0syRqrwkPMDUNEOq9gmV8
         foZPiddGuvxRYSMIppGCqs0b5UYju2k94VbFLPZqkMSwU9ayQMc66JZYDO2KRRael/pZ
         mRi+Zq4w3acxvSX4DJlS15E9xkePk0Ft74FWdZIa5/J+9MW8Q7PQTMNgNsldtP86WWTP
         K3Sg==
X-Gm-Message-State: APzg51A4mxw59BT6lfHJGBaCYCEuP7oLW4ap78WPQvxwU07lTR8saCqq
        PKghrYx1ih0AFIV8CJoZCl7aFByoHeGOuHXNNc/FjhC4HnCr4/ZgwFWeireZLIHZ6OgOcOoDNMo
        ARm4BwSOvw9su1COLpL9VGi4QcxjhKJf8jdvo+dpX86ummB2GrqFNn9cETJD9
X-Google-Smtp-Source: ANB0VdaWuow+kfKEqVPR8U9S1307T94/0aIqPP0iKJ9YspAJPrRrFJWU/yZ4AJgK2wanKUje1ma3BjHTW8Ue
X-Received: by 2002:a0c:d1fc:: with SMTP id k57-v6mr18549811qvh.58.1536102134038;
 Tue, 04 Sep 2018 16:02:14 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:45 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 07/11] submodule: move global changed_submodule_names into
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
index 8bee455137a..582c0263b91 100644
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
2.19.0.rc1.350.ge57e33dbd1-goog

