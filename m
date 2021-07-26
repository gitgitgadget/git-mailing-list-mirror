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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906BC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A81960560
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhGZCqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 22:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhGZCq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 22:46:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD57BC061760
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q3so9426172wrx.0
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dGjWUIHlbOJMmLRajoVhj5GWeDVM5yXhaHhMUOsKZPY=;
        b=YXw1oE3HjIV53xS8zzm7IFHyCzffRKcgvg6WcC4JDlMjzixnXbnJHiSyaKVhbhO7Il
         2ZsILjgTv53nPjKcTjVdbmjVQa6MPy0LAbcNapAWeIZyjwutpsSynljoLSs2fimy49Oi
         L8AlgO1Wz60kWF9c3HWxSj56IY+P2+LK7tGTnHKTiEi53Mi7i15+HmPXnA27yxYqkg4V
         nF+wUFk/aSZaSxn4TH8gkayGZGyhEyoadR2HD1yJe43reZTEyQeX8gQPQXRp7SLrRNGK
         0+tF/64LRnKnOCvPfNrrApqwQ73402jXPsRvdHSyHdIWbL/Xr2z3wD+STHq+jtOJKzyw
         92wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dGjWUIHlbOJMmLRajoVhj5GWeDVM5yXhaHhMUOsKZPY=;
        b=C6W6kDjSYH2FvFVCzmbs3UF4J93kDEgWs2/4rtcO4GsJNLIFmvEz5yJZw+8ub7rucT
         P70eSDxnjlTQ3TovsWFd3g6rExoANcSqfp/XG8hTB0zjQSlD9iFhNVvLQWyIjB9I4NdW
         6+3/Iuq2/EygzPk86uy1EaoVI29xxhlYkWFMUc91IdS7hiCVz07Js1JYWs/hi6MVoejr
         kuW2xdq3jkBNuPLdx176FR0tL+ybxEMxmBrzpI/yQbU6L2+ySPdMZLhSrFZnBtUpx0ky
         qux6lLusUMoywQ07pdCaG82b4wh1qd6wYOXSyisUpbWY2JnmFmTBbn0iYGJu2h7t/3E4
         4NgA==
X-Gm-Message-State: AOAM530Od/nNvDErL1PZJGZzoZV+1PCmdnx0k1e6KoJsIFHJ9wBgIwMg
        6kHSuClKR0u/JPEVHO4ixS40eH5SwSw=
X-Google-Smtp-Source: ABdhPJyZ8ovVr4hGcnQ0E7niC8sDblzyQnoXerurmcxPU5JgvgEhqt/D4ZxH9WmXcS905VPjkiMfDQ==
X-Received: by 2002:a05:6000:1b0c:: with SMTP id f12mr16773804wrz.225.1627270015446;
        Sun, 25 Jul 2021 20:26:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm40567697wrt.55.2021.07.25.20.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 20:26:55 -0700 (PDT)
Message-Id: <207cc5129649e767036d8467ea7c884c3f664cc7.1627270010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
References: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
        <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 03:26:50 +0000
Subject: [PATCH v4 5/5] [GSOC] ref-filter: add %(rest) atom
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
        Jacob Keller <jacob.keller@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

%(rest) is a atom used for cat-file batch mode, which can split
the input lines at the first whitespace boundary, all characters
before that whitespace are considered to be the object name;
characters after that first run of whitespace (i.e., the "rest"
of the line) are output in place of the %(rest) atom.

In order to let "cat-file --batch=%(rest)" use the ref-filter
interface, add %(rest) atom for ref-filter.

Introduce the reject_atom() to reject the atom %(rest) for
"git for-each-ref", "git branch", "git tag" and "git verify-tag".

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
Suggected-by: Jacob Keller <jacob.keller@gmail.com>
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
index f944160c5ce..2cacee9e64a 100644
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
@@ -992,6 +1003,11 @@ static const char *find_next(const char *cp)
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
@@ -1012,6 +1028,8 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
+		if (reject_atom(used_atom[at].atom_type))
+			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
 		if ((format->quote_style == QUOTE_PYTHON ||
 		     format->quote_style == QUOTE_SHELL ||
@@ -1931,6 +1949,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
 
@@ -2148,6 +2172,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 
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
