Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08714C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76852065C
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9nce9tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFBQfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgFBQfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 12:35:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E330AC05BD1E
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 09:35:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a4so5288980pfo.4
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyW8bnZkP5+ffqQY3erm9rBcnaAjX68vmowtxgRsQiM=;
        b=d9nce9tJVBb1m3QNvclUAV6sMHoznWdmqVXQUN0S4p6wUieluAvjVGroHr6RnXk7fr
         WOmxBl7yHqjgAHE383amgEGRCoRU9/dppwlpDNSOsa6ZwH69yVl1F2wrj6TgkCvUtLga
         TMo5I3Hppv0O82Ei05urHNq0IKqGG0QJU99XrrWRLkS+4Vv1dfVm+7PlBdhD5+MAj9QE
         WjUEqBDtoWBtUMsfzABj655Kfrz/TNTeV2AiUFOQ1HHlwOW7fdeJhe/Cs6nTdDTfistZ
         jAKxu2h1TXYfmYV7ciTGlQehF2JLWNg/0/Z0Z8Ds/lDwNHVQW+K4/1HRVutvii0+meZT
         5qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyW8bnZkP5+ffqQY3erm9rBcnaAjX68vmowtxgRsQiM=;
        b=Ba4R2LxbH8H2YyCGCQyQWLwRfVz06IPOQKuxF0B4/TAVSwDQiNe3ETK7ROtrb0cR4E
         W6uyyXzawCRL0Uwe4MUuopvH2Kgt4kpMJcfpoQIPeokzbvatY8Tn//u67Uo4SQXw60zU
         m/PH2sLPGVZM3f6rchL2WMPLE1J8g5wqL5oxNmTE7fCzKvxu/frVMF58y0lqwJH9arSv
         jpbmvHSlq8pfRMlKHRRklr7mIW/43F6enUCrfTKq0n7O0rSmDNIn0SUibEZVnRRP0S3H
         4uB91qOxQz0HJtieprAwrCU0zRbYIgn6LkCDmTBgFADzhv5jvWbmIm09NcfWperLUx45
         7gmw==
X-Gm-Message-State: AOAM531UAvQukZzHKSAoXq1z6U2n3jXJIVCs6f/FGyHiZrN+VqfFN0NE
        I3nFUIegKA/gNLMPbSoxGPW5Piq8zrGVtw==
X-Google-Smtp-Source: ABdhPJwUlj+J/hPZpDR3B5nWFbtoqULB7oXpJoDab/AGzffQXlge8WGJnCiM/miBlzotuRM7cBefNQ==
X-Received: by 2002:a63:c004:: with SMTP id h4mr8915027pgg.385.1591115735314;
        Tue, 02 Jun 2020 09:35:35 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id c2sm2774353pfi.71.2020.06.02.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 09:35:34 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, sunshine@sunshineco.com
Subject: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from shell to C
Date:   Tue,  2 Jun 2020 22:05:23 +0530
Message-Id: <20200602163523.7131-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
Here is the v5 of the subcommand. Thank you Danh for the feedback! I
apologise for not replying on time. I have taken into account Danh's
suggestions on the `quiet` option as well as done the fixup Dscho
suggested (fixed by Junio here:
https://github.com/gitster/git/commit/77ba62f66ff8e3de54d81c240542edb42a2711c7)

 builtin/submodule--helper.c | 44 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 32 +++------------------------
 2 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f50745a03f..a974e17571 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2284,6 +2284,49 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_set_branch(int argc, const char **argv, const char *prefix)
+{
+	int opt_default = 0, ret;
+	const char *opt_branch = NULL;
+	const char *path;
+	char *config_name;
+
+	/*
+	 * We accept the `quiet` option for uniformity across subcommands,
+	 * though there is nothing to make less verbose in this subcommand.
+	 */
+	struct option options[] = {
+		OPT_NOOP_NOARG('q', "quiet"),
+		OPT_BOOL('d', "default", &opt_default,
+			N_("set the default tracking branch to master")),
+		OPT_STRING('b', "branch", &opt_branch, N_("branch"),
+			N_("set the default tracking branch")),
+		OPT_END()
+	};
+	const char *const usage[] = {
+		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
+		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
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
+	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);
+
+	free(config_name);
+	return !!ret;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2315,6 +2358,7 @@ static struct cmd_struct commands[] = {
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
+	{"set-branch", module_set_branch, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 39ebdf25b5..43eb6051d2 100755
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
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
 }
 
 #
-- 
2.26.2

