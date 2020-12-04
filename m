Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBBC4167B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0B322583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgLDGR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:57 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0208DC08C5F2
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:39 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id l207so2128428oib.4
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g403MEr1OfI9sycspKwBy3ZzBdW6PPDv/NTjdHribuA=;
        b=HEuOwpyEnL9Y6ExNko2EZYGeOJQ2zG+mpxYKjffvu0hEc3Rwbq1oUN8hJjSPVBFb1p
         hnmGc6zxKCeA3hkrKEavBeNlTNhmGmcKOhIAq8+4CSmULRZtGmSxi/l6TQ59Um1/LmqN
         LXchIQ7CARvhtjZX3fKkjZZGaxpC54wkgSnR5GLKp2oyJNTXpbuzfi/kB7wjhdlEEbe1
         EJYNiWryVfLh6Mm/8ShwRYWlgkeVCSpZvmP+w4SYCgP2VIj3m/3Uz4S7q1gCD2MYJhR7
         5FnYK6KMijRbpWm+92oPAldwnKz0ryMogDvkLcYR2C5dx36MXFyqixoyMZfv65nfWl93
         QAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g403MEr1OfI9sycspKwBy3ZzBdW6PPDv/NTjdHribuA=;
        b=dfSxVX0BAvnO5icFWJ+w6YGu1NFXPmCk9vj+l+4nZdODvsd0TC7ZPIJTZEN8VUtTsj
         9zEpid17VCY21TF+T23Rgo0W048GfOsf+mN4koTImnDA51KdPQtk6IqBGRCqcp4vUlwS
         7KuJsBirZiX17yRPjQoUoYm4Q56VNKM9z0hpvaptjvrflnUGy4gL8g3cd+Ey8ODIAW/5
         IyBrnn+JIUruLGN+yAYNUFiPgxhEymjKGousnN647dLFvcxFmXtUumhm8qWRR+cbZV/8
         FS1fKa/LVUN7nAUa26Gr9rzqwFxzrLcfTyjro6KOLI75Tz5fEKjHdta3oKsee3vEtXfj
         WoBg==
X-Gm-Message-State: AOAM531zzD+VH54cZ7wJKhMyJxyw5pHDB9OTEBM11f13PNP9LnIIJmiD
        bKPB2Ot7bg2rz4g+np4KlkVr0JSfqBylSA==
X-Google-Smtp-Source: ABdhPJx8E8wTinSP8hcrM/fCNzeeQUXjVdXUbDME1e5nGH+sDdB+jpmGzG0d+OygGp+OFp5q3/cCQg==
X-Received: by 2002:aca:b587:: with SMTP id e129mr2133939oif.90.1607062598157;
        Thu, 03 Dec 2020 22:16:38 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m109sm435450otc.30.2020.12.03.22.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/14] pull: display default warning only when non-ff
Date:   Fri,  4 Dec 2020 00:16:16 -0600
Message-Id: <20201204061623.1170745-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to display the annoying warning on every pull... only
the ones that are not fast-forward.

This requires the tests to pick another base, so the merge is not
fast-forward.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   |  3 +++
 builtin/pull.c               |  2 +-
 t/t7601-merge-pull-config.sh | 28 +++++++++++++++++-----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index dc812139f4..ad33d2472c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -60,6 +60,9 @@ However, a non-fast-foward case looks very different.
 	origin/master in your repository
 ------------
 
+By default `git pull` will warn about these situations, however, most likely
+you would want to force a merge, which you can do with `git pull --no-rebase`.
+
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the
diff --git a/builtin/pull.c b/builtin/pull.c
index f82e214fc8..f0b1c6bfea 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1013,7 +1013,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
 			"discouraged; you need to specify if you want a merge, or a rebase.\n"
 			"You can squelch this message by running one of the following commands:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6774e9d86f..6b4adab8b1 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'pull.rebase not set' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git -c color.advice=always pull . c1 2>err &&
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
@@ -36,54 +36,60 @@ test_expect_success 'pull.rebase not set' '
 
 '
 
-test_expect_success 'pull.rebase not set and pull.ff=true' '
+test_expect_success 'pull.rebase not set (fast-forward)' '
 	git reset --hard c0 &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=true' '
+	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	test_config pull.ff only &&
-	git pull . c1 2>err &&
+	test_must_fail git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
-	git reset --hard c0 &&
-	git pull --ff-only . c1 2>err &&
+	git reset --hard c2 &&
+	test_must_fail git pull --ff-only . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.29.2

