Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFF1C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2189C61423
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhKQK0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbhKQK0o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:26:44 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A20C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:23:46 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id jo22so1636469qvb.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfJKlR/AqXwUeKYP5fsLgHWl1YUlcLvGXrsESGPDY1Q=;
        b=AlPXNxxdqIqowW5p/gyhm8RLyhR0i3sgV1701FGwgKJK0LAJn7tj3gDS++VtDqCLJ1
         r6t4TGrBA1Kqamkg4cVou4/dXqs5F5rGptpKiQkhXtHk1n4uEzlz2RzBdf4L8lCwFAMm
         OmtfoRshoPNynfjZA1sfCH+k/oG9S96/D2jKez8OuHEgSILvOHoUH9BVLpMjrCjgl3VX
         H7YNFEM4zaFNj92JAy/sg/0G706qysOnoTVUjtgO5s+mLUajJIZ9w0v4ZVBM3m9LfLFg
         CSFaUnd/Q0tcLRGJxR0uj5lAY3vsZO1YFnIkk6QCr2u1vB4kJkXgvvZxVKKG5w0ndLRc
         asYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfJKlR/AqXwUeKYP5fsLgHWl1YUlcLvGXrsESGPDY1Q=;
        b=D9RdigS8dFE8tHDpRjMZjg+ScRcPIisvIFisrET2Yz0t12svjXuAPTmdNaYmrW0suF
         +D4vVpwU6Fyvce/q1Ihkpp+Q0cgm7LKpjjVGgrEcKYT0n1ACSYIo+iGvDZNfW34rbWmj
         47+dRYky3yM+1dS4u2T/BnDYtTDFJFP9s1VE2Kg7XZqsfCPROHMKm2R9Y9iSRT6XL7eY
         67RhXBUctC18sVj9inoeFXvt6zHi5aIgx+ltp9rDMRQoMsQ4QjvV4bGRsoNuF9xr8PJP
         6pUSUVlJqvdELCVnl+HWL3+1ej8jfK24hKOkMxtgiKGxFaN+XoZgbhEMrR8QkADk/R9Q
         Cz2A==
X-Gm-Message-State: AOAM5310VOxYEZfRBFQ/NKEADKFOliyKxOvsHyYTCBE9lFJjauxPZAAw
        O4nHQ/eKRcpTDUyjb/Qhe2dfhX1L1vw=
X-Google-Smtp-Source: ABdhPJw29vPI03uD11jOCd+PPosjqA0qZ62d0LysOAFJopmBAYbAl4m4GJFGQqltp5zLrL703q3sHQ==
X-Received: by 2002:ad4:5cac:: with SMTP id q12mr53826387qvh.52.1637144625029;
        Wed, 17 Nov 2021 02:23:45 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f12sm6642565qtj.93.2021.11.17.02.23.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Nov 2021 02:23:44 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, someguy@effective-light.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v2] grep: avoid setting UTF mode when dangerous with PCRE
Date:   Wed, 17 Nov 2021 02:23:29 -0800
Message-Id: <20211117102329.95456-1-carenas@gmail.com>
X-Mailer: git-send-email 2.34.0.352.g07dee3c5e1
In-Reply-To: <20211116110035.22140-1-carenas@gmail.com>
References: <20211116110035.22140-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since ae39ba431a (grep/pcre2: fix an edge case concerning ascii patterns
and UTF-8 data, 2021-10-15), PCRE2_UTF mode is enabled for cases where it
will trigger UTF-8 validation errors (as reported) or can result in
undefined behaviour.

Our use of PCRE2 only allows searching through non UTF-8 validated data
safely through the use of the PCRE2_MATCH_INVALID_UTF flag, that is only
available after 10.34, so restrict the change to newer versions of PCRE
and revert to the old logic for older releases, which will still allow
for matching not using UTF-8 for likely most usecases (as shown in the
tests).

Fix one test that was using an expression that wouldn't fail without the
new code so it can be forced to fail if it is missing and restrict it to
run only for newer PCRE releases; while at it do some minor refactoring
to cleanup the fallout for when that test might be skipped or might
succeed under the new conditions.

Keeping the overly complex and unnecessary logic for now, to reduce risk
but with the hope that it will be cleaned up later.

Helped-by: René Scharfe <l.s.r@web.de>
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* restrict the code at compile time instead of reverting
* "fix" test to document  the behaviour under both PCRE code versions
* update commit message to better explain the issue

 grep.c                          |  7 ++++++-
 t/t7812-grep-icase-non-ascii.sh | 32 ++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/grep.c b/grep.c
index f6e113e9f0..0126aa3db4 100644
--- a/grep.c
+++ b/grep.c
@@ -382,12 +382,17 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
+#ifdef GIT_PCRE2_VERSION_10_34_OR_HIGHER
 	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
 	    (!opt->ignore_locale && is_utf8_locale() &&
 	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
 					    (p->fixed || p->is_fixed))))
 		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
-
+#else
+	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
+	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
+		options |= PCRE2_UTF;
+#endif
 #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
 	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS))
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 22487d90fd..3bfe1ee728 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -53,14 +53,27 @@ test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
 	test_cmp expected actual
 '
 
-test_expect_success GETTEXT_LOCALE,PCRE 'log --author with an ascii pattern on UTF-8 data' '
-	cat >expected <<-\EOF &&
-	Author: <BOLD;RED>À Ú Thor<RESET> <author@example.com>
-	EOF
+test_expect_success GETTEXT_LOCALE,PCRE 'setup ascii pattern on UTF-8 data' '
 	test_write_lines "forth" >file4 &&
 	git add file4 &&
 	git commit --author="À Ú Thor <author@example.com>" -m sécond &&
-	git log -1 --color=always --perl-regexp --author=".*Thor" >log &&
+	test_write_lines "fifth" >file5 &&
+	git add file5 &&
+	GIT_COMMITTER_NAME="Ç O Mîtter" &&
+	GIT_COMMITTER_EMAIL="committer@example.com" &&
+	git -c i18n.commitEncoding=latin1 commit -m thïrd
+'
+
+test_lazy_prereq PCRE2_MATCH_INVALID_UTF '
+	test-tool pcre2-config has-PCRE2_MATCH_INVALID_UTF
+'
+
+test_expect_success GETTEXT_LOCALE,PCRE,PCRE2_MATCH_INVALID_UTF 'log --author with an ascii pattern on UTF-8 data' '
+	cat >expected <<-\EOF &&
+	Author: <BOLD;RED>A U Thor<RESET> <author@example.com>
+	Author: <BOLD;RED>À Ú Thor<RESET> <author@example.com>
+	EOF
+	git log --color=always --perl-regexp --author=". . Thor" >log &&
 	grep Author log >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expected actual
@@ -70,11 +83,6 @@ test_expect_success GETTEXT_LOCALE,PCRE 'log --committer with an ascii pattern o
 	cat >expected <<-\EOF &&
 	Commit:     Ç<BOLD;RED> O Mîtter <committer@example.com><RESET>
 	EOF
-	test_write_lines "fifth" >file5 &&
-	git add file5 &&
-	GIT_COMMITTER_NAME="Ç O Mîtter" &&
-	GIT_COMMITTER_EMAIL="committer@example.com" &&
-	git -c i18n.commitEncoding=latin1 commit -m thïrd &&
 	git -c i18n.logOutputEncoding=latin1 log -1 --pretty=fuller --color=always --perl-regexp --committer=" O.*" >log &&
 	grep Commit: log >actual.raw &&
 	test_decode_color <actual.raw >actual &&
@@ -141,10 +149,6 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invali
 	test_cmp invalid-0xe5 actual
 '
 
-test_lazy_prereq PCRE2_MATCH_INVALID_UTF '
-	test-tool pcre2-config has-PCRE2_MATCH_INVALID_UTF
-'
-
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
 	test_might_fail git grep -hi "Æ" invalid-0x80 >actual &&
 	test_might_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual
-- 
2.34.0.352.g07dee3c5e1

