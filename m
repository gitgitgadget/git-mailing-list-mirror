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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0240C43460
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7636109D
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbhDMLmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhDMLmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 07:42:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD46C06175F
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c1so10713104ljd.7
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YveX1xA2U6v9kpF3Y6Zyh/fa/bg9xhxKtnohkjSiDtU=;
        b=QWM59or+4gE6qse6g8LExHDMjdu8VdJLoshA9icCfxdNmWyT2tW4s4XnjZk/E71fas
         qkUMrReQXzUBu3yUXt2m1kx5O0YKQ4g0GR0VvJqkcKDcskf8lWmYMm5SR3lVcwAyRQbJ
         mRlmNRJnTlaaa7mtpOZZiGvrdCRcNF1nRSyy86KI+9DGYLVlSsSwGHmBtM3e/D4woGgm
         HDIQC+5vFknCT7NElQ1NVd6uF2eCQ4r12NCSkOqXZlq7P2O4pCSnlqA1HeYoCtuH0NKs
         wIUNr+Rj2ggW+CQBq1lD4KDXdheXaFgq3/NumsDExI+rh5tN2B6uA+mDJaNxT8TVvhys
         /HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YveX1xA2U6v9kpF3Y6Zyh/fa/bg9xhxKtnohkjSiDtU=;
        b=es84ph2s4F8X9wnYxmOyuY4KlkG3bBJ9JsYUUEqlFvT5JvlAtL5C0dWTjLI2d5ovXi
         qQyhK9cZBdGjMltJNRimjugBL4th8Ik2If5eABvkV+lksZOg0nVBN8+PzPG1uPQgS99H
         UpkGkw5G8CueeI+MvWFkbsvsLHoKSGJvOj7VpqmkBDIZ22hN6THs3sISY8rltbt1tOmj
         qWrCV+u2JeJByydBmdR3MYs0o+qa8bRIWGttVGVTVq3gTv5AWS9XAfshL0kNENL0gsXA
         HHcDhmDg6vhzlenJOHSVWvUnNWAbC3QLcCoDzC7cDpQnWh90tJm54Xo14Z4erVu4k9vH
         K+lw==
X-Gm-Message-State: AOAM530wnCQYaFxukJl2lrC+lxEo2LmO98yy+fj8yqZ3nAO9v9YFMfsu
        t3eroqGai6gyvQRRbEYK47M=
X-Google-Smtp-Source: ABdhPJx7XKbAlcatywHUadQu10vvCwSI+niaAjp9ZBJRBfB1a5pqq69JvstAmW/M8aVEEAbeom3sPg==
X-Received: by 2002:a05:651c:489:: with SMTP id s9mr17761731ljc.62.1618314110297;
        Tue, 13 Apr 2021 04:41:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm663339lfi.292.2021.04.13.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:41:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 4/5] diff-merges: introduce log.diffMerges config variable
Date:   Tue, 13 Apr 2021 14:41:17 +0300
Message-Id: <20210413114118.25693-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210413114118.25693-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210413114118.25693-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New log.diffMerges configuration variable sets the format that
--diff-merges=on will be using. The default is "separate".

t4013: add the following tests for log.diffMerges config:

* Test that wrong values are denied.

* Test that the value of log.diffMerges properly affects both
--diff-merges=on and -m.

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
index 9d19225b3ec9..f3a9daed7e05 100644
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
index 26a7b4d19d4d..87def81699bf 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -460,6 +460,29 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
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
+	git log -p --diff-merges=on master >result &&
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

