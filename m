Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88979C197BF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4203223A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgLHA2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLHA2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:53 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5EC0619D2
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:19 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d8so6432162otq.6
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLBST7XuQMRlRmpenlHz+E1zD00nV0tWGMj9WDorV8g=;
        b=X9XBRzF1tdImRROTKB2SLTRFz2hFtSB4y31PrbuOUR244LlP7afnGyVTtJ6HTax7e5
         Bw/ERp9qRUvkv0uzeIoqceiewKVW5xsss/j7+ycDc0DopfVDw1mi+H6YLiT06Am+uWrN
         ZsrfLTQoFiViJ0b8yNhsS446sq99N8cmE+Qc60gSR1O/Me+2gWRC7xYoYlZddvOCIOdJ
         Zh631Fq00daAjOMzhWONt8kW0+n9v2voKjDmQvAWoCGJF+ThQQMRzT2f3F0OwouTTBHq
         Q+Fk8e+bhf4eNW0XslNL75fziIvga++ETwf8eEmu2zWFtAg10pQtO2SNkVopT7DFhZnh
         6wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLBST7XuQMRlRmpenlHz+E1zD00nV0tWGMj9WDorV8g=;
        b=CSVhrQOX72Q7h+8T7jYnOqr9CYeeKrKf7nhO6O68a9kSaD05O/qx3t1EtU13NR127w
         C1947wdC2WbwNSpKrRhn6JTSI/ibCXf60rSoojxudJUH350Q6fBriLxi4Zu+nCGFirhF
         6nP5ibVAX7k2iOXu+2SVx/6RoiEXUS/yuMAqlptj+ynkmP6ffjMG5es+AoP+OS7vz+OG
         ZusY9e8SuYpyv4V/HfiK+7ltMluffexUsISXQ3enZtjLlcgCEKtjYGzhJiYdYLZ3HkgD
         97Yr9QlfSw0yoLQfx9CZMkAqbBwJqyenEfYQ6oR753/AfQDQnsRO7rj/XCry53XKyZF3
         gvUw==
X-Gm-Message-State: AOAM5305R8Av3FTRdGMKJb+14LHD2FvDv+/9+KRRPqBcpoyB5rm9/tdk
        p6jemSJIpqU1xYV/jDkZKMEwlWmyTWB69pcN
X-Google-Smtp-Source: ABdhPJwtODRuhYVS791Oyy3unm9hTqr8J7N4ln0dPGf4mbVQY5WsUQcIiMlITVpRkTihIlHw/XOmoA==
X-Received: by 2002:a9d:3423:: with SMTP id v32mr15297263otb.129.1607387238327;
        Mon, 07 Dec 2020 16:27:18 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q18sm2712374ood.35.2020.12.07.16.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:17 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 17/19] pull: add pull.mode=ff-only
Date:   Mon,  7 Dec 2020 18:26:46 -0600
Message-Id: <20201208002648.1370414-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is very typical for Git newcomers to inadvertently create merges and
worse; pushing them. This is one of the reasons many experienced users
prefer to avoid 'git pull', and recommend newcomers to avoid it as well.

To escape these problems--and keep 'git pull' useful--it has been
suggested that 'git pull' barfs by default if the merge is
non-fast-forward, which unfortunately would break backwards
compatibility.

This patch leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it;

  pull.mode = ff-only.

Later on this mode can be enabled by default.

For the full discussion you can read:

https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |  4 +--
 Documentation/config/pull.txt   |  4 +--
 builtin/pull.c                  |  5 +++-
 builtin/remote.c                |  3 +++
 rebase.c                        |  2 ++
 rebase.h                        |  3 ++-
 t/t5520-pull.sh                 | 45 +++++++++++++++++++++++++++++++++
 7 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index b57bf2c308..39f60cd8f7 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -98,8 +98,8 @@ for details).
 
 branch.<name>.pullmode::
 	When "git pull" is run, this determines if it would either merge or
-	rebase the fetched branch. The possible values are 'merge', and
-	'rebase'. See "pull.mode" for doing this in a non
+	rebase the fetched branch. The possible values are 'merge',
+	'rebase', and 'ff-only'. See "pull.mode" for doing this in a non
 	branch-specific manner.
 
 branch.<name>.description::
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index f4385cde33..40778d9120 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -32,8 +32,8 @@ for details).
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
 	rebase the fetched branch. The possible values are 'merge',
-	and 'rebase'. See "branch.<name>.pullmode" for setting this on a
-	per-branch basis.
+	'rebase', and 'ff-only'. See "branch.<name>.pullmode" for setting
+	this on a per-branch basis.
 
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
diff --git a/builtin/pull.c b/builtin/pull.c
index 7756c8aea1..5a67667b79 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1088,6 +1088,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
+	if (mode == PULL_MODE_FF_ONLY && !can_ff)
+		die(_("The pull was not fast-forward, please either merge or rebase.\n"));
+
 	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
 			"you need to specify if you want a merge, or a rebase.\n"
@@ -1095,7 +1098,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"\n"
 			"  git config pull.mode merge    # (the default strategy)\n"
 			"  git config pull.mode rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
+			"  git config pull.mode ff-only  # fast-forward only\n"
 			"\n"
 			"You can replace \"git config\" with \"git config --global\" to set a default\n"
 			"preference for all repositories.\n"
diff --git a/builtin/remote.c b/builtin/remote.c
index 51b1e675e3..34d3ea9d38 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -335,6 +335,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		case PULL_MODE_REBASE:
 			info->rebase = REBASE_TRUE;
 			break;
+		case PULL_MODE_FF_ONLY:
+			info->rebase = REBASE_TRUE;
+			break;
 		default:
 			info->rebase = REBASE_INVALID;
 			break;
diff --git a/rebase.c b/rebase.c
index bdfca49886..c6233e888f 100644
--- a/rebase.c
+++ b/rebase.c
@@ -40,6 +40,8 @@ enum pull_mode_type pull_mode_parse_value(const char *value)
 		return PULL_MODE_MERGE;
 	else if (!strcmp(value, "rebase") || !strcmp(value, "r"))
 		return PULL_MODE_REBASE;
+	else if (!strcmp(value, "ff-only") || !strcmp(value, "f"))
+		return PULL_MODE_FF_ONLY;
 
 	return PULL_MODE_INVALID;
 }
diff --git a/rebase.h b/rebase.h
index 5ab8f4ddd5..432bcb55c4 100644
--- a/rebase.h
+++ b/rebase.h
@@ -17,7 +17,8 @@ enum pull_mode_type {
 	PULL_MODE_INVALID = -1,
 	PULL_MODE_DEFAULT = 0,
 	PULL_MODE_MERGE,
-	PULL_MODE_REBASE
+	PULL_MODE_REBASE,
+	PULL_MODE_FF_ONLY
 };
 
 enum pull_mode_type pull_mode_parse_value(const char *value);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index eb0086bd1c..b5b007b175 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -861,4 +861,49 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+setup_other () {
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other $1 &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master
+}
+
+setup_ff () {
+	setup_other master
+}
+
+setup_non_ff () {
+	setup_other master^
+}
+
+test_expect_success 'fast-forward (pull.mode=ff-only)' '
+	setup_ff &&
+	git -c pull.mode=ff-only pull
+'
+
+test_expect_success 'non-fast-forward (pull.mode=ff-only)' '
+	setup_non_ff &&
+	test_must_fail git -c pull.mode=ff-only pull
+'
+
+test_expect_success 'non-fast-forward with merge (pull.mode=ff-only)' '
+	setup_non_ff &&
+	git -c pull.mode=ff-only pull --merge
+'
+
+test_expect_success 'non-fast-forward with rebase (pull.mode=ff-only)' '
+	setup_non_ff &&
+	git -c pull.mode=ff-only pull --rebase
+'
+
+test_expect_success 'non-fast-forward error message (pull.mode=ff-only)' '
+	setup_non_ff &&
+	test_must_fail git -c pull.mode=ff-only pull 2> error &&
+	cat error &&
+	test_i18ngrep "The pull was not fast-forward" error
+'
+
 test_done
-- 
2.29.2

