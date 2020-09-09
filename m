Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D37C2BC11
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6A621973
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lmBcbjfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIIAuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgIIAt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:49:57 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6961C061755
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 17:49:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k13so739882pfh.4
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6OE/uE69yRebrRJPaGprkkwEu88LuiF7HtXoJUEcU5w=;
        b=lmBcbjfzcpREcxEpKM0AE/wx5vYybx1v3I84ILQt7GbYIutEJWiFoy3w7k+GBduQ5S
         5MKCmkVIS9Lpeu/rtt/VIdACpjBPTh2g6HuQqnrL7NPCkaQ56vxPxorUoWkw8Sq3XJM7
         e1lJUs+TG7xuoSb8tXxmjJDk36v9Cvd/6dYBDjNNW9bc3PNbv41YD2vfXEh1g9v/7plY
         U8QAKo4CInSi+sWRX17wQLU/9/Gr/aYgd6Y/G5R9NGBClkY4UK664mMR+iIJi1ssJVLm
         h4cAzQApSpA2HjRrPTBMd+7GihLvZfnngRDn8IwJSoukNYX4ekWvYicnchGADERscKx7
         0gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6OE/uE69yRebrRJPaGprkkwEu88LuiF7HtXoJUEcU5w=;
        b=pFd/+CFuKkU7Kk330sGHQbqEivyuVo0J1w+iQFENQPtjuYKm/udE/Vhsyl0ZxO+aiU
         2GUchQmrb1wRh7kisIMuJP3SIpm4cys4zET4TTXEZN6wdr9l3dS1UyB5/mMeNQOqMwj+
         bFkPMvskqj5owSfKMl7XuzE3+hYKjVWYXORk0CmVFUcAm6R1Qikv9c6ZwQ8NtfOYCNdG
         q10wGJKJFQaxhb+boYbrFfePFSHOtorhkOWQa1k5Tp7RDIkZ0DqhsEtegSQ9b0yHHnvn
         7g3yeTF52uovxq+ust6RbhCnqB0CahdU7ZczjW3/cSIpHZIaA9L9s7+XqAHmSPZaMpRs
         l59A==
X-Gm-Message-State: AOAM530LnL1QUM+IBZjgwkZ/ahjT98KTSAj47YDSauoC4z8/iQp39H6I
        R8Ui1hUPdJRN/HnB8vc92P0A4udqyONDgMQMJ8SOTkXLH0T9H5XGrmr1u7kwEL5HS+CQKVls8YS
        brMcG15/YwKJ5CzJtodZUK6uXekEOeRXu1Y9I75MQqBDMe5obH1iyNlKSpMpP45XqmQl8gED/Xg
        ==
X-Google-Smtp-Source: ABdhPJxXYd/rQKPLUicoCrMdUqbvOi67eAWo9NiHlfmlRWoMKJwP0oIV+Domi8kGvobi9vwaZpKn9zuwa7c1wR8ZzII=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a63:2d0:: with SMTP id
 199mr1021013pgc.408.1599612596270; Tue, 08 Sep 2020 17:49:56 -0700 (PDT)
Date:   Tue,  8 Sep 2020 17:49:34 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com>
Message-Id: <20200909004939.1942347-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4 4/9] hook: add --porcelain to list command
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git hook list --porcelain <hookname>', which prints simply the
commands to be run in the order suggested by the config. This option is
intended for use by user scripts, wrappers, or out-of-process Git
commands which still want to execute hooks. For example, the following
snippet might be added to git-send-email.perl to introduce a
`pre-send-email` hook:

  sub pre_send_email {
    open(my $fh, 'git hook list --porcelain pre-send-email |');
    chomp(my @hooks = <$fh>);
    close($fh);

    foreach $hook (@hooks) {
            system $hook
    }

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    | 13 +++++++++++--
 builtin/hook.c                | 17 +++++++++++++----
 t/t1360-config-based-hooks.sh | 12 ++++++++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index e458586e96..0854035ce2 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,7 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' list <hook-name>
+'git hook' list [--porcelain] <hook-name>
 
 DESCRIPTION
 -----------
@@ -43,11 +43,20 @@ Local config
 COMMANDS
 --------
 
-list <hook-name>::
+list [--porcelain] <hook-name>::
 
 List the hooks which have been configured for <hook-name>. Hooks appear
 in the order they should be run, and note the config scope where the relevant
 `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
++
+If `--porcelain` is specified, instead print the commands alone, separated by
+newlines, for easy parsing by a script.
+
+OPTIONS
+-------
+--porcelain::
+	With `list`, print the commands in the order they should be run,
+	separated by newlines, for easy parsing by a script.
 
 GIT
 ---
diff --git a/builtin/hook.c b/builtin/hook.c
index a0759a4c26..0d92124ca6 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -16,8 +16,11 @@ static int list(int argc, const char **argv, const char *prefix)
 	struct list_head *head, *pos;
 	struct hook *item;
 	struct strbuf hookname = STRBUF_INIT;
+	int porcelain = 0;
 
 	struct option list_options[] = {
+		OPT_BOOL(0, "porcelain", &porcelain,
+			 "format for execution by a script"),
 		OPT_END(),
 	};
 
@@ -29,6 +32,8 @@ static int list(int argc, const char **argv, const char *prefix)
 			      builtin_hook_usage, list_options);
 	}
 
+
+
 	strbuf_addstr(&hookname, argv[0]);
 
 	head = hook_list(&hookname);
@@ -41,10 +46,14 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct hook, list);
-		if (item)
-			printf("%s:\t%s\n",
-			       config_scope_name(item->origin),
-			       item->command.buf);
+		if (item) {
+			if (porcelain)
+				printf("%s\n", item->command.buf);
+			else
+				printf("%s:\t%s\n",
+				       config_scope_name(item->origin),
+				       item->command.buf);
+		}
 	}
 
 	clear_hook_list();
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 46d1ed354a..ebf8f38d68 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -72,4 +72,16 @@ test_expect_success 'git hook list reorders on duplicate commands' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list --porcelain prints just the command' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	$ROOT/path/def
+	$ROOT/path/ghi
+	EOF
+
+	git hook list --porcelain pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

