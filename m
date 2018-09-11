Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE381F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeILEvx (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:51:53 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:53916 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeILEvw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:52 -0400
Received: by mail-io0-f202.google.com with SMTP id h20-v6so68251iob.20
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kUdA9oKdgU249YiNpRsaZOph17WEjyfJNVIA3Yy8Wmg=;
        b=kZNa1DZ7Rro1Wm/GzVL+I1NTBRRkcs8WIIWc56JAc1R8ZFmABJHBMH4g5N6R0jShRC
         3b0kKwV1fc04IJ60zpxHWDpZ24q7WpnWRCy691DCpHROtVY+IPO3pmLJaPfonAKBgTSp
         5JTcUAINGn7HI77kV4EwyCWQLAkUDSTc48z1yxH6Ns1ZQRQU77ZEe5FRGObqXeNr1jyd
         oKJ/SPOGVC2vUO0684dfVF+sxznSZGsgXxnxYHTaG07ANAKEgUj6SiAkd58sgydw9TJq
         8g5QuK+m6YimfViJMIydcnbw9ask4km2IqNXbHv+x2WFl9+qZD064EA8dfJ9v/gCePaI
         ZvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kUdA9oKdgU249YiNpRsaZOph17WEjyfJNVIA3Yy8Wmg=;
        b=R++cC5XMyq8kQKDbqXIkY0eyJqumvT4I73FNva4+QVrWlWp6nWyKK81ebwPpCrm9Gh
         5RggmGE2NYbo3Y8nqxw1ydqcfgP/NARZtKyQoxUBulXLnHvU6j235QHYpnMTeyMsXhT/
         Caxp3QwQ75vdCZYBqRq9rVPSHrpcNSME4d394kVjDSlBrpkG7IAr0hmTJygy1WgUa/ct
         Fdgds3p3Dhk/tyU4IoADtIi6XvyVt4t4uXqSUsLIamM5C8Lv7epX3zllBEm9yzGkove3
         S4Y26bCI0P/AuLXw38J5YsQobVaNue2U2NFdysZ6RnbNZB5cdcQxelOIDCrBywuBAeEd
         Njcg==
X-Gm-Message-State: APzg51Cxok9W/bSZ8njNWkoc2TTq69Lzb6u6mRkl+NzkjvgMBrtNY93B
        UyrS+0YUedh53jiflDP8hqOdVW15IvKfFyl1FgBHCX3mjVmZ4dkIheIw2DOKt5WUgaNxXQbPXeG
        Xcyv2MGJnqw8ROtUvkYDLo7ZbBpB95ehtjIUvENY4oGaNOSYvVChPy/zDeKgO
X-Google-Smtp-Source: ANB0VdbOu3j1CH2Kct+V4nIfJMLKKpFrZq7am1soqAPEBGW88V+6LTrcV6sCxZAJtFFqPzgHChjGV3+Q0gT7
X-Received: by 2002:a24:47ca:: with SMTP id t193-v6mr3629264itb.24.1536709813340;
 Tue, 11 Sep 2018 16:50:13 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:48 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180911234951.14129-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 6/9] submodule.c: do not copy around submodule list
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

By doin so we'll have access to the util pointer for longer that
contains the commits that we need to fetch, which will be
useful in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3520dd76bdf..00a9a3c6b12 100644
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
2.19.0.397.gdd90340f6a-goog

