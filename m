Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A318D20951
	for <e@80x24.org>; Sat, 18 Mar 2017 00:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdCRAlz (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 20:41:55 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35533 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdCRAly (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 20:41:54 -0400
Received: by mail-pf0-f171.google.com with SMTP id x63so38574843pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 17:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zoz5tD/bNWhqzXbWrhYuR6F/NwDk/Pbk1ckcwxNUXRE=;
        b=O5tZR2+CdqndhPSMeKkJDxkOOBUy9Z/fp2MOqU7SNnqTD32c3t8JfLHdFg8oCsGLjw
         GVa0hUKZaoNkP0z7JUACjHmCskhHvmt7Z1YaI/AZWzcrwEJZTgtQh5DFU4bRK7x3Uo9L
         Q5LWfP++CzKpA/8F9k3emuYcBR9t8huTlCZ1Iw9LmAVQ3XY7+vS6BNu7/5tiKUQVNWf3
         dPjgye+tsRnO7mrOokOpU0xKj2A3d9cmS5P4nv6woy4MHDJbksC+QKmBQ6tAY1tIN4M4
         UEtiJXD15NIhqdqfFP50WA7Mkp+m6vrkBpG5tZ+iGb2JiOGIvP2wGXKXJAkrxWMtkkz7
         IlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zoz5tD/bNWhqzXbWrhYuR6F/NwDk/Pbk1ckcwxNUXRE=;
        b=qs5HABTInkQtVD/epX6hwr5kwceDhZPZ5G5+a0xopqACkmQOk+H0qWz9ULKeRGys4/
         KxpVJM7iyuMWaVJyG96Ywhv3No4p5VTMzP5YRJe9lChOgiTODEnsWJo7fns+H3QEa0FK
         PeghwIGEwBTGflXazt9FqHhidsxe9ejuSAn+PUuzjbUcH+gA/Khz7nXYsnwkGzxJoLP3
         UkJL+hLmGrzoL5lFezrQSE2bB+PSlyQHKPJh/SeN+oLdoT17sVh8W57Y/rX3rkoAXS9V
         JJSciHpEj8WWR7n6RkOy3TyHPP3BM8D5qSwwge2Sy7VxfTIj14rzPR4ZQ5l1andRuA1s
         P98Q==
X-Gm-Message-State: AFeK/H2QJ+5DFgge+BYaOfUdD7Re83c9GEMVguAvs04s8PNePtPHkWjqXPt8H4KQan6tym0p
X-Received: by 10.99.144.65 with SMTP id a62mr7896105pge.151.1489790295002;
        Fri, 17 Mar 2017 15:38:15 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:14 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 00/10] decoupling url and submodule interest
Date:   Fri, 17 Mar 2017 15:37:55 -0700
Message-Id: <20170317223805.95271-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v5:
  * Add "NEEDSWORK" comments to indicate where attention is needed once
    per-worktree config is a reality
  * --no-recurse now works by clearing the string list of paths.
  * module_list_active() now does post-processing instead of duplicating code.

Brandon Williams (10):
  submodule--helper: add is-active subcommand
  submodule status: use submodule--helper is-active
  submodule sync: skip work for inactive submodules
  submodule sync: use submodule--helper is-active
  submodule--helper clone: check for configured submodules using helper
  submodule: decouple url and submodule interest
  submodule init: initialize active submodules
  clone: teach --recurse-submodules to optionally take a pathspec
  submodule--helper init: set submodule.<name>.active
  submodule add: respect submodule.active and submodule.<name>.active

 Documentation/config.txt        |  15 ++++-
 Documentation/git-clone.txt     |  14 +++--
 Documentation/git-submodule.txt |   4 +-
 builtin/clone.c                 |  50 ++++++++++++---
 builtin/submodule--helper.c     |  68 ++++++++++++++++----
 git-submodule.sh                |  55 ++++++++++------
 submodule.c                     |  50 ++++++++++++---
 t/t7400-submodule-basic.sh      | 136 ++++++++++++++++++++++++++++++++++++++++
 t/t7413-submodule-is-active.sh  | 107 +++++++++++++++++++++++++++++++
 9 files changed, 445 insertions(+), 54 deletions(-)
 create mode 100755 t/t7413-submodule-is-active.sh

---interdiff with 'origin/bw/submodule-is-active'


diff --git a/builtin/clone.c b/builtin/clone.c
index 3dc8faac5..a7be61d6b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -62,9 +62,8 @@ static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
 {
 	if (unset)
-		return -1;
-
-	if (arg)
+		string_list_clear((struct string_list *)opt->value, 0);
+	else if (arg)
 		string_list_append((struct string_list *)opt->value, arg);
 	else
 		string_list_append((struct string_list *)opt->value,
@@ -984,6 +983,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		string_list_sort(&option_recurse_submodules);
 		string_list_remove_duplicates(&option_recurse_submodules, 0);

+		/*
+		 * NEEDSWORK: In a multi-working-tree world, this needs to be
+		 * set in the per-worktree config.
+		 */
 		for_each_string_list_item(item, &option_recurse_submodules) {
 			strbuf_addf(&sb, "submodule.active=%s",
 				    item->string);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a574596cb..7700d8948 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -273,29 +273,24 @@ static int module_list_compute(int argc, const char **argv,
 static void module_list_active(struct module_list *list)
 {
 	int i;
-
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
+	struct module_list active_modules = MODULE_LIST_INIT;

 	gitmodules_config();

-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < list->nr; i++) {
+		const struct cache_entry *ce = list->entries[i];

-		if (!S_ISGITLINK(ce->ce_mode) ||
-		    !is_submodule_initialized(ce->name))
+		if (!is_submodule_initialized(ce->name))
 			continue;

-		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
-		list->entries[list->nr++] = ce;
-		while (i + 1 < active_nr &&
-		       !strcmp(ce->name, active_cache[i + 1]->name))
-			/*
-			 * Skip entries with the same name in different stages
-			 * to make sure an entry is returned only once.
-			 */
-			i++;
+		ALLOC_GROW(active_modules.entries,
+			   active_modules.nr + 1,
+			   active_modules.alloc);
+		active_modules.entries[active_modules.nr++] = ce;
 	}
+
+	free(list->entries);
+	*list = active_modules;
 }

 static int module_list(int argc, const char **argv, const char *prefix)
@@ -361,7 +356,12 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
 			displaypath);

-	/* Set active flag for the submodule being initialized */
+	/*
+	 * NEEDSWORK: In a multi-working-tree world, this needs to be
+	 * set in the per-worktree config.
+	 *
+	 * Set active flag for the submodule being initialized
+	 */
 	if (!is_submodule_initialized(path)) {
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
@@ -452,14 +452,15 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);

+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
 	/*
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
 	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
-	else if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;

 	for (i = 0; i < list.nr; i++)
 		init_submodule(list.entries[i]->name, prefix, quiet);
diff --git a/git-submodule.sh b/git-submodule.sh
index 6eca93416..6ec35e5fc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -279,6 +279,8 @@ or you are unsure what this means choose another name with the '--name' option."
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"

+	# NEEDSWORK: In a multi-working-tree world, this needs to be
+	# set in the per-worktree config.
 	if git config --get submodule.active >/dev/null
 	then
 		# If the submodule being adding isn't already covered by the

--
2.12.0.367.g23dc2f6d3c-goog

