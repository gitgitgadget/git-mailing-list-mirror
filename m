Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5AF1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeJKFOh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:14:37 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:48606 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFOg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:14:36 -0400
Received: by mail-vs1-f73.google.com with SMTP id t85so2625647vsc.15
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nhKbX5UMMokr0xuH5bisVy2OvQYMXSMU76Ag85Cxuxg=;
        b=tph//wk2j/vYllqeBndH5mVRxEiETThkC6mVnr262lTC2ea1mNDkZWw4b+oI8TVa9f
         9veYESem9XR7C1DvwJVIczzirPl6b/JviOzLfnaxalCYOoPXnmFCE4nVWkWa0PlIyXNa
         Z523wMRFN98uk+ZqDNZMCfFrEngRtavZvGqb8U1iFiKexAUgpd602eFERQ73Gy7zCzyq
         qez9fGHsha285kn/CJ9m4fowDqSLMh6SAW6YqODyrhZotBUwmqOL2VQWMSYqYbwZMFFQ
         VU1gnZ+he9fLVlpJyAs1J3KcNpuXEmE4dxhtTbTe2/my8lxsHaGQanbB1ohn17kKmdzd
         N3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nhKbX5UMMokr0xuH5bisVy2OvQYMXSMU76Ag85Cxuxg=;
        b=j22vrfI4nPyxWGm57OHOAgTmXXDlSCZE+9JU5+55PAj398eWmiFOGTAUgflbld9AZ0
         e7zJdVNxs/ZeSzD1Hgr891v6XHHBe+Dfnwd4eWWUDikyuhg1WncvSA+aXSpK1mmXyGaj
         RLwQen6pQw0BmwWJcQSb98r122NmrVBduowZG+uohn1jGr6iKrmXVj10p1hAffLVWRye
         2I7cT4hV0QMqI/mLdHuJEAhsz2WtiFxWxvaj7fK1Y9o45UWxE+ImonTCAkL5yaRultTj
         AuVrTbAk/bxoR+ksCiZeVFN8eCT70D3kygDtvQh0dhYSqRbToPw2vnLfJq9e15Iz5YUy
         9k/Q==
X-Gm-Message-State: ABuFfogQTbvAx63/lylPfMyCTiagsxi1b5hwJzdcob+FdBEYE8AftCPc
        InyW4pJrlpfss74uBuoPdHyskurQKVvmtwgm2SWd7X2I7hZ5ages7vm0OggyaM/vtdK0IqNV8vC
        RmAbcq8guAvrDl62YpR1349w4sGbXtCb9BV9DoM3sC78piyZDqjoSTbQW/GPL
X-Google-Smtp-Source: ACcGV60hVnJjIZ3pLNomCSIgARnwHNbqJzzs/NK9eHzP5aLrBHSVZrKgUbBhraIJf7sff+esUGgWUHu2AiSx
X-Received: by 2002:a67:3644:: with SMTP id d65mr15658164vsa.35.1539208230464;
 Wed, 10 Oct 2018 14:50:30 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:04 -0700
In-Reply-To: <20181010215008.233529-1-sbeller@google.com>
Message-Id: <20181010215008.233529-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181010215008.233529-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 5/9] submodule.c: do not copy around submodule list
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
index 17103379ba..dd478ed70b 100644
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
2.19.0

