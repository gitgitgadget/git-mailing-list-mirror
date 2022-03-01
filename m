Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C319C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiCAAJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiCAAJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:18 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4393CC084B
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:37 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id g2-20020a170902740200b0014fc971527eso5304224pll.14
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1ALfYMdx6j4I7kPm4Vq44Cz3IGeeUu+NpRtb7yuZuMM=;
        b=CmK2A5ZVYKlgnlrzIfkxvL4GMVWNlcD4UWThT6jAllr+NnazRKUZB5O3HL2dWvOizO
         6ClrAbcyiW/BDr1uea4vXrcRkIy+M6mkN21uYinyvT8hiKw736bcGThP1XvF89ZKz9Ef
         aP56w1ASF8wWFHRe3uWtU5lnaPOR7NefLg+NSSsqR21MUJgecn8Q9DpEbnTs0nT5Bogv
         J2j8YVlKZDXsN9ZHQ5xj4PPU/caW+cdhlpO1oSv/BghYTuBfwz9WXOUBhrwMc1yuCNz1
         GxMoM0ltWiZlpUhOdgflYdsVBVGLMF4/WYZ295PULh7VDajcz9tQcYDu2OK91MwVhy8S
         xATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1ALfYMdx6j4I7kPm4Vq44Cz3IGeeUu+NpRtb7yuZuMM=;
        b=Tzr5XHPlAtDu2rQ16JyP+1assswq61BCDk48wMlG///95RpntMzfRwxPH2H40wQGB6
         CXwE1Mf8AzxcN4FGO39eL8W1vnCgCjYagszXP5FZcgBRn3i/knc8y9N3JTmIAnrX/4i8
         5AD1TRfV3QVVDSC9mUY80LwIdFglER0Z9xJUAGphkXb3i7BL7o3NwMYaY43Hu2IyZd55
         uH/IhPkqe7KjMQpykWa6yUl2bCTPTXOKmW3fnOpoMcu1i46XXslaDdI8SQEd3mF5YJl8
         eNK7RwAgMrE77yQ2zA+Ym3du9iV+/m3K/06ByV/YvnQXHAe4EGrxM+g1ivoqYP+Cgezq
         v1bA==
X-Gm-Message-State: AOAM531RB1pBH5rj9AxBX1m/41KbC0QoSdwggirq04Tn2qIps1Z52HqG
        8dN8qo3/2r/Pq1Qk4LJQyRXJjiqQPqCM2JcWvrK9OabdN1I8D3iYiF8E1VFW2OGdkr4skvJryVM
        m2cETDohREFa74z3h3smgZXsiMFpS4y+Onk2xRpLoJeLnGN+heU7OnGzkUBg3LA4=
X-Google-Smtp-Source: ABdhPJxACuz8vQV4V13bA1X4v26zVGKXten1uSatLydcXeNGaO4I+QdjK/p6xOF/NjLKFqu3BTgwFUQu0C3ffg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:568b:0:b0:378:86b8:9426 with SMTP id
 v11-20020a65568b000000b0037886b89426mr8057199pgs.70.1646093316626; Mon, 28
 Feb 2022 16:08:36 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:11 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 08/13] submodule--helper run-update-procedure: learn --remote
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach run-update-procedure to handle --remote instead of parsing
--remote in git-submodule.sh. As a result, "git submodule--helper
print-default-remote" has no more callers, so remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 39 ++++++++++++++++++++++---------------
 git-submodule.sh            | 30 +---------------------------
 2 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5fbf8713db..1d4d9231ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -73,21 +73,6 @@ static char *get_default_remote(void)
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
@@ -2028,6 +2013,7 @@ struct update_data {
 	unsigned int quiet;
 	unsigned int nofetch;
 	unsigned int just_cloned;
+	unsigned int remote;
 };
 #define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
 
@@ -2604,6 +2590,8 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
+		OPT_BOOL(0, "remote", &update_data.remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
 		OPT_END()
 	};
 
@@ -3034,6 +3022,25 @@ static int update_submodule2(struct update_data *update_data)
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
 
@@ -3432,10 +3439,10 @@ static struct cmd_struct commands[] = {
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
+	/* NEEDSWORK: remote-branch is also obsolete */
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
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

