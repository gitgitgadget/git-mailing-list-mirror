Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0467C07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D8BD610FA
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGLLt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhGLLtz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D73C0613E9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l4-20020a05600c4f04b0290220f8455631so3687110wmq.1
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pq8IYJEyiWeBl0MKFag6xI7dzV+BVgtdzOmHeff1v6M=;
        b=UR+d6wyAlAVvxXi9GIJZLt4T96FeTPxR4oCdSoKzOL3nDcN81SRQx/GHtePetod7Jk
         J81BCGYfM6+oCoYaMPjw3NQu+a/Iylfe2osMHwPrBU0DHfhhpC1lFRcsK9MBqHo1Y/Rs
         kS01gPLZ0GAIOHzGLsyp7M8S1lwU+iMEFMjLkvS6o1mJuXqGSgggJ1HiAiRrMJptvFMN
         9u6CXvaK3TXVObmc5jz5YOAue0uS3Oa5a3vRCVP3/nBBVVmDdCz01tN8d5WS6NMhYsCq
         V7Aedkd7L04b6Dtf6xC79/btkFHIyWKDqXDbgDr7diTmrS3VlgsYs9PzIdPD8+93Cz4N
         xncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pq8IYJEyiWeBl0MKFag6xI7dzV+BVgtdzOmHeff1v6M=;
        b=lYy8vl6/jrZnpOgQ7PHZCZcChaitVFUAu6qvIX+bGLPXCgoSN36ui3ro806eaoG3kB
         oMfgMTBayh/tlAToPQDugCW/zTQYyhvCVMeCqUt7QpO8WseotS537nvLVl/nCCME4hFi
         +ADOQPQ+9KieU6AFkKBrJweQNejHGnRpeiPfC5y9E3ZbuKC70QMKi3/IdVDKa8xNK9aH
         s6hOBhw/hCEg4WUHADGRPCdgXyjjArkFJhnGjI1PtCho+/Hcu3u7Y2ohTXmGCZOZIA6n
         xdOyx/hFesjr5DFNCh72DXgD1yYCkjKVxkT78kg/TlAL7yA7y4Rm/ZXYlMOm/MZINYgS
         wj/w==
X-Gm-Message-State: AOAM533kA/JnqxoISPVFsZVOW3EM7vS5tcmf//s46wbzJJdVe9zWQbA+
        e8LmlXYtt6OqR3XW54DwNfd7IGbcdsA=
X-Google-Smtp-Source: ABdhPJx7Jaaw7T5CQZEnC8QEcUlZXS9lw8zLzGwm5yFYWUPU0BJYZQq8QKjapau4w8IfarsxCwOoZQ==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr18554944wmj.148.1626090424852;
        Mon, 12 Jul 2021 04:47:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d24sm19694483wmb.42.2021.07.12.04.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:04 -0700 (PDT)
Message-Id: <460c807c6ab9010ae166fe77e54d5435960f8e37.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:47 +0000
Subject: [PATCH 07/19] [GSOC] ref-filter: add %(rest) atom
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
        ZheNing Hu <adlternative@gmail.com>,
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
index c8e561a3687..ee6c906f22d 100644
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
@@ -1928,6 +1942,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
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
 
@@ -2145,6 +2165,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 
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

