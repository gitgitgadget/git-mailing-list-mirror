Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D1C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0132054F
	for <git@archiver.kernel.org>; Fri,  1 May 2020 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwE10Nkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgEANyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730738AbgEANyr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 09:54:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879DBC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 06:54:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o27so6290389wra.12
        for <git@vger.kernel.org>; Fri, 01 May 2020 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WhQhuZu+r+omZRvuix4W9nC7z1/RH6C/1fSsNKBYVDM=;
        b=VwE10NklLx+4N+XNACWWrVov7dAViJfJB9IbQVIp3Cv413Eal5hOL51oHAn2h08FXM
         HciWg5xd6WYGNgPgc988gNjSUPp6kDU2nA3KDP9HtaupWsLhL3+58ClV6u0zpzPgPszA
         Zdw/hjOCc0ioLTTpPK2eKrC/XBgjeR23U1EUbFj2yV+/cExXkhXixRD55xEXRooPwTC2
         UXLEfF45v1kiB9/5d4bVnmtgtZ3SYuTjs9+VUvcIJp9wKMdBHWDr5yhMWbHXlC1PHdvR
         D3R94ilJCX1mP3D2GIt+fab++1dP70P0MCRWBPf8AZf50ODy+WBUu4IMBvGpiR2YTjvf
         ruLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WhQhuZu+r+omZRvuix4W9nC7z1/RH6C/1fSsNKBYVDM=;
        b=jfRvpJmL9Ruag6gsibmdP/Rd5FX3S+rWq9T4pDu/ALKbM5V8bcbyPxs6GsS0x4OGlu
         MEDpVBAYy46z3OEMr7wc57tKkm0GfbAjxl64FjJ/c7vgKh9azH9bs+9ntmKHntVeGxRu
         uC80bZCjLlRYelPXDrOTRJ3gG6hdfjIFNUjKloGJmrA6pEgxxnI7o+FzR665mLiZiUL1
         GZlhwdVKpYMH3E5ExO+s7c3U0Ib9otcDt9uakSMFv1ynyiGVkai6sgPbg8IMimsQloX1
         OPlqRXZ/8Er7g2LaToLiRNDwhOF4VgZ/27+FCV79im+j4OE/M1O6v4eM/M23BWwl0Hl0
         UWjQ==
X-Gm-Message-State: AGi0PuamDZdTuLRrEy9zE8nYWMR7QyocSOxs24/eOryQTrGEHya2Lr8G
        X2NolCOU0rLhqlLZL9j4AxD7Xgm1
X-Google-Smtp-Source: APiQypJiNBPBnjUlfFfmQG272RQX4OBJklTLT9kczzZrXVA6ZLAXo3e3RjByXeH5YTnPyapA6I7UNw==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr4220301wrt.236.1588341282233;
        Fri, 01 May 2020 06:54:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm4309586wro.64.2020.05.01.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:54:41 -0700 (PDT)
Message-Id: <pull.695.v4.git.git.1588341280967.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.git.1582585595108.gitgitgadget@gmail.com>
References: <pull.695.v3.git.git.1582585595108.gitgitgadget@gmail.com>
From:   "Markus Klein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 13:54:39 +0000
Subject: [PATCH v4] clone: use submodule.recurse option for automatically
 clone submodules
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Markus Klein <masmiseim@gmx.de>, Markus Klein <masmiseim@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Klein <masmiseim@gmx.de>

Simplify cloning repositories with submodules when the option
submodule.recurse is set by the user. This makes it transparent to the
user if submodules are used. The user doesn’t have to know if he has to add
an extra parameter to get the full project including the used submodules.
This makes clone behave identical to other commands like fetch, pull,
checkout, ... which include the submodules automatically if this option is
set.

It is implemented analog to the pull command by using an own config
function instead of using just the default config. In contrast to the pull
command, the submodule.recurse state is saved in addition as an array of
strings as it can take an optionally pathspec argument which describes
which submodules should be recursively initialized and cloned. To
recursively initialize and clone all submodules a pathspec of "." has to
be used.
The regression test is simplified compared to the test for "git clone
--recursive" as the general functionality is already checked there.

Signed-off-by: Markus Klein <masmiseim@gmx.de>
---
    Add the usage of the submodules.recurse parameter on clone
    
    This adds the usage of the submodule.recurse parameter on clone
    
    Changes since v1:
    
     * Fixed the commit author to match the Signed-off-by line
    
    Changes since v2:
    
     * Added additional regression tests for checking the
       --no-recurse-submodules parameter
     * fixed not working --no-recurse-submodules parameter when
       submodule.recurse option is set
     * fixed invalid setting of “true” to the pathspec
    
    Changes since v3:
    
     * Using the solution from Junio C Hamano which is tested with the
       regression tests introduced in V3

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-695%2FMasmiseim36%2Fdev%2FCloneWithSubmodule-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-695/Masmiseim36/dev/CloneWithSubmodule-v4
Pull-Request: https://github.com/git/git/pull/695

Range-diff vs v3:

 1:  f71ca264885 ! 1:  e502f370b04 clone: use submodule.recurse option for automatically clone submodules
     @@ Commit message
      
       ## builtin/clone.c ##
      @@
     - #include "dir-iterator.h"
     - #include "iterator.h"
     - #include "sigchain.h"
     -+#include "submodule-config.h"
     + #include "connected.h"
     + #include "packfile.h"
     + #include "list-objects-filter-options.h"
      +#include "submodule.h"
     - #include "branch.h"
     - #include "remote.h"
     - #include "run-command.h"
     -@@ builtin/clone.c: static const char * const builtin_clone_usage[] = {
     - 	NULL
     - };
       
     -+struct option_submodules
     -+{
     -+	struct string_list option;
     -+	int status;
     -+};
     -+
     - static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
     - static int option_local = -1, option_no_hardlinks, option_shared;
     - static int option_no_tags;
     -@@ builtin/clone.c: static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
     - static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
     - static int option_dissociate;
     - static int max_jobs = -1;
     --static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
     -+static struct option_submodules option_recurse_submodules = {STRING_LIST_INIT_NODUP, RECURSE_SUBMODULES_DEFAULT};
     - static struct list_objects_filter_options filter_options;
     + /*
     +  * Overall FIXMEs:
     +@@ builtin/clone.c: static struct list_objects_filter_options filter_options;
       static struct string_list server_options = STRING_LIST_INIT_NODUP;
       static int option_remote_submodules;
     -@@ builtin/clone.c: static int option_remote_submodules;
     + 
     ++static int recurse_submodules_option_given;
     ++
       static int recurse_submodules_cb(const struct option *opt,
       				 const char *arg, int unset)
       {
     --	if (unset)
     --		string_list_clear((struct string_list *)opt->value, 0);
     --	else if (arg)
     --		string_list_append((struct string_list *)opt->value, arg);
     --	else
     --		string_list_append((struct string_list *)opt->value,
     --				   (const char *)opt->defval);
     -+	struct option_submodules *list = (struct option_submodules *)(opt->value);
     -+
     -+	if (unset) {
     -+		string_list_clear(&list->option, 0);
     -+		list->status = RECURSE_SUBMODULES_OFF;
     -+	}
     -+	else if (arg) {
     -+		string_list_append(&list->option, arg);
     -+		list->status = RECURSE_SUBMODULES_ON_DEMAND;
     -+	}
     -+	else {
     -+		string_list_append(&list->option, (const char *)opt->defval);
     -+		list->status = RECURSE_SUBMODULES_ON;
     -+	}
     - 
     +@@ builtin/clone.c: static int recurse_submodules_cb(const struct option *opt,
     + 	else
     + 		string_list_append((struct string_list *)opt->value,
     + 				   (const char *)opt->defval);
     +-
     ++	recurse_submodules_option_given = 1;
       	return 0;
       }
     -@@ builtin/clone.c: static int recurse_submodules_cb(const struct option *opt,
     - static struct option builtin_clone_options[] = {
     - 	OPT__VERBOSITY(&option_verbosity),
     - 	OPT_BOOL(0, "progress", &option_progress,
     --		 N_("force progress reporting")),
     -+		N_("force progress reporting")),
     - 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
     --		 N_("don't create a checkout")),
     -+		N_("don't create a checkout")),
     - 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
     - 	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
     - 			N_("create a bare repository")),
     -@@ builtin/clone.c: static struct option builtin_clone_options[] = {
     - 	OPT_BOOL('l', "local", &option_local,
     - 		N_("to clone from a local repository")),
     - 	OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
     --		    N_("don't use local hardlinks, always copy")),
     -+			N_("don't use local hardlinks, always copy")),
     - 	OPT_BOOL('s', "shared", &option_shared,
     --		    N_("setup as shared repository")),
     -+			N_("setup as shared repository")),
     - 	OPT_ALIAS(0, "recursive", "recurse-submodules"),
     - 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
     - 	  N_("pathspec"), N_("initialize submodules in the clone"),
     - 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
     - 	OPT_INTEGER('j', "jobs", &max_jobs,
     --		    N_("number of submodules cloned in parallel")),
     -+			N_("number of submodules cloned in parallel")),
     - 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
     --		   N_("directory from which templates will be used")),
     -+			N_("directory from which templates will be used")),
     - 	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
     - 			N_("reference repository")),
     - 	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
     - 			N_("repo"), N_("reference repository")),
     - 	OPT_BOOL(0, "dissociate", &option_dissociate,
     --		 N_("use --reference only while cloning")),
     -+			N_("use --reference only while cloning")),
     - 	OPT_STRING('o', "origin", &option_origin, N_("name"),
     --		   N_("use <name> instead of 'origin' to track upstream")),
     -+			N_("use <name> instead of 'origin' to track upstream")),
     - 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
     --		   N_("checkout <branch> instead of the remote's HEAD")),
     -+			N_("checkout <branch> instead of the remote's HEAD")),
     - 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
     --		   N_("path to git-upload-pack on the remote")),
     -+			N_("path to git-upload-pack on the remote")),
     - 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
     --		    N_("create a shallow clone of that depth")),
     -+			N_("create a shallow clone of that depth")),
     - 	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
     --		    N_("create a shallow clone since a specific time")),
     -+			N_("create a shallow clone since a specific time")),
     - 	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
     - 			N_("deepen history of shallow clone, excluding rev")),
     - 	OPT_BOOL(0, "single-branch", &option_single_branch,
     --		    N_("clone only one branch, HEAD or --branch")),
     -+			N_("clone only one branch, HEAD or --branch")),
     - 	OPT_BOOL(0, "no-tags", &option_no_tags,
     --		 N_("don't clone any tags, and make later fetches not to follow them")),
     -+			N_("don't clone any tags, and make later fetches not to follow them")),
     - 	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
     --		    N_("any cloned submodules will be shallow")),
     -+			N_("any cloned submodules will be shallow")),
     - 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
     --		   N_("separate git dir from working tree")),
     -+			N_("separate git dir from working tree")),
     - 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
     - 			N_("set config inside the new repository")),
     - 	OPT_STRING_LIST(0, "server-option", &server_options,
     -@@ builtin/clone.c: static struct option builtin_clone_options[] = {
     - 			TRANSPORT_FAMILY_IPV6),
     - 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
     - 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
     --		    N_("any cloned submodules will use their remote-tracking branch")),
     -+			N_("any cloned submodules will use their remote-tracking branch")),
     - 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
     --		    N_("initialize sparse-checkout file to include only files at root")),
     -+			N_("initialize sparse-checkout file to include only files at root")),
     - 	OPT_END()
     - };
     - 
     -@@ builtin/clone.c: static int checkout(int submodule_progress)
     - 	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
     - 			   oid_to_hex(&oid), "1", NULL);
     - 
     --	if (!err && (option_recurse_submodules.nr > 0)) {
     -+	if (!err && (option_recurse_submodules.option.nr > 0)) {
     - 		struct argv_array args = ARGV_ARRAY_INIT;
     - 		argv_array_pushl(&args, "submodule", "update", "--require-init", "--recursive", NULL);
       
      @@ builtin/clone.c: static int path_exists(const char *path)
       	return !stat(path, &sb);
     @@ builtin/clone.c: static int path_exists(const char *path)
       
      +static int git_clone_config(const char *var, const char *value, void *cb)
      +{
     -+	if (!strcmp(var, "submodule.recurse")){
     -+		if (git_config_bool(var, value) && option_recurse_submodules.status != RECURSE_SUBMODULES_OFF)
     -+			string_list_append(&option_recurse_submodules.option, ".");
     -+		return 0;
     -+	}
     ++	if (starts_with(var, "submodule."))
     ++		return git_default_submodule_config(var, value, NULL);
      +	return git_default_config(var, value, cb);
      +}
      +
     @@ builtin/clone.c: static int path_exists(const char *path)
       {
       	int is_bundle = 0, is_local;
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
     - 	}
     - 
     --	if (option_recurse_submodules.nr > 0) {
     -+	if (option_recurse_submodules.option.nr > 0) {
     - 		struct string_list_item *item;
     - 		struct strbuf sb = STRBUF_INIT;
     - 
     - 		/* remove duplicates */
     --		string_list_sort(&option_recurse_submodules);
     --		string_list_remove_duplicates(&option_recurse_submodules, 0);
     -+		string_list_sort(&option_recurse_submodules.option);
     -+		string_list_remove_duplicates(&option_recurse_submodules.option, 0);
     - 
     - 		/*
     - 		 * NEEDSWORK: In a multi-working-tree world, this needs to be
     - 		 * set in the per-worktree config.
     - 		 */
     --		for_each_string_list_item(item, &option_recurse_submodules) {
     -+		for_each_string_list_item(item, &option_recurse_submodules.option) {
     - 			strbuf_addf(&sb, "submodule.active=%s",
     - 				    item->string);
     - 			string_list_append(&option_config,
     -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       	write_config(&option_config);
       
      -	git_config(git_default_config, NULL);
      +	git_config(git_clone_config, NULL);
     ++	if (!recurse_submodules_option_given && should_update_submodules())
     ++		string_list_append(&option_recurse_submodules, ".");
       
       	if (option_bare) {
       		if (option_mirror)


 builtin/clone.c              | 16 ++++++++++++++--
 t/t7407-submodule-foreach.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0fc89ae2b9c..163803d89e5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "submodule.h"
 
 /*
  * Overall FIXMEs:
@@ -71,6 +72,8 @@ static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
 
+static int recurse_submodules_option_given;
+
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
 {
@@ -81,7 +84,7 @@ static int recurse_submodules_cb(const struct option *opt,
 	else
 		string_list_append((struct string_list *)opt->value,
 				   (const char *)opt->defval);
-
+	recurse_submodules_option_given = 1;
 	return 0;
 }
 
@@ -929,6 +932,13 @@ static int path_exists(const char *path)
 	return !stat(path, &sb);
 }
 
+static int git_clone_config(const char *var, const char *value, void *cb)
+{
+	if (starts_with(var, "submodule."))
+		return git_default_submodule_config(var, value, NULL);
+	return git_default_config(var, value, cb);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -1103,7 +1113,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	write_config(&option_config);
 
-	git_config(git_default_config, NULL);
+	git_config(git_clone_config, NULL);
+	if (!recurse_submodules_option_given && should_update_submodules())
+		string_list_append(&option_recurse_submodules, ".");
 
 	if (option_bare) {
 		if (option_mirror)
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6b2aa917e11..e6667d8e9b0 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -383,6 +383,36 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
 	)
 '
+test_expect_success 'use "git clone" with submodule.recurse=true to checkout all submodules' '
+	git clone -c submodule.recurse=true super clone7 &&
+	(
+		git -C clone7 rev-parse --resolve-git-dir .git --resolve-git-dir nested1/nested2/nested3/submodule/.git >actual &&
+		cat >expect <<-EOF &&
+		.git
+		$(pwd)/clone7/.git/modules/nested1/modules/nested2/modules/nested3/modules/submodule
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'use "git clone" with submodule.recurse=false and --recurse-submodules to checkout all submodules' '
+	git clone -c submodule.recurse=false --recurse-submodules super clone8 &&
+	(
+		git -C clone8 rev-parse --resolve-git-dir .git --resolve-git-dir nested1/nested2/nested3/submodule/.git >actual &&
+		cat >expect <<-EOF &&
+		.git
+		$(pwd)/clone8/.git/modules/nested1/modules/nested2/modules/nested3/modules/submodule
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'use "git clone" with submodule.recurse=true and --no-recurse-submodules to checkout no submodules' '
+	git clone -c submodule.recurse=true --no-recurse-submodules super clone9 &&
+	(
+		test_path_is_missing clone9/nested1/nested2/nested3/submodule
+	)
+'
 
 test_expect_success 'command passed to foreach retains notion of stdin' '
 	(

base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
-- 
gitgitgadget
