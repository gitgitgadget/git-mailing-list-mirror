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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F47FC07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDFA613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGEMf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhGEMf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:26 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3967C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:49 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 11so20616906oid.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO47CqSagNIZgSICHTMXjdoSnRTs4R6eFSe5BJm0jHc=;
        b=KW00ibwmVVsbjvBQ/L97gdS+DaBy0f6b79gc/28i7YHKJ6E3Q5PzEsXkhwf0AqhtEH
         Tmumfe1JYs7gRhneUWepPkpQMoo8bcx0IvrJtjtMTGC2w2PNE/xrdqFmBU+LysuLklK3
         9wLrsdxrGEiCzi072fQf+hh9baE872mnalRl9r5U/aGh6Bc3gUfjYeymI1z0heijvwTv
         WBBXMFi+mqZfTh3gku8EKCZRdUc2R6zqQhLwq9uXQTQGpmObzVipSHfWJ2RpVBSfKNRi
         kcL3qM1ZnLNa1GAvEdx5l7p5bhpL9zAgS+tUlvZX9iLUIGra/6OTI5RHIO525r+WalEt
         iojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO47CqSagNIZgSICHTMXjdoSnRTs4R6eFSe5BJm0jHc=;
        b=lh8YBaa2xGngYLn7Mnv6RY4wUIG2jXX3TDQpmTZrjBbgTNYDHUckiZKAICR/xcsJgB
         lVr1Qu2/+MLqPRnx/K4wEJoaGQ0T415txlRrRjFKLQs4pu6ZPjVECUPsCR32xEsCsoHe
         NVmGXv+w+mR2VMyS8O5wfU+wfd+SMQxUNpddWflzBqYvWP4eW4e4yDipJTzHePAji1Ak
         rHVbjSQwELz/x/v5v4dz6T2MM8APjAPYyC46nbb5XYmentvsktKGZQPJQxdB/FtFTuhk
         SU+d37kXVM0CjQz0QROD9gqka2ohJI6rKpbwgENGoBRWHhbh7VpZLzcp/1NLzh18drjX
         L/hQ==
X-Gm-Message-State: AOAM531WffLSV33WqUTFcg177S9Y/Oqbgu0T2QixYQA9d4ztyYWpRsFd
        HgVLjHt9tqhQ31mJ4NFYAIHjU2h2KEKKLw==
X-Google-Smtp-Source: ABdhPJy/3WjV/H2TyH4NXaH8gPvBzHXJR31QiFN+qhonxBRBvAom978ctAyPqYFEby5pZo56RF7IgA==
X-Received: by 2002:aca:bb41:: with SMTP id l62mr9773404oif.113.1625488369002;
        Mon, 05 Jul 2021 05:32:49 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id p18sm2586327oth.60.2021.07.05.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 22/35] pull: introduce --merge option
Date:   Mon,  5 Jul 2021 07:31:56 -0500
Message-Id: <20210705123209.1808663-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously --no-rebase (which still works for backwards compatibility).

Now we can update the default warning, and the git-pull(1) man page to
use --merge instead of the non-intuitive --no-rebase.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   | 7 +++++--
 builtin/pull.c               | 4 +++-
 t/t7601-merge-pull-config.sh | 8 ++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..d23128fa72 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -131,8 +131,11 @@ It rewrites history, which does not bode well when you
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
index 3e13f81084..0d76b54186 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -129,6 +129,8 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
+	OPT_SET_INT('m', "merge", &opt_rebase,
+		N_("incorporate changes by merging"), REBASE_FALSE),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -936,7 +938,7 @@ static void show_advice_pull_non_ff(void)
 		 "  git config pull.ff only       # fast-forward only\n"
 		 "\n"
 		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+		 "preference for all repositories. You can also pass --rebase, --merge,\n"
 		 "or --ff-only on the command line to override the configured default per\n"
 		 "invocation.\n"));
 }
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933..6d03e0b9fe 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -60,9 +60,9 @@ test_expect_success 'pull.rebase not set and --rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given' '
+test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c0 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
@@ -119,9 +119,9 @@ test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)'
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
+test_expect_success 'pull.rebase not set and --merge given (not-fast-forward)' '
 	git reset --hard c2 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.32.0.36.g70aac2b1aa

