Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919A61F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeCZBOq (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:14:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43954 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeCZBOo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:14:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id j2so6896361pff.10
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 18:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MJCyAMj6HwwERtQzFgd3vU1vFBsBf1wbd4F6HgOjx0=;
        b=b0nVCfCstBR73DsIKtmNGpI9S8lYpFFrhj2MHRcfn58JRTWrpD8Getmew5WRFFcDN6
         Clua53xZoGHHcmYRyqLD2g++h8apVu/xPG7K9VZUQUK11QHUGGnGDwGFcQCLUY/9qcot
         95RxwaCnFL8/aI6LpD7sD9IFXWoyq2lGL+8gya4xZvpk3UfaTA43ZmxmUVZ6ZrHN6JTX
         LWEJKgF9l2in7yoHxdsWRKP0WpF5I82DxiHHl2XTcEJjDtIPToUN3lBFhUFS5xgE4YDG
         eTRIJlkIE6WwV5fsmWdigzgAdcSFvYM0P7vis2iTDmcuUxeakVgSjjTlWlFPdRZwY7AC
         HMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MJCyAMj6HwwERtQzFgd3vU1vFBsBf1wbd4F6HgOjx0=;
        b=PJV+A5f42bMBQtWdzJJZjauB2a920Fx5mgpiEN4oiVOBkE/XHiNv4FY8fwlTpAVe5T
         tnX8hEhDvTCsj5LaXdW6lI3huHpzpngC1PwW5D4cuRvRmJPjJ/XB8p6iGercyM2myyXf
         xD3XTzpQ//mYDWWQMAZ/pmNE2s3OaZG24shtC1LBy9wyu8UHqu1tuj3f+CW2YJEEe520
         onZwKcqe927MZQTxi5QQQc5hdsWmrLbWimz1wZACtznAPlmJH+6kjEgNPhBjEuM/TsbR
         ahOVE5hd/pWpNLizcjMRsLwJGnXLMs16AFBCRKMekDVwUfr5S3hR32+jG4Fsk+uNkaui
         LjCw==
X-Gm-Message-State: AElRT7EPi9KtLY34O+tJkoAt6ATjcq02cl/hijad8OaHQoB0YHdp5KTq
        7+60TndTygrTYzN8Gp3r+KNp+1Q=
X-Google-Smtp-Source: AG47ELtC/+Yc0cg2lNKhKTszQ4MW890kgllVRX3oNhXwKKC1xZqT79prjEZyvsxrdhfnhlP+b+rrMQ==
X-Received: by 10.99.140.87 with SMTP id q23mr27011883pgn.258.1522026883831;
        Sun, 25 Mar 2018 18:14:43 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id k70sm18664894pga.72.2018.03.25.18.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 18:14:43 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v2 5/6] stash: convert branch to builtin
Date:   Sun, 25 Mar 2018 18:14:25 -0700
Message-Id: <20180326011426.19159-6-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326011426.19159-1-joel@teichroeb.net>
References: <20180326011426.19159-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++---------------
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 640de6d0aa..4226c13be3 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,6 +13,7 @@
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
 };
@@ -27,6 +28,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_branch_usage[] = {
+	N_("git stash--helper branch <branchname> [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_clear_usage[] = {
 	N_("git stash--helper clear"),
 	NULL
@@ -496,6 +502,45 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *branch = NULL;
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_branch_usage, 0);
+
+	if (argc == 0)
+		return error(_("No branch name specified"));
+
+	branch = argv[0];
+
+	if (get_stash_info(&info, argc - 1, argv + 1))
+		return -1;
+
+	argv_array_pushl(&args, "checkout", "-b", NULL);
+	argv_array_push(&args, branch);
+	argv_array_push(&args, oid_to_hex(&info.b_commit));
+	ret = cmd_checkout(args.argc, args.argv, prefix);
+	if (ret) {
+		destroy_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_apply_stash(prefix, &info, 1);
+	if (!ret && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info);
+
+	destroy_stash_info(&info);
+
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	int result = 0;
@@ -522,6 +567,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		result = branch_stash(argc, argv, prefix);
 	else {
 		error(_("unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 0b8f07b38a..c5fd4c6c44 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -598,20 +598,6 @@ drop_stash () {
 	clear_stash
 }
 
-apply_to_branch () {
-	test -n "$1" || die "$(gettext "No branch name specified")"
-	branch=$1
-	shift 1
-
-	set -- --index "$@"
-	assert_stash_like "$@"
-
-	git checkout -b $branch $REV^ &&
-	apply_stash "$@" && {
-		test -z "$IS_STASH_REF" || drop_stash "$@"
-	}
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -672,7 +658,8 @@ pop)
 	;;
 branch)
 	shift
-	apply_to_branch "$@"
+	cd "$START_DIR"
+	git stash--helper branch "$@"
 	;;
 *)
 	case $# in
-- 
2.16.2

