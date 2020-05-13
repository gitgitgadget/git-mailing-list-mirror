Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFD0C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0A0206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF1RV3sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390732AbgEMUR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732650AbgEMUR7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:17:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62CC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:17:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f15so269862plr.3
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIzpy+WJc9DHkGsnCQCa10f7jmZGSgQTq4ovWOGtr9M=;
        b=bF1RV3sgvrOHe/Mf9teyJib8QoShzFTSn05gEiZ4Bl00wwezgvE75fUWJ0DRHbebLs
         vu/zhxBvpokxizDXdXo4AivWqSDzv4jsE/L3Zyhpn+G+cOG9X/E+NRzCqf2I9ZCDBDlN
         W1cIqkmhAJuwciTU/FTjwJJ9slrLf62XxfWFmebZfIZFREvHskJ6yzW5ghIn6FT8SW3S
         Yagd8z+TOuolRDUMKu2IW5RIlwgoTYI0DglL4QUU0R3ntalb6L6xtoTcILM0QcdO7uGW
         2FbzpdnvF8h2mwQh4VCcuYxolncGPEZavoFZCfEygz748Kuhwnst3MPyJNpNF+l2wHHd
         GUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIzpy+WJc9DHkGsnCQCa10f7jmZGSgQTq4ovWOGtr9M=;
        b=uJkGkouxooI/LzU9GYq5/gh8yBLZclkkdSgJTD+XtQ9I6OCuTbLxpDjT51C852481m
         O6ckZ2XcJtv3bgXFg9idxTpoITHlxbgIEv5y58GDKKA99L0BFDOA5KLaGYdHqCwh35nl
         OLREK3JBSQnfHXV20GncwTzimbFVtPyzALsmxogjvWAfN7GyJS15ssDRZcHnPyhw0bJa
         +LmP7qkLAnnggmQHYUqROnwcJS6Bbw1BIx7CBBnQQ2SRxcMuiBBY00fAOABd6Gs4PJJY
         PQ72FyYsDRHZ9DZnMIdM7vb8BdDfTreqPCgpLESqe1WmkP/cHpRuQE6BfE4Vl7+5vlgd
         gJOg==
X-Gm-Message-State: AGi0PubkDC5k67H8E57Kyzg5euNUqz3zRLGjGYX2u4Gnw9N5Uxt+/S9d
        NnFCdSaxGhmXwwUWEzyzdZr3xYxRy5g=
X-Google-Smtp-Source: APiQypIFoPzhYGe37JesCyR30tH8iEvTH43cn3AJmw8Jl2jpOBFkFVrgtW/cRX5AApryistApMDIiw==
X-Received: by 2002:a17:90a:254b:: with SMTP id j69mr34486373pje.222.1589401077894;
        Wed, 13 May 2020 13:17:57 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id b1sm342804pfi.140.2020.05.13.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 13:17:57 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        gitster@pobox.com, liu.denton@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] submodule: port subcommand 'set-branch' from shell to C
Date:   Thu, 14 May 2020 01:47:36 +0530
Message-Id: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert submodule subcommand 'set-branch' to a builtin. Port 'set-branch'
to 'submodule--helper.c' and call the latter via 'git-submodule.sh'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
Here is another conversion, this time it is 'set-branch'. It passes all
the tests in t7419. I am aware that there are some repetitve parts in
the conversion as well as variables which can be named better. I would
love everyone's suggestion on this and how this can be made better.

The extra '$branch' on line 752 was because of Christian's help after
reference from TLDP's Parameter Subsitution documentation:
https://www.tldp.org/LDP/abs/html/parameter-substitution.html

Similarly, I had to change a coouple of other lines in the shell version
so as to make it compatible with the C version.

Thank you so much Christian and Kaartic for the mentoring, this wouldn't
have been possible otherwise :)

 builtin/submodule--helper.c | 58 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 31 ++------------------
 2 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f50745a03f..5a8815b76e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2284,6 +2284,63 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_set_branch(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0, opt_branch = 0, opt_default = 0;
+	const char *newbranch;
+	const char *path;
+	char *config_name;
+
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output for setting default tracking branch of a submodule")),
+		OPT_BOOL(0, "default", &opt_default, N_("Set the default tracking branch to master")),
+		OPT_BOOL(0, "branch", &opt_branch, N_("Set the default tracking branch to the one specified")),
+		OPT_END()
+	};
+	const char *const usage[] = {
+		N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
+		N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if ((!opt_branch && !opt_default))
+		die(_("At least one of --branch and --default required"));
+
+	if (opt_branch) {
+		if (opt_default)
+			die(_("--branch and --default do not make sense"));
+
+		newbranch = argv[0];
+		path = argv[1];
+
+		if (argc != 2 || !(newbranch = argv[0]) || !(path = argv[1]))
+			usage_with_options(usage, options);
+
+		config_name = xstrfmt("submodule.%s.branch", path);
+		config_set_in_gitmodules_file_gently(config_name, newbranch);
+
+		printf(_("Default tracking branch set to '%s' successfully\n"), newbranch);
+		free(config_name);
+	}
+
+	if (opt_default) {
+		path = argv[0];
+
+		if (argc != 1 || !(path = argv[0]))
+			usage_with_options(usage, options);
+
+		config_name = xstrfmt("submodule.%s.branch", path);
+		config_set_in_gitmodules_file_gently(config_name, NULL);
+
+		printf(_("Default tracking branch set to 'master' successfully\n"));
+		free(config_name);
+	}
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2315,6 +2372,7 @@ static struct cmd_struct commands[] = {
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
+	{"set-branch", module_set_branch, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 39ebdf25b5..2438ef576e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -719,7 +719,6 @@ cmd_update()
 # $@ = requested path
 #
 cmd_set_branch() {
-	unset_branch=false
 	branch=
 
 	while test $# -ne 0
@@ -729,7 +728,7 @@ cmd_set_branch() {
 			# we don't do anything with this but we need to accept it
 			;;
 		-d|--default)
-			unset_branch=true
+			default=1
 			;;
 		-b|--branch)
 			case "$2" in '') usage ;; esac
@@ -750,33 +749,7 @@ cmd_set_branch() {
 		shift
 	done
 
-	if test $# -ne 1
-	then
-		usage
-	fi
-
-	# we can't use `git submodule--helper name` here because internally, it
-	# hashes the path so a trailing slash could lead to an unintentional no match
-	name="$(git submodule--helper list "$1" | cut -f2)"
-	if test -z "$name"
-	then
-		exit 1
-	fi
-
-	test -n "$branch"; has_branch=$?
-	test "$unset_branch" = true; has_unset_branch=$?
-
-	if test $((!$has_branch != !$has_unset_branch)) -eq 0
-	then
-		usage
-	fi
-
-	if test $has_branch -eq 0
-	then
-		git submodule--helper config submodule."$name".branch "$branch"
-	else
-		git submodule--helper config --unset submodule."$name".branch
-	fi
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"
 }
 
 #
-- 
2.26.2

