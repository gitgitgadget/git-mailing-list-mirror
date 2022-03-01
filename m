Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034FFC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiCAEms (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiCAEmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:39 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D570070
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:52 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso8975084pfa.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pVUeq3Y5jSxZALpUcz7YtbpU/lAeG5FYv4uMaBelxgw=;
        b=jhJCLEib3RhmEVS+TPbRG+9IXaKZPT4pihOTg4VkKangekrrnvddMezUfEfPxSQhxG
         4KHQxB4YOQ101QV7nmX/odHlPGt7ttJZ0ybhJhOqznbpmGDIYcIQvsaDC8EkTn2WBnSI
         oIyQ94o8dWlhJvFAaltATVTRzxx09cneDCqYkPHXaB8qXxaPSChEir2N/ostrZHuacLn
         i0KYpnfQx2tRLDaWcp68g+PkyTdda2AKSUSI5MWNmNL/IrOy2DRlaoIp2vtWL9BrHNv2
         CVju1TddzFOp9SWhgltBjGk7cv52hamGpPMwAnwPgD5s6NCy7Gh0AZSeJDOIbHe0SpCN
         a8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pVUeq3Y5jSxZALpUcz7YtbpU/lAeG5FYv4uMaBelxgw=;
        b=Pb86GoffKyv8Xf20E0WVr0vzYRFEERGszz4VOf8DsNIzakCqDSM8kRivCbeiX6Knj8
         tVGFWUzmXKUteF60GuaSV0jjk4PkQbz/1xl/X5DuH9xKKuqP7tjwl7B37Q6F6tAA56A8
         OdAmnKwcEnANwOHmEa3WE3DHzpg8jX8/JY4AXzI6uICzcaT1AqJaHVbC+cshzdOVDdPZ
         Pp9pEqR5oWm9hKICgGdQuX5OIDL/5eHm9bMV1WFj4ZeEi0rbBEFUK20e+pzVIji86byx
         M9p4kxC8MOQnjicsDc72hIhcg6BBBOPcfI7o3ZHd/duOuL8M+b7gV4ZuBewyEX4/RAjg
         /ReA==
X-Gm-Message-State: AOAM533T8oziDGvaYmkQPif+CynthZu7cUVjSJnBFQPTEitq4UY+JB80
        +d8mqWTENa+20f/T03h9QKpPH1rWxn3ZViLi07EPNY39yPMv188J1Uovf/4Eygj1HHe56RtOyMS
        OqwZmSRxhY/lY4xdX/oGx1RbcGsVKsz6AnkqGQ32bZN+g/6H9vOMyLGEqcwrQMVY=
X-Google-Smtp-Source: ABdhPJyxADua15+1DJ67iagCcw65EO5q+26D/0h8UFHPb/d7c/+zXoLM+yRz2c6FcjFMSQnrp9SdAT2Gz4UwSg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:d816:b0:1bd:3194:70fc with SMTP
 id a22-20020a17090ad81600b001bd319470fcmr11451766pjv.136.1646109712081; Mon,
 28 Feb 2022 20:41:52 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:27 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 08/13] submodule--helper run-update-procedure: learn --remote
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach run-update-procedure to handle --remote instead of parsing
--remote in git-submodule.sh. As a result, "git submodule--helper
[print-default-remote|remote-branch]" have no more callers, so remove
them.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 56 +++++++++++++++----------------------
 git-submodule.sh            | 30 +-------------------
 2 files changed, 23 insertions(+), 63 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3a96c35b86..99341fb343 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -72,21 +72,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository);
 }
 
-static int print_default_remote(int argc, const char **argv, const char *prefix)
-{
-	char *remote;
-
-	if (argc != 1)
-		die(_("submodule--helper print-default-remote takes no arguments"));
-
-	remote = get_default_remote();
-	if (remote)
-		printf("%s\n", remote);
-
-	free(remote);
-	return 0;
-}
-
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -2027,6 +2012,7 @@ struct update_data {
 	unsigned int quiet;
 	unsigned int nofetch;
 	unsigned int just_cloned;
+	unsigned int remote;
 };
 #define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
 
@@ -2603,6 +2589,8 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
+		OPT_BOOL(0, "remote", &update_data.remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
 		OPT_END()
 	};
 
@@ -2682,23 +2670,6 @@ static const char *remote_submodule_branch(const char *path)
 	return branch;
 }
 
-static int resolve_remote_submodule_branch(int argc, const char **argv,
-		const char *prefix)
-{
-	const char *ret;
-	struct strbuf sb = STRBUF_INIT;
-	if (argc != 2)
-		die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
-
-	ret = remote_submodule_branch(argv[1]);
-	if (!ret)
-		die("submodule %s doesn't exist", argv[1]);
-
-	printf("%s", ret);
-	strbuf_release(&sb);
-	return 0;
-}
-
 static int push_check(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
@@ -3033,6 +3004,25 @@ static int update_submodule2(struct update_data *update_data)
 		die(_("Unable to find current revision in submodule path '%s'"),
 			update_data->displaypath);
 
+	if (update_data->remote) {
+		char *remote_name = get_default_remote_submodule(update_data->sm_path);
+		const char *branch = remote_submodule_branch(update_data->sm_path);
+		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+
+		if (!update_data->nofetch) {
+			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
+					      0, NULL))
+				die(_("Unable to fetch in submodule path '%s'"),
+				    update_data->sm_path);
+		}
+
+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
+			die(_("Unable to find %s revision in submodule path '%s'"),
+			    remote_ref, update_data->sm_path);
+
+		free(remote_ref);
+	}
+
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
 		return do_run_update_procedure(update_data);
 
@@ -3431,11 +3421,9 @@ static struct cmd_struct commands[] = {
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
-	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 458ce73ac6..23ebd90892 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -247,20 +247,6 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
-# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
-# Because arguments are positional, use an empty string to omit <depth>
-# but include <sha1>.
-fetch_in_submodule () (
-	sanitize_submodule_env &&
-	cd "$1" &&
-	if test $# -eq 3
-	then
-		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
-	else
-		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
-	fi
-)
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -409,21 +395,6 @@ cmd_update()
 			just_cloned=
 		fi
 
-		if test -n "$remote"
-		then
-			branch=$(git submodule--helper remote-branch "$sm_path")
-			if test -z "$nofetch"
-			then
-				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" $depth ||
-				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
-			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
-			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
-		fi
-
 		out=$(git submodule--helper run-update-procedure \
 			  ${wt_prefix:+--prefix "$wt_prefix"} \
 			  ${GIT_QUIET:+--quiet} \
@@ -434,6 +405,7 @@ cmd_update()
 			  ${update:+--update "$update"} \
 			  ${prefix:+--recursive-prefix "$prefix"} \
 			  ${sha1:+--oid "$sha1"} \
+			  ${remote:+--remote} \
 			  "--" \
 			  "$sm_path")
 
-- 
2.33.GIT

