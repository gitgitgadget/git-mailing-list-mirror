Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3D01FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbcFYFYM (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36101 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbcFYFYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:10 -0400
Received: by mail-lf0-f68.google.com with SMTP id a2so23666996lfe.3
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/ZyM6K2BSjFAmhDw48CiY66cxKjEkmTv4uz46BZns4=;
        b=oBsAT166HeWku2il+3nl5xYoP31WWWdiNUgGukl1BSRpDP7PTmtji4GIs7RtlmshQR
         Na79BzrVLf6/d4L//px8rRkJRdtM4CIbSmEL9ZZSX+x8HBY2WbZjsBXbiwstaynKehKt
         AjRvBuNC/9S+ReclmgnC+OHanlbfNYItTMF40aFhNmHagAWcXzmC7NRFk9NUyV9zjnr9
         MLY7ZDIVCHTiLVrQ7JGrJg7RBgADvWOBFYMk9I3jaRG+EDCfhD8HpIy99UKbSDOaSmBS
         CouXc5FBNlhCrUOZnw5KS2jutRQkJke7D2iEfbjEO/UakTaXeVWidB33MIih02kXwymS
         sL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/ZyM6K2BSjFAmhDw48CiY66cxKjEkmTv4uz46BZns4=;
        b=m9zmfu6KwVeF729MCFYhTxplfUGwFxVVmhn7i4NPTibG3rAvmDCDGkA4DoJEQAKixZ
         6nSw7sMSMy+ee6MjcyEBvvOW4/X/d400jLVSx1IoJfKbhMXBaLw4Ny1qxK0w3gi1/hbj
         u/zH3wM2KNQdw+5x3za1TFaSzHogKo7KeFF1yAHWBKfuLyVIe9XWZdDQti2WdmmyJE3u
         uZo0bc+lY7eW+1tICZom08SJvQ/rIxGNel1mQ0J+3p/D0kIvvuhFC4yvkAAaRzz4MxVq
         XLc3JAZsHLiGTFos5GTo4BSORzX72HJS92uHuyd9dDuAF9cRCN62pwyLgXQpXB/lHXHO
         4T3Q==
X-Gm-Message-State: ALyK8tKY1qbE+vl0g2oLEw/AjnIzPG/Y8dip4NdhYLPJNLQe1kn7evYO9Hy2mK0uRSL7Ww==
X-Received: by 10.25.160.135 with SMTP id j129mr1959218lfe.231.1466832248401;
        Fri, 24 Jun 2016 22:24:08 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:07 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/12] grep/icase: avoid kwsset on literal non-ascii strings
Date:	Sat, 25 Jun 2016 07:22:30 +0200
Message-Id: <20160625052238.13615-5-pclouds@gmail.com>
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

When we detect the pattern is just a literal string, we avoid heavy
regex engine and use fast substring search implemented in kwsset.c.
But kws uses git-ctype which is locale-independent so it does not know
how to fold case properly outside ascii range. Let regcomp or pcre
take care of this case instead. Slower, but accurate.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                                   |  7 ++++++-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh

diff --git a/grep.c b/grep.c
index f430d7e..451275d 100644
--- a/grep.c
+++ b/grep.c
@@ -4,6 +4,7 @@
 #include "xdiff-interface.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "commit.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -398,14 +399,18 @@ static int is_fixed(const char *s, size_t len)
 
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
+	int icase, ascii_only;
 	int err;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
+	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
+	ascii_only     = !has_non_ascii(p->pattern);
 
 	if (opt->fixed)
 		p->fixed = 1;
-	else if (is_fixed(p->pattern, p->patternlen))
+	else if ((!icase || ascii_only) &&
+		 is_fixed(p->pattern, p->patternlen))
 		p->fixed = 1;
 	else
 		p->fixed = 0;
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
new file mode 100755
index 0000000..b78a774
--- /dev/null
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='grep icase on non-English locales'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_LOCALE 'setup' '
+	test_write_lines "TILRAUN: Halló Heimur!" >file &&
+	git add file &&
+	LC_ALL="$is_IS_locale" &&
+	export LC_ALL
+'
+
+test_have_prereq GETTEXT_LOCALE &&
+test-regex "HALLÓ" "Halló" ICASE &&
+test_set_prereq REGEX_LOCALE
+
+test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
+	git grep -i "TILRAUN: Halló Heimur!" &&
+	git grep -i "TILRAUN: HALLÓ HEIMUR!"
+'
+
+test_done
-- 
2.8.2.526.g02eed6d

