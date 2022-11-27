Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09BC4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 09:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiK0Jhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 04:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK0Jhg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 04:37:36 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E271136
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:34 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b9so9890665ljr.5
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMDU0mhFWpC9bYffKO6uPKev2QDu0cxQKIRbfvee2yE=;
        b=XxyptKjcyQj23I8UZdvTDCS6+MsdM8O2fRriMHHwj+r4cZf6XiRMGj2Nf63CJTlSsL
         5iFWI2pzH7vELDJk7VIz6wegrFraV32Bx9X2/ZNYSiSg42qlr/xnmMo1iaiuawBVqZcD
         +lyHqRBUWpIiaz5qumk9G93vQyhofgkJYJSzDi/M/5XgFTIbYOXn1pttQ9r1rMJ0je+/
         jtJ2mT8O6TcrAv9VlLvPU9Xa2jFkNTN16n3NWmPEK2WlM4wYCtXaJBsZ1b1J/zhCiHHX
         YIwUhnzTtej6MZJUa7gU5LJvHYPzzcncEB2UAcy0vTY8Cn//ACJLs9toBspi8aa5feky
         9ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMDU0mhFWpC9bYffKO6uPKev2QDu0cxQKIRbfvee2yE=;
        b=OZRipKq3tduPGKoBzYjvezNFN0MsbUkt7a1AjW6xlK1+GvSIjKFKwC56D+ZpG2aUYi
         uJAJ2FzVCuOKfdeh/0WqhrkrWHQfz2O8r0JW8oKBuJiSsz8qqiZ+Z012Te9GHbIiPPEg
         UyTkd9bOP3zAEDsdWdlBCkNnM3cC1oeqUDCsdRzlGh58F2Fa4OZgpBG32vpaZUJGU6bA
         9h5uIuVPo1Y6dOmdNIH/n1LynjK3r76+f37gUE266cYiRedOkniEK+9icV/0WJ0gS7z7
         4Q14Hf7ZtLzSARasHVcLpUvgTpaz3jI7GuDNAJ/USlQuj43+plJzwtZXRM05lkcHunPL
         /wHA==
X-Gm-Message-State: ANoB5pn/mHCYBjKSiTLIuDC/VzEbUR36rwF3C2fW3hSdYxaXk5tEvqIQ
        5RCK93e9qmf0q4XWC8GGdd4=
X-Google-Smtp-Source: AA0mqf6Innphr5V8vaJoJRMc2380WKRSt9Y84pm+ztRgZBqEH8zBcbOSssUYh9lxrs1sTwzAQZ7dwg==
X-Received: by 2002:a2e:be87:0:b0:277:f0f:927e with SMTP id a7-20020a2ebe87000000b002770f0f927emr15747654ljr.138.1669541852466;
        Sun, 27 Nov 2022 01:37:32 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bd3-20020a05651c168300b002770a48fd12sm835615ljb.102.2022.11.27.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 01:37:31 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 2/5] diff-merges: implement log.diffMerges-m-imply-p config
Date:   Sun, 27 Nov 2022 12:37:18 +0300
Message-Id: <20221127093721.31012-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221127093721.31012-1-sorganov@gmail.com>
References: <20221127093721.31012-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Historically, `-m` doesn't imply `-p` whereas similar `-c` and `--cc`
options do. Simply fixing this inconsistency by unconditional
modification of `-m` semantics appeared to be a bad idea, as it broke
some legacy scripts.

Implement "log.diffMerges-m-imply-p" boolean configuration variable
that allows user to enable implication of `-p` by `-m`.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/config/log.txt   | 3 +++
 Documentation/diff-options.txt | 6 ++++--
 builtin/log.c                  | 2 ++
 diff-merges.c                  | 8 ++++++++
 diff-merges.h                  | 2 ++
 t/t4013-diff-various.sh        | 9 +++++++++
 t/t9902-completion.sh          | 3 +++
 7 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 9c6be643bcf6..265a57312e58 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -40,6 +40,9 @@ diffs for merge commits when `-p` option is not used.
 log.diffMergesHide::
 	`true` implies `--diff-merges=hide` option.
 
+log.diffMerges-m-imply-p::
+	`true` enables implication of `-p` by `-m`.
+
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 351d51215717..e64066af8d96 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -48,12 +48,14 @@ ifdef::git-log[]
 --diff-merges=on:::
 --diff-merges=m:::
 -m:::
-	This option makes diff output for merge commits to be shown in
+	These options make diff output for merge commits to be shown in
 	the default format. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
 	is `separate`.
 +
-	`-m` is a shortcut for '--diff-merges=on --diff-merges=hide'
+	`-m` is a shortcut for '--diff-merges=on --diff-merges=hide'.
+	In addition it implies `-p` when `log.diffMerges-m-imply-p` is
+	active.
 +
 --diff-merges=first-parent:::
 --diff-merges=1:::
diff --git a/builtin/log.c b/builtin/log.c
index e031021e53b2..332b5e478cc5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -583,6 +583,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return diff_merges_config(value);
 	if (!strcmp(var, "log.diffmergeshide"))
 		return diff_merges_hide_config(git_config_bool(var, value));
+	if (!strcmp(var, "log.diffmerges-m-imply-p"))
+		return diff_merges_m_imply_p_config(git_config_bool(var, value));
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
diff --git a/diff-merges.c b/diff-merges.c
index 55fe5b70c102..1fbf476d378e 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -8,6 +8,7 @@ static void set_separate(struct rev_info *revs);
 static diff_merges_setup_func_t set_to_default = set_separate;
 static int suppress_m_parsing;
 static int hide = 0;
+static int m_imply_p = 0;
 
 static void suppress(struct rev_info *revs)
 {
@@ -143,6 +144,12 @@ int diff_merges_hide_config(int on)
 	return 0;
 }
 
+int diff_merges_m_imply_p_config(int on)
+{
+	m_imply_p = on;
+	return 0;
+}
+
 void diff_merges_suppress_m_parsing(void)
 {
 	suppress_m_parsing = 1;
@@ -157,6 +164,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
 		set_hide(revs);
+		revs->merges_imply_patch = m_imply_p;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
diff --git a/diff-merges.h b/diff-merges.h
index e86e5381693b..9f0b3901fe82 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -13,6 +13,8 @@ int diff_merges_config(const char *value);
 
 int diff_merges_hide_config(int hide);
 
+int diff_merges_m_imply_p_config(int on);
+
 void diff_merges_suppress_m_parsing(void);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 4fc8ba2fc59c..1789dd6063c5 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -548,6 +548,15 @@ test_expect_success 'git config log.diffMerges hide: has no effect on --cc' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git config log.diffMerges-m-imply-p has proper effect' '
+	git log -m -p master >result &&
+	process_diffs result >expected &&
+	test_config log.diffMerges-m-imply-p true &&
+	git log -m master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 # -m in "git diff-index" means "match missing", that differs
 # from its meaning in "git diff". Let's check it in diff-index.
 # The line in the output for removed file should disappear when
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index fc6b0722216a..26a7e4ff877c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2498,6 +2498,7 @@ test_expect_success 'git config - variable name' '
 	log.decorate Z
 	log.diffMerges Z
 	log.diffMergesHide Z
+	log.diffMerges-m-imply-p Z
 	EOF
 '
 
@@ -2527,6 +2528,7 @@ test_expect_success 'git -c - variable name' '
 	log.decorate=Z
 	log.diffMerges=Z
 	log.diffMergesHide=Z
+	log.diffMerges-m-imply-p=Z
 	EOF
 '
 
@@ -2550,6 +2552,7 @@ test_expect_success 'git clone --config= - variable name' '
 	log.decorate=Z
 	log.diffMerges=Z
 	log.diffMergesHide=Z
+	log.diffMerges-m-imply-p=Z
 	EOF
 '
 
-- 
2.37.3.526.g5f84746cb16b

