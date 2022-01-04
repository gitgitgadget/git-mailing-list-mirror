Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF994C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiADVph (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiADVpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:45:36 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072BEC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 13:45:36 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b85so36309418qkc.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 13:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mTj01l7FSB+ykchu330JmH1+pn3QTMc/PlBr70Bf0Q=;
        b=HExKk4k3jBX9BYyknibLQsCtUdIsSIKNnGf2TMuT+RJBeWtkRTFrr/+qoQVP3f53i4
         2el3zW1ohqj9UljcR9vzsn4cwEdzvFnh5zUOX7dQdCmk0jOVKdlaouG0Kuu2xLrL41Ec
         mC7Hg/TRsj2WyC82DDjkSCmcXWQn4p7vmNVwXaeYNBmL9V3yu+XOR6p55vCHNCzgh/00
         zd4wrOzbIIbqjlbfX73KuhK1GqWiyHacSX56t/PMK4G6JHEhg5LzVrAIpj0hmcsFO9S3
         qCkVmR38PoQnKW67GCXSLCSx1ZL98bTRcSqp8cUYzcTNzG1OFTHoDc+7YokVKLKDVnfj
         pV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mTj01l7FSB+ykchu330JmH1+pn3QTMc/PlBr70Bf0Q=;
        b=Xs61X+n9+fSEE28yTAKayuGHdDkT59PRtjI/BKNJ0gr5oN3socv1BloVVHltksQOB1
         bEJTx+iW4+zu4lOQcH7g2AdsPdUtimwnO2v2Te7z30W2KL+4TBIb6Fr6MK+VxjFltQm1
         3bPbiNxi+Fh9oxdHMUO1JRF/3XwvtRLeCSLbc0aslQ1L/RgeOuBuidz2Gk0rSOIFkgX9
         NqQFky3IJbwm4JB5o1LdE7dXmRbsASAKqJB+vYO/12WfAwu8BOJqtDptLIECc6ql4tpu
         ZLY8vR94n0s+9kY054WudardeGyriGlBuz6y1W5ApUHdtMEpBQVF/nU0uM24a2PYeqPA
         luDg==
X-Gm-Message-State: AOAM530Rh6xAnmIlm/fkPCudr2Ob26pFB8wlVKt4berNYUIH8gWLAxF6
        K4A1vtwFkDLknYFRdSJHcGJGOUvYCPfe2Q==
X-Google-Smtp-Source: ABdhPJyp1RbNJwXI4jwgtKbAANSpjQkd74dgbRGGHFa+XAA2fRyiKWDNlPMuSSUYPoYaOHiIdN8wlQ==
X-Received: by 2002:a37:b944:: with SMTP id j65mr36814910qkf.708.1641332734989;
        Tue, 04 Jan 2022 13:45:34 -0800 (PST)
Received: from Johns-MBP.myfiosgateway.com (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id i14sm34352164qko.9.2022.01.04.13.45.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Jan 2022 13:45:34 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>,
        "Tilman Vogel" <tilman.vogel@web.de>,
        "Philippe Blain" <levraiphilippeblain@gmail.com>
Subject: [PATCH 1/1] builtin/pull.c: use config value of autostash
Date:   Tue,  4 Jan 2022 16:45:22 -0500
Message-Id: <20220104214522.10692-2-johncai86@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104214522.10692-1-johncai86@gmail.com>
References: <20220104214522.10692-1-johncai86@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A bug in pull.c causes merge and rebase functions to ignore
rebase.autostash if it is only set in the config.

There are a couple of different scenarios that we need to be mindful of:
1. --autostash passed in through command line
$ git pull --autostash
merge/rebase should get --autostashed passed through

2. --rebase passed in, rebase.autostash set in config
$ git config rebase.autostash true
$ git pull --rebase

merge/rebase should get --autostash from config

3. --no-autostash passed in
$ git pull --no-autostash
--no-autostash should be passed into merge/rebase

4. rebase.autostash set but --rebase not used

$ git config rebase.autostash true
$ git pull
--autostash should not be passed into merge but not rebase

This change adjusts variable names to make it more clear which autostash
setting it is modifying, and ensures --autostash is passed into the
merge/rebase where appropriate.

Reported-by: "Tilman Vogel" <tilman.vogel@web.de>
Co-authored-by: "Philippe Blain" <levraiphilippeblain@gmail.com>
Signed-Off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/pull.c          | 15 ++++++------
 t/t5521-pull-options.sh | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 100cbf9fb8..fb700c2d39 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,7 +86,8 @@ static char *opt_ff;
 static char *opt_verify_signatures;
 static char *opt_verify;
 static int opt_autostash = -1;
-static int config_autostash;
+static int rebase_autostash = 0;
+static int cfg_rebase_autostash;
 static int check_trust_level = 1;
 static struct strvec opt_strategies = STRVEC_INIT;
 static struct strvec opt_strategy_opts = STRVEC_INIT;
@@ -361,7 +362,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 	int status;
 
 	if (!strcmp(var, "rebase.autostash")) {
-		config_autostash = git_config_bool(var, value);
+		cfg_rebase_autostash = git_config_bool(var, value);
 		return 0;
 	} else if (!strcmp(var, "submodule.recurse")) {
 		recurse_submodules = git_config_bool(var, value) ?
@@ -689,7 +690,7 @@ static int run_merge(void)
 		strvec_push(&args, opt_gpg_sign);
 	if (opt_autostash == 0)
 		strvec_push(&args, "--no-autostash");
-	else if (opt_autostash == 1)
+	else if (rebase_autostash == 1 || opt_autostash == 1)
 		strvec_push(&args, "--autostash");
 	if (opt_allow_unrelated_histories > 0)
 		strvec_push(&args, "--allow-unrelated-histories");
@@ -901,7 +902,7 @@ static int run_rebase(const struct object_id *newbase,
 		strvec_push(&args, opt_signoff);
 	if (opt_autostash == 0)
 		strvec_push(&args, "--no-autostash");
-	else if (opt_autostash == 1)
+	else if (rebase_autostash == 1)
 		strvec_push(&args, "--autostash");
 	if (opt_verify_signatures &&
 	    !strcmp(opt_verify_signatures, "--verify-signatures"))
@@ -1038,14 +1039,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		oidclr(&orig_head);
 
 	if (opt_rebase) {
-		int autostash = config_autostash;
+		rebase_autostash = cfg_rebase_autostash;
 		if (opt_autostash != -1)
-			autostash = opt_autostash;
+			rebase_autostash = opt_autostash;
 
 		if (is_null_oid(&orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		if (!autostash)
+		if (!rebase_autostash)
 			require_clean_work_tree(the_repository,
 				N_("pull with rebase"),
 				_("please commit or stash them."), 1, 0);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 66cfcb09c5..28f551db8e 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -251,5 +251,56 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
 	test_commit -C src two &&
 	test_must_fail git -C dst pull --no-ff --no-verify --verify
 '
+test_expect_success 'git pull --rebase --autostash succeeds on ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
+	echo "dirty" >>dst/file &&
+	git -C dst pull --rebase --autostash >actual 2>&1 &&
+	grep -q "Fast-forward" actual &&
+	grep -q "Applied autostash." actual
+'
+
+test_expect_success 'git pull --rebase with rebase.autostash succeeds on ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
+	echo "dirty" >>dst/file &&
+	test_config -C dst rebase.autostash true &&
+	git -C dst pull --rebase  >actual 2>&1 &&
+	grep -q "Fast-forward" actual &&
+	grep -q "Applied autostash." actual
+'
+
+test_expect_success 'git pull --rebase --autostash succeeds on non-ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "src_content" file "src content\ncontent\n" &&
+	test_commit -C dst --append "dst_content" file "dst content" &&
+	echo "dirty" >>dst/file &&
+	git -C dst pull --rebase --autostash >actual 2>&1 &&
+	grep -q "Successfully rebased and updated refs/heads/main." actual &&
+	grep -q "Applied autostash." actual
+'
+
+test_expect_success 'git pull --rebase with rebase.autostash succeeds on non-ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "src_content" file "src content\ncontent\n" &&
+	test_commit -C dst --append "dst_content" file "dst content" &&
+	echo "dirty" >>dst/file &&
+	test_config -C dst rebase.autostash true &&
+	git -C dst pull --rebase >actual 2>&1 &&
+	grep -q "Successfully rebased and updated refs/heads/main." actual &&
+	grep -q "Applied autostash." actual
+'
 
 test_done
-- 
2.34.1

