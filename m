Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA301F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbdGYVjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:39:53 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35243 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbdGYVjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:49 -0400
Received: by mail-pg0-f53.google.com with SMTP id v190so75314882pgv.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OceDCs9v1E4MR+d/1qYD6y5eimpUSJF1s8RsSDeWYmc=;
        b=oFogCyGbgv7ftgv3PfGzWaDUZal9otVxQ7OF1/8dLRDMzzaa5mZfkgeuMvJolYlT79
         79Rl4qfe29grjZEuCCjyAWBRvMEI9vQiPK6++m0H+3qJIvVJ3cVQcVoo2aCK+pOL3KSt
         vxNfYhph53Sv3pfBC4rXMckufUGyu8f3sOgeaS11QUMlycEy5xWj3M7aDb+Wpp9vSIhk
         7YRYmiRGwV6N4uOqPFtCEMYi47qvBO+FwFED+2vViiWRoAvFopLpbCi6C9F3XgYrhhhC
         VhxlKi+cAo1j96tZ/fXY7QWbYPV2y15MSc0dYbuOkNcYzQrDYybVr75x3uJaL0XZOFJp
         mOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OceDCs9v1E4MR+d/1qYD6y5eimpUSJF1s8RsSDeWYmc=;
        b=Cpx5Lft0RvNVxSh4t9d19FEfhgpoXLbH+DaaJU4qn/acSwU2uzi+IisQCKwg2a2+5e
         K0pBA5+3qHGSu4b5P4XTz9JYC2Bj/R8e7tj7zvQ44ipQ2znH6sjZT/u6WvYG5y+wucNS
         6SoV310hpPHp7oAN6ibaL++ELXYHLXVNbhRMrAsx0VfXDodkxaJ7oFt5GShFSnz4t9u0
         9EhgIkrT6Sgh82GRE1OYiEw8oECWXQMnKwtNsspK2D3XdMyeDRq+VUBjT08UviMdxqhi
         h/0jOrz/YdwMSnAq3oZn4Um7x/Uaqe6/N9U0a7lqvvC7AWZ+sKRSwGrmJQGevQ60uGR0
         7FWQ==
X-Gm-Message-State: AIVw111Z/9o2Jnrm+1Hx7ktgV6HftxWpv3/dJlzgd70qtcAMCh1Uk5/k
        B3iOYY48u3rQ1aE5FndrFQ==
X-Received: by 10.99.126.69 with SMTP id o5mr21013515pgn.2.1501018788044;
        Tue, 25 Jul 2017 14:39:48 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/15] submodule--helper: don't overlay config in update-clone
Date:   Tue, 25 Jul 2017 14:39:18 -0700
Message-Id: <20170725213928.125998-6-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't rely on overlaying the repository's config on top of the
submodule-config, instead query the repository's config directly for the
url and the update strategy configuration.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 14 ++++++++++----
 submodule.c                 | 30 ++++++++++++++++++++++++++++++
 submodule.h                 |  3 +++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f71f4270d..25f471ba1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -780,6 +780,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 					   struct strbuf *out)
 {
 	const struct submodule *sub = NULL;
+	const char *url = NULL;
+	struct submodule_update_strategy update;
 	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *displaypath = NULL;
@@ -808,9 +810,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
+	update = submodule_strategy_with_config_overlayed(the_repository, sub);
 	if (suc->update.type == SM_UPDATE_NONE
 	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
-		&& sub->update_strategy.type == SM_UPDATE_NONE)) {
+		&& update.type == SM_UPDATE_NONE)) {
 		strbuf_addf(out, _("Skipping submodule '%s'"), displaypath);
 		strbuf_addch(out, '\n');
 		goto cleanup;
@@ -822,6 +825,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.url", sub->name);
+	if (repo_config_get_string_const(the_repository, sb.buf, &url))
+		url = sub->url;
+
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/.git", ce->name);
 	needs_cloning = !file_exists(sb.buf);
@@ -851,7 +859,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--depth=1");
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
-	argv_array_pushl(&child->args, "--url", sub->url, NULL);
+	argv_array_pushl(&child->args, "--url", url, NULL);
 	if (suc->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &suc->references)
@@ -1025,9 +1033,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	/* Overlay the parsed .gitmodules file with .git/config */
 	gitmodules_config();
-	git_config(submodule_config, NULL);
 
 	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,
diff --git a/submodule.c b/submodule.c
index fd391aea6..8b9e48a61 100644
--- a/submodule.c
+++ b/submodule.c
@@ -440,6 +440,36 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 	return NULL;
 }
 
+struct submodule_update_strategy submodule_strategy_with_config_overlayed(struct repository *repo,
+									  const struct submodule *sub)
+{
+	struct submodule_update_strategy strat = sub->update_strategy;
+	const char *update;
+	char *key;
+
+	key = xstrfmt("submodule.%s.update", sub->name);
+	if (!repo_config_get_string_const(repo, key, &update)) {
+		strat.command = NULL;
+		if (!strcmp(update, "none")) {
+			strat.type = SM_UPDATE_NONE;
+		} else if (!strcmp(update, "checkout")) {
+			strat.type = SM_UPDATE_CHECKOUT;
+		} else if (!strcmp(update, "rebase")) {
+			strat.type = SM_UPDATE_REBASE;
+		} else if (!strcmp(update, "merge")) {
+			strat.type = SM_UPDATE_MERGE;
+		} else if (skip_prefix(update, "!", &update)) {
+			strat.type = SM_UPDATE_COMMAND;
+			strat.command = update;
+		} else {
+			die("invalid submodule update strategy '%s'", update);
+		}
+	}
+	free(key);
+
+	return strat;
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
diff --git a/submodule.h b/submodule.h
index e402b004f..f17ca1e34 100644
--- a/submodule.h
+++ b/submodule.h
@@ -6,6 +6,7 @@ struct diff_options;
 struct argv_array;
 struct oid_array;
 struct remote;
+struct submodule;
 
 enum {
 	RECURSE_SUBMODULES_ONLY = -5,
@@ -65,6 +66,8 @@ extern void die_path_inside_submodule(const struct index_state *istate,
 extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
+extern struct submodule_update_strategy submodule_strategy_with_config_overlayed(struct repository *repo,
+										 const struct submodule *sub);
 extern void handle_ignore_submodules_arg(struct diff_options *, const char *);
 extern void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-- 
2.14.0.rc0.400.g1c36432dff-goog

