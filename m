Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9341FC433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 06:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhLaG3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 01:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLaG3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 01:29:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E59C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 22:29:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so54444224wra.6
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 22:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xpva9V0VXekHcV8IaadpbjJ5yqxOeAd4KKMHRJ2FS+c=;
        b=XuuFMmGP0mGL+z8SD+U6iambomy56S17j6D0Au2888e6O/Jgj9N962fi+rg8MUP06A
         uSsr+Ggj6dKX1z3zomlEXEmBoE6EmoT737FXwvi1C3N6m5YQLaaxArYZ1cIzUY85GeLN
         oJxLAtUF6iCneFXayWrDPKfjzcfq7Q4xlSqJt6MKx7v/howrg0LlMfsRMpsQ5TDKNbQv
         ZBw1XPjn0JTzWZS4pZufUqbTPlRPG9Qh79mRqttXiMs21qA7BxMu4iU5q+wRAb5fQf1M
         wVlI3+K0/ohJyRBHLbEinalrvOR53lcInCxJMe4JTbzbgHcsqT75dXDSQgMOjwPzyfLI
         wU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xpva9V0VXekHcV8IaadpbjJ5yqxOeAd4KKMHRJ2FS+c=;
        b=yctXakhFjzCZkShIfNhJsTdGkNO5bwDFJI58eqNX0gyULAfNwrIP+QvWNeVr9Fb5tg
         Clw8Qzf/UDbv5OTN9OhEjzqbFEQRbzynYbz5ZrXRVjt4esZZcSnouCmqGff8ZJ0eF5e2
         GVwGMDJGaFNP+4/3f2nKbNMkrwWjDZVsnsnOuL/i6aWaq0qfU93uTLBmJqEzb1+drciY
         9J86fT92/JpXlMovd9UiwXOxhhyvr2Sv0JXrWxP7UTB8t+arBzE+4yHsp96SYODYl65g
         DRcMynqvZuTkTb3C8Hq4tvDOdBgUSQS9+LsZzUZgU7FRtPOBxT/iS7h3A6AjCXfk6GYu
         6e8Q==
X-Gm-Message-State: AOAM532SZBJHrHmNRkgRQwpvzDMIZCJU+jlBCyfht92X94LfzrhM1Kst
        wyJfhAbZgu5KlBCoz0K8IJZN6zrRwaE=
X-Google-Smtp-Source: ABdhPJys9RzTY6RkIb8weRYjuNU9Gx5Q5nCm1cnEOiwPq3UpMmS3lwsLjJQX7eaztKeuSS/+5ckr7A==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr24469138wri.564.1640932153970;
        Thu, 30 Dec 2021 22:29:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11sm31927537wmq.48.2021.12.30.22.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 22:29:13 -0800 (PST)
Message-Id: <9bd3c6672c4232e0a5c0905b834146ca02af8a4b.1640932151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 06:29:10 +0000
Subject: [PATCH 1/2] builtin/reflog.c: use parse-options for expire subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Switch out manual argv parsing for the reflog expire subcommand to use
the parse-options API.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/reflog.c | 72 ++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 175c83e7cc2..afaf5ba67e2 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -11,13 +11,8 @@
 #include "revision.h"
 #include "reachable.h"
 #include "worktree.h"
+#include "parse-options.h"
 
-/* NEEDSWORK: switch to using parse_options */
-static const char reflog_expire_usage[] =
-N_("git reflog expire [--expire=<time>] "
-   "[--expire-unreachable=<time>] "
-   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
-   "[--verbose] [--all] <refs>...");
 static const char reflog_delete_usage[] =
 N_("git reflog delete [--rewrite] [--updateref] "
    "[--dry-run | -n] [--verbose] <refs>...");
@@ -539,6 +534,14 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 		cb->expire_unreachable = default_reflog_expire_unreachable;
 }
 
+static const char * reflog_expire_usage[] = {
+	N_("git reflog expire [--expire=<time>] "
+   "[--expire-unreachable=<time>] "
+   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
+   "[--verbose] [--all] <refs>..."),
+	NULL
+};
+
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct expire_reflog_policy_cb cb;
@@ -547,6 +550,29 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
 
+	const struct option options[] = {
+		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
+				EXPIRE_REFLOGS_DRY_RUN),
+		OPT_BIT(0, "rewrite", &flags,
+				N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
+				EXPIRE_REFLOGS_REWRITE),
+		OPT_BIT(0, "updateref", &flags,
+				N_("update the reference to the value of the top reflog entry"),
+				EXPIRE_REFLOGS_UPDATE_REF),
+		OPT_BIT(0, "verbose", &flags, N_("print extra information on screen."),
+				EXPIRE_REFLOGS_VERBOSE),
+		OPT_EXPIRY_DATE(0, "expire", &cb.cmd.expire_total,
+				N_("prune entries older than the specified time")),
+		OPT_EXPIRY_DATE(0, "expire-unreachable", &cb.cmd.expire_unreachable,
+			N_("prune entries older than <time> that are not reachable from the current tip of the branch")),
+		OPT_BOOL(0, "stale-fix", &cb.cmd.stalefix,
+				N_("prune any reflog entries that point to broken commits")),
+		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
+		OPT_BOOL(1, "single-worktree", &all_worktrees,
+				N_("limits processing to reflogs from the current worktree only.")),
+		OPT_END()
+	};
+
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
 	git_config(reflog_expire_config, NULL);
@@ -560,41 +586,15 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-
-		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			flags |= EXPIRE_REFLOGS_DRY_RUN;
-		else if (skip_prefix(arg, "--expire=", &arg)) {
-			if (parse_expiry_date(arg, &cb.cmd.expire_total))
-				die(_("'%s' is not a valid timestamp"), arg);
+		if (starts_with(arg, "--expire=")) {
 			explicit_expiry |= EXPIRE_TOTAL;
-		}
-		else if (skip_prefix(arg, "--expire-unreachable=", &arg)) {
-			if (parse_expiry_date(arg, &cb.cmd.expire_unreachable))
-				die(_("'%s' is not a valid timestamp"), arg);
+		} else if (starts_with(arg, "--expire-unreachable=")) {
 			explicit_expiry |= EXPIRE_UNREACH;
 		}
-		else if (!strcmp(arg, "--stale-fix"))
-			cb.cmd.stalefix = 1;
-		else if (!strcmp(arg, "--rewrite"))
-			flags |= EXPIRE_REFLOGS_REWRITE;
-		else if (!strcmp(arg, "--updateref"))
-			flags |= EXPIRE_REFLOGS_UPDATE_REF;
-		else if (!strcmp(arg, "--all"))
-			do_all = 1;
-		else if (!strcmp(arg, "--single-worktree"))
-			all_worktrees = 0;
-		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
-		else if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		else if (arg[0] == '-')
-			usage(_(reflog_expire_usage));
-		else
-			break;
 	}
 
+	argc = parse_options(argc, argv, prefix, options, reflog_expire_usage, 0);
+
 	/*
 	 * We can trust the commits and objects reachable from refs
 	 * even in older repository.  We cannot trust what's reachable
-- 
gitgitgadget

