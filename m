Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE4B1FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbcFYFYV (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34320 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbcFYFYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:13 -0400
Received: by mail-lf0-f65.google.com with SMTP id l184so23684435lfl.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0FcbDLKkajulJsbg6rFd3+M/F+y336AgiNEhOuP6H4=;
        b=jYKUDhDSMQABakoaIHyq2yZ4w1ZuWsmVXTksV/aa6AB30iK2AMamznng+XJCG0t7wo
         yGePtNWZ3Z6ei5CueGzl8VLH/9xXG0wwf8yArXayd2Wfkg4ccddVdPjd1v6eXXXWLUx5
         QgYR4rx6tIx3EqroqBmYbubKOBef6V75P+stPrHJD2CguZoCUW5GMhQRbwBAvDQb+69X
         0CMhOwjD2kXl+YGaa2yP0nh4V6Cg+xSJtO5tLmQZF3kCMXYnYarz3lmuWbttvpb7nNp7
         WlfG9Ihj5kTz+vRepYkMshy3g3VcAjdVt4cYlpHPU5QMipiIsBCCTw/+2MXDYOIkUBNq
         eNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0FcbDLKkajulJsbg6rFd3+M/F+y336AgiNEhOuP6H4=;
        b=elrrUyXVAD58wd+qbjpfn0ZDzU7dcR1Tno55pWO04neF9YK5yzbbCKts4dflW3g1ib
         fJoAab51dyugcJnNcBroKCp4AmOEp611HFk9SrZ3yX3ULCbWiDYzEpB+bb4gclJbatoF
         YjtVryOOj+4FAAe+gB0ZVYv0CJ8jY9Ogo9wLLtAE3JOAv2wvLr4fSxyvM8kHA8Ednfep
         1RVf+QANFjuNZBXeGt9PxuAkpuBhR6jHbUSBB+2Hoqh1p/MucGBWY5tpfEMY6j2Po3dU
         jTt+RL6yHoyhWCgfnvWwg8CDauoZA/K0tOqf6tnmXNIf+lr9mFfRvwhmHXIM2m8QRM0U
         9Y+w==
X-Gm-Message-State: ALyK8tIbCxNjfSneYdptBePDX/gF7rRcw6CEvgUi5HtufbM7Pc5lSL8ZSHtV2J0Fog5q3Q==
X-Received: by 10.46.71.206 with SMTP id u197mr2148171lja.16.1466832251621;
        Fri, 24 Jun 2016 22:24:11 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:10 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/12] grep/pcre: prepare locale-dependent tables for icase matching
Date:	Sat, 25 Jun 2016 07:22:33 +0200
Message-Id: <20160625052238.13615-8-pclouds@gmail.com>
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

The default tables are usually built with C locale and only suitable
for LANG=C or similar.  This should make case insensitive search work
correctly for all single-byte charsets.

Signed-off-by: Nguy·ªÖn Th√°i Ng·ªçc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                             |  8 ++++++--
 grep.h                             |  1 +
 t/t7813-grep-icase-iso.sh (new +x) | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100755 t/t7813-grep-icase-iso.sh

diff --git a/grep.c b/grep.c
index 4b6b7bc..8cf4247 100644
--- a/grep.c
+++ b/grep.c
@@ -324,11 +324,14 @@ static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	int erroffset;
 	int options = PCRE_MULTILINE;
 
-	if (opt->ignore_case)
+	if (opt->ignore_case) {
+		if (has_non_ascii(p->pattern))
+			p->pcre_tables = pcre_maketables();
 		options |= PCRE_CASELESS;
+	}
 
 	p->pcre_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
-			NULL);
+				      p->pcre_tables);
 	if (!p->pcre_regexp)
 		compile_regexp_failed(p, error);
 
@@ -362,6 +365,7 @@ static void free_pcre_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre_regexp);
 	pcre_free(p->pcre_extra_info);
+	pcre_free((void *)p->pcre_tables);
 }
 #else /* !USE_LIBPCRE */
 static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 95f197a..cee4357 100644
--- a/grep.h
+++ b/grep.h
@@ -48,6 +48,7 @@ struct grep_pat {
 	regex_t regexp;
 	pcre *pcre_regexp;
 	pcre_extra *pcre_extra_info;
+	const unsigned char *pcre_tables;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
diff --git a/t/t7813-grep-icase-iso.sh b/t/t7813-grep-icase-iso.sh
new file mode 100755
index 0000000..efef7fb
--- /dev/null
+++ b/t/t7813-grep-icase-iso.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='grep icase on non-English locales'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_ISO_LOCALE 'setup' '
+	printf "TILRAUN: HallÛ Heimur!" >file &&
+	git add file &&
+	LC_ALL="$is_IS_iso_locale" &&
+	export LC_ALL
+'
+
+test_expect_success GETTEXT_ISO_LOCALE,LIBPCRE 'grep pcre string' '
+	git grep --perl-regexp -i "TILRAUN: H.llÛ Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LL” HEIMUR!"
+'
+
+test_done
-- 
2.8.2.526.g02eed6d

