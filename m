Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBFAC4167B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CE2230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgLETyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgLETyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:41 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A3C08C5F2
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:34 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id h3so10515986oie.8
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvTQWkFYKQ2TyN5+/ZzotImNKcFX5+pavYv15u3tkKw=;
        b=hRDgk7eoCdr9Lttfx2KBa+XhFK+R8ZqzwGddXxE4qAqz9oVIFcFex3/SfI4PdtHI4K
         AIeetUb/cwHH/WDotB8OP4INdtT0SAQ1IUher0IUgcjbXFwgwIP4KiscP4Ryj6/rnJTK
         3M2OpGxQbpsmxgv+ZJRO+LdAPP2XUdwPnbbwEJM5nhA4FkSgq5nA0deQHsr1O+r5wtUQ
         gV8xWKon6t3ASh/ExPTepKw4Lh3MDrXuaHSKoxRv3nJDSzFEQcVPDC8SNFVxERkYWuM4
         MDXJu1sgCQX0SaImwaeo0toP7u143KOXFJMi5CNqOCoOi0FqYQwutaVJZ7U8nb8K6Rq2
         XQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvTQWkFYKQ2TyN5+/ZzotImNKcFX5+pavYv15u3tkKw=;
        b=POxMa2+rUAU9FLpP9iTYsdrlsphhVXWba4tjvP2avXQMwrqPv4P+8c6dW2wmnD81YS
         wM0Y4405XFOpOpv16m2uciFUd6nYNhEWFGpdpd9igJN/TWcehrs08x+pLhPF5CJFUwGh
         FrhA2D/a6o82JxRM1aEC+AiA3FGk6NHYWBOZXTBacnITo8D+EjiemmSQf8S806Wgc6T3
         ltAblFsRtrtx4GPmNbZMvTREU7ejmSw8zwRXkgsHBs0Pvm77Fj8wFAqBWB50GaAPp/xd
         9xgnyB5lCT/yUzwcG5/hIHqkNrdl+mD+6Ko0eGmlIYXvC7sAX2FYYynQfQfVJ+MQZbCC
         krVw==
X-Gm-Message-State: AOAM530/0/oVr6U6O/dKirqZzW8isWSd6HEc3ejZ3wvL8YkzhEkG2aI5
        RN43dyB76TuiP/1GIdJGEwkpqQFZwKxqhw==
X-Google-Smtp-Source: ABdhPJwlyDJS38itWmUH4HXUkTGMrEQMsfO5yBRwpwcTjerHpQiGmHtLVQ4pTw6YGrAhJI+b40Dtxw==
X-Received: by 2002:aca:1109:: with SMTP id 9mr7414932oir.129.1607198013152;
        Sat, 05 Dec 2020 11:53:33 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g188sm1614528oia.19.2020.12.05.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:32 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/16] pull: introduce --merge option
Date:   Sat,  5 Dec 2020 13:53:06 -0600
Message-Id: <20201205195313.1557473-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously --no-rebase (which still works for backwards compatbility).

Now we can update the default warning, and the git-pull(1) man page to
use --merge instead of the non-intuitive --no-rebase.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   | 9 ++++++---
 builtin/pull.c               | 4 +++-
 t/t7601-merge-pull-config.sh | 4 ++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ad33d2472c..c220da143a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -61,7 +61,7 @@ However, a non-fast-foward case looks very different.
 ------------
 
 By default `git pull` will warn about these situations, however, most likely
-you would want to force a merge, which you can do with `git pull --no-rebase`.
+you would want to force a merge, which you can do with `git pull --merge`.
 
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
@@ -148,8 +148,11 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+Previously this was --no-rebase, but that usage has been deprecated.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/pull.c b/builtin/pull.c
index cecbacc549..da91d78a22 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -131,6 +131,8 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
+	OPT_SET_INT('m', "merge", &opt_rebase,
+		N_("incorporate changes by merging"), REBASE_FALSE),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -1024,7 +1026,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"\n"
 			"You can replace \"git config\" with \"git config --global\" to set a default\n"
 			"preference for all repositories.\n"
-			"If unsure, run \"git pull --no-rebase\".\n"
+			"If unsure, run \"git pull --merge\".\n"
 			"Read \"git pull --help\" for more information."
 			));
 	}
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6b4adab8b1..1de64e6cc5 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -69,9 +69,9 @@ test_expect_success 'pull.rebase not set and --rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given' '
+test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c2 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.29.2

