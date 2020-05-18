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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D520C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2190207C4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsxMQz8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgERSoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgERSop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:44:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7AEC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:44:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so5254452pgn.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B2xTcJ7kZjMR8tCi1fCL7gZCKgQXtIY1yuhw+1xyBFE=;
        b=qsxMQz8IT+NCpqVwC+4heSveIWd2zOGMR7VUC4GoYlL9xYNddhtHAQrcJBwfuYBaWL
         p+S1UZUmPv6aLqGoE/7519JcybSqXdnWqycnzjnelMRcQUkNGdbEas0GTDyifQ724gpY
         aov8nMpiRyu86cAJ6zOpnPuyNwL/ycxtX03dNk2q1I//oXVVoHeQTKOgpvPOhNrUDW9B
         GeZR/dlXnpImMca4V+pZ9EdagWsivgUvXZEoPKRNEKGJx5jFWj+Lho+pM3LIqqfB69H9
         pSMF9PNsD5wU537+rrpSVoPGXudMPDNRhKjzPzhWvU2B1dsX62WNpeaqe8EC6IhUq4+/
         0fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B2xTcJ7kZjMR8tCi1fCL7gZCKgQXtIY1yuhw+1xyBFE=;
        b=RKipnkUuNk24ePnnItxCViYj0fofBzRQY9uDij4plKil5IgBAUolNDu4ZNlilpvnC7
         DvwoQPMvw5SA/sm2d6nbd+dUGAqT1AR4uiIh8TjvntdIanxXZOMaiU6f90ty1nMi0q7v
         CcCFu6dgdzY3zf4xlzH81M1/E4X2C4yQX6QpFd05SJ6zRO4RDIRE9SvK7XwS3dLIqhyp
         3/2ImIpeXieAYe2tlJx9kWMJnylJmDRvsNEct4Pm+Ydsh7BFRrCWl3MewOt017Yj1CB/
         3JLL+8PAlV9E+L52iEZ6H0AcI1a8Ix4H1bB0wA8JdI0HzitGHeNMTBGhS2UwLMggXnEr
         wxxA==
X-Gm-Message-State: AOAM532bCD7BH5Kb6pTGa1aOP7CXaSR3xHd8cvmkXunKkExHO6h++flK
        Qz4yzcLu+07oaaRfqpy/mMZJOAOZ
X-Google-Smtp-Source: ABdhPJwtj672ioHDD0qzHTm+x/YmvalM0dO8vKMWBFgZcgPwW/iFQYp0svYqtxcR1CWd9tKl2qnAow==
X-Received: by 2002:a65:5781:: with SMTP id b1mr15390966pgr.388.1589827484666;
        Mon, 18 May 2020 11:44:44 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id f6sm9489113pfd.175.2020.05.18.11.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 11:44:44 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     emaste@freebsd.org, sunshine@sunshineco.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 1/2] t/helper: teach test-regex to report pattern errors (like REG_ILLSEQ)
Date:   Mon, 18 May 2020 11:44:15 -0700
Message-Id: <20200518184416.13882-2-carenas@gmail.com>
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
adds a REG_ILLSEQ prerequisite to avoid failures from the tests added in
4e2443b181 (log tests: test regex backends in "--encode=<enc>" tests,
2019-06-28), but hardcodes it to be only enabled in FreeBSD.

Instead of hardcoding the affected platform, teach the test-regex helper,
how to validate a pattern and report back, so it can be used to detect the
same issue in other affected systems (like DragonFlyBSD or macOS).

While at it, refactor the tool so it can report back the source of the
errors it founds, and can be invoked also in a --silent mode, when needed,
for backward compatibility.  A missing flag has been added and the code
reformatted, as well as updates to the way the parameters are handled, for
consistency.

To minimize changes, it is assumed the regcomp error is of the right type
since we control the only caller, and is also assumed to affect both basic
and extended syntax (only basic is tested, but both behave the same in all
three affected platforms since they use the same function).

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/helper/test-regex.c | 94 ++++++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 28 deletions(-)

diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index 10284cc56f..d6f28ca8d1 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "git-compat-util.h"
 #include "gettext.h"
 
 struct reg_flag {
@@ -8,12 +7,13 @@ struct reg_flag {
 };
 
 static struct reg_flag reg_flags[] = {
-	{ "EXTENDED",	 REG_EXTENDED	},
-	{ "NEWLINE",	 REG_NEWLINE	},
-	{ "ICASE",	 REG_ICASE	},
-	{ "NOTBOL",	 REG_NOTBOL	},
+	{ "EXTENDED",	REG_EXTENDED	},
+	{ "NEWLINE",	REG_NEWLINE	},
+	{ "ICASE",	REG_ICASE	},
+	{ "NOTBOL",	REG_NOTBOL	},
+	{ "NOTEOL",	REG_NOTEOL	},
 #ifdef REG_STARTEND
-	{ "STARTEND",	 REG_STARTEND	},
+	{ "STARTEND",	REG_STARTEND	},
 #endif
 	{ NULL, 0 }
 };
@@ -41,36 +41,74 @@ int cmd__regex(int argc, const char **argv)
 {
 	const char *pat;
 	const char *str;
-	int flags = 0;
+	int ret, silent = 0, flags = 0;
 	regex_t r;
 	regmatch_t m[1];
-
-	if (argc == 2 && !strcmp(argv[1], "--bug"))
-		return test_regex_bug();
-	else if (argc < 3)
-		usage("test-tool regex --bug\n"
-		      "test-tool regex <pattern> <string> [<options>]");
+	char errbuf[64];
 
 	argv++;
-	pat = *argv++;
-	str = *argv++;
-	while (*argv) {
-		struct reg_flag *rf;
-		for (rf = reg_flags; rf->name; rf++)
-			if (!strcmp(*argv, rf->name)) {
-				flags |= rf->flag;
-				break;
-			}
-		if (!rf->name)
-			die("do not recognize %s", *argv);
+	argc--;
+
+	if (!argc)
+		goto usage;
+
+	if (!strcmp(*argv, "--bug")) {
+		if (argc == 1)
+			return test_regex_bug();
+		else
+			goto usage;
+	}
+	if (!strcmp(*argv, "--silent")) {
+		silent = 1;
 		argv++;
+		argc--;
+	}
+	if (!argc)
+		goto usage;
+
+	pat = *argv++;
+	if (argc == 1)
+		str = NULL;
+	else {
+		str = *argv++;
+		while (*argv) {
+			struct reg_flag *rf;
+			for (rf = reg_flags; rf->name; rf++)
+				if (!strcmp(*argv, rf->name)) {
+					flags |= rf->flag;
+					break;
+				}
+			if (!rf->name)
+				die("do not recognize flag %s", *argv);
+			argv++;
+		}
 	}
 	git_setup_gettext();
 
-	if (regcomp(&r, pat, flags))
-		die("failed regcomp() for pattern '%s'", pat);
-	if (regexec(&r, str, 1, m, 0))
-		return 1;
+	ret = regcomp(&r, pat, flags);
+	if (ret) {
+		if (silent)
+			return ret;
+
+		regerror(ret, &r, errbuf, sizeof(errbuf));
+		die("failed regcomp() for pattern '%s' (%s)", pat, errbuf);
+	}
+	if (!str)
+		return 0;
+
+	ret = regexec(&r, str, 1, m, 0);
+	if (ret) {
+		if (silent || ret == REG_NOMATCH)
+			return ret;
+
+		regerror(ret, &r, errbuf, sizeof(errbuf));
+		die("failed regexec() for subject '%s' (%s)", str, errbuf);
+	}
 
 	return 0;
+usage:
+	usage("\ttest-tool regex --bug\n"
+	      "\ttest-tool regex [--silent] <pattern>\n"
+	      "\ttest-tool regex [--silent] <pattern> <string> [<options>]");
+	return -1;
 }
-- 
2.27.0.rc0.183.gde8f92d652

