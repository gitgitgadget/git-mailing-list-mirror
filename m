Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F30C4320A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3770F60E78
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhGWIXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhGWIXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:23:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13654C061760
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:04:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id x14-20020a7bc20e0000b0290249f2904453so3823516wmi.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l17VI/WIx1Z6So/o+FTxuxdsJfL83YHMZtKKcDJNLnY=;
        b=cdLJgzedxlEn7vlKsd7O9sK57/iNpiB41DTJ97vAuvokYPJfUjpqu8A25ivSxUWpDP
         kh1+I55AKERz9VsTrfQsJohliU2n46DlLV8041lg5Mep2NQWh0fne0+VUhwJZLGcbZou
         DGZqmuk7U9tQK017qaEIKWIu2z/yGjf/0e67iGn7y7KnZvuIoq7tCbYr6f/NQQuBNwfT
         X135lJo07nWg/+mDAbpoN8Qrqsn7jShuHUMzp5Vlqvh+Sx955WqK6dzQDhjvYN5bFxhN
         4jOMIK38uml8FRGC18CYnvcFHKXFxbmNbc9KUeJWIxqXP0YPdaHSHvjfXwFugt7WgXvt
         xdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l17VI/WIx1Z6So/o+FTxuxdsJfL83YHMZtKKcDJNLnY=;
        b=ZJCDB/x9FvIc4U5cphKFNvPhTDb4exJdhXCfnfMY2Drnv9yea4t4OYVWPF77ASvgEq
         j5nh1bgGN/b14nj0G5IgoGBQPO+k+DkJDtTHTvpe5WxTEC6i22Lk63HhTJwcaw6KLgiC
         xOPPMl/CMTWd+pFsBmVxDKZHs7kyBvqp0HhYkdXemU0aRU1kY+bt5U913Je9vDVn3uzo
         eeuKSepYfvFmRETdFAVJG3FJbC9E96EyjFFc3kBR0ZYJ7NVt+QIFD+ZPN2vUliyAZr4J
         PCv7FvXs+WJEfdCBp10YLbDAGsljkmhqFCG3C/7hMEBF7rXSK10GaX/75y3Fp5ppKa1e
         v2Fg==
X-Gm-Message-State: AOAM532rvGHZbwIPa6UJ05u356TtRZgGbWaB996VAnmHjdBSoji+ore/
        hv+P+FAnn0IdIyGY0f4Ef/TfkrNoOqE=
X-Google-Smtp-Source: ABdhPJy0R6WY0he6Oguo68IYgJNUHVNBBzY+j78BSSOocsU2vJYHM2naYuypuJUC3AidvRkviwYA8w==
X-Received: by 2002:a05:600c:1c86:: with SMTP id k6mr3532012wms.147.1627031048709;
        Fri, 23 Jul 2021 02:04:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19sm18448619wmr.18.2021.07.23.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:04:08 -0700 (PDT)
Message-Id: <71249dfd4e08077c954ae512eccfd98ccf8f9e1c.1627031043.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
        <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 09:04:03 +0000
Subject: [PATCH v2 5/5] [GSOC] ref-filter: add %(rest) atom
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to let "cat-file --batch=%(rest)" use the ref-filter
interface, add %(rest) atom for ref-filter. Introduce the
reject_atom() to reject the atom %(rest) for "git for-each-ref",
"git branch", "git tag" and "git verify-tag".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c             | 25 +++++++++++++++++++++++++
 ref-filter.h             |  5 ++++-
 t/t3203-branch-output.sh |  4 ++++
 t/t6300-for-each-ref.sh  |  4 ++++
 t/t7004-tag.sh           |  4 ++++
 t/t7030-verify-tag.sh    |  4 ++++
 6 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1277ed483a7..c4cfff10822 100644
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
@@ -991,6 +1002,11 @@ static const char *find_next(const char *cp)
 	return NULL;
 }
 
+static int reject_atom(enum atom_type atom_type)
+{
+	return atom_type == ATOM_REST;
+}
+
 /*
  * Make sure the format string is well formed, and parse out
  * the used atoms.
@@ -1011,6 +1027,8 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
+		if (reject_atom(used_atom[at].atom_type))
+			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
 		if ((format->quote_style == QUOTE_PYTHON ||
 		     format->quote_style == QUOTE_SHELL ||
@@ -1930,6 +1948,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
 
@@ -2147,6 +2171,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 
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
index 3d15d0a5360..0d2e062f791 100755
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
