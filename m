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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1AEC432BE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2A960EAF
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhGXNd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhGXNd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 09:33:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB3C061757
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:14:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e2so5409181wrq.6
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dFUftGK/HlYzbQtnH7/QhCIwYPePpV3KVlXllgJr4I8=;
        b=H7vZydmquR90AALMJ1Bhwbm4yo5x+SLDhmvDTZ9ZYbHh9kugERBtOjmnPDYVhIna1w
         crULXp9AdWk9hSLl6tBnf3Q78KWpitcMX4U26lK7Fj/GYCqAPs8INkrk4hKo8r3ALSzT
         bqDeRgsJwB1iy5cvMbGejnVV2DVSDOx6dd2PRDfvBO1HFABw0XT4e/ccMH02BL7W7g+v
         hk4HSwnRelgT++X+VQpMoIkipL5KuUsWZ+kTYCTi/2FeWazhgSHQd2prBcRcCK3yVSBC
         dzu5cZKuTvepL1C2OBJec3KDraaQMg5wRGX3z8zviTgOhd4Qn7yu8OdYyONlOIRDDt3q
         M9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=dFUftGK/HlYzbQtnH7/QhCIwYPePpV3KVlXllgJr4I8=;
        b=hjLkrP4e3axkQnzKibmc4jMNHflVS4EHjUbd8ZP9IYdBmTbQg+GlF+T40yn3H0b3Bi
         1MrpKl43he45I7zG1e8Lk5/tHEjSPomhBHjSi42tKCrU0MUvhxiYFtuKYFus2lVIPHLL
         NvCB9q9AgBpEPVo0m+8mYX90kr4I+E3h2Dsfdy7kI466jl7NohMMNFMh2XRiwmE1vYLS
         jVu9cP+mmhVSrUY2zBne6au45kZq2BUqzXWWj1/x045dD1iZVJ7Hhy9v7pJR/fpSoWN4
         dPwLeZ0aMD5/6tLWsKgAFQFiEDBOjNHWemkCvesXwihyyNVoNeLBogAbHqevN8La2ldj
         k/pQ==
X-Gm-Message-State: AOAM5330xHxm9CrqzHVk9kzuqZ4pVhKZdUI7Kww41x6isiyLe74P6Re9
        r781K/nfruxJ2SIOeDgNeafY3SILV/k=
X-Google-Smtp-Source: ABdhPJybSfzkN/wTOEl73FhzF338nCmMBBK62lK1lLiY5AGECgCWetN0DjTtpYWdJ20RJI4aN2it6w==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr10395997wru.311.1627136065591;
        Sat, 24 Jul 2021 07:14:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm30113881wmb.35.2021.07.24.07.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 07:14:25 -0700 (PDT)
Message-Id: <ac5d98647dad31ebe165daa7cbf84f2b7e5fbe80.1627136062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
References: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
        <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 14:14:19 +0000
Subject: [PATCH v3 3/5] [GSOC] ref-filter: --format=%(raw) re-support --perl
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
index 01545618101..597354c941d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -746,7 +746,10 @@ static void quote_formatting(struct strbuf *s, const char *str, size_t len, int
 		sq_quote_buf(s, str);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(s, str);
+		if (len != -1)
+			perl_quote_buf_with_len(s, str, len);
+		else
+			perl_quote_buf(s, str);
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

