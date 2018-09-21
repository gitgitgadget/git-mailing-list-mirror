Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98D91F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeIVE1o (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:44 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:39011 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVE1o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:44 -0400
Received: by mail-yb1-f201.google.com with SMTP id g139-v6so6417756ybf.6
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PasKoMTvPQ5hM57cqvFIxQWPIYaVNQFbxKIOgHG+mYk=;
        b=AFxI6sRvPMhbGez8+d38vAgqQOFUy5qy3u2rhBCTH0lFG+cY+ovHbAXN5bA9PRZZ4A
         OqwsXkLsbpM5CEt69Z64enfWN8I/lEhQLn07M73Mwl2XsaGKr/qA0ZFor1/f0WKzUPWe
         HkrniJOj3vahY8C6Sq3ukTtbqtS9MWo3BbnNj+WpyXtWtcumClv3HxfPP/JSdTEX9088
         KyLj1JqWbtVSYw1jJfenqbmBbE1kZuvFfxaAMAVea2bfOMmEjVy5arYr66RtIi2PyFnd
         ZjrBtn/EBuzrcSYAudTNXOstqYLrgneQZsWLbCaHKEz4eMMtKLh0OChXd0EFWB+ZWAmB
         /G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PasKoMTvPQ5hM57cqvFIxQWPIYaVNQFbxKIOgHG+mYk=;
        b=uSSYml9GGs978lJRgWQYK8GxdWe+ieeWkIo36NRpRoVAhqQ8d4eowgPsI6ZbivdKVx
         jwaF2kEiHZSFVJ3fGiCQlKfs1ClZvt0EmxcElpasb594ca6vknu9Ob0Nvi/2yTtYsXjO
         vJHDEpGEtKNGWGZvF4rqPyc8psDVtu5veA4J61d7NAAfV3CnMPKrJxG2MPTxligbViEp
         uC/DVINnEM3jFyNQ0br4ksHUxo4hfLvhnnZMx7vDno4wodeMP5pPWBhF2Jqg7oHWQQ66
         wtpYjWozQOeDYeuFae8wcirbQgXlo2Lg7ffc0MjkIDfC8+qqojSdpKdRosBuqtk/0khq
         vQsg==
X-Gm-Message-State: APzg51D/W9TDiA8WWgTjMA+2y17aOwuHVq4vW2nYVc7G01Vw1Rxzi7oJ
        6ajNpZ+wJNe3NjS3YfkErZl20g8I92w5vGopEL+527l/0ZCOreK+2w7m/WwqsDLAKLStPKmifxJ
        syDqBaId5Ac0FZPPVX4tgzUSyBT5nmS8k86QfOYpENubxAoV4Qk5y1S32WdLR
X-Google-Smtp-Source: ANB0VdZ7y6N3kLHH7OWMkuj1Mz4+Htb088YVHMxK6eckCdbEmIvYuFOQzADdMCC8Kwzi7HWnTlQep/eh+Abp
X-Received: by 2002:a25:8812:: with SMTP id c18-v6mr3166925ybl.71.1537569407753;
 Fri, 21 Sep 2018 15:36:47 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:55 -0700
In-Reply-To: <20180921223558.65055-1-sbeller@google.com>
Message-Id: <20180921223558.65055-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 5/8] submodule.c: do not copy around submodule list
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
index 7b4d136849b..209680ec076 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1129,8 +1129,7 @@ static void calculate_changed_submodule_paths(
 	struct submodule_parallel_fetch *spf)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
-	const struct string_list_item *name;
+	struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(the_repository, NULL, NULL))
@@ -1147,9 +1146,9 @@ static void calculate_changed_submodule_paths(
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
@@ -1163,12 +1162,14 @@ static void calculate_changed_submodule_paths(
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
@@ -1364,7 +1365,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&spf.changed_submodule_names, 1);
+	free_submodules_oids(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.19.0.444.g18242da7ef-goog

