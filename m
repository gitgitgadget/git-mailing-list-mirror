Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5800E1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbcFWQ35 (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36468 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcFWQ3i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id a2so18848194lfe.3
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHSK/Cc4pm7t/PwFZXWBOqdBgU9WZLtEl1e9GVy5WfU=;
        b=UM6kcTkF89w51VVn31fd2wC1Y51jRZ+4kYSZKJzQVVpE0B+WlZy0QVkL8JyB9Zksxu
         ng4briFYiTIAnAhYbnzcd5M0xUNSeleV/F5TgI+y/0z+YEujmIIVAuH5+WCW41P4hT5V
         kZNG//mFgZYlB2KihgalXAM5QqLdi5p+6mBVwL9nObIoFgd6W60xBWu8SpUeKZRTBvLg
         y+LoIABnguN3y6lFSTzOZP5FvJCIsslFCtQJ3FK0LVo5X2OOuWziICnMdTqW3PFyLSBN
         HMIIsx4jHtINmDNXCtquFxIN/lN5da3v8He26FhqlrZ1c8yvw8umkvXVDnH8ebfYq3lb
         u3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHSK/Cc4pm7t/PwFZXWBOqdBgU9WZLtEl1e9GVy5WfU=;
        b=iwqbwj/FI4Z87MSKuS4vNFxqoxeeY69tNSaQsHl1EV/ynBdAFJwcDvW+g6wbFozJWc
         2OhELIh/KYd/5scl2k4bhlpNO/MkHBaz9eFFLydymatRSDDc/xETwtS/i/WzipBUbtUU
         Eeub2iA90rHwzmEyX/TMzdkQMBWxLCRppYWM4hgiC8mlVZGofXE26GJJanW7zxGrZhIy
         EJkONsESBFapGXTTo9cZnQjTZl0+EtA3T5fzeiLzNQTN5JQrn22x1ggk20+7SYg/ed2C
         HBNhzGIFhsOVKzrlc9iLTEFklrHNz/sN77j+n54Q4AvZyD3Ulum/9P169IppoW8HzwSY
         sd0Q==
X-Gm-Message-State: ALyK8tJ0p7ogd6Tg1eYOXA36ggilVuk88cXgz/9reL5Gs9VWfq6lkPMicnjurvb1ujJShA==
X-Received: by 10.25.86.209 with SMTP id k200mr13015663lfb.65.1466699375495;
        Thu, 23 Jun 2016 09:29:35 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:34 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/11] grep/pcre: prepare locale-dependent tables for icase matching
Date:	Thu, 23 Jun 2016 18:29:02 +0200
Message-Id: <20160623162907.23295-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
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
index 6de58f3..22f4d99 100644
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

