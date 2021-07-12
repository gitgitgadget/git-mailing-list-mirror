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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F69BC07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F8E610CD
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhGLLuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhGLLty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F86C0613E5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m2so14165468wrq.2
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5lP/QekKLM+IAZt7gPZOgld34VmFhgG0WJwvzYiMv3c=;
        b=fEydNlS73A7/86Q2L+gDsxLxhy3wkEKzbaTYT8lzzFwJu68XsFTQjiueV3pOxp63wy
         T8Ow9eqJACSaUzPo9sn7r3d/bVqliPMQxldsZSYteOVACOByFsD5nq4P1Ac8y44Rzs7m
         dBarx3p6K/uF0DoqaA99p4g/eEVjJdXWl04F0/0c/Tu5Tkug0kIyirIpmPpKpO23B704
         seXwALPVAP8XAln3r3J5OTN6r07K0DYMjvvumV0b0WeXSp7Osi12OoxTc9waB7In1UfZ
         SojgPcpTGwfzMiAW3bGJayQp9SJzRGTNI0Es8yG5YUcm3FuCw5xGrIu0c2PjM/p8JYWD
         G2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5lP/QekKLM+IAZt7gPZOgld34VmFhgG0WJwvzYiMv3c=;
        b=B7f8NMVnq64OFeqrW5hWY2Bw42XuQyfmUrat5Tf1rvWY2NyPX8n7LV8txP6OpTjOfh
         imHzgSkalF/h42Ndvuqn7cInZD2E4sQKJchpvqsQKr4ehPR0vaL2eYF67WDpsEDAqhng
         hnzcjkG54gKexnxwkHI+BXPd+GGmTBLQUUpFqbEPZPiMn6IH+RiwHZkncpwBOO6jWaiv
         AarxN7am3jMexFKFWhHOluwpolFhDnTTQJrfacqKk4xwmf08hyPRokW/kZWmCCsLm0Js
         6YUVOQVTPCQCJyHTb5fLVieBEvsRULpngrlPip8aYMVz2cgHV6GgNqJMQI+J4JLm1WDZ
         xjfA==
X-Gm-Message-State: AOAM530j5PP3O71nzgP1QuRuiUzt1LB3+X29f8b0FrRr8qd9itN+p+ts
        e7pj/RqvV52dQyHxMxl9KOO1yFdHawE=
X-Google-Smtp-Source: ABdhPJwAg2YF1p+kIPdWD17KK/xvuyTIklJSrmQekaihewvHd5FruZIlLadEUZTY1n5S2wYLD8qBRw==
X-Received: by 2002:adf:f04a:: with SMTP id t10mr57238017wro.318.1626090423764;
        Mon, 12 Jul 2021 04:47:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm14441486wre.84.2021.07.12.04.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:03 -0700 (PDT)
Message-Id: <df2cd9e8e614d8eb1eee05ff7307b88211504116.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:45 +0000
Subject: [PATCH 05/19] [GSOC] ref-filter: --format=%(raw) re-support --perl
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Because the perl language can handle binary data correctly,
add the function perl_quote_buf_with_len(), which can specify
the length of the data and prevent the data from being truncated
at '\0' to help `--format="%(raw)"` re-support `--perl`.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++--
 quote.c                            | 17 +++++++++++++++++
 quote.h                            |  1 +
 ref-filter.c                       | 15 +++++++++++----
 t/t6300-for-each-ref.sh            | 19 +++++++++++++++++--
 5 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index cbb6f87d13f..6da899c6296 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -241,8 +241,8 @@ raw:size::
 	The raw data size of the object.
 
 Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
-`--perl` because such language may not support arbitrary binary data in their
-string variable type.
+because such language may not support arbitrary binary data in their string
+variable type.
 
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
diff --git a/quote.c b/quote.c
index 8a3a5e39eb1..26719d21d1e 100644
--- a/quote.c
+++ b/quote.c
@@ -471,6 +471,23 @@ void perl_quote_buf(struct strbuf *sb, const char *src)
 	strbuf_addch(sb, sq);
 }
 
+void perl_quote_buf_with_len(struct strbuf *sb, const char *src, size_t len)
+{
+	const char sq = '\'';
+	const char bq = '\\';
+	const char *c = src;
+	const char *end = src + len;
+
+	strbuf_addch(sb, sq);
+	while (c != end) {
+		if (*c == sq || *c == bq)
+			strbuf_addch(sb, bq);
+		strbuf_addch(sb, *c);
+		c++;
+	}
+	strbuf_addch(sb, sq);
+}
+
 void python_quote_buf(struct strbuf *sb, const char *src)
 {
 	const char sq = '\'';
diff --git a/quote.h b/quote.h
index 768cc6338e2..0fe69e264b0 100644
--- a/quote.h
+++ b/quote.h
@@ -94,6 +94,7 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
 
 /* quoting as a string literal for other languages */
 void perl_quote_buf(struct strbuf *sb, const char *src);
+void perl_quote_buf_with_len(struct strbuf *sb, const char *src, size_t len);
 void python_quote_buf(struct strbuf *sb, const char *src);
 void tcl_quote_buf(struct strbuf *sb, const char *src);
 void basic_regex_quote_buf(struct strbuf *sb, const char *src);
diff --git a/ref-filter.c b/ref-filter.c
index 506fbc3d691..ba9ab35d7ec 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -742,7 +742,10 @@ static void quote_formatting(struct strbuf *s, const char *str, size_t len, int
 		sq_quote_buf(s, str);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(s, str);
+		if (len != ATOM_VALUE_S_SIZE_INIT)
+			perl_quote_buf_with_len(s, str, len);
+		else
+			perl_quote_buf(s, str);
 		break;
 	case QUOTE_PYTHON:
 		python_quote_buf(s, str);
@@ -1006,10 +1009,14 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
-		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
-		    used_atom[at].u.raw_data.option == RAW_BARE)
+
+		if ((format->quote_style == QUOTE_PYTHON ||
+		     format->quote_style == QUOTE_SHELL ||
+		     format->quote_style == QUOTE_TCL) &&
+		     used_atom[at].atom_type == ATOM_RAW &&
+		     used_atom[at].u.raw_data.option == RAW_BARE)
 			die(_("--format=%.*s cannot be used with"
-			      "--python, --shell, --tcl, --perl"), (int)(ep - sp - 2), sp + 2);
+			      "--python, --shell, --tcl"), (int)(ep - sp - 2), sp + 2);
 		cp = ep + 1;
 
 		if (skip_prefix(used_atom[at].name, "color:", &color))
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 18554f62d94..3d15d0a5360 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -915,8 +915,23 @@ test_expect_success '%(raw) with --tcl must fail' '
 	test_must_fail git for-each-ref --format="%(raw)" --tcl
 '
 
-test_expect_success '%(raw) with --perl must fail' '
-	test_must_fail git for-each-ref --format="%(raw)" --perl
+test_expect_success '%(raw) with --perl' '
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/myblobs/blob1 --perl | perl >actual &&
+	cmp blob1 actual &&
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/myblobs/blob3 --perl | perl >actual &&
+	cmp blob3 actual &&
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/myblobs/blob8 --perl | perl >actual &&
+	cmp blob8 actual &&
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/myblobs/first --perl | perl >actual &&
+	cmp one actual &&
+	git cat-file tree refs/mytrees/first > expected &&
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/mytrees/first --perl | perl >actual &&
+	cmp expected actual
 '
 
 test_expect_success '%(raw) with --shell must fail' '
-- 
gitgitgadget

