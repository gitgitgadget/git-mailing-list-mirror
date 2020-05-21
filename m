Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7079C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8FF208C9
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZt90AlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgEUSye (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbgEUSyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:54:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBFDC061A0F
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:54:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 5so6415440ybe.17
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UyyyqzHhRLQ6JaolD9JAOwdk4Z7TICBWzomUYHy8LyQ=;
        b=TZt90AlV8aAYoXI2XIYgwUEy32hAGhVlqUt3S+Cw4NEJb7CdwZqPyXqtmLSxoFaWu6
         cnMAkKUGawa2rT0QQRGT42BSNl4kzAKtlRmml/L3CYeDOmo3rOQj7M+zjzccjyCZouHf
         W9YEz9YdmGtkwvMWJ/KlzKNvRohVXmZCYHQkxOKHFdYmfS8DIPQdepndczIrq0tmorf/
         3zf4Af6Z+91dK0gf63lkQRFC8S0AlrAwT1/BGkj53vVZQLG+xA3ZpkZtBUgU2WB9D0Jb
         +s2YxsxYvCGf9GCyUfNxCn7nlqLa2QDQvC9KKGQesO81JWP+eLnuzgm0UKkAJO1gOBf0
         iA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UyyyqzHhRLQ6JaolD9JAOwdk4Z7TICBWzomUYHy8LyQ=;
        b=ts0f6fY7lLKmwAt+TrfSOTYtMZiCrRCV5wqcqxPZh5bCC0kb2tvOlxnXYJUGyWwd0M
         uFxRMmS6AQtqlWi+PRi23zwM8snzlG7EoLRzpozx0c1RZAS1qvfU8ehdwoXJ5i5UBdSf
         ZjI/nwQ4zDH4qWCtcKvWr7VgcYKlhTpyxcAS1ea/NTv9SyV/0FGRq9ESsXm+DkARqZGE
         nvsv2d11e6YX6lQOQFdMI4n7J0Z9dWdzreqXemQmTZLVloJmuBGfcii7z84Lgi3s4cP2
         ewR9V14EURbLg53cP7YOWMr2xF36qfy2kILvOX43EKI/yqdVTinL4cY4guiXejkHRcB+
         SEqg==
X-Gm-Message-State: AOAM530UK5JWuI28T0qPEHWcdGcTvPJaccOAcMAeHofLB74d4Cnoy797
        kvR4KSEV92P4OoAAFUXotA8IenX2zdrUqg1UQK0Cbq2MD3pCjnLloIjcOxM4Wtzk7YpcNDcG17T
        JQCsVc99mgDXKP8j/JpX4laYhp7r2ZuKhBBcrjCggfz6McY6pDU3lSPGsn37j+SgDc2yoj4mMhA
        ==
X-Google-Smtp-Source: ABdhPJxF+sL4BqDS204eyIRwI12SIUY/DQplHjnIvpIBZOVAbbWq0F14W9p/MKwVmbR6smvuHk2vTyGXjjVMkZXKnNs=
X-Received: by 2002:a25:bc81:: with SMTP id e1mr15141342ybk.311.1590087271399;
 Thu, 21 May 2020 11:54:31 -0700 (PDT)
Date:   Thu, 21 May 2020 11:54:14 -0700
In-Reply-To: <20200521185414.43760-1-emilyshaffer@google.com>
Message-Id: <20200521185414.43760-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200521185414.43760-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 4/4] hook: add --porcelain to list command
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
 t/t1360-config-based-hooks.sh | 11 +++++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)

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
index cfd8e388bd..2e51c84c81 100644
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
index 4e46d7dd4e..3296d8af45 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -55,4 +55,15 @@ test_expect_success 'git hook list reorders on duplicate commands' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list --porcelain prints just the command' '
+	cat >expected <<-\EOF &&
+	/path/ghi
+	/path/abc
+	/path/def
+	EOF
+
+	git hook list --porcelain pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.27.0.rc0.183.gde8f92d652-goog

