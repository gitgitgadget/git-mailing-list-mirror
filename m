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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F8FC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229C9230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgLETyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgLETyp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:45 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D689C08E861
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:42 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id w3so8103189otp.13
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2F4Y4lHwIoHakhpeYacH5Ikbck/Mt74vDktyEsLDQjM=;
        b=vFAdfXCETz+p7U6p7IFbfdgzxMbQv81kwn1xopvcf2etqbPgoyemqzKbZzk1jXHDOx
         ZmoAOcMZmztTb1see17db7AOnmEUEDvh/DE0Putuk7vxMskSfVaVdWajo5dVNE7abDUA
         1bl65zCQqbVt4T3DgGbiHhg9gA7+W2JUC6hX30XwNQaTGgcBweMKdDIsn7bdHA32NoqO
         Wkjfa/u9y4roVZVpQsm+oQgcCzskpGdg2BIQ5kkYF1Dp/gqoMoA98QzfTQ421fs+J73i
         LCqPqTjC9OCytkyEEehUkPQsckm1fRWx4cVDsWHWDu05abBiAtHAdImeYb3JnCIcMxLY
         UAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2F4Y4lHwIoHakhpeYacH5Ikbck/Mt74vDktyEsLDQjM=;
        b=Spq4tJp1vU9LboW7lBEH1nWZviKjWr/5uNaMHvANV20hceXSCeCz9refK5N/PzqTWr
         xt5ajhz3He5QowfTDv3FqzoIEZLqDVFbVcS4kIfGkurgV305VvVv8mOTwz1X2u3pX16H
         swjFIoqOFlOAbYJ+vGmqjvTQ9HRlW2BHHfvmt1EncipeXucUiklQTNINw7XtP1R3X22R
         q5CmUufzhehYKubVQhtiNp72POYp+UhMJHr2FiN8rb0926+SJ5b5/IicAMXsUCB02H4a
         1W8r32YLmX145l3XEUe6b/TlOKBVGmbw1c/VODjODlRXbPU9pGJrqGTuhZxIOjPtpmXs
         UH0Q==
X-Gm-Message-State: AOAM531aDmd7cVJ9OwHT+yll/3Yl5nMOB28BT5Rw0tY+9Q39z0eHBAPu
        HY68T/14fytMIaHe4plJYwsJs3sTrgOGLw==
X-Google-Smtp-Source: ABdhPJzGdq5IzwXPyMwui+NRntm41mH9/LMub+U18F63fY5dUYA/CvH5BlU0JbStEzegQ6EcD4FXYA==
X-Received: by 2002:a9d:5781:: with SMTP id q1mr7988544oth.325.1607198021708;
        Sat, 05 Dec 2020 11:53:41 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o6sm1553947oon.7.2020.12.05.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:41 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 13/16] pull: add proper error with --ff-only
Date:   Sat,  5 Dec 2020 13:53:10 -0600
Message-Id: <20201205195313.1557473-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current error is not user-friendly:

  fatal: not possible to fast-forward, aborting.

We want something that actually explains what is going on:

  The pull was not fast-forward, please either merge or rebase.

The user can get rid of the warning by doing either --merge or
--rebase.

Except: doing "git pull --merge" is not actually enough; we would return
to the previous behavior: "fatal: not possible to fast-forward,
aborting". In order to do the right thing we will have to change the
semantics of --ff-only.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c  | 60 +++++++++++++++++++++++-----------
 t/t5520-pull.sh | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 18 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e0157d013f..54c58618e9 100644
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
@@ -1008,20 +1027,25 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
-		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
-			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
-			"You can squelch this message by running one of the following commands:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories.\n"
-			"If unsure, run \"git pull --merge\".\n"
-			"Read \"git pull --help\" for more information."
-			));
+	if (!can_ff && !opt_rebase) {
+		if (opt_ff && !strcmp(opt_ff, "--ff-only"))
+			die(_("The pull was not fast-forward, please either merge or rebase."));
+
+		if (opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
+			advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+				"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
+				"You can squelch this message by running one of the following commands:\n"
+				"\n"
+				"  git config pull.rebase false  # merge (the default strategy)\n"
+				"  git config pull.rebase true   # rebase\n"
+				"  git config pull.ff only       # fast-forward only\n"
+				"\n"
+				"You can replace \"git config\" with \"git config --global\" to set a default\n"
+				"preference for all repositories.\n"
+				"If unsure, run \"git pull --merge\".\n"
+				"Read \"git pull --help\" for more information."
+				));
+		}
 	}
 
 	if (opt_rebase >= REBASE_TRUE) {
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..0cdac4010b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -819,4 +819,89 @@ test_expect_success 'git pull --rebase against local branch' '
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
+test_expect_success 'fast-forward (ff-only)' '
+	test_config pull.ff only &&
+	setup_ff &&
+	git pull
+'
+
+test_expect_success 'non-fast-forward (ff-only)' '
+	test_config pull.ff only &&
+	setup_non_ff &&
+	test_must_fail git pull
+'
+
+test_expect_success 'non-fast-forward with merge (ff-only)' '
+	test_config pull.ff only &&
+	setup_non_ff &&
+	git pull --merge
+'
+
+test_expect_success 'non-fast-forward with rebase (ff-only)' '
+	test_config pull.ff only &&
+	setup_non_ff &&
+	git pull --rebase
+'
+
+test_expect_success 'non-fast-forward error message (ff-only)' '
+	test_config pull.ff only &&
+	setup_non_ff &&
+	test_must_fail git pull 2> error &&
+	cat error &&
+	grep -q "The pull was not fast-forward" error
+'
+
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

