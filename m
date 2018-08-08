Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FD21F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbeHIAkJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:40:09 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:50849 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:40:09 -0400
Received: by mail-io0-f201.google.com with SMTP id v2-v6so2777641ioh.17
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OAtEPs68V9oeEb3Y8GZVqg1uoo9eDJiNH5v7XYKRHvM=;
        b=XbWA8B7agGtUUNo+hih483D7lAsqdcvFzyvZJQkllCaQJV+dha/6Oj22GhdSClJIVh
         KMOxx8rnRTWVKy0aGiCCKrXR9jeUmKhQDw5kbhpG1sA2oJv0XIulPe289Wy1l9EFen57
         9wrhkXiwVC7MU1nCnqXuL0nqmpDIpC2nZc36STS+T/VWVKqFLVUQfMie2KZ2sjR6PsSq
         A7ZH3ObTu+E/ThfMGrnTkIpXZbo4O3Q51fw9ApaNwvsyoh7fUUi4SBpEyOaik+8Cn4SS
         b/gPWaEvguzIehV84PooWvWG4pksPHHKaSzr2JfCwKmdopUOEzUstHS7BuxrHeZ0g3eR
         y3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OAtEPs68V9oeEb3Y8GZVqg1uoo9eDJiNH5v7XYKRHvM=;
        b=PIHWQP5j4HaqrH9WiJHP+J5f7M2Wo/4dmfSuWjUsmQrsWodX15WP2wkgoLtOStiv8J
         T6AIsxaflZPfT0djOXufwfGPgFYqbmFiyBt8uNJrNLVG9XQTZEQPgk9++Z0Fx6as4ULh
         qTJI2IQOr3YeowvfXe0IKpKg3VyHLEhHiS/7cNO2g83OQwhCqVDvRTp7Q1pvAqJDW/8l
         JM3PHK+sU9ZHzALDh/LEqg0IUnKzZL5a8Pz8j+JLESByJE6JyRlcMhpwRoB/x/2MOTky
         jRvolAjr3UKkK8k6r/Z6cy5IG8HNTbIyb11AZA5qQCfzc5lhvj9YwYJ+H2psULSpLvRP
         BmBA==
X-Gm-Message-State: AOUpUlGPgTKeqLZVumxkJFBEyPOIhmXt4cYdIsIjLybsTinaLGjTXMey
        WR3Ol8klnTtS9WHK9ojQxgWsUj8JuotuP4+KiY9GK2xYJE7E1oTVsR94MIVZ4kyRhumzSFbroF3
        rWdT7BJ0/a7dyvJ5CRBYLtAx7hT693CUOJLfg99wJ5tINKYCM1ucYuvRznF14
X-Google-Smtp-Source: AA+uWPy8f8eapEWE97IKqmLfByDnAieiLP6CZcFfCwA+Z6nfQfc99By1hafz1g+wGyEEKHhKKI+wDzx6MdBl
X-Received: by 2002:a6b:9d0f:: with SMTP id g15-v6mr2009963ioe.136.1533766707896;
 Wed, 08 Aug 2018 15:18:27 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:50 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-9-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 08/10] submodule.c: do not copy around submodule list
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
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
index 92988239f6b..21757e32908 100644
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
2.18.0.597.ga71716f1ad-goog

