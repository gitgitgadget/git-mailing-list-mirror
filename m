Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7FC433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB4F20715
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKijodHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgERSos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgERSor (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:44:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638C2C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:44:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so248337pjb.3
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jqBF1ymukkINMvlM/l6/OLmqfaMNdY70VXQMnlweKRc=;
        b=YKijodHF+Vuqa656WurFdzUwRFg88XRP+jNhWLH3QuW1zDu7ThQ+42bUuBazoh0Ik1
         tdYVt6/Bod/AvdhzgW69h+aa1+C47GccjKX9p5kGFhrqHl4gdSneYzTjPX6+qwp5JPz/
         CSBtSnMqWpvDh+Q8Avphrq8Jn+RD7gPBolnlt65tIVk4OdBAlCw+J6wzMcFm872B3j9J
         cwjrKhAQ3sk5Bqbd/hPTpoUogihv8MW4bH7DYNphLzrDRT4kWswMa0s+HcTkgNR4t2ne
         11RMkZ7PcfSR2A7X+S0ZCLVnhDVhMLW623ksoUQjNm7QfAmx5z1DC6q1rVjISJQQQrQ3
         YuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqBF1ymukkINMvlM/l6/OLmqfaMNdY70VXQMnlweKRc=;
        b=SxPc0Hn5dUklUuOhb2Ejw1LhcKQMpYcAqkw44DNB6xoxfOM9ly7yDWSbiTwWV2Kmvs
         xtn+23kPIu+4SbC51hIbH/dhLHlVfPZF1qI7MJz5fPiw2ABRBh2clBd199PAt3pJ/y7P
         0ebLp8DH12Fn4wD+B7Icj9RxUiqCxeXETcffMZEwo0b3DH1bazAyz4e94vJKAv9AUrax
         1P/PpcrtadJyy8zQlUvsEY5Xo9h7pFY7jlkX+apZleJxqgs0L1WRJJX12GH2F7js55Hj
         UY5CEY2Dk3BMYW2ct6IjiSxOiHEoJOaHSqPjv/fLjWKlwFwG5GIm6+njCA2m9hGp8L3H
         zZmw==
X-Gm-Message-State: AOAM533066jLuN+oFSihQ+eklZJ2p+cZ+uJN+OrjKFcOKPFkQIDNnI5X
        29dK3Q62chI2BA2AmSkvIkT+KBCH
X-Google-Smtp-Source: ABdhPJyjn0byYo2stYdTQACtlYziYfDnIdxff2Yj4lXi5ZTr1gKYLvlmPUDns3/nQfV9HMZVAAJ/bw==
X-Received: by 2002:a17:90b:4398:: with SMTP id in24mr738212pjb.152.1589827486510;
        Mon, 18 May 2020 11:44:46 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id f6sm9489113pfd.175.2020.05.18.11.44.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 11:44:46 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     emaste@freebsd.org, sunshine@sunshineco.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 2/2] t4210: detect REG_ILLSEQ dynamically and skip affected tests
Date:   Mon, 18 May 2020 11:44:16 -0700
Message-Id: <20200518184416.13882-3-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200518184416.13882-1-carenas@gmail.com>
References: <20200515195157.41217-1-carenas@gmail.com>
 <20200518184416.13882-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

7187c7bbb8 (t4210: skip i18n tests that don't work on FreeBSD, 2019-11-27)
adds a REG_ILLSEQ prerequisite, and to do that copies the common branch in
test-lib and expands it to include it in a special case for FreeBSD.

Instead; test for it using a previously added extension to test-tool and
use that, together with a function that identifies when regcomp/regexec
will be called with broken patterns to avoid any test that would otherwise
rely on undefined behaviour.

The description of the first test which wasn't accurate has been corrected,
and the test rearranged for clarity, including a helper function that avoids
overly long lines.

Only the affected engines will have their tests suppressed, also including
"fixed" if the PCRE optimization that uses LIBPCRE2 since b65abcafc7
(grep: use PCRE v2 for optimized fixed-string search, 2019-07-01) is not
available.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t4210-log-i18n.sh | 77 ++++++++++++++++++++++++++++++++++-----------
 t/test-lib.sh       |  6 ----
 2 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index c3792081e6..d2dfcf164e 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -10,6 +10,13 @@ latin1_e=$(printf '\351')
 # invalid UTF-8
 invalid_e=$(printf '\303\50)') # ")" at end to close opening "("
 
+have_reg_illseq=
+if test_have_prereq GETTEXT_LOCALE &&
+	! LC_ALL=$is_IS_locale test-tool regex --silent $latin1_e
+then
+	have_reg_illseq=1
+fi
+
 test_expect_success 'create commits in different encodings' '
 	test_tick &&
 	cat >msg <<-EOF &&
@@ -51,43 +58,77 @@ test_expect_success !MINGW 'log --grep does not find non-reencoded values (utf8)
 	test_must_be_empty actual
 '
 
-test_expect_success !MINGW 'log --grep does not find non-reencoded values (latin1)' '
+test_expect_success 'log --grep does not find non-reencoded values (latin1)' '
 	git log --encoding=ISO-8859-1 --format=%s --grep=$utf8_e >actual &&
 	test_must_be_empty actual
 '
 
+triggers_undefined_behaviour () {
+	local engine=$1
+
+	case $engine in
+	fixed)
+		if test -n "$have_reg_illseq" &&
+			! test_have_prereq LIBPCRE2
+		then
+			return 0
+		fi
+		;;
+	basic|extended)
+		if test -n "$have_reg_illseq"
+		then
+			return 0
+		fi
+		;;
+	esac
+	return 1
+}
+
+mismatched_git_log () {
+	local pattern=$1
+
+	LC_ALL=$is_IS_locale git log --encoding=ISO-8859-1 --format=%s \
+		--grep=$pattern
+}
+
 for engine in fixed basic extended perl
 do
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
+		force_regex='.*'
 	fi
-	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
-		cat >expect <<-\EOF &&
-		latin1
-		utf8
-		EOF
-		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$latin1_e\" >actual &&
-		test_cmp expect actual
-	"
 
-	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
-		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$utf8_e\" >actual &&
-		test_must_be_empty actual
+	test_expect_success $prereq "config grep.patternType=$engine" "
+		git config grep.patternType $engine
 	"
 
-	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
-		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
+	test_expect_success GETTEXT_LOCALE,$prereq "log --grep does not find non-reencoded values (latin1 + locale)" "
+		mismatched_git_log '$force_regex$utf8_e' >actual &&
 		test_must_be_empty actual
 	"
+
+	if ! triggers_undefined_behaviour $engine
+	then
+		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "log --grep searches in log output encoding (latin1 + locale)" "
+			cat >expect <<-\EOF &&
+			latin1
+			utf8
+			EOF
+			mismatched_git_log '$force_regex$latin1_e' >actual &&
+			test_cmp expect actual
+		"
+
+		test_expect_success GETTEXT_LOCALE,$prereq "log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
+			mismatched_git_log '$force_regex$invalid_e' >actual &&
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
2.27.0.rc0.183.gde8f92d652

