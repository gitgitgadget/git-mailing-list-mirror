Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A0F200B9
	for <e@80x24.org>; Thu,  3 May 2018 00:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeECAy3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 20:54:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36522 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeECAyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 20:54:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id w129so7816615pfd.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 17:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kn5j7w4VsBQJDbKCFNhmeYyLBptsM3KMoQPtCVwLihQ=;
        b=nH9QFJyMcId9bd94Ov6K38SK35rz6qsb5yognw1skVbwF0LDUPrAD/mxwhkkRJakKr
         EVCvbW4n1WsDaGK4TGShgVYQwZWpYx9neMTOEJP4zMp0mVKUPgLozbTwt9eqd2YwApAj
         X8TD/BYeTm+5xfmsTKgmz/Q6smPD6bs+Ar1aCWp803Co+JeEe8/hH5lj6HqD+oCMID+z
         OETRm+Ba91v8/9XJFkQun+W3V2oxddslnHyYEvDugus7AITe7HX8mCTGGSVZsKwn5zXM
         bzCBJI2q2TF8fSMeIX3PenhbkrIrbNi6CtmG5nlOyhDkfVy/ybTakyMIBCfltlcGUQub
         6Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kn5j7w4VsBQJDbKCFNhmeYyLBptsM3KMoQPtCVwLihQ=;
        b=RkKONT4ddC57c2Rk2YDev7CehnxmYTYJtXd1iE41+g2Gb0PBUxapMtuLjkXFL19OJ2
         tHFUbysqR0A83Rrot95w4s8MvwxfUMr+KlLIRWYSI8MJ8vzL/pxcugNOJDu2hXneEvnE
         pVb/ivNeL0Gg+lEFpEdrBlae7MWUlVMTjRUlpSr7n8Wr1eqEmPImuTamBz7bFKmxK4fl
         wUkYeUkXTRRb5u/ZfQwkmYGU7lMTB+jdPR9lFZXrFFkCxAWEt0uLncQaBLLODODgWI2w
         VRmfsfeMQDFGKHMM+q/sNELahSwLbTkSnGa1oohacRg70w2SWLxoHnsrzpXFWvEx5bUn
         0RAQ==
X-Gm-Message-State: ALQs6tC3p3aBZLklRMvmNTEtjxUVjn1Y8zOtxz3gATgLC7o1Surs9/SK
        ZW4OGI27vFXfovU3v0eBlwKbC8lRuvg=
X-Google-Smtp-Source: AB8JxZp4+9l3e7Qs0mxka3Jd/V+QbHG9hE6/LOK2Wd3Q9NqwHhMDV+kdzm5MXbpInk/ug8nEriHrYg==
X-Received: by 2002:a17:902:d808:: with SMTP id a8-v6mr22135236plz.177.1525308861238;
        Wed, 02 May 2018 17:54:21 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p24sm12306231pfk.58.2018.05.02.17.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 17:54:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        christian.couder@gmail.com, pc44800@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] submodule: port submodule subcommand 'foreach' from shell to C
Date:   Wed,  2 May 2018 17:53:58 -0700
Message-Id: <20180503005358.89082-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180503005358.89082-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
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
 builtin/submodule--helper.c | 148 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +---------
 2 files changed, 149 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a404df3ea49..bbbea5868de 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -439,6 +439,153 @@ static void for_each_listed_submodule(const struct module_list *list,
 		fn(list->entries[i], cb_data);
 }
 
+struct cb_foreach {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	char *toplevel;
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
+	sub = submodule_from_path(&null_oid, path);
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
+	* For the purpose of executing <command> in the submodule,
+	* separate shell is used for the purpose of running the
+	* child process.
+	*/
+	cp.use_shell = 1;
+	cp.dir = path;
+
+	/*
+	* NEEDSWORK: the command currently has access to the variables $name,
+	* $sm_path, $displaypath, $sha1 and $toplevel only when the command
+	* contains a single argument. This is done for maintaining a faithful
+	* translation from shell script.
+	*/
+	if (info->argc == 1) {
+		char *toplevel = xgetcwd();
+
+		argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+		argv_array_pushf(&cp.env_array, "sm_path=%s", path);
+		argv_array_pushf(&cp.env_array, "displaypath=%s", displaypath);
+		argv_array_pushf(&cp.env_array, "sha1=%s",
+				oid_to_hex(ce_oid));
+		argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+		/*
+		* Since the path variable was accessible from the script
+		* before porting, it is also made available after porting.
+		* The environment variable "PATH" has a very special purpose
+		* on windows. And since environment variables are
+		* case-insensitive in windows, it interferes with the
+		* existing PATH variable. Hence, to avoid that, we expose
+		* path via the args argv_array and not via env_array.
+		*/
+		argv_array_pushf(&cp.args, "path=%s; %s",
+				path, info->argv[0]);
+
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
+		if (info->toplevel)
+			argv_array_pushf(&cpr.args, "--toplevel=%s", info->toplevel);
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
+		OPT_STRING(0, "toplevel", &info.toplevel, N_("path"),
+			   N_("path from the top level of the invocation")),
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
@@ -1838,6 +1985,7 @@ static struct cmd_struct commands[] = {
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
2.17.0.441.gb46fe60e1d-goog

