Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40FC1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIZB5X (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:57:23 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:50186 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:57:23 -0400
Received: by mail-yb1-f201.google.com with SMTP id z8-v6so10384824ybo.17
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OovX9oELGzUKOdvo4/EwToobohXdU2DiOOONq/EmaAw=;
        b=matiTTXb/eGpF1m5H26IcWdCOsSf+Twg7AkmVxTV/EE9RPFLbL/hE52+LV7mK/Yyal
         m6YfKl0YpHA7MxOHiv2Dfwj6EjMNPic8m3MzqswTRWp0yH3cmFtFVZI4LE0nchuFUXgb
         oKMq/7NIfcLvSkIAmGqwPLkoR0kwfpx2Oe3c1OQd3iR4pZaQrHQkiyjXv1+lRZPcb2hC
         2tDqIrJuT7Fvvz+GJDaw7gZ/wyjwznfVZ/qKdwsbfbf6MggXq1r4Biu61aKAfNwAJdKO
         LmwxBDcWF9+XbsU+zpA8XOHA4KUpS4ZzECXDBJOOycuMiFLQUEtgFrBQn/pmKp+m+rUQ
         CFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OovX9oELGzUKOdvo4/EwToobohXdU2DiOOONq/EmaAw=;
        b=rgNDziRbBfatIHX4qNrWLlfEPhBGQRFP5nQzDuXJXJ05PPZt//UnW82mEgmVNBCCOI
         GbrLxWMC7KVnGzlrRf6Jzl2SsHjYPG60saUgoYXllm8f8KApGh5lfjPgnl8weozlN997
         eM7x2v5bQ606iSc4K4clmtK1/6Qq8ubydSOOvNslFHkSwzfEPTNP8HWYxo75ZQCem6wf
         fBcC4Jc5/zwHFrgtaS+2/YNAOBZZvpY+ea3RrieyqKU/a6Jas052etaGUGjbhiTz/EeC
         WwiyXUEpRULNxvrhtRK0LtteeK/HULtMxXD+69xirLVObW6bhaXUSgK2CT1auYRc3jNA
         Z7NA==
X-Gm-Message-State: ABuFfoinBDeqFkCwEgUr9VdULuKypNXXfoPHxHvhZMuTETEQIEGbA5tD
        hADjUPEVC6SCSkt6OWVazmOrDgw0w190xB3u3CT6K6OqRKCdVm7HBIis7H/SLo3K+WEoEd7fKw4
        TiVcSwoYRjXeUoJcktE3CkyPkm55JptaHhB9q8t9F7eRyLiVIbl/6jJ7P1rFX
X-Google-Smtp-Source: ACcGV61LtpCg2z5UChn94wg+013obmozJ7+tTGJo8sxo44SPmLokheS73spvw3DlHpAHcAYRRHb5S2A1N6wi
X-Received: by 2002:a81:260b:: with SMTP id m11-v6mr132282ywm.178.1537904894582;
 Tue, 25 Sep 2018 12:48:14 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:51 -0700
In-Reply-To: <20180925194755.105578-1-sbeller@google.com>
Message-Id: <20180925194755.105578-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180925194755.105578-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 5/9] submodule.c: do not copy around submodule list
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

By doing so we'll have access to the util pointer for longer that
contains the commits that we need to fetch, which will be
useful in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index 17103379ba4..dd478ed70bf 100644
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
@@ -1363,7 +1364,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&spf.changed_submodule_names, 1);
+	free_submodules_oids(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.19.0.605.g01d371f741-goog

