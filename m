Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE521FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbcFYFYT (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:19 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35362 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcFYFYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id w130so23688131lfd.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNX4UNdvvX0S9ALRauhHqA4pQaSzF8aZ/yFCLc+9jMQ=;
        b=lzvkfgZI1BTmIOBwJask/hQnj7rTwqYiXZ8ZtprWobR8w6f9/TNC04M7CsNCoPRgG0
         gyexfVDUE+p0z98cqbPDp17fp2i3DxaxbZtSuhmDf1QfhoE8582wCEITig0VaG+cK1GH
         kAzcBtY18JsBueV1YznwEzGMmcOe19IZNhjNhaijR1PdZ9tsuZaJD1y9p7Fh6hAts6/a
         sQ2Nt0Us4NWPoKO2rWnaos57fv1skEIQHVAA5fxyrhA/ludOY77R8/HPb+BqKuAGGnG8
         caVfuPZ5PEVHpI/dvKk8bR2M7RWDj+mCZDQ0qskm0bfWU5zxjr/oW49Z8J+jXJZCVBbj
         b4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNX4UNdvvX0S9ALRauhHqA4pQaSzF8aZ/yFCLc+9jMQ=;
        b=YCXdJDYDL1byud95GRaQ0tFs8ocWxIuigy6M+y7nDvFqyIWVX1GooEu3g8p6fqGWbM
         2S9AmOTrzbJB7kFLm7oOSIei2K2xO7HZcIq9/bR2jEIZnx9hBIy31jJYSusrENSl9Aj0
         Y2P1PZlPIEU1J8cF/1aUKeq4ZJyqYaDATz7q2tnC6GNJ+PL3Im8n/tBMicm06/yfCWMA
         gk+dWCnqeq0CT/K7c0xdzLNm26cbZIchHWIHpCC9DmddrcNURzHS75CdhZl+WC42icsQ
         wiUwTINkv1x1XIeY8yEt/MSBsUbmy0wRuPeGpGU67vQhZmU0TNaIlAfowozkcuh/Fo+P
         0ymA==
X-Gm-Message-State: ALyK8tKu0Uf4g/3tsr4DiLow/ZHPUxlTRLeLn4vPbTVbQQPR6WBOImIjtuz27LcZfKs/MA==
X-Received: by 10.25.131.200 with SMTP id f191mr2432275lfd.219.1466832249423;
        Fri, 24 Jun 2016 22:24:09 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:08 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/12] grep/icase: avoid kwsset when -F is specified
Date:	Sat, 25 Jun 2016 07:22:31 +0200
Message-Id: <20160625052238.13615-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similar to the previous commit, we can't use kws on icase search
outside ascii range. But we can't simply pass the pattern to
regcomp/pcre like the previous commit because it may contain regex
special characters, so we need to quote the regex first.

To avoid misquote traps that could lead to undefined behavior, we
always stick to basic regex engine in this case. We don't need fancy
features for grepping a literal string anyway.

basic_regex_quote_buf() assumes that if the pattern is in a multibyte
encoding, ascii chars must be unambiguously encoded as single
bytes. This is true at least for UTF-8. For others, let's wait until
people yell up. Chances are nobody uses multibyte, non utf-8 charsets
anymore.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                          | 24 +++++++++++++++++++++++-
 quote.c                         | 37 +++++++++++++++++++++++++++++++++++++
 quote.h                         |  1 +
 t/t7812-grep-icase-non-ascii.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 451275d..5a8c52a 100644
--- a/grep.c
+++ b/grep.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "commit.h"
+#include "quote.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -397,6 +398,24 @@ static int is_fixed(const char *s, size_t len)
 	return 1;
 }
 
+static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int err;
+
+	basic_regex_quote_buf(&sb, p->pattern);
+	err = regcomp(&p->regexp, sb.buf, opt->regflags & ~REG_EXTENDED);
+	if (opt->debug)
+		fprintf(stderr, "fixed %s\n", sb.buf);
+	strbuf_release(&sb);
+	if (err) {
+		char errbuf[1024];
+		regerror(err, &p->regexp, errbuf, sizeof(errbuf));
+		regfree(&p->regexp);
+		compile_regexp_failed(p, errbuf);
+	}
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int icase, ascii_only;
@@ -408,7 +427,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	ascii_only     = !has_non_ascii(p->pattern);
 
 	if (opt->fixed)
-		p->fixed = 1;
+		p->fixed = !icase || ascii_only;
 	else if ((!icase || ascii_only) &&
 		 is_fixed(p->pattern, p->patternlen))
 		p->fixed = 1;
@@ -423,6 +442,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
+	} else if (opt->fixed) {
+		compile_fixed_regexp(p, opt);
+		return;
 	}
 
 	if (opt->pcre) {
diff --git a/quote.c b/quote.c
index fe884d2..c67adb7 100644
--- a/quote.c
+++ b/quote.c
@@ -440,3 +440,40 @@ void tcl_quote_buf(struct strbuf *sb, const char *src)
 	}
 	strbuf_addch(sb, '"');
 }
+
+void basic_regex_quote_buf(struct strbuf *sb, const char *src)
+{
+	char c;
+
+	if (*src == '^') {
+		/* only beginning '^' is special and needs quoting */
+		strbuf_addch(sb, '\\');
+		strbuf_addch(sb, *src++);
+	}
+	if (*src == '*')
+		/* beginning '*' is not special, no quoting */
+		strbuf_addch(sb, *src++);
+
+	while ((c = *src++)) {
+		switch (c) {
+		case '[':
+		case '.':
+		case '\\':
+		case '*':
+			strbuf_addch(sb, '\\');
+			strbuf_addch(sb, c);
+			break;
+
+		case '$':
+			/* only the end '$' is special and needs quoting */
+			if (*src == '\0')
+				strbuf_addch(sb, '\\');
+			strbuf_addch(sb, c);
+			break;
+
+		default:
+			strbuf_addch(sb, c);
+			break;
+		}
+	}
+}
diff --git a/quote.h b/quote.h
index 99e04d3..362d315 100644
--- a/quote.h
+++ b/quote.h
@@ -67,5 +67,6 @@ extern char *quote_path_relative(const char *in, const char *prefix,
 extern void perl_quote_buf(struct strbuf *sb, const char *src);
 extern void python_quote_buf(struct strbuf *sb, const char *src);
 extern void tcl_quote_buf(struct strbuf *sb, const char *src);
+extern void basic_regex_quote_buf(struct strbuf *sb, const char *src);
 
 #endif
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index b78a774..1929809 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -20,4 +20,30 @@ test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
 	git grep -i "TILRAUN: HALLÓ HEIMUR!"
 '
 
+test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
+	git grep --debug -i -F "TILRAUN: Halló Heimur!"  2>&1 >/dev/null |
+		 grep fixed >debug1 &&
+	test_write_lines "fixed TILRAUN: Halló Heimur!" >expect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "TILRAUN: HALLÓ HEIMUR!"  2>&1 >/dev/null |
+		 grep fixed >debug2 &&
+	test_write_lines "fixed TILRAUN: HALLÓ HEIMUR!" >expect2 &&
+	test_cmp expect2 debug2
+'
+
+test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
+	test_write_lines "^*TILR^AUN:.* \\Halló \$He[]imur!\$" >file &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\Halló \$He[]imur!\$" 2>&1 >/dev/null |
+		 grep fixed >debug1 &&
+	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\Halló \$He\\[]imur!\\\$" >expect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\HALLÓ \$HE[]IMUR!\$"  2>&1 >/dev/null |
+		 grep fixed >debug2 &&
+	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\HALLÓ \$HE\\[]IMUR!\\\$" >expect2 &&
+	test_cmp expect2 debug2
+'
+
 test_done
-- 
2.8.2.526.g02eed6d

