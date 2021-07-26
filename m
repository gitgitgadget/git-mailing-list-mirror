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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8CBC432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D3760F21
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhGZCqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 22:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhGZCq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 22:46:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8732FC061765
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l18so1682919wrv.5
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=HNq+RvYll+ZTasGR58M+bp4Cb8aAM/+X6bBBJjxxjKs=;
        b=lq6xz1SfWOsTr/kWFknpnqZKNTz/EMVdf0QwQzR1+fbRFBVDYVVtRDXh/NazQD+3Fn
         asPf2gz4V+u9Adlya1sK+j+pejxarqMSEQ1Z9VAG4c91Dem34wLIC0QEViACSN8RpXfe
         CoBCWEDo7Ny7vRAX5GX/+Wg4C7sgDzNEcK3wwgQffNkNOM/g2/axTi7nwNKCOuCYhzWq
         oMwvO7LzPCxpR+MYGXxV+V4u/PuPXx59+e6h7GIStegCr6jvUaRiBbJgMrqEDvnZHtop
         0G4rkfMNyYvKVnRaPdTTDGBfB1yNjDxNL8jlvWejwV107Lb9RUn3jUOFRUIhELVANTpU
         forg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=HNq+RvYll+ZTasGR58M+bp4Cb8aAM/+X6bBBJjxxjKs=;
        b=mwQIxQsKB0Gfv4h6zkNgfXR6XXXpQl2XS3AYtyvgaEMyGI90d+LvjTCIZ/R0K/34Pr
         Wo529ovaXoKuizkafj+KCysiP/wB8oQ+jhEv644BgX0bamvn+rZB6YKPoQ2Gt/CI3Z3m
         jLX3phxHp4bvcSHUlWNa0kfsGYsFkYJiE92GZuxogSip5OKSrQnsMPhH1PixEIJlZHLi
         RNe5jTqSscrjyczE199bdqN/HCL4P/bHvOPvrbLmjv3yViheBm2lSur6E6LI2PIf4Xyi
         TIodGhlDb/GCsbj+iEBt53iYrOwebTEmsmnJSVSCaYXjypLspMKpyOORS2AXGchJycXo
         zKZw==
X-Gm-Message-State: AOAM531RGgFkEr7xIZ9ZygOdz0xuSM2AQCWxu19bDzrZ41End12mP5ke
        UEjzca2NnzV/vBEKdqOGjVHn+hzeEO0=
X-Google-Smtp-Source: ABdhPJwN7OEzJDujV/BBL9KDvS2C0n2k+tDVJrE9meRw9lNCqc8fgvpq3DOqXlrhGHRGPtwFOiUKUQ==
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr16562475wrv.197.1627270014206;
        Sun, 25 Jul 2021 20:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm6345437wrn.9.2021.07.25.20.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 20:26:53 -0700 (PDT)
Message-Id: <d14fae5208013836d8015cf1be19314c61a65d1e.1627270010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
References: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
        <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 03:26:48 +0000
Subject: [PATCH v4 3/5] [GSOC] ref-filter: --format=%(raw) support --perl
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
        Jacob Keller <jacob.keller@gmail.com>,
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
index 0d5eb91ed54..ce6c2115016 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -746,7 +746,10 @@ static void quote_formatting(struct strbuf *s, const char *str, ssize_t len, int
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
@@ -1009,10 +1012,14 @@ int verify_ref_format(struct ref_format *format)
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

