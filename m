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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7023DC07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E3613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhGEMft (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhGEMfr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:47 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAD6C061762
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:33:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m3so1656190oig.10
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVYotwuhI6FBI/3kC//mYo5k3GQrYq2pfEoDD07ObvU=;
        b=ExjgtlQiwVls2qdiQXx2mr4NaNsD69JXvdyH1LfXz1FxcPgVq5X5j0QL3GtgEcFO9r
         p0RLHriuBBVK8UByru+gD+qXtK8xmVy07HuwYtEOl9u256AbK6ra6QU2L/jb6P+OGB6i
         lUu3e8j6nX2+5N/3yDrmLnSkRUscZrJTf42Dx2PecW4HFXfWyM+QFG1aZJGCarQP6HTV
         baoXRUz0mQSlUqJodMRHsVtZY8oCSGm7yv5eDjrku3UdQoB6PFxZpzfHL99K4YZfCNsu
         YRQro6GnBFEi5aEC2kPdjsgHwcXtPJKaoFHcaC/RHBEky9fk+0v6erNf7Lb6uFjDtu/s
         FI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVYotwuhI6FBI/3kC//mYo5k3GQrYq2pfEoDD07ObvU=;
        b=hcPtUMb76iu9R0oldXK4eqKFY7sdDGTc74yv4jk1iGVLykDZyxCB80qjLiFKn0rGI4
         eR6yVBdY2K2ztwYp8ppEgqnjJsEcrjAZ0wtS7ZYFzPUHQafxGqqlIG7m3x/RTCfp/0s9
         QvLv4rkeLrHqFmirBNAjy2M9XiH8K+pJ7Xf32qIHg/aXTF1LZqTputvxnesDkI5bqKWC
         EamyYuEvVsaV1PnLi+x969/H60BWQRcPz7uo56UFh+x7jVIFOEI/J9CoWk1fxwGioA79
         w2GN8t/gazlBw15q5zPNY/e+vOyG8+/bnKw9AAM2d+oDii878K5GK3iZBZ6FzGyuHvpj
         a0TA==
X-Gm-Message-State: AOAM531EGNW/LqBEnheE42RO3R0pD4Mp9WoCHI4sYxo0c6EMni3jQwuO
        JjTK5uA28zjsF1GuU8ZDUaPk9ltVZCWkeQ==
X-Google-Smtp-Source: ABdhPJy5LlbuKnc3TXV+SNYnpUzwPNcHfV0aUdXOMBB5kntd55a8ktpl2Nrt6g6KUTHkCVVikjxfKQ==
X-Received: by 2002:aca:3a55:: with SMTP id h82mr9158032oia.59.1625488390021;
        Mon, 05 Jul 2021 05:33:10 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id g31sm2542800otb.53.2021.07.05.05.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:33:09 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 34/35] FUTURE: pull: enable ff-only mode by default
Date:   Mon,  5 Jul 2021 07:32:08 -0500
Message-Id: <20210705123209.1808663-35-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The user has been warned that this change was coming and should have
already configured his/her preference.

It's time to flip the switch and make ff-only the default.

There's no need for the annoying warning anymore.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   |   3 +
 builtin/pull.c               |  30 +-------
 t/t5520-pull.sh              |  28 +++-----
 t/t7601-merge-pull-config.sh | 130 -----------------------------------
 4 files changed, 16 insertions(+), 175 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d23128fa72..c2768fadb1 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -35,6 +35,9 @@ Default values for <repository> and <branch> are read from the
 "remote" and "merge" configuration for the current branch
 as set by linkgit:git-branch[1] `--track`.
 
+By default non-fast-forward merges fail, so you need to specify if you want to
+do a merge or a rebase.
+
 Assume the following history exists and the current branch is
 "`master`":
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 4771c953d2..24c72e33c6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -977,25 +977,6 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
 	return ret;
 }
 
-static void show_advice_pull_non_ff(void)
-{
-	advise(_("The pull was not a fast-forward, in the future you will have to choose\n"
-		"between a merge or a rebase.\n"
-		"\n"
-		"To quell this message you have two main options:\n"
-		"\n"
-		"1. Adopt the new behavior:\n"
-		"\n"
-		"  git config --global pull.mode fast-forward\n"
-		"\n"
-		"2. Maintain the current behavior:\n"
-		"\n"
-		"  git config --global pull.mode merge\n"
-		"\n"
-		"For now we will fall back to the traditional behavior: merge.\n"
-		"For more information check \"git help fast-forward\"."));
-}
-
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -1123,14 +1104,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!can_ff) {
-		if (!mode && opt_verbosity >= 0)
-			show_advice_pull_non_ff();
-
-		if (mode == PULL_MODE_FAST_FORWARD) {
-			diverging_advice();
-			die(_("The pull was not fast-forward, either merge or rebase.\n"));
-		}
+	if ((!mode || mode == PULL_MODE_FAST_FORWARD) && !can_ff) {
+		diverging_advice();
+		die(_("The pull was not fast-forward, either merge or rebase.\n"));
 	}
 
 	if (opt_rebase >= REBASE_TRUE) {
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index bc1c601b8b..dea3ea8c37 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -897,38 +897,30 @@ setup_non_ff () {
 	setup_other main^
 }
 
-test_expect_success 'fast-forward (pull.mode=fast-forward)' '
+test_expect_success 'fast-forward (default)' '
 	setup_ff &&
-	git -c pull.mode=fast-forward pull
+	git pull
 '
 
-test_expect_success 'non-fast-forward (pull.mode=fast-forward)' '
+test_expect_success 'non-fast-forward (default)' '
 	setup_non_ff &&
-	test_must_fail git -c pull.mode=fast-forward pull
+	test_must_fail git pull
 '
 
-test_expect_success 'non-fast-forward with merge (pull.mode=fast-forward)' '
+test_expect_success 'non-fast-forward with merge (default)' '
 	setup_non_ff &&
-	git -c pull.mode=fast-forward pull --merge
+	git pull --merge
 '
 
-test_expect_success 'non-fast-forward with rebase (pull.mode=fast-forward)' '
+test_expect_success 'non-fast-forward with rebase (default)' '
 	setup_non_ff &&
-	git -c pull.mode=fast-forward pull --rebase
+	git pull --rebase
 '
 
-test_expect_success 'non-fast-forward error message (pull.mode=fast-forward)' '
+test_expect_success 'non-fast-forward error message (default)' '
 	setup_non_ff &&
-	test_must_fail git -c pull.mode=fast-forward pull 2> error &&
+	test_must_fail git pull 2> error &&
 	test_i18ngrep "The pull was not fast-forward" error
 '
 
-test_expect_success 'non-fast-forward warning (default)' '
-	setup_non_ff &&
-	git pull 2> error &&
-	cat error &&
-	test_i18ngrep "The pull was not a fast-forward" error &&
-	test_i18ngrep "in the future you will have to choose" error
-'
-
 test_done
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 16d1e1ba47..c6c44ec570 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -27,136 +27,6 @@ test_expect_success 'setup' '
 	git tag c3
 '
 
-test_expect_success 'pull.rebase not set' '
-	git reset --hard c0 &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.mode set' '
-	git reset --hard c0 &&
-	test_config pull.mode merge &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=true' '
-	git reset --hard c0 &&
-	test_config pull.ff true &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=false' '
-	git reset --hard c0 &&
-	test_config pull.ff false &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=only' '
-	git reset --hard c0 &&
-	test_config pull.ff only &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --rebase given' '
-	git reset --hard c0 &&
-	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --merge given' '
-	git reset --hard c0 &&
-	git pull --merge . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --ff given' '
-	git reset --hard c0 &&
-	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --no-ff given' '
-	git reset --hard c0 &&
-	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --ff-only given' '
-	git reset --hard c0 &&
-	git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set (not-fast-forward)' '
-	git reset --hard c2 &&
-	git -c color.advice=always pull . c1 2>err &&
-	test_decode_color <err >decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "in the future you will have to choose" decoded
-'
-
-test_expect_success 'pull.mode set' '
-	git reset --hard c2 &&
-	test_config pull.mode merge &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
-	git reset --hard c2 &&
-	test_config pull.ff true &&
-	git pull . c1 2>err &&
-	test_i18ngrep "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
-	git reset --hard c2 &&
-	test_config pull.ff false &&
-	git pull . c1 2>err &&
-	test_i18ngrep "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
-	git reset --hard c2 &&
-	test_config pull.ff only &&
-	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
-	git reset --hard c2 &&
-	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --merge given (not-fast-forward)' '
-	git reset --hard c2 &&
-	git pull --merge . c1 2>err &&
-	test_i18ngrep ! "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
-	git reset --hard c2 &&
-	git pull --ff . c1 2>err &&
-	test_i18ngrep "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
-	git reset --hard c2 &&
-	git pull --no-ff . c1 2>err &&
-	test_i18ngrep "in the future you will have to choose" err
-'
-
-test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
-	git reset --hard c2 &&
-	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep "in the future you will have to choose" err
-'
-
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
2.32.0.36.g70aac2b1aa

