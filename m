Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C5B1F406
	for <e@80x24.org>; Thu, 10 May 2018 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeEJVZK (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 17:25:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42958 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbeEJVZI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 17:25:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id u6-v6so2009912pls.9
        for <git@vger.kernel.org>; Thu, 10 May 2018 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WlnT5synhViEK8EyvoWDVO5WJ11YyYAzDSdmuXxSGQY=;
        b=iHp/sJz7UlxnyBG8XZNjRJqjvzQqCKaxtT4v8sgI2m65YhuksBhuopKEPGerR3ZWyG
         g0mhke2+hTs6kOsTisaZ34EqezS0yb3EaIZXwipnhgUcE6TJEIW+7KAsrX0qSZ2Ndomy
         otKFW3C4IS80hY1OBdyFSrcrfI3UEthf5Uwhua0lREMy+dF2M+Pnz+JSR9eVHXvCz6qN
         EOi39QHr+dNvfMzkQgwGhCBm3oskLKZHt70iunbUp9KOjuj0RgcvMWprOc88l5Wzdf92
         0C5VGde5eGnqi2RwaySwDxGMSW7XxJkAHNGjZ5M5ZHXyGWEGgtta6AlRSvr8MK+C6NLH
         j4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WlnT5synhViEK8EyvoWDVO5WJ11YyYAzDSdmuXxSGQY=;
        b=ekN/YIKZZfPsxEbr8DZ1cv+iTzUhm6Bfmz9NR2r4RSG8e3lazhcDshC99iNP1gYMwt
         VSv+NHoNznpkv7qerpInQPS/u4cy1eIleTXXXY5J0fm4l07XYiqj6c45xJdScUhOe25B
         b9a4JLQTKv34HDQ9AxgxiWViYp/pLVMmbVUsyKJMKpwsUdJ/aUN+wbR+VhQXb43jNgaw
         TPpLNKXfVns+m6WHWaK2+8UEWdcc7HOs1AdwwPSRShIZgoxUASV09zKf8cXGGtI+na70
         VKjjlUQk2dh3AcKnljLh5iUgG4xSYdWKlKzi7je3lRaALfNWzN1VpK5Bp/HY2EJjVUdi
         +ljQ==
X-Gm-Message-State: ALKqPwevWTyICxktIK7VomlTYU/jUgiGizd0RMbdXhbu5EI5pTSD4QB8
        uCzIiTV/vaeBGJTsfod0O9lzGA==
X-Google-Smtp-Source: AB8JxZodZSRs7Pbvwu32SovAcaR4aDRrh19JFcbsUNWV641iRN43SPF8kv6HBKu/mwCv2UiblSR0IA==
X-Received: by 2002:a17:902:d681:: with SMTP id v1-v6mr2842905ply.16.1525987507942;
        Thu, 10 May 2018 14:25:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t1-v6sm2571778pgu.41.2018.05.10.14.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 14:25:07 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        jonathantanmy@google.com, pc44800@gmail.com, sbeller@google.com
Subject: [PATCH] submodule: port submodule subcommand 'foreach' from shell to C
Date:   Thu, 10 May 2018 14:25:01 -0700
Message-Id: <20180510212501.140660-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <xmqqo9hoj9s7.fsf@gitster-ct.c.googlers.com>
References: <xmqqo9hoj9s7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

This aims to make git-submodule foreach a builtin. 'foreach' is ported to
the submodule--helper, and submodule--helper is called from
git-submodule.sh.

Helped-by: Brandon Williams <bmwill@google.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is a resend of the last commit in origin/pc/submodule-helper-foreach
It addresses the micro nits of funny comment indentation.

Thanks,
Stefan

 builtin/submodule--helper.c | 144 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +---------
 2 files changed, 145 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c2403a915ff..4002026d1ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -439,6 +439,149 @@ static void for_each_listed_submodule(const struct module_list *list,
 		fn(list->entries[i], cb_data);
 }
 
+struct cb_foreach {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	int quiet;
+	int recursive;
+};
+#define CB_FOREACH_INIT { 0 }
+
+static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
+				       void *cb_data)
+{
+	struct cb_foreach *info = cb_data;
+	const char *path = list_item->name;
+	const struct object_id *ce_oid = &list_item->oid;
+
+	const struct submodule *sub;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char *displaypath;
+
+	displaypath = get_submodule_displaypath(path, info->prefix);
+
+	sub = submodule_from_path(the_repository, &null_oid, path);
+
+	if (!sub)
+		die(_("No url found for submodule path '%s' in .gitmodules"),
+			displaypath);
+
+	if (!is_submodule_populated_gently(path, NULL))
+		goto cleanup;
+
+	prepare_submodule_repo_env(&cp.env_array);
+
+	/*
+	 * For the purpose of executing <command> in the submodule,
+	 * separate shell is used for the purpose of running the
+	 * child process.
+	 */
+	cp.use_shell = 1;
+	cp.dir = path;
+
+	/*
+	 * NEEDSWORK: the command currently has access to the variables $name,
+	 * $sm_path, $displaypath, $sha1 and $toplevel only when the command
+	 * contains a single argument. This is done for maintaining a faithful
+	 * translation from shell script.
+	 */
+	if (info->argc == 1) {
+		char *toplevel = xgetcwd();
+		struct strbuf sb = STRBUF_INIT;
+
+		argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+		argv_array_pushf(&cp.env_array, "sm_path=%s", path);
+		argv_array_pushf(&cp.env_array, "displaypath=%s", displaypath);
+		argv_array_pushf(&cp.env_array, "sha1=%s",
+				oid_to_hex(ce_oid));
+		argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+		/*
+		 * Since the path variable was accessible from the script
+		 * before porting, it is also made available after porting.
+		 * The environment variable "PATH" has a very special purpose
+		 * on windows. And since environment variables are
+		 * case-insensitive in windows, it interferes with the
+		 * existing PATH variable. Hence, to avoid that, we expose
+		 * path via the args argv_array and not via env_array.
+		 */
+		sq_quote_buf(&sb, path);
+		argv_array_pushf(&cp.args, "path=%s; %s",
+				 sb.buf, info->argv[0]);
+		strbuf_release(&sb);
+		free(toplevel);
+	} else {
+		argv_array_pushv(&cp.args, info->argv);
+	}
+
+	if (!info->quiet)
+		printf(_("Entering '%s'\n"), displaypath);
+
+	if (info->argv[0] && run_command(&cp))
+		die(_("run_command returned non-zero status for %s\n."),
+			displaypath);
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = path;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", NULL);
+		argv_array_pushf(&cpr.args, "%s/", displaypath);
+		argv_array_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
+				NULL);
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		argv_array_pushv(&cpr.args, info->argv);
+
+		if (run_command(&cpr))
+			die(_("run_command returned non-zero status while"
+				"recursing in the nested submodules of %s\n."),
+				displaypath);
+	}
+
+cleanup:
+	free(displaypath);
+}
+
+static int module_foreach(int argc, const char **argv, const char *prefix)
+{
+	struct cb_foreach info = CB_FOREACH_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+
+	struct option module_foreach_options[] = {
+		OPT__QUIET(&info.quiet, N_("Suppress output of entering each submodule command")),
+		OPT_BOOL(0, "recursive", &info.recursive,
+			 N_("Recurse into nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper foreach [--quiet] [--recursive] <command>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_foreach_options,
+			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	info.argc = argc;
+	info.argv = argv;
+	info.prefix = prefix;
+
+	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
+
+	return 0;
+}
+
 struct init_cb {
 	const char *prefix;
 	unsigned int flags;
@@ -1841,6 +1984,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"print-default-remote", print_default_remote, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 331d71c908b..cba585f0754 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -323,44 +323,7 @@ cmd_foreach()
 		shift
 	done
 
-	toplevel=$(pwd)
-
-	# dup stdin so that it can be restored when running the external
-	# command in the subshell (and a recursive call to this function)
-	exec 3<&0
-
-	{
-		git submodule--helper list --prefix "$wt_prefix" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		if test -e "$sm_path"/.git
-		then
-			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-			say "$(eval_gettext "Entering '\$displaypath'")"
-			name=$(git submodule--helper name "$sm_path")
-			(
-				prefix="$prefix$sm_path/"
-				sanitize_submodule_env
-				cd "$sm_path" &&
-				# we make $path available to scripts ...
-				path=$sm_path &&
-				if test $# -eq 1
-				then
-					eval "$1"
-				else
-					"$@"
-				fi &&
-				if test -n "$recursive"
-				then
-					cmd_foreach "--recursive" "$@"
-				fi
-			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
-		fi
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
 }
 
 #
-- 
2.17.0.255.g8bfb7c0704

