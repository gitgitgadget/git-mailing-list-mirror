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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F9C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 20:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0133B2246B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgLEUUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 15:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLEUUR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 15:20:17 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC5C0613D4
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 12:19:37 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id l10so2279523oom.6
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPCwxRe7lx+Cxa1ALv/55JdGdNMDDpytU0DAkwMAdLI=;
        b=BTRAm/rwPaq5zfMTHWyGZhI72j1V5zxJzL9zK/fSESGQ/AXHxWMRM1pZYzw0w+I0he
         uqNnEmFz3fTp4BJfBnrnxHOxFUnPD/DMVF+pn9DEaxBrm3hhzG30ZSrzVw6UYBRSqhII
         Ow50d8R7IQAo9BE8ydXSLn70gEql3v9SbShspHaJAy2Au8QWcw7ecMKj8uaJ9X0SS3fF
         ehrG0KzM7eLj064V+vTRuiQOQ21EdnFdeYcRRX8aZ1Odom57EJ56L+LD0aFWqrlh4cWp
         Wz4klxMbdCt0szs9b8QhaMmqJ95vUq50SH3IROirkjE1R+WJsoOJqR705yH+UJsOKAcc
         uBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPCwxRe7lx+Cxa1ALv/55JdGdNMDDpytU0DAkwMAdLI=;
        b=iDsQtw3tHdb5oOzKA0j89aDeHqncBha1evUQkjwdReLQGn1IuLvx0Iypwic4Q+vR2H
         /gct1A8d3iSpmc2PdM0MQvjAYyrGzru2fDfDbLjiZI/N9JeJti2WjWWmAg/CCLLjSO7R
         6e1OaQFAilkrUcT5pgkQyRySAV03lEebYYi5G9/5K/KOO9Zb6jdro+9gGsBXH1UQEPxJ
         ypjqij6D/enoi2lMEiV4X94G3tGe46R84/8iO1OLdCRWQ17hvpWA3GI21nqtM0UZOn8d
         6agC4baqkP75Z1SWTIKynyCbqNnSW6RgPvl97/8aUiFsZQ86QQXHnipCwjDAruzIeifg
         CbrQ==
X-Gm-Message-State: AOAM530NQ9uzUQmr41kgXr8ri9C1lCDPdy/9OViZXnz8SQZ3mD8D9Oz7
        Sk6UuHZvuIiKygdDRCq4/1rpeIWrdEAKxA==
X-Google-Smtp-Source: ABdhPJxH9nuSSLq/QPUiCqaCZhj9diGDMgm8K4oFHFPYfRMRJp3CgxDFY/GabSzlSttbD6eMpoh7dA==
X-Received: by 2002:a4a:764e:: with SMTP id w14mr7926615ooe.56.1607199576434;
        Sat, 05 Dec 2020 12:19:36 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 2sm1633098oir.40.2020.12.05.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 12:19:35 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] tentative: pull: change the semantics of --ff-only
Date:   Sat,  5 Dec 2020 14:19:33 -0600
Message-Id: <20201205201933.1560133-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205201933.1560133-1-felipe.contreras@gmail.com>
References: <CAMP44s3xqjoJm5AL6dLcS6R-RFGGOdQ39W+ZY3_PWL+WMeCxjw@mail.gmail.com>
 <20201205201933.1560133-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want the last thing specified to override everything previously.

For example --merge should override a previous "pull.ff = only"
configuration.

And --ff-only should override a previous "pull.rebase = true"
configuration.

Currently "git pull --ff-only --merge" fails with:

  fatal: not possible to fast-forward, aborting.

But that's not what we want; we want --merge to override --ff-only and
do a --no-ff merge.

This is a backwards-incompatible change that achieves that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c  | 27 +++++++++++++++++++++++----
 t/t5520-pull.sh | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 44ec6e7216..54c58618e9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -112,6 +112,24 @@ static int opt_show_forced_updates = -1;
 static char *set_upstream;
 static struct strvec opt_fetch = STRVEC_INIT;
 
+static int parse_opt_ff_only(const struct option *opt, const char *arg, int unset)
+{
+	char **value = opt->value;
+	opt_rebase = REBASE_DEFAULT;
+	free(*value);
+	*value = xstrdup_or_null("--ff-only");
+	return 0;
+}
+
+static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
+{
+	enum rebase_type *value = opt->value;
+	free(opt_ff);
+	opt_ff = NULL;
+	*value = REBASE_FALSE;
+	return 0;
+}
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -129,8 +147,9 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
-	OPT_SET_INT('m', "merge", &opt_rebase,
-		N_("incorporate changes by merging"), REBASE_FALSE),
+	OPT_CALLBACK_F('m', "merge", &opt_rebase, NULL,
+		N_("incorporate changes by merging"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_merge),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -159,9 +178,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
+	OPT_CALLBACK_F(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_ff_only),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 067780e658..0cdac4010b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -849,7 +849,7 @@ test_expect_success 'non-fast-forward (ff-only)' '
 	test_must_fail git pull
 '
 
-test_expect_failure 'non-fast-forward with merge (ff-only)' '
+test_expect_success 'non-fast-forward with merge (ff-only)' '
 	test_config pull.ff only &&
 	setup_non_ff &&
 	git pull --merge
@@ -869,4 +869,39 @@ test_expect_success 'non-fast-forward error message (ff-only)' '
 	grep -q "The pull was not fast-forward" error
 '
 
+test_expect_success '--merge overrides --ff-only' '
+	setup_non_ff &&
+	git pull --ff-only --merge
+'
+
+test_expect_success '--rebase overrides --ff-only' '
+	setup_non_ff &&
+	git pull --ff-only --rebase
+'
+
+test_expect_success '--ff-only overrides --merge' '
+	setup_non_ff &&
+	test_must_fail git pull --merge --ff-only
+'
+
+test_expect_success '--ff-only overrides pull.rebase=false' '
+	test_config pull.rebase false &&
+	setup_non_ff &&
+	test_must_fail git pull --ff-only
+'
+
+test_expect_success 'pull.rebase=true overrides pull.ff=only' '
+	test_config pull.ff only &&
+	test_config pull.rebase true &&
+	setup_non_ff &&
+	git pull
+'
+
+test_expect_success 'pull.rebase=false overrides pull.ff=only' '
+	test_config pull.ff only &&
+	test_config pull.rebase false &&
+	setup_non_ff &&
+	test_must_fail git pull
+'
+
 test_done
-- 
2.29.2

