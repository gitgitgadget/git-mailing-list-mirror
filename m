Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B30C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39A1205CB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7hx/ICm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390043AbgEMSC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733070AbgEMSCZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:02:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B757CC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:02:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so11323263pjb.5
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUgRLVJqPES3ITbjR5Uwf2MKTeAhwjgov3+gNzhIzY8=;
        b=e7hx/ICmua/J8ZMgX+u8rQl990dcrXmnB20WnQfhXq7Xa18/lQv++Wcgszig9PUL50
         9jWBcB6M+S6BxWBbibZRBEtIPb/AvAlZspn4bw+5VV/DELWPlsO9anL+q8Sg5HhE94+V
         G9Nl9voJ5wfB7f5nr3mBTMJVZCYPKqVZzN2ytc5TtB2NP060fgr6nUilJFfMROgIyYYk
         jHy4SSTsE3OEImXZdTkJgxAXcZrZdwzMlZ5YHclIWCt9Rz6WhBM9biTnfLq1Uks6RaDr
         z5L/C7Ffs/2qmjsLhg2e20g66DM0iPzG+qqoSrQ5AqSJV3FvNaS6YnRS/bynE6kEUJ0T
         3r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUgRLVJqPES3ITbjR5Uwf2MKTeAhwjgov3+gNzhIzY8=;
        b=prZUYX/y3MTGbkGal6wSjFUmXgl9I/9iwtzatR9ZVfgUPOvvziSqyZnPst6y1JMV4/
         1p2ZRJcg6Yr1uvuV+avnf+qSqcMZNtKVBMBFRv2HVIqUt5A2x2PSUYDUDnH40m4voDtn
         1hVtplOHV+hBJr6J6HEwfXsWj1rh8rk5cg7p8OfaiC71cE7gydxpiKE2Bn3zSNEryrot
         pnl9O2KjCYOK12tOj4ixgboLOuKH2wWG+uLT88VWxy8uYw95e8JM6cGkOqorI1rKfpIm
         Mzlaj57UP42jcGURbmA0jCN2YGgHy6RpbYVWyPfLWm+Daf8o4egA8AJDI+X71Bhd4Cs4
         S3Hg==
X-Gm-Message-State: AGi0PuZo7sb2JoIOjFtvQ325uQTIx/qrUSliycaliFMArabJmZtgwsW9
        zfUcxG/aI5s62Aj65HR0Q6HOrF+P
X-Google-Smtp-Source: APiQypKpI9hUZqImulh4kByadRUyxpQGwe0Vdt9XoHgImn7OcNT1rLLyLDKF1m4q2mTbfxHgP+BvCg==
X-Received: by 2002:a17:90a:2f64:: with SMTP id s91mr35662036pjd.30.1589392944718;
        Wed, 13 May 2020 11:02:24 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id m18sm16204485pjl.14.2020.05.13.11.02.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 11:02:24 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     emaste@freebsd.org, sunshine@sunshineco.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v2] t4210: detect REG_ILLSEQ dynamically
Date:   Wed, 13 May 2020 11:02:13 -0700
Message-Id: <20200513180213.45866-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.812.g046d49d455
In-Reply-To: <20200513111636.30818-1-carenas@gmail.com>
References: <20200513111636.30818-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

7187c7bbb8 (t4210: skip i18n tests that don't work on FreeBSD, 2019-11-27)
adds a REG_ILLSEQ prerequisite to avoid failures from the tests added with
4e2443b181 (log tests: test regex backends in "--encode=<enc>" tests,
2019-06-28), but hardcodes it to be only enabled for FreeBSD.

Instead of hardcoding the affected platform, add a test using test-tool to
make sure it can be dynamically detected in other affected systems (like
DragonFlyBSD or macOS), and while at it, enhance the tool so it can report
better on the cause of failure and be silent when needed.

To minimize changes, it is assumed the regcomp error is of the right type
since we control the only caller, and is also assumed to affect both basic
and extended syntax (only extended is tested, but both behave the same in
all three affected platforms).

The description of the first test which wasn't accurate has been corrected,
and unlike the original fix from 7187c7bbb8, all added entries to test-lib
are no longer needed and only the 2 affected engines will have their tests
suppressed.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
- nicer variable names and hopefully easier to understand logic

 t/helper/test-regex.c | 20 +++++++++++++++----
 t/t4210-log-i18n.sh   | 45 ++++++++++++++++++++++++++++---------------
 t/test-lib.sh         |  6 ------
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index 10284cc56f..a4bd1f3a36 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -41,16 +41,21 @@ int cmd__regex(int argc, const char **argv)
 {
 	const char *pat;
 	const char *str;
-	int flags = 0;
+	int ret, silent = 0, flags = 0;
 	regex_t r;
 	regmatch_t m[1];
+	char errbuf[64];
 
 	if (argc == 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
 	else if (argc < 3)
 		usage("test-tool regex --bug\n"
-		      "test-tool regex <pattern> <string> [<options>]");
+		      "test-tool regex [--silent] <pattern> <string> [<options>]");
 
+	if (!strcmp(argv[1], "--silent")) {
+		silent = 1;
+		argv++;
+	}
 	argv++;
 	pat = *argv++;
 	str = *argv++;
@@ -67,8 +72,15 @@ int cmd__regex(int argc, const char **argv)
 	}
 	git_setup_gettext();
 
-	if (regcomp(&r, pat, flags))
-		die("failed regcomp() for pattern '%s'", pat);
+	ret = regcomp(&r, pat, flags);
+	if (ret) {
+		if (!silent) {
+			regerror(ret, &r, errbuf, sizeof(errbuf));
+			die("failed regcomp() for pattern '%s' (%s)",
+				pat, errbuf);
+		} else
+			return 1;
+	}
 	if (regexec(&r, str, 1, m, 0))
 		return 1;
 
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index c3792081e6..8fccb83020 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -10,6 +10,12 @@ latin1_e=$(printf '\351')
 # invalid UTF-8
 invalid_e=$(printf '\303\50)') # ")" at end to close opening "("
 
+if test_have_prereq GETTEXT_LOCALE &&
+	! LC_ALL=$is_IS_locale test-tool regex --silent $latin1_e $latin1_e EXTENDED
+then
+	have_reg_illseq=1
+fi
+
 test_expect_success 'create commits in different encodings' '
 	test_tick &&
 	cat >msg <<-EOF &&
@@ -61,33 +67,40 @@ do
 	prereq=
 	if test $engine = "perl"
 	then
-		prereq="PCRE"
-	else
-		prereq=""
+		prereq=PCRE
 	fi
 	force_regex=
 	if test $engine != "fixed"
 	then
-	    force_regex=.*
+		force_regex=.*
+	fi
+
+	if test -z "$have_reg_illseq" ||
+		test $engine = "fixed" || test $engine = "perl"
+	then
+		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep searches in log output encoding (latin1 + locale)" "
+			cat >expect <<-\EOF &&
+			latin1
+			utf8
+			EOF
+			LC_ALL=$is_IS_locale git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$latin1_e\" >actual &&
+			test_cmp expect actual
+		"
 	fi
-	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
-		cat >expect <<-\EOF &&
-		latin1
-		utf8
-		EOF
-		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$latin1_e\" >actual &&
-		test_cmp expect actual
-	"
 
 	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
 		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$utf8_e\" >actual &&
 		test_must_be_empty actual
 	"
 
-	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
-		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
-		test_must_be_empty actual
-	"
+	if test -z "$have_reg_illseq" ||
+		test $engine = "fixed" || test $engine = "perl"
+	then
+		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
+			LC_ALL=$is_IS_locale git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
+			test_must_be_empty actual
+		"
+	fi
 done
 
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05e..81473fea1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1454,12 +1454,6 @@ case $uname_s in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	;;
-FreeBSD)
-	test_set_prereq REGEX_ILLSEQ
-	test_set_prereq POSIXPERM
-	test_set_prereq BSLASHPSPEC
-	test_set_prereq EXECKEEPSPID
-	;;
 *)
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
-- 
2.26.2.812.g046d49d455

