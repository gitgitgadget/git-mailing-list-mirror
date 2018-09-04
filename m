Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87F91F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeIED3d (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:33 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:55663 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED3d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:33 -0400
Received: by mail-yb1-f201.google.com with SMTP id v1-v6so1783649ybk.22
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Up5ydddzxA0JIpEEdcxi1yNfvyL0XoeT59xvgeZpTyI=;
        b=STAx3XGBZKFdDAaKxJmjBVxntVRfAihaCA6LXHhxt4Q3SuhX+OsW5QT8u9vodk9SMZ
         x2jVL+AcqUsfzUJFiOZRzd3VCaqHhIEPSpempNDjGkYxJndeuhkEWWWLnZQc1IhFV/xA
         oFCyo0KzzyHdbnLekHm2sfiXFKbakEy/XkXnDiA7L1UJvOfvwJujgkSAJ7HW1xIlO4uE
         zE8hKniszhYOfAS4Bbl23gMYkd9B5ew5AkWydnbfIJooMzF+j+bTmDDFJVXSZv6ogvEA
         GlM9rrN6OCODgOZrlIsEr7ioebGHOoJVrBNmwUwDVAvsItU6OFMDDzmslT9AtiuwhSWO
         U/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Up5ydddzxA0JIpEEdcxi1yNfvyL0XoeT59xvgeZpTyI=;
        b=j8ZkHQtyLSQXmvzviCG1BgpbzIqpcf+K4FoG7FDWLMFKGVyofBBSnU0QDfEdiHajWc
         Lip6hKl9Fz4Aa4Venwl3nDgtxO4oGFcU40ozYR5uoaAcT+nivyFJxnkpDY0ZHv0weIwd
         bnN3pkF/kYWBG9ESQA+zZmGwkih3tJA2OKb4DLBbHJbqofmfIMYVGipd88RvjlbYgmtH
         9mlaIdDhtF0rP7bmNY6Nn2YbjRyXlYZLWvnlG72P/xvl0pZu9pULCl/Ftx2ZQHuTL7qp
         S0p5FD9pdKolYHDLA/UR35+7YGSlG1CVpE7TISc7ndDXP0YPRUmSLgM0mPo6fVSXRRj8
         WP+Q==
X-Gm-Message-State: APzg51DhGsSlg18qBp/eG8onxgxGCwe0LhXsuCiU58dnBFmzwvdP67PZ
        8xbUEN/q2ld2VsqfTetr3PRLf/78dguRwEN2UprBLn2J1T7K+kn/ceFztbDxUhlFf/YzSYhiQP3
        mKGyKaBzcrfg1RFi8a39Yr8oOr5HbijXtpilWXnOqW15d/6q7ngMGd85UT1u0
X-Google-Smtp-Source: ANB0VdZCzZfeU067sGRm43SyW+gIqSGyrbAbmqN4NEDyz+EqfjdaRlI8WUJPKq1EVhWFovDA59OxyK1DtJXQ
X-Received: by 2002:a81:4ac5:: with SMTP id x188-v6mr7204857ywa.129.1536102136350;
 Tue, 04 Sep 2018 16:02:16 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:46 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-9-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 08/11] submodule.c: do not copy around submodule list
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'calculate_changed_submodule_paths' uses a local list to compute the
changed submodules, and then produces the result by copying appropriate
items into the result list.

Instead use the result list directly and prune items afterwards
using string_list_remove_empty_items.

As a side effect, we'll have access to the util pointer for longer that
contains the commits that we need to fetch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index 582c0263b91..0efe6711a8c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1128,8 +1128,7 @@ static void calculate_changed_submodule_paths(
 	struct submodule_parallel_fetch *spf)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
-	const struct string_list_item *name;
+	struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(the_repository, NULL, NULL))
@@ -1146,9 +1145,9 @@ static void calculate_changed_submodule_paths(
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(&changed_submodules, &argv);
+	collect_changed_submodules(&spf->changed_submodule_names, &argv);
 
-	for_each_string_list_item(name, &changed_submodules) {
+	for_each_string_list_item(name, &spf->changed_submodule_names) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
@@ -1162,12 +1161,14 @@ static void calculate_changed_submodule_paths(
 		if (!path)
 			continue;
 
-		if (!submodule_has_commits(path, commits))
-			string_list_append(&spf->changed_submodule_names,
-					   name->string);
+		if (submodule_has_commits(path, commits)) {
+			oid_array_clear(commits);
+			*name->string = '\0';
+		}
 	}
 
-	free_submodules_oids(&changed_submodules);
+	string_list_remove_empty_items(&spf->changed_submodule_names, 1);
+
 	argv_array_clear(&argv);
 	oid_array_clear(&ref_tips_before_fetch);
 	oid_array_clear(&ref_tips_after_fetch);
@@ -1362,7 +1363,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&spf.changed_submodule_names, 1);
+	free_submodules_oids(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

