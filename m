Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59974C352A1
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 09:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK0Jhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 04:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiK0Jhi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 04:37:38 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5445595B7
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bp15so13085003lfb.13
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wEZkkHdatuTxvzbDqh8EP4XGFfpsIgKyB6MbLC2OJY=;
        b=kGvsiPOBMOHqDT3SXjeRoXkgY/sXoP96br1Kk7m3jkECihtAoYJ95m32je+uRwn8z3
         mYxVZvD4/pz3iBcwgyp5t22YdLv77W3GneMImB21gb/gHfKjcjC5+XWFaHFr2nuspuwL
         dWcJTdogvkesvijJGE18MEgO++TTocordLazCTBUa+0yebekP+KA1KEdUJdYkDFlBfDj
         cho8JD6AQv4iEjOdpjBJ3DJtRYXQTYbymgLmj0lpBuLCcjtIoukisXKk1qzUfuOEdPcA
         gdMAPj8TiybS/XwB8ymcGYt1l5wq0eqq7e/tduRVUX76raGdAR4/C10WfwFuqGqnTd2R
         sEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wEZkkHdatuTxvzbDqh8EP4XGFfpsIgKyB6MbLC2OJY=;
        b=Yo1p1PtKFDLPALHZIwiFR2O8lrltEMi53Yd09IE/XOjJCc1nKO/iWSrtUXyHqUMrWs
         1PIajujcNHWONPJbcczPX8hqgR9IkcThBrftxLb3EvTT2Q8R211aa2OeezpSYYQ4NaVV
         e1AJ8MtJuEVh+xg3UQbAc5HVJ9SXXI0U0uNsY5e/7VwgYuTcFSZpIYdJxKbuC2UNEdFJ
         AvxYOECwy8ogn6DPNdrFhgknPoKAPTENQdDpOKwYCSlh3nxJJ0BbICLQ04DQe2EKTCP2
         39E3M1GynY62fp1uh5ZW4lh/61ARpT0T37F2ulv0WaySdXDi46B1eLzd0jVCgcjeajov
         uHoQ==
X-Gm-Message-State: ANoB5pnYOmnzlDKwO67LTBpX75Fi75McSzAs4yttRx8frQ8/n+uI2aq6
        0/IOr1hkvDnWCva6rk5whIM=
X-Google-Smtp-Source: AA0mqf5tLgjj4YKyPiyapgo0ADpMdMQ2/GbwjjoSarcf2trHnSrkYKX9ziyIbyU6d9RLhnUg+aXJpw==
X-Received: by 2002:a05:6512:606:b0:4b1:2aab:7cbf with SMTP id b6-20020a056512060600b004b12aab7cbfmr12338561lfe.499.1669541853482;
        Sun, 27 Nov 2022 01:37:33 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bd3-20020a05651c168300b002770a48fd12sm835615ljb.102.2022.11.27.01.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 01:37:32 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
Date:   Sun, 27 Nov 2022 12:37:19 +0300
Message-Id: <20221127093721.31012-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221127093721.31012-1-sorganov@gmail.com>
References: <20221127093721.31012-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Force specified log format for -c, --cc, and --remerge-diff options
instead of their respective formats. The override is useful when some
external tool hard-codes diff for merges format option.

Using any of the above options twice or more will get back the
original meaning of the option no matter what configuration says.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/config/log.txt | 11 +++++++++++
 builtin/log.c                |  2 ++
 diff-merges.c                | 32 ++++++++++++++++++++++++++------
 diff-merges.h                |  2 ++
 t/t4013-diff-various.sh      | 18 ++++++++++++++++++
 t/t9902-completion.sh        |  3 +++
 6 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 265a57312e58..7452c7fad638 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -43,6 +43,17 @@ log.diffMergesHide::
 log.diffMerges-m-imply-p::
 	`true` enables implication of `-p` by `-m`.
 
+log.diffMergesForce::
+	Use specified log format for -c, --cc, and --remerge-diff
+	options instead of their respective formats when the option
+	appears on the command line one time. See `--diff-merges` in
+	linkgit:git-log[1] for allowed values. Using 'off' or 'none'
+	disables the override (default).
++
+The override is useful when external tool hard-codes one of the above
+options. Using any of these options two (or more) times will get back
+the original meaning of the options.
+
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
diff --git a/builtin/log.c b/builtin/log.c
index 332b5e478cc5..1e8d0a2545a9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -585,6 +585,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return diff_merges_hide_config(git_config_bool(var, value));
 	if (!strcmp(var, "log.diffmerges-m-imply-p"))
 		return diff_merges_m_imply_p_config(git_config_bool(var, value));
+	if (!strcmp(var, "log.diffmergesforce"))
+		return diff_merges_force_config(value);
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
diff --git a/diff-merges.c b/diff-merges.c
index 1fbf476d378e..cedd7652bf42 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -6,6 +6,7 @@ typedef void (*diff_merges_setup_func_t)(struct rev_info *);
 static void set_separate(struct rev_info *revs);
 
 static diff_merges_setup_func_t set_to_default = set_separate;
+static diff_merges_setup_func_t force_func = NULL;
 static int suppress_m_parsing;
 static int hide = 0;
 static int m_imply_p = 0;
@@ -150,6 +151,21 @@ int diff_merges_m_imply_p_config(int on)
 	return 0;
 }
 
+int diff_merges_force_config(const char *value)
+{
+	diff_merges_setup_func_t func = func_by_opt(value);
+
+	if (!func)
+		return -1;
+
+	if (func == set_none)
+		force_func = NULL;
+	else if (func != set_hide && func != set_no_hide)
+		force_func = func;
+
+	return 0;
+}
+
 void diff_merges_suppress_m_parsing(void)
 {
 	suppress_m_parsing = 1;
@@ -160,20 +176,18 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	int argcount = 1;
 	const char *optarg;
 	const char *arg = argv[0];
+	diff_merges_setup_func_t set_func = NULL;
 
 	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
 		set_hide(revs);
 		revs->merges_imply_patch = m_imply_p;
 	} else if (!strcmp(arg, "-c")) {
-		set_combined(revs);
-		revs->merges_imply_patch = 1;
+		set_func = set_combined;
 	} else if (!strcmp(arg, "--cc")) {
-		set_dense_combined(revs);
-		revs->merges_imply_patch = 1;
+		set_func = set_dense_combined;
 	} else if (!strcmp(arg, "--remerge-diff")) {
-		set_remerge_diff(revs);
-		revs->merges_imply_patch = 1;
+		set_func = set_remerge_diff;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		set_none(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
@@ -183,6 +197,12 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	} else
 		return 0;
 
+	if (set_func != NULL) {
+		(force_func ? force_func : set_func)(revs);
+		force_func = NULL;
+		revs->merges_imply_patch = 1;
+	}
+
 	revs->explicit_diff_merges = 1;
 	return argcount;
 }
diff --git a/diff-merges.h b/diff-merges.h
index 9f0b3901fe82..6ef0cc87bb2a 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -15,6 +15,8 @@ int diff_merges_hide_config(int hide);
 
 int diff_merges_m_imply_p_config(int on);
 
+int diff_merges_force_config(const char *value);
+
 void diff_merges_suppress_m_parsing(void);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 1789dd6063c5..8a90d2dac360 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -557,6 +557,24 @@ test_expect_success 'git config log.diffMerges-m-imply-p has proper effect' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git config log.diffMergesForce has proper effect' '
+	git log -m -p master >result &&
+	process_diffs result >expected &&
+	test_config log.diffMergesForce on &&
+	git log --cc master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git config log.diffMergesForce override by duplicate' '
+	git log --cc master >result &&
+	process_diffs result >expected &&
+	test_config log.diffMergesForce on &&
+	git log --cc --cc master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 # -m in "git diff-index" means "match missing", that differs
 # from its meaning in "git diff". Let's check it in diff-index.
 # The line in the output for removed file should disappear when
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 26a7e4ff877c..411e08b2fa1b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2498,6 +2498,7 @@ test_expect_success 'git config - variable name' '
 	log.decorate Z
 	log.diffMerges Z
 	log.diffMergesHide Z
+	log.diffMergesForce Z
 	log.diffMerges-m-imply-p Z
 	EOF
 '
@@ -2528,6 +2529,7 @@ test_expect_success 'git -c - variable name' '
 	log.decorate=Z
 	log.diffMerges=Z
 	log.diffMergesHide=Z
+	log.diffMergesForce=Z
 	log.diffMerges-m-imply-p=Z
 	EOF
 '
@@ -2552,6 +2554,7 @@ test_expect_success 'git clone --config= - variable name' '
 	log.decorate=Z
 	log.diffMerges=Z
 	log.diffMergesHide=Z
+	log.diffMergesForce=Z
 	log.diffMerges-m-imply-p=Z
 	EOF
 '
-- 
2.37.3.526.g5f84746cb16b

