Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1FD1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 21:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbdFSVu7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 17:50:59 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36804 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbdFSVuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 17:50:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id e187so9458246pgc.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 14:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a8QPQ5Nqx9B9yKEjRQxvlpmqcqh8imx+wD68fxCOMcA=;
        b=ngPCnfHsGCuIK1z6oriNcEr3JeJlewJHQVJjX3lTAQC43fT+RYF6gEzFo5niKh3pXS
         ADiG75WBZ96C+fgDC2uAZ6udYegyKJA3xrusMy6bhSfpGPlnWZBEklkDbRkwnL8YDZj4
         KX0U1KQg2ORqZF2tKqeG6v8Y72TQI3BDsFn57/c686zVBgQUXc9/yQ7cS5b84XMPbtEP
         MqvMdgqvXC/+ls/Xi9j74rGGqyAHfYdbkhCdiP+6euVWF6CfRQlfV6/Qohle2z8jKosw
         fu5MmyDIHg06jp3mT3VNTz+zPcmVXK9rkhk3TGSsOGLD3S2g+62ox7fDP9FJjxkbKbM4
         Qf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a8QPQ5Nqx9B9yKEjRQxvlpmqcqh8imx+wD68fxCOMcA=;
        b=r74WTNf2FmNSa7748P2D7FaQGjc38//k4may7yjaQhpTK+nPxeRnc1I75+v+LhoI0O
         43icfRUP8nGVEM9U+1QYjN0RWGD35xxYaGjoIAP7lL4ER+5ikgZHU7f4korLpytECW1a
         5LqsLZjPuP3RFe+XhaPZpprHCvrfDXgFwOcfJoMf1hFewL6vGKqe7U4LPcpwBsytWcR7
         l/PtshwRH0Sf33t2+RCM8aopn1j+J35OXCC+Q+iaOdvovdxSuEiYAQaSUweA6WZvFp+2
         aWhdfl3K2DJ+37x8WWeVTvVNb2bBrFwho6zFbGtNg5zE6IAXVwgyqUnF7GXglhaqlj1T
         ts1g==
X-Gm-Message-State: AKS2vOxyZW/kEJvtcEF7r5awGpNFKIkddw0B0MBprpljoPsmmDzbKd1c
        PudsQNZ7emRIrqnx
X-Received: by 10.98.12.134 with SMTP id 6mr27321234pfm.5.1497909054481;
        Mon, 19 Jun 2017 14:50:54 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id 5sm20744309pfe.60.2017.06.19.14.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 14:50:54 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 4/6] submodule: port submodule subcommand status
Date:   Tue, 20 Jun 2017 03:20:23 +0530
Message-Id: <20170619215025.10086-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170619215025.10086-1-pc44800@gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mechanism used for porting submodule subcommand 'status'
is similar to that used for subcommand 'foreach'.
The function cmd_status from git-submodule is ported to three
functions in the builtin submodule--helper namely: module_status,
for_each_submodule_list and status_submodule.

print_status is also introduced for handling the output of
the subcommand and also to reduce the code size.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 152 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  49 +-------------
 2 files changed, 153 insertions(+), 48 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6fd861e42..78b21ab22 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -566,6 +566,157 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct status_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int recursive: 1;
+	unsigned int cached: 1;
+};
+#define STATUS_CB_INIT { NULL, 0, 0, 0 }
+
+static void print_status(struct status_cb *info, char state, const char *path,
+			 char *sub_sha1, char *displaypath)
+{
+	if (info->quiet)
+		return;
+
+	printf("%c%s %s", state, sub_sha1, displaypath);
+
+	if (state == ' ' || state == '+') {
+		struct argv_array name_rev_args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&name_rev_args, "print-name-rev",
+				 path, sub_sha1, NULL);
+		print_name_rev(name_rev_args.argc, name_rev_args.argv,
+			       info->prefix);
+	} else {
+		printf("\n");
+	}
+}
+
+static void status_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct status_cb *info = cb_data;
+	char *sub_sha1 = xstrdup(oid_to_hex(&list_item->oid));
+	char *displaypath;
+	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
+
+	if (!submodule_from_path(null_sha1, list_item->name))
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		      list_item->name);
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	if (list_item->ce_flags) {
+		print_status(info, 'U', list_item->name,
+			     sha1_to_hex(null_sha1), displaypath);
+		goto cleanup;
+	}
+
+	if (!is_submodule_initialized(list_item->name)) {
+		print_status(info, '-', list_item->name, sub_sha1, displaypath);
+		goto cleanup;
+	}
+
+	argv_array_pushl(&diff_files_args, "diff-files",
+			 "--ignore-submodules=dirty", "--quiet", "--",
+			 list_item->name, NULL);
+
+	if (!cmd_diff_files(diff_files_args.argc, diff_files_args.argv,
+			    info->prefix)) {
+		print_status(info, ' ', list_item->name, sub_sha1, displaypath);
+	} else {
+		if (!info->cached) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf sb = STRBUF_INIT;
+
+			prepare_submodule_repo_env(&cp.env_array);
+			cp.git_cmd = 1;
+			cp.dir = list_item->name;
+
+			argv_array_pushl(&cp.args, "rev-parse",
+					 "--verify", "HEAD", NULL);
+
+			if (capture_command(&cp, &sb, 0))
+				die(_("could not run 'git rev-parse --verify"
+				      "HEAD' in submodule %s"),
+				      list_item->name);
+
+			strbuf_strip_suffix(&sb, "\n");
+			print_status(info, '+', list_item->name, sb.buf,
+				     displaypath);
+			strbuf_release(&sb);
+		} else {
+			print_status(info, '+', list_item->name, sub_sha1,
+				     displaypath);
+		}
+	}
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = list_item->name;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,
+				 "submodule--helper", "status", "--recursive",
+				 NULL);
+
+		if (info->cached)
+			argv_array_push(&cpr.args, "--cached");
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		if (run_command(&cpr))
+			die(_("failed to recurse into submodule '%s'"),
+			      list_item->name);
+	}
+
+cleanup:
+	free(displaypath);
+	free(sub_sha1);
+}
+
+static int module_status(int argc, const char **argv, const char *prefix)
+{
+	struct status_cb info = STATUS_CB_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int cached = 0;
+	int recursive = 0;
+
+	struct option module_status_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
+		OPT_BOOL(0, "cached", &cached, N_("Use commit stored in the index instead of the one stored in the submodule HEAD")),
+		OPT_BOOL(0, "recursive", &recursive, N_("Recurse into nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_status_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+	info.recursive = !!recursive;
+	info.cached = !!cached;
+
+	gitmodules_config();
+	for_each_submodule_list(list, status_submodule, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1312,6 +1463,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
+	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 091051891..a24b1b91b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1004,54 +1004,7 @@ cmd_status()
 		shift
 	done
 
-	{
-		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		name=$(git submodule--helper name "$sm_path") || exit
-		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-		if test "$stage" = U
-		then
-			say "U$sha1 $displaypath"
-			continue
-		fi
-		if ! git submodule--helper is-active "$sm_path" ||
-		{
-			! test -d "$sm_path"/.git &&
-			! test -f "$sm_path"/.git
-		}
-		then
-			say "-$sha1 $displaypath"
-			continue;
-		fi
-		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
-		then
-			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
-			say " $sha1 $displaypath$revname"
-		else
-			if test -z "$cached"
-			then
-				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
-			fi
-			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
-			say "+$sha1 $displaypath$revname"
-		fi
-
-		if test -n "$recursive"
-		then
-			(
-				prefix="$displaypath/"
-				sanitize_submodule_env
-				wt_prefix=
-				cd "$sm_path" &&
-				eval cmd_status
-			) ||
-			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
-		fi
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"
 }
 #
 # Sync remote urls for submodules
-- 
2.13.0

