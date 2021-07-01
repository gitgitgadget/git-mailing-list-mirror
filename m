Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72824C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B9561414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhGAQKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhGAQKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C17C061764
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g7so8903518wri.7
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QFBlWXIncwttHrgd04N7RqxYe8ew5peYTqRIybnr11g=;
        b=CGMvfaZCV+c693LxPfWOV59T38bUoKMbuIuuzM0jHkqYN7cgiyxL+EXa/UCT+77jeI
         47UVpJq1QajRM0NClfSA1JcnGApUf6sq16bQm6lhG4CfqtuqvOJFCteJOmG742c0uSGd
         5UIZ//zSfpygiur5zl5skZrCHnxcdbMf2R1GZhtFeMImvJ04I0OXm9Gqc94oKdJq1cja
         pcLouotAJRcL7qkd5QoIgBtDkbLbgcqy3FU8IfLia7mzkR+mjYb5AD9n3bGX6axQQR9o
         4hrPk5g0jpIcoTc8mxPIhSQayJcFL90WEcz7ZC5NXLhNrX+7UqoMSpayktILSSR8ZkLN
         /jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QFBlWXIncwttHrgd04N7RqxYe8ew5peYTqRIybnr11g=;
        b=ooUFpj/vUxPkqldDaUitx2WtiT3Tgiqh+IUWbOb3qK4eSnDJLxHHjFPUpj7V9gw2Vv
         37uwExOPX/cUupKNh0GuIvCE8KcKZtCXqXn7WZwraAtCHjgL7VqQWTk40hSvS9Ry12/I
         z85+WQkmKSCRhNnXfZapTnc5nIiCwPgc3uCzv9niMzCRiIHgmcmxK8hQhDW2RwRuYPxI
         wEyVU7XuL78xOjeBQ1ceGsimDPtM4jQmxzTtHWtwALqXcCu+oXVRrA86X+LauPz8wFkX
         4JLqhM89eExZODiuNSOraVgk+ooHk1MN4wwn4TFyqKvmx0AXKHC0UMP6By8NOdYXb4BQ
         OxIg==
X-Gm-Message-State: AOAM532gYFTZ6UMAGwCwQ2AMeB9W9fxo3QzI8tP+i6qMhhrZTXCgGRzb
        pvv3lexhNwMYcoldlGNQrfFaZ+RPswQ=
X-Google-Smtp-Source: ABdhPJw6EczlonGx2J2wP6NcWvAlpo3VFCroeUXPwcnu6bUpLJmHYsBYBgQ/1dOdGekRAR+xkbmntQ==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr483753wrw.247.1625155697859;
        Thu, 01 Jul 2021 09:08:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5sm390336wrn.38.2021.07.01.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:17 -0700 (PDT)
Message-Id: <82ffe602759f1819060b655e0f5488a74f16aaf7.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:03 +0000
Subject: [PATCH 05/15] [GSOC] ref-filter: add %(rest) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to let "cat-file --batch=%(rest)" use the ref-filter
interface, add %(rest) atom for ref-filter. "git for-each-ref",
"git branch", "git tag" and "git verify-tag" will reject %(rest)
by default.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c             | 21 +++++++++++++++++++++
 ref-filter.h             |  5 ++++-
 t/t3203-branch-output.sh |  4 ++++
 t/t6300-for-each-ref.sh  |  4 ++++
 t/t7004-tag.sh           |  4 ++++
 t/t7030-verify-tag.sh    |  4 ++++
 6 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index d01a0266fb8..10c78de9cfa 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -157,6 +157,7 @@ enum atom_type {
 	ATOM_IF,
 	ATOM_THEN,
 	ATOM_ELSE,
+	ATOM_REST,
 };
 
 /*
@@ -559,6 +560,15 @@ static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
+static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
+			    const char *arg, struct strbuf *err)
+{
+	if (arg)
+		return strbuf_addf_ret(err, -1, _("%%(rest) does not take arguments"));
+	format->use_rest = 1;
+	return 0;
+}
+
 static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *unused_err)
 {
@@ -615,6 +625,7 @@ static struct {
 	[ATOM_IF] = { "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
 	[ATOM_THEN] = { "then", SOURCE_NONE },
 	[ATOM_ELSE] = { "else", SOURCE_NONE },
+	[ATOM_REST] = { "rest", SOURCE_NONE, FIELD_STR, rest_atom_parser },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -1010,6 +1021,9 @@ int verify_ref_format(struct ref_format *format)
 		if (at < 0)
 			die("%s", err.buf);
 
+		if (used_atom[at].atom_type == ATOM_REST)
+			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
+
 		if ((format->quote_style == QUOTE_PYTHON ||
 		     format->quote_style == QUOTE_SHELL ||
 		     format->quote_style == QUOTE_TCL) &&
@@ -1927,6 +1941,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			v->handler = else_atom_handler;
 			v->s = xstrdup("");
 			continue;
+		} else if (atom_type == ATOM_REST) {
+			if (ref->rest)
+				v->s = xstrdup(ref->rest);
+			else
+				v->s = xstrdup("");
+			continue;
 		} else
 			continue;
 
@@ -2144,6 +2164,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
+	ref->rest = NULL;
 
 	return ref;
 }
diff --git a/ref-filter.h b/ref-filter.h
index 74fb423fc89..c15dee8d6b9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -38,6 +38,7 @@ struct ref_sorting {
 
 struct ref_array_item {
 	struct object_id objectname;
+	const char *rest;
 	int flag;
 	unsigned int kind;
 	const char *symref;
@@ -76,14 +77,16 @@ struct ref_format {
 	 * verify_ref_format() afterwards to finalize.
 	 */
 	const char *format;
+	const char *rest;
 	int quote_style;
+	int use_rest;
 	int use_color;
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 };
 
-#define REF_FORMAT_INIT { NULL, 0, -1 }
+#define REF_FORMAT_INIT { .use_color = -1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 5325b9f67a0..6e94c6db7b5 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -340,6 +340,10 @@ test_expect_success 'git branch --format option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch with --format=%(rest) must fail' '
+	test_must_fail git branch --format="%(rest)" >actual
+'
+
 test_expect_success 'worktree colors correct' '
 	cat >expect <<-EOF &&
 	* <GREEN>(HEAD detached from fromtag)<RESET>
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0b66e743c58..6ca5c2cc19c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1211,6 +1211,10 @@ test_expect_success 'basic atom: head contents:trailers' '
 	test_cmp expect actual.clean
 '
 
+test_expect_success 'basic atom: rest must fail' '
+	test_must_fail git for-each-ref --format="%(rest)" refs/heads/main
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2f72c5c6883..082be85dffc 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1998,6 +1998,10 @@ test_expect_success '--format should list tags as per format given' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git tag -l with --format="%(rest)" must fail' '
+	test_must_fail git tag -l --format="%(rest)" "v1*"
+'
+
 test_expect_success "set up color tests" '
 	echo "<RED>v1.0<RESET>" >expect.color &&
 	echo "v1.0" >expect.bare &&
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 3cefde9602b..10faa645157 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -194,6 +194,10 @@ test_expect_success GPG 'verifying tag with --format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'verifying tag with --format="%(rest)" must fail' '
+	test_must_fail git verify-tag --format="%(rest)" "fourth-signed"
+'
+
 test_expect_success GPG 'verifying a forged tag with --format should fail silently' '
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
 	test_must_be_empty actual-forged
-- 
gitgitgadget

