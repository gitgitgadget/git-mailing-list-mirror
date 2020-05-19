Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9B9C433E1
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F7520578
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRO6Vexy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgESS1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESS1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 14:27:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6668C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 11:27:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k7so47612pjs.5
        for <git@vger.kernel.org>; Tue, 19 May 2020 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1nS/T8EifHBVHBJAoLta9ZmL5whQjEBwdT/9rwMoy0A=;
        b=FRO6VexyB9Hnou1fInv2jwdGhqFcwRiEUv5laNsMG87FYSRa3ZoloDR1QdgVokjvxm
         xxda637ya9kYbSo8tVNfNK1ZNWS6LxIsmnMzeS2ocBrVaBonWPAOZKS80ThcO1Mnasn5
         l2FMneK+nBMfmKX2y2BDl9brNjCYiXT0l6gWTNmYNlhEnDD0dH0AXScf5e+ldbnT0eT2
         PTN3S2YaxRToqUeHh+TS6WeHZYPV6NJGp0fgT8m1+A/eKeMvln86QbguLX1bt8GbosNr
         u97x5djQH/r7OsxZvcQoGvtKNMWyV3delad+emDMrTutZa28/fvuks//hxF1rB9OBIqf
         diuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1nS/T8EifHBVHBJAoLta9ZmL5whQjEBwdT/9rwMoy0A=;
        b=V8/qRytxWa/AHZH69JoHM5WiCoCnXi2iQ96YeBabqJG6Vt9Rqd7SzGqdJwU6gYm1Uw
         X9e3PqFpY5d3/1RKLbfqyIfPQhO3SyAtikfNMBj7QaUP6a29s/yODp4TEia8LBGfLPe7
         CISz+a6JeHG7GMVk69ROxXAigpXcxfdiSxLzc8IkCVma0OBcyNl0k2SX24bcTRNCF1sm
         17QYfjY0KGEB8MeUbp6xMJaDFvhu56S4y6q9GIxAgCcnIl5MMUkf/vPybHme9Wt6+15l
         jEgp2T+Pebhx29FTd4j3vYrXGf4sPm0gfYrNO3LOnpmMzFYfWfNaZIwAm9+mMpWvsDsu
         GLYA==
X-Gm-Message-State: AOAM530UGUR61ImBL4UW1FAkrCcSe5iWac5g0FDzYBHitt4yV7CRH1r2
        /cUk3gCYDl+2tJH20aXy8/MpbV1kJfQ=
X-Google-Smtp-Source: ABdhPJziDNVTbkpJem2+yi7B3t7KLmMNKBvFFzmSho7GXr56bSO/ov9rVFKSnmQwhU/TooGqYketsg==
X-Received: by 2002:a17:90b:1103:: with SMTP id gi3mr826510pjb.184.1589912834605;
        Tue, 19 May 2020 11:27:14 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id p2sm156032pgh.25.2020.05.19.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:27:13 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, gitster@pobox.com, congdanhqx@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] submodule: port subcommand 'set-branch' from shell to C
Date:   Tue, 19 May 2020 23:56:54 +0530
Message-Id: <20200519182654.33318-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert submodule subcommand 'set-branch' to a builtin. Port 'set-branch'
to 'submodule--helper.c' and call the latter via 'git-submodule.sh'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
An improvement over the previous version, with a lot less clutter and
redundancy. This version also covers the side-effect pointed out by
Công Danh in (thanks to Kaartic for pointing it out):
https://lore.kernel.org/git/20200517161151.GA30938@danh.dev/

I have refrained from using the `newbranch` variable because using
only `opt_branch` simplified things even further (thanks to Christian).
I think a similar improvement could be made to `set-url`, but let's leave
that for 'leftoverbits' maybe?

Thank you Denton, Christian and Kaartic for the reviews! :)
Next step is conversion of `summary` to C (after the review of `set-branch`
is done).

 builtin/submodule--helper.c | 41 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 32 +++--------------------------
 2 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f50745a03f..5cd7dc84c6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2284,6 +2284,46 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_set_branch(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0, opt_default = 0;
+	char *opt_branch = NULL;
+	const char *path;
+	char *config_name;
+
+	struct option options[] = {
+		OPT__QUIET(&quiet,
+			N_("suppress output for setting default tracking branch of a submodule")),
+		OPT_BOOL(0, "default", &opt_default,
+			N_("set the default tracking branch to master")),
+		OPT_STRING(0, "branch", &opt_branch, N_("branch"),
+			N_("set the default tracking branch to the one specified")),
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
+		die(_("at least one of --branch and --default required"));
+
+	if (opt_branch && opt_default)
+		die(_("--branch and --default do not make sense together"));
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
@@ -2315,6 +2355,7 @@ static struct cmd_struct commands[] = {
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

