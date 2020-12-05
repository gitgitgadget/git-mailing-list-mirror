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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A29C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 04:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B01E22DD6
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 04:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgLEEHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 23:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEEHd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 23:07:33 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62169C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 20:06:47 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id f11so8669835oij.6
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 20:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFILQ23Az67Vghx7xAx5E/7bSjKC6TMinFZmUhYj3Q4=;
        b=S5cTnYO46bcbWL69MJ64gZrYXC7JBgh3+P2aJ8eOihS8M8dF4NhhUPq9+hPQrT8Yx9
         vYdTWnK9TllB5xzPjg++By6GT/sxbOAkkgIFcDnRnYs2/wPOWzjYldnt0J085bqYkIyv
         LTRL5fmIBSjl2WBnKJYwVRd+Rnn16BlPB/Vsb78R8mz3//98Ns83ek7WXj8BbWzxRyQf
         lZzi9YJssABUdXlj7pPyGyye+b6ztiH0dGx0XU7Pghs4DOuVidyl9zyTFzWk4OjyGWAI
         CqqLBpg1lRIjvWKOv5xaNqkW7NAeaxZ1rE85gZhzkTxo3S0+Nia5B2dQTGqpBzDbF3iS
         6jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFILQ23Az67Vghx7xAx5E/7bSjKC6TMinFZmUhYj3Q4=;
        b=nt54tzFspMZYjFzRNE11Ag4cEUWNDnW5Gg/kCStTXUIT3ueBHMCzxGXhGJrZhM4Hkv
         hkSdUnp0RD8soV6BxreDEDqP9jUEv00Pghgi7abhiiDhZmCapFsreZ85JVuXS3zrnlFM
         ws7EfZ783oHpv/rH5YzJyyvT6MmjY2H/aKq3PC5YNwg3rZWVNUJPNdfpwq8m5V8kGFp2
         OdJvSIZTYD2WPk35KgJKtqP3PEQaPk78dwZovSEU1RewY3eE/f1wspESnG+DaxhLyoN4
         7hTGkhRx4rFXkPHtFt+sa8LY4gkY6Xi3JButbD+cSSdMo703NOmBUv3Hz1jTx8g0rSRl
         VbJw==
X-Gm-Message-State: AOAM530HHTbZD4ZYsBK3y7bMZzUsI8rxFHHK5DtXIVPGcNJYLhy4n+73
        eXDQ1Wnal23u1vpeUDtP4PRgI3ZLSFGWcA==
X-Google-Smtp-Source: ABdhPJwYu6/mvNeygx9OqM0ys0N1xP2ZcLZF8DcfiFt+A1TxPj3hvF2NVLO50jET2DnanIsT3rK64A==
X-Received: by 2002:aca:4d8b:: with SMTP id a133mr5489159oib.79.1607141205760;
        Fri, 04 Dec 2020 20:06:45 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id c19sm1105802otn.59.2020.12.04.20.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 20:06:45 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] experiment: pull: change --ff-only and default mode
Date:   Fri,  4 Dec 2020 22:06:43 -0600
Message-Id: <20201205040644.1259845-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAMP44s1wFPQ0mEExYUQfxYx2AjMZS2=zL5ihfjp3qjp+EfNe9Q@mail.gmail.com>
References: <CAMP44s1wFPQ0mEExYUQfxYx2AjMZS2=zL5ihfjp3qjp+EfNe9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c  | 40 ++++++++++++++++++++++++++--------------
 t/t5520-pull.sh | 23 +++++++++++++++++++++++
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e389ffcdc3..95ecbdaad5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -62,6 +62,7 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 		*value = parse_config_rebase("--rebase", arg, 0);
 	else
 		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+	if (*value != REBASE_INVALID) default_mode = 0;
 	return *value == REBASE_INVALID ? -1 : 0;
 }
 
@@ -114,6 +115,23 @@ static int opt_show_forced_updates = -1;
 static char *set_upstream;
 static struct strvec opt_fetch = STRVEC_INIT;
 
+static int parse_opt_ff_only(const struct option *opt, const char *arg, int unset)
+{
+	char **value = opt->value;
+	opt_rebase = REBASE_FALSE;
+	*value = "--ff-only";
+	return 0;
+}
+
+static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
+{
+	char **value = opt->value;
+	opt_ff = NULL;
+	*value = REBASE_FALSE;
+	default_mode = 0;
+	return 0;
+}
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -131,8 +149,9 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
-	OPT_SET_INT('m', "merge", &opt_rebase,
-		N_("incorporate changes by merging"), 0),
+	OPT_CALLBACK_F('m', "merge", &opt_rebase, NULL,
+		N_("incorporate changes by merging"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_merge),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -161,9 +180,9 @@ static struct option pull_options[] = {
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
@@ -924,6 +943,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	git_config(git_pull_config, NULL);
 
+	opt_ff = xstrdup_or_null(config_get_ff());
+	opt_rebase = config_get_rebase();
+
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
 	if (cleanup_arg)
@@ -935,12 +957,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
-		opt_ff = xstrdup_or_null(config_get_ff());
-
-	if (opt_rebase < 0)
-		opt_rebase = config_get_rebase();
-
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
@@ -1037,10 +1053,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	/* Disable --ff-only when --merge is specified */
-	if (!can_ff && !default_mode && !opt_rebase && opt_ff && !strcmp(opt_ff, "--ff-only"))
-		opt_ff = NULL;
-
 	if (opt_rebase) {
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f48d0f8d50..c0cfde54e1 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -881,4 +881,27 @@ test_expect_success 'git pull non-fast-forward error message' '
 	grep -q "The pull was not fast-forward" error
 '
 
+test_expect_success 'git pull --merge overrides --ffonly' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.ff only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull --ff-only --merge
+'
+
+test_expect_success 'git pull --ff-only overrides --merge' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull --merge --ff-only
+'
+
 test_done
-- 
2.29.2

