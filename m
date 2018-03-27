Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8741F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeC0Fpu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:45:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33838 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC0Fpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:45:47 -0400
Received: by mail-pg0-f65.google.com with SMTP id q6so93468pgr.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 22:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Mhh5KgeoHHYsYMnnhWtQPX6OvcDknh5Q1ytyu3P/IM=;
        b=NmmvOUSk1AO9iualOYSCZUhRFFaod10thM+yJZWVisOnegXihbF6ri0fPohtmtaxQD
         vJBQxwAYwHGmNYOiyHfqPmXQ1Q0IQECyJu9TdFE8u7YZgl7AinJUcVD41V3Po2BKKfHE
         WbZZUqprKFujaRVICgbanL827QvQstVLEyNyGw4fprvmhKDDYSHjj7C/sNYv3lLX+vB9
         Wg1jw9WDQK/Sifgpi4QDKQQ8NFLrae5zgKjjHkRV8DJ/LAPc5MQgMlPCz/BmtSI9HYAA
         SBpvPZXtq2+tjz4uazICNKssRcg1bAtkoidN8YpmVhwp3gBsFGtMTElqQOtjfqSjNNyd
         j+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Mhh5KgeoHHYsYMnnhWtQPX6OvcDknh5Q1ytyu3P/IM=;
        b=feH+Ly8R6gAquAZlBQGC9nJWZuay/45WHmDf6n0toviGQHgkCfEdDy7eAtQ76bsDPg
         35MBkt1NgRstTwt0vu16DIc6l9Vj0SAD5Yex6zPxqw357W7xB8W8HDVP+/q393ZM6yss
         L1WKP/DexzjU80/ZjfB1T9Sxe5mS2q+nS7sAoppJA6ofzCFx7+UY0KNDJaxi574FOE+y
         YxQSJnByzV/6SULH/xzmh/5rFc+TIAAI/iQjLIF0PMkvPJRsj7cttA95HTNFmGrVNEuo
         y9UFfZ4PtZsw+G5mBu9RcY7LN6QFaLB3XzwkfxO81f8S3eOFExu14DDhXXnrnOtr9s8k
         oIXw==
X-Gm-Message-State: AElRT7EvvrrnzRJ5wOTxugP/94XmYXZHEOscRwqDGEVG8v9BkyKFihcj
        8HGHAj/7DoqAHdfmYj8jBuOqCcw=
X-Google-Smtp-Source: AG47ELsJraIbs+Me1NvkLONmQB/ZFy4kAoEjP0P9d446v+ge1p0l0KbRromb6KCwrCfL+07hAKzWtg==
X-Received: by 10.99.121.131 with SMTP id u125mr30615561pgc.263.1522129546078;
        Mon, 26 Mar 2018 22:45:46 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id n8sm898733pff.131.2018.03.26.22.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 22:45:45 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 5/5] stash: convert pop to builtin
Date:   Mon, 26 Mar 2018 22:44:32 -0700
Message-Id: <20180327054432.26419-6-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180327054432.26419-1-joel@teichroeb.net>
References: <20180327054432.26419-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref and pop_stash functions from the shell script
now that they are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 41 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 50 ++++---------------------------------------------
 2 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index d755faf33..53c0d2171 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
@@ -23,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_apply_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
@@ -513,6 +519,39 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0, ret;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	if (assert_stash_ref(&info)) {
+		free_stash_info(&info);
+		return -1;
+	}
+
+	if (do_apply_stash(prefix, &info, index)) {
+		printf_ln(_("The stash entry is kept in case you need it again."));
+		free_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_drop_stash(prefix, &info);
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *branch = NULL;
@@ -578,6 +617,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		result = pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		result = branch_stash(argc, argv, prefix);
 	else {
diff --git a/git-stash.sh b/git-stash.sh
index c5fd4c6c4..8f2640fe9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -554,50 +554,6 @@ assert_stash_like() {
 	}
 }
 
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	res=$?
-	cd_to_toplevel
-	return $res
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -634,7 +590,8 @@ push)
 	;;
 apply)
 	shift
-	apply_stash "$@"
+	cd "$START_DIR"
+	git stash--helper apply "$@"
 	;;
 clear)
 	shift
@@ -654,7 +611,8 @@ drop)
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-- 
2.16.2

