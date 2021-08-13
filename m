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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCFEC4320E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DFF6056B
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbhHMIXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbhHMIXl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472EC0617AF
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q6so618021wrv.6
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=AOOm8J191P4j4KlKZ3cqk8UGe++6yL/hpw1DpiVJqyA=;
        b=I0asmJR32+EDkDdPkVARXhjk3Uf+sY2h7oXdQCEtuK5gRM/xvxHsrriNPmNEnAPsQO
         r3MR3reErJH2ZX9uGVZbJVkogjnITQ8/WFT1RMVA+bqD1DiPfNT7Dk/nnrQQVPo3e9cA
         x0Wxyr4xDlD2vlI2m6mHG2rAHO8oO1DublxQXUNS+r39OoW1B2Uoso59aYXqgANltoKZ
         hx0N5mg/2/8YMttdre0ZmR2XWmZPnaIixmS3dK7PqyzpJxlO5g1EvbXkNkeDVrmbXIEN
         rUL1waZaXGniqlIvomhoJ9EGVXe83KtMx6fV7cqKn6D3vmji4R5aOmNMkkUy3gmHbmYu
         i23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=AOOm8J191P4j4KlKZ3cqk8UGe++6yL/hpw1DpiVJqyA=;
        b=dbBXQwbg3jAiGuItxkrBqg0HVABnxFt/qTuMTzrNLWyGS+hH7ptuk0bNNwLN0Y+DJu
         89JiocxFTzJTrA4HMgG7VWo6hWMJkx45gZdEFkG3y5ZTA3209K1murEN2lYdhiVWEinU
         OzCN2fOgA/qe5Vm+uO/obwmvpBaGQE/dmIyV6QlQwjxvsynsYbzkJkghYyho3Ytkrw5x
         glF7c8HS1JE+RBmnAaaqFT8GzaRRI5HnAx506OYK1yD3U2+5QwSTzehl1j6xuVE//gYt
         eKg1XhDyoftT2tw0IfxL+uR4yCKK9X0OKC8mdXE7HU5HojvpItY/01TBIJ0hUdqcRHmC
         Av5Q==
X-Gm-Message-State: AOAM531dBgoXavBVLSviF+X3TOMk6jxdkztX31a3M7p4yrGWYpPaYpPL
        GSc5b4t9ZdFVoujGrq2Ymar7SmX/D/o=
X-Google-Smtp-Source: ABdhPJzm0LYx9tSFKTY82aY1EIvxtSXox1GuFGBY3DQHY219+7Ui9rxH7vrmGoz5gW6eedUvgQw+Xw==
X-Received: by 2002:adf:a452:: with SMTP id e18mr1767104wra.244.1628842993870;
        Fri, 13 Aug 2021 01:23:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o24sm706406wmm.37.2021.08.13.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:13 -0700 (PDT)
Message-Id: <452ea887e6123bc74b1a2f563ab0ea7c650867b9.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:46 +0000
Subject: [PATCH 03/27] [GSOC] ref-filter: --format=%(raw) support --perl
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
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Because the perl language can handle binary data correctly,
add the function perl_quote_buf_with_len(), which can specify
the length of the data and prevent the data from being truncated
at '\0' to help `--format="%(raw)"` support `--perl`.

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
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
index 049d8dd0b3d..87ff458b06d 100644
--- a/quote.h
+++ b/quote.h
@@ -95,6 +95,7 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
 
 /* quoting as a string literal for other languages */
 void perl_quote_buf(struct strbuf *sb, const char *src);
+void perl_quote_buf_with_len(struct strbuf *sb, const char *src, size_t len);
 void python_quote_buf(struct strbuf *sb, const char *src);
 void tcl_quote_buf(struct strbuf *sb, const char *src);
 void basic_regex_quote_buf(struct strbuf *sb, const char *src);
diff --git a/ref-filter.c b/ref-filter.c
index 1e660f60c4b..f2454d34ce8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -747,7 +747,10 @@ static void quote_formatting(struct strbuf *s, const char *str, ssize_t len, int
 		sq_quote_buf(s, str);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(s, str);
+		if (len < 0)
+			perl_quote_buf(s, str);
+		else
+			perl_quote_buf_with_len(s, str, len);
 		break;
 	case QUOTE_PYTHON:
 		python_quote_buf(s, str);
@@ -1010,10 +1013,14 @@ int verify_ref_format(struct ref_format *format)
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

