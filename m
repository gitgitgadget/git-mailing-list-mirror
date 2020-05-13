Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB98CA90AF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 11:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D55206E5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 11:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwm0iCzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgEMLRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 07:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgEMLRF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 07:17:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5FDC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 04:17:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y25so7866411pfn.5
        for <git@vger.kernel.org>; Wed, 13 May 2020 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jodG+eB/zd8rPc9uMbuS1/UZF4fl8+srTT16lvo3Pd4=;
        b=Cwm0iCzk3KXZCYRDGmwpdiU0BfnRbWmb55i5v9c6PXlQ1wPdq3qi2+RJhfrIaRDTwl
         P23xyR/mJ739w3NJex0mf17vBetWgyuPx0x1gOahIcKvltVYqURghXKzZaaknwjGHNeg
         ifAzLxjtHYwcdY2p+I49JP/m76pIcz2JGWrGQ8cdk1GXEjs5FQogFh3Qf7PxGvlOMshN
         deb7rdYcc+If+5bxSRtd+9l6JH1xXHwn2v7R3Bv8B/W6GJ2Boc39P6B6qLsK2sq0/SiF
         OhAQfZ/T3O8BfkyQI1/DTp7qUnXVJxVuHaI3f8es/Lr6RR4opWoRW9AgW29Zv6dwUY2i
         FHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jodG+eB/zd8rPc9uMbuS1/UZF4fl8+srTT16lvo3Pd4=;
        b=WdurLDqOAFMFc6nFjV6oVz6P1JDW+YX7NJSM5WgKXIviJ6xQYIKfrt3m8y48mj6EOi
         OuIL0FbYW74c0M0cImd26p03DN+F7mWTWvcdiqAixpAE/ftibnMjpAvgab0RLnfXu8qE
         QiA7o5anuW5qLJh7ZKkluadLspb5ZLoH+2tLR6f2NlkftVerCDvgw7vUEbzwj9AAun8z
         OQf2zQU8eJV5LSlZ8l7st+YnyavLdeqL888+9ltlrB5T26ZReB31R960+JWku/1BZM1v
         nlg3+cOgz6Ph/NLk9N9hI7gJoHwjCAvXaELWz8rJ9SsIroJ1jDz7kghXOsH9eDWrAcY6
         3Yhw==
X-Gm-Message-State: AOAM532lc9U7y8OD8KdWnjBvZe5MTM4A0btxa0aJuWimC5q+PSPAJj7p
        0XFAGj6jz3cLrlmaRIDL47JVbd/c
X-Google-Smtp-Source: ABdhPJy1Sy7XNXnou7y1qIHouDbQ40rryoHFNOCEyFSyEeNXoGPUthtccA2penQ5BsiMyjbZj3twgg==
X-Received: by 2002:a63:e148:: with SMTP id h8mr14279704pgk.313.1589368623399;
        Wed, 13 May 2020 04:17:03 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 14sm15501549pjd.36.2020.05.13.04.17.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 04:17:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     emaste@freebsd.org,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] t4210: detect REG_ILLSEQ dynamically
Date:   Wed, 13 May 2020 04:16:36 -0700
Message-Id: <20200513111636.30818-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.737.gf3227dd3d3
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

To minimize changes, it is assumed the compilation error is because of the
right type since we control the only caller, and is also assumed to affect
both basic and extended syntax (only extended is tested).  The description
of the first test which wasn't accurate has been also corrected, and the
suppressed tests restricted to the two affected engines only.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/helper/test-regex.c | 21 +++++++++++++++++----
 t/t4210-log-i18n.sh   | 24 ++++++++++++++++--------
 t/test-lib.sh         |  6 ------
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index 10284cc56f..985fcb0f75 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -41,16 +41,21 @@ int cmd__regex(int argc, const char **argv)
 {
 	const char *pat;
 	const char *str;
-	int flags = 0;
+	int ret, opt_s = 0, flags = 0;
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
+		opt_s++;
+		argv++;
+	}
 	argv++;
 	pat = *argv++;
 	str = *argv++;
@@ -67,8 +72,16 @@ int cmd__regex(int argc, const char **argv)
 	}
 	git_setup_gettext();
 
-	if (regcomp(&r, pat, flags))
-		die("failed regcomp() for pattern '%s'", pat);
+	ret = regcomp(&r, pat, flags);
+	if (ret) {
+		if (opt_s)
+			return 1;
+		else {
+			regerror(ret, &r, errbuf, sizeof(errbuf));
+			die("failed regcomp() for pattern '%s' (%s)",
+				pat, errbuf);
+		}
+	}
 	if (regexec(&r, str, 1, m, 0))
 		return 1;
 
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index c3792081e6..24b9e7e72b 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -56,21 +56,29 @@ test_expect_success !MINGW 'log --grep does not find non-reencoded values (latin
 	test_must_be_empty actual
 '
 
+test_have_prereq GETTEXT_LOCALE &&
+! LC_ALL=$is_IS_locale test-tool regex --silent $latin1_e $latin1_e EXTENDED &&
+test_set_prereq REGEX_ILLSEQ
+
 for engine in fixed basic extended perl
 do
+	ireq=
 	prereq=
-	if test $engine = "perl"
-	then
-		prereq="PCRE"
-	else
-		prereq=""
-	fi
+	case $engine in
+	basic|extended)
+		ireq=!REGEX_ILLSEQ,
+		;;
+	perl)
+		prereq=PCRE
+		;;
+	esac
 	force_regex=
 	if test $engine != "fixed"
 	then
 	    force_regex=.*
 	fi
-	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
+
+	test_expect_success !MINGW,GETTEXT_LOCALE,$ireq$prereq "-c grep.patternType=$engine log --grep searches in log output encoding (latin1 + locale)" "
 		cat >expect <<-\EOF &&
 		latin1
 		utf8
@@ -84,7 +92,7 @@ do
 		test_must_be_empty actual
 	"
 
-	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
+	test_expect_success !MINGW,GETTEXT_LOCALE,$ireq$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
 		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
 		test_must_be_empty actual
 	"
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
2.26.2.737.gf3227dd3d3

