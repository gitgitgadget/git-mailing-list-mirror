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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC44C49EA2
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BAB6120D
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFVDXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFVDXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D4C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:20:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so11291917wrs.12
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fs6HNinpIy5EDeC8HD9JEYHJ4F6sUtG05DtM6skNysU=;
        b=qJSk7K9Ax5puw1dwMKf51hcV387b85nhTu+9AnVh6LFOuVlDEAB/Mq/sLD/X7Jn9Oz
         UU+lvAvr/WHdcNekZAtf4fqAZgu6GLY9DHt0Mi7moteGM1h92wE/Yn+TP75t6uo4KaUP
         087LsbdKWtisg6/JC1KsLknPT1lxC8/Tmak5azB38JzDAGUWe11Vl8Y4llT5IZKnk2xL
         MDoPLBen454vZd0Fbn5ZfKtoHfv9vBIbxqVcag+VpjEuw5FC9xLzPmepzhU5Q+iG9h+y
         lmVZvXlCDFwqFCuQQgj05IMD9BDslYNg2cdzTksh1VxwqWfBrEsaX/fVY+7MzGLEBN53
         LBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fs6HNinpIy5EDeC8HD9JEYHJ4F6sUtG05DtM6skNysU=;
        b=A7i3GvNix4frdl79a0af9OqK/hknMFJIJpjTzRR4DLiKC6hB4EbZjjIAr0PtnQxsn8
         Ft+SYX3NOtFMh2OFZrYx7XLfOOV46B2fUADVq7s/lRAeon2Vcm86gcGG+WY4LbweWbS4
         e43nxRq9Vv3gCEXGB2pAPS2leULC3yqxfi4lB3TaNiPpeCmr7EFm89HAciXfkFfdDqQX
         6aqLa717dG2oQFkztwdlvp9ScCaX758pMzuwMeqEXh9hMaBtE4QNlGVID228qFJpwkrA
         HWZ7cSvCxrjsw1B3onRMOTB9KaQZ1xmoeCBYGtBKJbd7PJHUbm2YWx6Mc1fx/+iRgPqG
         2XlQ==
X-Gm-Message-State: AOAM533slgQ+lUn5vNkyD6sQdLiuYc9XlTkYqVyWcCUAelySqKr+zYaj
        BNw/nLynI3nTfGEiAwAZkRN8xOVITuQ=
X-Google-Smtp-Source: ABdhPJziyxaCVuwi8bYQF0RRNPNNaYXZayAlPE9EspUmr1o2UU15xVYjrtZf+scEpoCgJFI9IodHYw==
X-Received: by 2002:adf:eacc:: with SMTP id o12mr1903665wrn.3.1624332058013;
        Mon, 21 Jun 2021 20:20:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm18702574wry.74.2021.06.21.20.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:20:57 -0700 (PDT)
Message-Id: <b54dbc431e043c3ea2530fa8d1b4ba7e743b3d61.1624332054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
        <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:43 +0000
Subject: [PATCH v4 03/14] [GSOC] ref-filter: --format=%(raw) re-support --perl
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
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
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
 Documentation/git-for-each-ref.txt |  2 +-
 quote.c                            | 17 +++++++++++++++++
 quote.h                            |  1 +
 ref-filter.c                       | 15 +++++++++++----
 t/t6300-for-each-ref.sh            | 19 +++++++++++++++++--
 5 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7f1f0a1ca3b6..ea9b438c16f6 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -241,7 +241,7 @@ raw:size::
 	The raw data size of the object.
 
 Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
-`--perl` because the host language may not support arbitrary binary data in the
+because the host language may not support arbitrary binary data in the
 variables of its string type.
 
 The message in a commit or a tag object is `contents`, from which
diff --git a/quote.c b/quote.c
index 8a3a5e39eb12..26719d21d1e7 100644
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
index 768cc6338e27..0fe69e264b0e 100644
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
index 7822be903071..797b20ffa612 100644
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
index 9c5379e2f56f..5556063c347d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -915,8 +915,23 @@ test_expect_success '%(raw) with --tcl must fail' '
 	test_must_fail git for-each-ref --format="%(raw)" --tcl
 '
 
-test_expect_success '%(raw) with --perl must fail' '
-	test_must_fail git for-each-ref --format="%(raw)" --perl
+test_expect_success '%(raw) with --perl' '
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/myblobs/blob1 --perl | perl > actual &&
+	cmp blob1 actual &&
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/myblobs/blob3 --perl | perl > actual &&
+	cmp blob3 actual &&
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/myblobs/blob8 --perl | perl > actual &&
+	cmp blob8 actual &&
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/myblobs/first --perl | perl > actual &&
+	cmp one actual &&
+	git cat-file tree refs/mytrees/first > expected &&
+	git for-each-ref --format="\$name= %(raw);
+print \"\$name\"" refs/mytrees/first --perl | perl > actual &&
+	cmp expected actual
 '
 
 test_expect_success '%(raw) with --shell must fail' '
-- 
gitgitgadget

