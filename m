Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C435E20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbdCMVof (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:44:35 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35648 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753920AbdCMVoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:44:01 -0400
Received: by mail-pg0-f45.google.com with SMTP id b129so70796384pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VHmG/OvDqS9Wk86RLVkir1lZnvK4o2eyX3Ix6n2Osg8=;
        b=kSgw88gTVqSVIuGoN0QPdClLbEZLYuTzy65hElEmwKBXfnjjc0S40KuLLgXK6xYq3r
         FOw0tLBkMRlGRMeTNQJCoAJVHqAzeX+J3HzgSz6etYBZQxc9ZfZRgyrxhKvl8SkXdIfB
         gPVzxumWmhKJTJMkAvIeGVu5GLBRyzH+sjOjCTxLYnX9EtpLNTVp6QItZKBi8DhW2gx8
         jq5a4NbDB1834lG3rJp/FhRcib7CxAP9QUIdir0jxfKrgg0qabyR5U/f76z9XRxss0Mv
         4R6mLx3CPjTo5TtXm/Y03F9OfZx0BZpk+fgUhNdRYkcfxSOGb5ObNfekppBs7WDBRZeq
         5RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VHmG/OvDqS9Wk86RLVkir1lZnvK4o2eyX3Ix6n2Osg8=;
        b=naD6jOqI4LA7/DzW/O1RGjgM50Rcrl1SXUi1ltzIHOPHJNMJLgfwV0PgH/luls2xMM
         CNWGkOLMiaF1gLh/yHF67TsU0SlV19obvmecr/zafwfbBIZ+6uPBp5qNICCFWw7ksDOd
         iizomCac834ijexCjJ/p1466cNIP4GMqgqyfBs0LQ0NnW/JNlNf385cgfVWrBVi/i/kM
         PwHXptSs9xI02ZUSv8Xh5JsUyOwua7XmpGUmiexNSrSA/CMfS8ljdamLXTrTwyUk7xFG
         TOb/L3xLmJZnnc9pAAarTCo77gUAmbjSj8IQ15p/3RFIxED5bMG2oDo/7Mu2iWo9MF+o
         J85A==
X-Gm-Message-State: AMke39nn2bVGOGsGEdQicz5Ed5AKqmj8/OasrLqRVeBS2FuTuYfeTZHLLk4RLJFhqZp4pKWW
X-Received: by 10.84.232.72 with SMTP id f8mr49847500pln.85.1489441434675;
        Mon, 13 Mar 2017 14:43:54 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:53 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 06/10] submodule update: add `--init-active` switch
Date:   Mon, 13 Mar 2017 14:43:37 -0700
Message-Id: <20170313214341.172676-7-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new switch `--init-active` initializes the submodules which are
configured in `submodule.active` and `submodule.<name>.active` instead
of those given as command line arguments before updating. In the first
implementation this is made incompatible with further command line
arguments as it is unclear what the user means by

    git submodule update --init --init-active <paths>

This new switch allows users to record more complex patterns as it saves
retyping them whenever you invoke update.

Based on a patch by Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-submodule.txt |  9 +++++++
 builtin/submodule--helper.c     | 35 ++++++++++++++++++++++++-
 git-submodule.sh                | 26 +++++++++++++++---
 t/t7400-submodule-basic.sh      | 58 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e05d0cdde..6b17cd707 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -198,6 +198,10 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 
+You can configure a set of submodules using pathspec syntax in
+submodule.active you can use `--init-active` to initialize
+those before updating.
+
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
@@ -384,6 +388,11 @@ the submodule itself.
 	Initialize all submodules for which "git submodule init" has not been
 	called so far before updating.
 
+--init-active::
+	This option is only valid for the update command.
+	Initialize all submodules configured in "`submodule.active`"
+	that have not been updated before.
+
 --name::
 	This option is only valid for the add command. It sets the submodule's
 	name to the given string instead of defaulting to its path. The name
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f38e332c5..a3acc9e4c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -270,6 +270,34 @@ static int module_list_compute(int argc, const char **argv,
 	return result;
 }
 
+static void module_list_active(struct module_list *list)
+{
+	int i;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	gitmodules_config();
+
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+
+		if (!S_ISGITLINK(ce->ce_mode) ||
+		    !is_submodule_initialized(ce->name))
+			continue;
+
+		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
+		list->entries[list->nr++] = ce;
+		while (i + 1 < active_nr &&
+		       !strcmp(ce->name, active_cache[i + 1]->name))
+			/*
+			 * Skip entries with the same name in different stages
+			 * to make sure an entry is returned only once.
+			 */
+			i++;
+	}
+}
+
 static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -402,9 +430,12 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
+	int active = 0;
 	int i;
 
 	struct option module_init_options[] = {
+		OPT_BOOL(0, "active", &active,
+			 N_("ensure all active submodules are properly initialized")),
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
 		OPT_END()
 	};
@@ -417,7 +448,9 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+	if (active)
+		module_list_active(&list);
+	else if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
 	for (i = 0; i < list.nr; i++)
diff --git a/git-submodule.sh b/git-submodule.sh
index e2d08595f..3c7da08aa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init[-active]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
@@ -363,6 +363,9 @@ cmd_init()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		--active)
+			GIT_ACTIVE=1
+			;;
 		--)
 			shift
 			break
@@ -377,7 +380,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet}  "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} ${GIT_ACTIVE:+--active} "$@"
 }
 
 #
@@ -506,7 +509,12 @@ cmd_update()
 			progress="--progress"
 			;;
 		-i|--init)
-			init=1
+			test -z $init || test $init = by_args || die "$(gettext "Only one of --init or --init-active may be used.")"
+			init=by_args
+			;;
+		--init-active)
+			test -z $init || test $init = by_config || die "$(gettext "Only one of --init or --init-active may be used.")"
+			init=by_config
 			;;
 		--remote)
 			remote=1
@@ -575,7 +583,17 @@ cmd_update()
 
 	if test -n "$init"
 	then
-		cmd_init "--" "$@" || return
+		if test "$init" = "by_config"
+		then
+			if test $# -gt 0
+			then
+				die "$(gettext "path arguments are incompatible with --init-active")"
+			fi
+			cmd_init "--active" || return
+		else
+			cmd_init "--" "$@" || return
+		fi
+
 	fi
 
 	{
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c09ce0d4c..cc348b807 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1130,5 +1130,63 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup superproject with submodules' '
+	git init sub1 &&
+	test_commit -C sub1 test &&
+	test_commit -C sub1 test2 &&
+	git init multisuper &&
+	git -C multisuper submodule add ../sub1 sub0 &&
+	git -C multisuper submodule add ../sub1 sub1 &&
+	git -C multisuper submodule add ../sub1 sub2 &&
+	git -C multisuper submodule add ../sub1 sub3 &&
+	git -C multisuper commit -m "add some submodules"
+'
+
+cat >expect <<-EOF
+-sub0
+ sub1 (test2)
+ sub2 (test2)
+ sub3 (test2)
+EOF
+
+test_expect_success 'submodule update --init with a specification' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone submodule update --init . ":(exclude)sub0" &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update --init-active' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone config submodule.active "." &&
+	git -C multisuper_clone config --add submodule.active ":(exclude)sub0" &&
+	git -C multisuper_clone submodule update --init-active &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_must_fail git -C multisuper_clone submodule update --init-active sub0 &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule init --active and update' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone config --bool submodule.sub0.active "true" &&
+	git -C multisuper_clone config --bool submodule.sub1.active "false" &&
+	git -C multisuper_clone config --bool submodule.sub2.active "true" &&
+
+	cat >expect <<-\EOF &&
+	 sub0 (test2)
+	-sub1
+	 sub2 (test2)
+	-sub3
+	EOF
+	git -C multisuper_clone submodule update &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
 
 test_done
-- 
2.12.0.246.ga2ecc84866-goog

