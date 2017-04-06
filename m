Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC71920966
	for <e@80x24.org>; Thu,  6 Apr 2017 06:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbdDFGNA (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 02:13:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33290 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756147AbdDFGMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 02:12:55 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so6144900pgf.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6A5IjLvgr8Iu/HcU/E8NxsZzVICLD508jeFIQKqy8YI=;
        b=CxNny8eQWDn2/cq3sVBP6mwon5oBR+JaSOtsnUtYMRlbQsjykWZsKmSR9ytpW8K95X
         C5rQvT4gR/tm7Cfo1DM0yUFYjI3KI84qcOQy1Czzd0Wn7QuzvLfrU+JiQgkzEfw7EsVF
         j7QfV67eUYuUZdL5FQ5QK43leAHG295zGn8I6A1074bUCZP8aDN1daYh3tgn+gVHcnwR
         7QwdUZQaiitXLBbm10rlqyBQA+zqHwxYYIg+BpOIRM7qSeLLwmo2tSyil6sudsAENQYM
         YRm0/pwe7h+z2Vr5szLtS8JTzzMpr3wFqReoMrEWltVY5rcaBRWg3YF7wMTgGfjmi8CR
         AvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6A5IjLvgr8Iu/HcU/E8NxsZzVICLD508jeFIQKqy8YI=;
        b=uCRvp3Fl5zif5VkCjtEoHU783J9AVfa78Tb3K9E/LSfGmJ8+C9uiQbWAgqVPcuJJWj
         +JdPGeWS5aGKaKD/4k4QoWjw2WmmPsYCogkqC2DShoqZpkhKgnx7F2WDWW5CnrcZ5+5C
         kiX7PSBRzlH+18gMzGCA484RRYZM6DSHjsXkQkco4YKOx/DgLR5ufPYT5i3+/5+cqE4F
         t8n1HN8hj/zOuOg1nRE7kPm4oKtyIdWYhJviX5poy5SJFHrRKUJq3cLvs0zodRDlrhPe
         ZF1wT4c7goVtINk1VYi/ocCZ5iax7aRzwDGwFww928bSoU/Xk6FTfroqDcFe0vyeig6e
         1Kzg==
X-Gm-Message-State: AFeK/H2QbL+qEY8e8uU4hzuupqSXJGvukawRGdx9VENuad/H1hH3g6SfYl6XUpHhcGXauA==
X-Received: by 10.99.3.76 with SMTP id 73mr33839792pgd.105.1491459164894;
        Wed, 05 Apr 2017 23:12:44 -0700 (PDT)
Received: from localhost.localdomain ([47.11.8.91])
        by smtp.gmail.com with ESMTPSA id f81sm1253505pfe.61.2017.04.05.23.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 23:12:44 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     pc44800@gmail.com
Cc:     sbeller@google.com, git@vger.kernel.org, peff@peff.net
Subject: [GSoC][PATCH v1] Disallow git commands from within unpopulated submodules
Date:   Thu,  6 Apr 2017 11:41:07 +0530
Message-Id: <20170406061107.6849-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170406060053.4453-1-pc44800@gmail.com>
References: <20170406060053.4453-1-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main motivations for disallowing git commands within an
unpopulated submodule are:

Whenever we run "git -C status" within an unpopulated submodule, it
falls back to the superproject. This occurs since there is no .git
file in the submodule directory. So superproject's status gets displayed.
Also, the user's intention is not clear behind running the command
in an unpopulated submodule. Hence we prefer to error out.

When we run the command "git -C sub add ." within a submodule, the
results observed are:

In the case of the populated submodule, it acts like running “git add .“
inside the submodule. This is uncontroversial and runs as expected.

In the case of the unpopulated submodule, the user's intention behind
entering the above command is unclear. He may have intended to add
the submodule to the superproject or to add all files inside the
sub/ directory to the submodule or superproject. Hence we’ll prefer
to error out in these case.

Eventually, we use a check_prefix_inside_submodule to see check if the
path is inside an unpopulated submodule. If it is, then we report the
user about the unpopulated submodule.

Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---

Since this patch effectively uses RUN_SETUP, builtin commands like
'diff' and other non-builtin commands are not filtered.
For such cases, I think, we need to handle them separately.

Also since currently, git-submodule is not a builtin command, the
command for initializing and updating the submodule doesn't return an
error message, but once it is converted to builtin, we need to handle
its case explicitly.

The build report of this patch is available on:
https://travis-ci.org/pratham-pc/git/builds/219030999

Also, the above patch was initially my GSoC project topic, but I changed
it later on and added these bug fixes to my wishlist of the proposal.

(Had to send the patch again since a typo occurred while sending previous the mail)

 builtin/submodule--helper.c      |  4 ----
 git.c                            |  3 +++
 submodule.c                      | 45 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                      |  6 ++++++
 t/t6134-pathspec-in-submodule.sh |  2 +-
 5 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 15a5430c0..4f7c7d7b8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -219,10 +219,6 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-struct module_list {
-	const struct cache_entry **entries;
-	int alloc, nr;
-};
 #define MODULE_LIST_INIT { NULL, 0, 0 }
 
 static int module_list_compute(int argc, const char **argv,
diff --git a/git.c b/git.c
index 33f52acbc..eefe3fb01 100644
--- a/git.c
+++ b/git.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
+#include "submodule.h"
 
 const char git_usage_string[] =
 	"git [--version] [--help] [-C <path>] [-c name=value]\n"
@@ -364,6 +365,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		if (prefix)
 			die("can't use --super-prefix from a subdirectory");
 	}
+	if (prefix)
+		check_prefix_inside_submodule(prefix);
 
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
diff --git a/submodule.c b/submodule.c
index 0a2831d84..d2c3023bf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -545,6 +545,51 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+#define MODULE_LIST_INIT { NULL, 0, 0 }
+
+void check_prefix_inside_submodule(const char *prefix)
+{
+	struct module_list list = MODULE_LIST_INIT;
+	int i;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+
+		if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+
+		ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
+		list.entries[list.nr++] = ce;
+		while (i + 1 < active_nr &&
+			!strcmp(ce->name, active_cache[i + 1]->name))
+			 /*
+			  * Skip entries with the same name in different stages
+			  * to make sure an entry is returned only once.
+			  */
+			i++;
+	}
+
+	for(i = 0; i < list.nr; i++) {
+		if(strlen((*list.entries[i]).name) ==  strlen(prefix)) {
+			if (!strcmp((*list.entries[i]).name, prefix)) {
+				/* This case cannot happen because */
+				die("BUG: prefixes end with '/', but we do not record ending slashes in the index");
+			}
+		}
+		else if(strlen((*list.entries[i]).name) ==  strlen(prefix)-1) {
+			const char *out = NULL;
+			if(skip_prefix(prefix, (*list.entries[i]).name, &out)) {
+				if(strlen(out) == 1 && out[0] == '/')
+					die(_("command from inside unpopulated submodule '%s' not supported."), (*list.entries[i]).name);
+			}
+		}
+	}
+
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index 05ab674f0..5e41e5afc 100644
--- a/submodule.h
+++ b/submodule.h
@@ -31,6 +31,12 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
+struct module_list {
+	const struct cache_entry **entries;
+	int alloc, nr;
+};
+
+extern void check_prefix_inside_submodule(const char *prefix);
 extern int is_staging_gitmodules_ok(void);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index fd401ca60..086cc4c47 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -25,7 +25,7 @@ test_expect_success 'error message for path inside submodule' '
 '
 
 cat <<EOF >expect
-fatal: Pathspec '.' is in submodule 'sub'
+fatal: command from inside unpopulated submodule 'sub' not supported.
 EOF
 
 test_expect_success 'error message for path inside submodule from within submodule' '
-- 
2.11.0

