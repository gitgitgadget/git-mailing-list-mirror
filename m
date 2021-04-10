Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F93DC43470
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE30B611ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDJRRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 13:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhDJRRi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 13:17:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82FBC06138A
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o16so10179363ljp.3
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ephUlwupFbjFTnzN2zWNMpIJf4tmj4WtTZn1Ml1+zF8=;
        b=jYNQJzeOSISuPugeMBiFhY7kifR8Ii+NUKeVDnwDn9fCTcKapsvNKIZZe7bgGBZrv6
         RLa0PCf6JatUD8QvGcIPF7noXVR4++n+enfsAksBu1MBZoZjVYfC/S/ajDzsvVw8uIb2
         9b5iBYTogOUOx+lVFFq/IrfavVOJy97N+m5M0RglKg45Du4qkx/HR3JYE6UXztUTq2ew
         fJiFV4YrywkPyq3uimsldqRyjnsLztAIWb/AT8ImR5Jc1n9De429qWZocVirN8V5ha7z
         5wkdbSSvRBJmwtgtAAqZ4uH+zK4WcsBb5JNOHzRQDAghochWXtQSdwBYBzAt53vIJiyE
         yW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ephUlwupFbjFTnzN2zWNMpIJf4tmj4WtTZn1Ml1+zF8=;
        b=X9zFORjjq9XAB5lNxvuVXWwxWs9qenhskFmy8RRwfDujX+kz+OzpHm1/9JOlRj/Bf8
         pHsYNafH1Wn4YChdcpcnZL7xr6tlDvqdMk3ylMnDfl86Zv4ecvfJ2a4jIkg14rP0xhFR
         SmRiuMPHHAHmbfhh6J02yjQq8Htjzsu6TUkLVvH9kd/7KDmIkMIjJODsBXeSBjVfRFKE
         njNjZlcaUF0sjbdgpOoQhSRLVgKyk3yGfFadix+RvQqoAhWSbA+DL18SMJ/r0cKCymc2
         B+nrguiDfbN88ZxLGe2oGioAz/NjNnKR6QBKEiBeyPULe0T/jm43YMJJyUcjzCam9u99
         ShBQ==
X-Gm-Message-State: AOAM533QkuYtvWJKhRNcErVPRHqUqTl/wu2bamC8S9rASSWOh69I9NhL
        FCm73bk1gkId681pO7NFXV8=
X-Google-Smtp-Source: ABdhPJzljpHs99O9fKGXTmo6du4Hlp0BhVQ442ALk5J5BoUtiME3u5w7UVqH712iXNOMp/ug+xCWaQ==
X-Received: by 2002:a2e:b4cc:: with SMTP id r12mr12644736ljm.247.1618075041437;
        Sat, 10 Apr 2021 10:17:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z7sm1336543ljo.64.2021.04.10.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:17:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 4/5] diff-merges: introduce log.diffMerges config variable
Date:   Sat, 10 Apr 2021 20:16:56 +0300
Message-Id: <20210410171657.20159-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210410171657.20159-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210410171657.20159-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New log.diffMerges configuration variable sets the format that
--diff-merges=default will be using. The default is "separate".

t4013: add the following tests for log.diffMerges config:

* Test that wrong values are denied.

* Test that the value of log.diffMerges properly affects both
--diff-merges=default and -m.

t9902: fix completion tests for log.d* to match log.diffMerges.

Added documentation for log.diffMerges.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/config/log.txt |  5 +++++
 builtin/log.c                |  2 ++
 diff-merges.c                | 11 +++++++++++
 diff-merges.h                |  2 ++
 t/t4013-diff-various.sh      | 23 +++++++++++++++++++++++
 t/t9902-completion.sh        |  3 +++
 6 files changed, 46 insertions(+)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 208d5fdcaa68..456eb07800cb 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -24,6 +24,11 @@ log.excludeDecoration::
 	the config option can be overridden by the `--decorate-refs`
 	option.
 
+log.diffMerges::
+	Set default diff format to be used for merge commits. See
+	`--diff-merges` in linkgit:git-log[1] for details.
+	Defaults to `separate`.
+
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
diff --git a/builtin/log.c b/builtin/log.c
index 8acd285dafd8..6102893fccb9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -481,6 +481,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 			decoration_style = 0; /* maybe warn? */
 		return 0;
 	}
+	if (!strcmp(var, "log.diffmerges"))
+		return diff_merges_config(value);
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
diff --git a/diff-merges.c b/diff-merges.c
index a02f39828336..75630fb8e6b8 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -90,6 +90,17 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
  * Public functions. They are in the order they are called.
  */
 
+int diff_merges_config(const char *value)
+{
+	diff_merges_setup_func_t func = func_by_opt(value);
+
+	if (!func)
+		return -1;
+
+	set_to_default = func;
+	return 0;
+}
+
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 {
 	int argcount = 1;
diff --git a/diff-merges.h b/diff-merges.h
index 659467c99a4f..09d9a6c9a4fb 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -9,6 +9,8 @@
 
 struct rev_info;
 
+int diff_merges_config(const char *value);
+
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
 void diff_merges_suppress(struct rev_info *revs);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8acb5b866900..87cab7867135 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -460,6 +460,29 @@ test_expect_success 'log --diff-merges=default matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
+test_expect_success 'deny wrong log.diffMerges config' '
+	test_config log.diffMerges wrong-value &&
+	test_expect_code 128 git log
+'
+
+test_expect_success 'git config log.diffMerges first-parent' '
+	git log -p --diff-merges=first-parent master >result &&
+	process_diffs result >expected &&
+	test_config log.diffMerges first-parent &&
+	git log -p --diff-merges=default master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git config log.diffMerges first-parent vs -m' '
+	git log -p --diff-merges=first-parent master >result &&
+	process_diffs result >expected &&
+	test_config log.diffMerges first-parent &&
+	git log -p -m master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 04ce884ef5ac..4d732d6d4f81 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
 	test_completion "git config log.d" <<-\EOF
 	log.date Z
 	log.decorate Z
+	log.diffMerges Z
 	EOF
 '
 
@@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
 	test_completion "git -c log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
+	log.diffMerges=Z
 	EOF
 '
 
@@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config= - variable name' '
 	test_completion "git clone --config=log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
+	log.diffMerges=Z
 	EOF
 '
 
-- 
2.25.1

