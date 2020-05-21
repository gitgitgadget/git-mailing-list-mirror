Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F6C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4862072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGh9Edc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgEUQii (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 12:38:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28AC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 09:38:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a13so3044850pls.8
        for <git@vger.kernel.org>; Thu, 21 May 2020 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PV8/+i6YA6TU/J6/UP/jGKfvS8BVC6Esc07UiPXk9Bc=;
        b=oGh9Edc6TAWdCGnp6rNoyBYYcLhjMWoP1iKuFO/uzJTNZBVQMd0CvusiEMShLJL/bI
         17YFJa80sx+6n90DZ+pWLdXaYuml1Ptljdd1D86Ap5Q1vALpVMzwr2p9I91Adg+a7rGU
         j8P23t9p20pcyV6VGMvJUOmmimW8Z5Aff5hpREgq5viJ6+jAuSCkCU+SmeGLeKin03hb
         5jimHTa1DGFnVT9+0rxyZFFgpESm7nBk/XR4IbWSoTmoHZNqFfTNbFBXMtF647AjODHF
         8TzPhpoJM82N6NFAavrkQLGcVv/6kYXa7ShEQ6/yTtie8TOEXciNR+SCLAmudPmQSAI4
         c6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PV8/+i6YA6TU/J6/UP/jGKfvS8BVC6Esc07UiPXk9Bc=;
        b=rqfJ7nU7PENKWd2SvY+LHjQoWAi3595jpobSzEBYAR1thaH/XXlWfsom4XLSninnEH
         RseYgJW9dUWJxRGBT8OyyeVXV35g1rDDoDtRk0kvHFHJVB3aJMYQVyMp115UARJLtoV/
         Ctq7THslun1UsejJ3/dk/SjCQBQk4LKd7WeQbNBbqvRif30xS65m0dNC35qahwBq1Jm/
         j9cwEvF0cPYbHhYYkJ3WJxDlQLmqaj84hCfbBof8WeN2vfMoS0/MU6lXJf/xuSg1Pf2x
         Ww6B+BBSg8kgSW3TwSVEWImLSb3qNHq+Uh7Q5UzetTltTFehcIszsG6l/wxv0Pn0z5iO
         ObTg==
X-Gm-Message-State: AOAM531wVExJo5lwHpDLHKoGgwWxiWZnA/Wh7h1c51UpXl3NkLld3b1w
        Pod/KJ84RCM44N6q5rPyVlBbhkIP+8NdBw==
X-Google-Smtp-Source: ABdhPJxnAJ7HKkMFPBai2dj5KgjK9S5Lf6Ky0UmF3SAdmaaqpuweRt8jmL0/VLUQnZ/ilN0FlaynXA==
X-Received: by 2002:a17:90b:e07:: with SMTP id ge7mr12370227pjb.105.1590079115273;
        Thu, 21 May 2020 09:38:35 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id v1sm4854421pjn.9.2020.05.21.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 09:38:34 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, gitster@pobox.com, congdanhqx@gmail.com,
        sunshine@sunshineco.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3] submodule: port subcommand 'set-branch' from shell to C
Date:   Thu, 21 May 2020 22:08:19 +0530
Message-Id: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert submodule subcommand 'set-branch' to a builtin and call it via
'git-submodule.sh'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Denton Liu <liu.denton@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
Thank you for the review Eric. I have changed the commit message,
and the error prompts. Also, I have added a brief comment about
the `quiet` option.

 builtin/submodule--helper.c | 45 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 32 +++-----------------------
 2 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f50745a03f..d14b9856a3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2284,6 +2284,50 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_set_branch(int argc, const char **argv, const char *prefix)
+{
+	/*
+	 * The `quiet` option is present for backward compatibility
+	 * but is currently not used.
+	 */
+	int quiet = 0, opt_default = 0;
+	const char *opt_branch = NULL;
+	const char *path;
+	char *config_name;
+
+	struct option options[] = {
+		OPT__QUIET(&quiet,
+			N_("suppress output for setting default tracking branch")),
+		OPT_BOOL(0, "default", &opt_default,
+			N_("set the default tracking branch to master")),
+		OPT_STRING(0, "branch", &opt_branch, N_("branch"),
+			N_("set the default tracking branch")),
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
+	if (!opt_branch && !opt_default)
+		die(_("--branch or --default required"));
+
+	if (opt_branch && opt_default)
+		die(_("--branch and --default are mutually exclusive"));
+
+	if (argc != 1 || !(path = argv[0]))
+		usage_with_options(usage, options);
+
+	config_name = xstrfmt("submodule.%s.branch", path);
+	config_set_in_gitmodules_file_gently(config_name, opt_branch);
+
+	free(config_name);
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2315,6 +2359,7 @@ static struct cmd_struct commands[] = {
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
+	{"set-branch", module_set_branch, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 39ebdf25b5..8c56191f77 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -719,7 +719,7 @@ cmd_update()
 # $@ = requested path
 #
 cmd_set_branch() {
-	unset_branch=false
+	default=
 	branch=
 
 	while test $# -ne 0
@@ -729,7 +729,7 @@ cmd_set_branch() {
 			# we don't do anything with this but we need to accept it
 			;;
 		-d|--default)
-			unset_branch=true
+			default=1
 			;;
 		-b|--branch)
 			case "$2" in '') usage ;; esac
@@ -750,33 +750,7 @@ cmd_set_branch() {
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

