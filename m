Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD841C34027
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A34120801
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2tix6BJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgBQRZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:25:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgBQRZb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:25:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so134442wmi.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=922JIO9OiZx+Hx7ovbjND8UXNcB0spap8OV4FDQUMxU=;
        b=H2tix6BJ8mtnv7jdZRorkpM8YvHc1JW47liQPKv5AVnWZXJdO27JVONI70N7ItB+ky
         78Tz8i+7ks1lbsVk2wxffJwwg20xBR+uNJVjYw8rVQJbCd0KueKUcisKt535QocwRPI0
         eVUK34EiXqvTUy/WKJ7miPbFfZeYAh1MtnvaA3rlDpXfiZUr6C51Lpg76YHdLKcg1DVG
         R/ohHx2bgLqY/fL6PFz0Xy+cQGWinzUFVPENqrZGEpfKC/Z+K9+ufXc9DvICrJkH/5rP
         PJ5rzO7DY1Lgj/a2tS5IYmNpEDu90FA2sRFlQDYEHuqyz8AZ10fHV4l5KqRFN1/PdjiS
         aoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=922JIO9OiZx+Hx7ovbjND8UXNcB0spap8OV4FDQUMxU=;
        b=iV0jk4XLGl6JMGEz1evaDCn6yiVLNsjBuhnb0F8j0kIOFLn5NUPlCkUq/TLKKEgHIv
         Ggl7G2+GWdOQT0cbJOccIk1ICtp9XG2T6hXLScIpk0JwUQGhryONT1BIDk+0zBv4w8IQ
         Z+2xB8c3WLzDrvyH2Gzl/3VheYhFvW8jvYB5ZCpCLwYa9r4ZbF39kEjDo4m37Alk+h9s
         vaoBwJBLLFElWKZiAHYcKd0qlHoHSMHlJnr/rSU2e/+B4lqkaaSL/saoyfeNrolGNo9w
         L+5mqkKoInLLalyEZyBFS3JlJymcfiTkOW/UCu38aoxvxfFG5H7XgopVq25wmLDHSpz+
         sDYQ==
X-Gm-Message-State: APjAAAUV3s5QgwWSJwbJbrBUE9IuB4ocG0QDGpbhK7iGxRXWwkMh8fQE
        /RjLPBYq6T3csS4SuPIbKuJ66dnG
X-Google-Smtp-Source: APXvYqzQ+9CsbIHy4/BN5OfMaUJ33wknWM3eoGUJPhDg5PuQEghhzLElUraXblvdCukY+xQy38SxIQ==
X-Received: by 2002:a05:600c:2254:: with SMTP id a20mr60377wmm.97.1581960328816;
        Mon, 17 Feb 2020 09:25:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm1893424wro.85.2020.02.17.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:25:28 -0800 (PST)
Message-Id: <d34eaf4a27236591a9bc345d5a2cb465542a3243.1581960322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
References: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:25:21 +0000
Subject: [PATCH v3 7/8] stash: eliminate crude option parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Eliminate crude option parsing and rely on real parsing instead, because
1) Crude parsing is crude, for example it's not capable of
   handling things like `git stash -m Message`
2) Adding options in two places is inconvenient and prone to bugs

As a side result, the case of `git stash -m Message` gets fixed.
Also give a good error message instead of just throwing usage at user.

----

Some review of what's been happening to this code:

Before [1], `git-stash.sh` only verified that all args begin with `-` :

	# The default command is "push" if nothing but options are given
	seen_non_option=
	for opt
	do
		case "$opt" in
		--) break ;;
		-*) ;;
		*) seen_non_option=t; break ;;
		esac
	done

Later, [1] introduced the duplicate code I'm now removing, also making
the previous test more strict by white-listing options.

----

[1] Commit 40af1468 ("stash: convert `stash--helper.c` into `stash.c`" 2019-02-26)

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/stash.c  | 59 +++++++++++++++++-------------------------------
 t/t3903-stash.sh |  5 ++++
 2 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 879fc5f3683..ed84ff2e168 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1451,8 +1451,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	return ret;
 }
 
-static int push_stash(int argc, const char **argv, const char *prefix)
+static int push_stash(int argc, const char **argv, const char *prefix,
+		      int push_assumed)
 {
+	int force_assume = 0;
 	int keep_index = -1;
 	int patch_mode = 0;
 	int include_untracked = 0;
@@ -1474,10 +1476,22 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (argc)
+	if (argc) {
+		force_assume = !strcmp(argv[0], "-p");
 		argc = parse_options(argc, argv, prefix, options,
 				     git_stash_push_usage,
-				     0);
+				     PARSE_OPT_KEEP_DASHDASH);
+	}
+
+	if (argc) {
+		if (!strcmp(argv[0], "--")) {
+			argc--;
+			argv++;
+		} else if (push_assumed && !force_assume) {
+			die("subcommand wasn't specified; 'push' can't be assumed due to unexpected token '%s'",
+			    argv[0]);
+		}
+	}
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
@@ -1550,7 +1564,6 @@ static int use_builtin_stash(void)
 
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
-	int i = -1;
 	pid_t pid = getpid();
 	const char *index_file;
 	struct argv_array args = ARGV_ARRAY_INIT;
@@ -1583,7 +1596,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		    (uintmax_t)pid);
 
 	if (!argc)
-		return !!push_stash(0, NULL, prefix);
+		return !!push_stash(0, NULL, prefix, 0);
 	else if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "clear"))
@@ -1603,45 +1616,15 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(argv[0], "create"))
 		return !!create_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "push"))
-		return !!push_stash(argc, argv, prefix);
+		return !!push_stash(argc, argv, prefix, 0);
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
 	else if (*argv[0] != '-')
 		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 			      git_stash_usage, options);
 
-	if (strcmp(argv[0], "-p")) {
-		while (++i < argc && strcmp(argv[i], "--")) {
-			/*
-			 * `akpqu` is a string which contains all short options,
-			 * except `-m` which is verified separately.
-			 */
-			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
-			    strchr("akpqu", argv[i][1]))
-				continue;
-
-			if (!strcmp(argv[i], "--all") ||
-			    !strcmp(argv[i], "--keep-index") ||
-			    !strcmp(argv[i], "--no-keep-index") ||
-			    !strcmp(argv[i], "--patch") ||
-			    !strcmp(argv[i], "--quiet") ||
-			    !strcmp(argv[i], "--include-untracked"))
-				continue;
-
-			/*
-			 * `-m` and `--message=` are verified separately because
-			 * they need to be immediately followed by a string
-			 * (i.e.`-m"foobar"` or `--message="foobar"`).
-			 */
-			if (starts_with(argv[i], "-m") ||
-			    starts_with(argv[i], "--message="))
-				continue;
-
-			usage_with_options(git_stash_usage, options);
-		}
-	}
-
+	/* Assume 'stash push' */
 	argv_array_push(&args, "push");
 	argv_array_pushv(&args, argv);
-	return !!push_stash(args.argc, args.argv, prefix);
+	return !!push_stash(args.argc, args.argv, prefix, 1);
 }
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ea56e85e70d..3ad23e2502b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -285,6 +285,11 @@ test_expect_success 'stash --no-keep-index' '
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'dont assume push with non-option args' '
+	test_must_fail git stash -q drop 2>err &&
+	test_i18ngrep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
+'
+
 test_expect_success 'stash --invalid-option' '
 	echo bar5 >file &&
 	echo bar6 >file2 &&
-- 
gitgitgadget

