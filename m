Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABADC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D164B6124C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhERIRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbhERIRF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 04:17:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF044C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:15:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s20so4646115plr.13
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvFsKnuXiXZUn8wkxroaylV9nhA5Lx05B+o/iwo98+c=;
        b=pb8U94nB7m9I7GgsvMhNWTJhhai07ooXMz1u2NjysenJZTiTcTkK6csawMk9GEyWwd
         /7ilT0cjq2DbWW481hO2YFweu3IhjCSqTZY6EVdPsimQdSQswPu0jz8XBYjuVlJKC8Yv
         JWdpehrye1xf+bcHeqIGR9u9wIjrd/m57U0g93v8QCn/iqZn3j5BRoA+cbQ1sltcBotP
         tFBpyWkNJimREuOcdaJ7rAhRjIY+Six4Cgama14L6eD5MCOUJsZnHDXK1pysr2/LMnli
         91e3Ov70K12BYo1vtZdDr2VcoS++kbFGZEmlUMpHNaONIq4UgZR52u3nj8rwHbwgQXJq
         PNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvFsKnuXiXZUn8wkxroaylV9nhA5Lx05B+o/iwo98+c=;
        b=uT4tdDddlO7L3S4TkphGUl2vs/TmSvxL5RMIH91jsBGyANMCcgw87DwRFhm6ERodkK
         SIO/F+EJJ7g5Nex5cp3/JkyLio9pq60JoBeqdH4Y8dcWZrq4vcb19fyQhkcKSvO1/d+p
         aJZ8lsYAwri7xwpNS3GIL2jmXcp6O6lhNxR5Wz8XaH0frRPmZgy8ZFYEqpU3gzNOjvbG
         Ka+aaAW/uKghfZOwBUmbWDAEuYkLKMW+CrAildaq73EqeRoo2Aa+El8nXurEgc6SEL99
         tX0J8KtdhP4VhNmO+gvN35mq3e/JxHT8NUANBgnZI0Xz9udEydwgZpX5LJJB1iHLrmrJ
         meyA==
X-Gm-Message-State: AOAM531jfN8xgLPs/4JbIChc2mrAlRLU9VUk0GeCMqRIk0vHDhE3uxhZ
        /LMiyJb2XsId5sgjyHlNqjA6ZPnxqFU=
X-Google-Smtp-Source: ABdhPJzzc45eyyTSCAl8Qcxk5bj86L9MxAf2LVF9cKzmgwTx7A+D91VZ0iziHMZvKDmPlkuMGfXKmQ==
X-Received: by 2002:a17:902:bcc7:b029:ed:6f73:ffc4 with SMTP id o7-20020a170902bcc7b02900ed6f73ffc4mr3276998pls.1.1621325745837;
        Tue, 18 May 2021 01:15:45 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id bt4sm5496413pjb.53.2021.05.18.01.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 01:15:45 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] stash show: don't setup default diff output format if --{include,only}-untracked given
Date:   Tue, 18 May 2021 01:15:38 -0700
Message-Id: <76dfa90a32ae926f7477d5966109f81441eb2783.1621325684.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.171.g09c0ee21fe
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git stash show` is given no arguments, it will pass `--stat` to
`git diff` by default. When any argument is given, `--stat` is no longer
passed by default.

When `git stash show` learned the `--include-untracked` and
`--only-untracked` options, it failed to retain the same behaviour of
not passing `--stat` by default.

This isn't necessarily incorrect since with other arguments, they're
passed through directly to `git diff` which means it wouldn't make sense
to pass `--stat` as well. With `--include-untracked` and
`--only-untracked`, they are handled by `git stash show` directly
meaning we don't necessarily have this conflict. However, this would be
unintuitive for users since the existing behaviour seems to be that if
any arguments are given, `--stat` will not be given by default.

Don't setup the default diff output format if `--include-untracked` or
`--only-untracked` are given.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
This is based on 'dl/stash-show-untracked-fixup'.

 builtin/stash.c                    |  3 +-
 t/t3903-stash.sh                   | 18 ++++++++++++
 t/t3905-stash-include-untracked.sh | 46 +++++++++++-------------------
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 82e4829d44..675261b7f5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -841,6 +841,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			      UNTRACKED_ONLY, PARSE_OPT_NONEG),
 		OPT_END()
 	};
+	int old_argc = argc;
 
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
@@ -867,7 +868,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	 * The config settings are applied only if there are not passed
 	 * any options.
 	 */
-	if (revision_args.nr == 1) {
+	if (revision_args.nr == 1 && argc == old_argc) {
 		if (show_stat)
 			rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 84b039e573..5bc286e251 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -655,6 +655,24 @@ test_expect_success 'stash show --patience shows diff' '
 	diff_cmp expected actual
 '
 
+test_expect_success 'stash show --include-untracked shows diff' '
+	git reset --hard &&
+	echo foo >>file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	cat >expected <<-EOF &&
+	diff --git a/file b/file
+	index 7601807..71b52c4 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 baz
+	+foo
+	EOF
+	git stash show --include-untracked ${STASH_ID} >actual &&
+	diff_cmp expected actual
+'
+
 test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 1c9765928d..892cf7d8c9 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -307,9 +307,12 @@ test_expect_success 'stash show --include-untracked shows untracked files' '
 	git stash -u &&
 
 	cat >expect <<-EOF &&
-	 tracked   | 0
-	 untracked | 0
-	 2 files changed, 0 insertions(+), 0 deletions(-)
+	diff --git a/tracked b/tracked
+	new file mode 100644
+	index 0000000..$empty_blob_oid
+	diff --git a/untracked b/untracked
+	new file mode 100644
+	index 0000000..$empty_blob_oid
 	EOF
 	git stash show --include-untracked >actual &&
 	test_cmp expect actual &&
@@ -319,20 +322,13 @@ test_expect_success 'stash show --include-untracked shows untracked files' '
 	test_cmp expect actual &&
 	git stash show --only-untracked --include-untracked >actual &&
 	test_cmp expect actual &&
-	git -c stash.showIncludeUntracked=true stash show >actual &&
-	test_cmp expect actual &&
 
 	cat >expect <<-EOF &&
-	diff --git a/tracked b/tracked
-	new file mode 100644
-	index 0000000..$empty_blob_oid
-	diff --git a/untracked b/untracked
-	new file mode 100644
-	index 0000000..$empty_blob_oid
+	 tracked   | 0
+	 untracked | 0
+	 2 files changed, 0 insertions(+), 0 deletions(-)
 	EOF
-	git stash show -p --include-untracked >actual &&
-	test_cmp expect actual &&
-	git stash show --include-untracked -p >actual &&
+	git -c stash.showIncludeUntracked=true stash show >actual &&
 	test_cmp expect actual
 '
 
@@ -346,24 +342,15 @@ test_expect_success 'stash show --only-untracked only shows untracked files' '
 	git stash -u &&
 
 	cat >expect <<-EOF &&
-	 untracked | 0
-	 1 file changed, 0 insertions(+), 0 deletions(-)
+	diff --git a/untracked b/untracked
+	new file mode 100644
+	index 0000000..$empty_blob_oid
 	EOF
 	git stash show --only-untracked >actual &&
 	test_cmp expect actual &&
 	git stash show --no-include-untracked --only-untracked >actual &&
 	test_cmp expect actual &&
 	git stash show --include-untracked --only-untracked >actual &&
-	test_cmp expect actual &&
-
-	cat >expect <<-EOF &&
-	diff --git a/untracked b/untracked
-	new file mode 100644
-	index 0000000..$empty_blob_oid
-	EOF
-	git stash show -p --only-untracked >actual &&
-	test_cmp expect actual &&
-	git stash show --only-untracked -p >actual &&
 	test_cmp expect actual
 '
 
@@ -376,8 +363,9 @@ test_expect_success 'stash show --no-include-untracked cancels --{include,only}-
 	git stash -u &&
 
 	cat >expect <<-EOF &&
-	 tracked | 0
-	 1 file changed, 0 insertions(+), 0 deletions(-)
+	diff --git a/tracked b/tracked
+	new file mode 100644
+	index 0000000..$empty_blob_oid
 	EOF
 	git stash show --only-untracked --no-include-untracked >actual &&
 	test_cmp expect actual &&
@@ -412,7 +400,7 @@ test_expect_success 'stash show --{include,only}-untracked on stashes without un
 	git add tracked &&
 	git stash &&
 
-	git stash show >expect &&
+	git stash show -p >expect &&
 	git stash show --include-untracked >actual &&
 	test_cmp expect actual &&
 
-- 
2.32.0.rc0.171.g09c0ee21fe

