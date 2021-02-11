Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6ADC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CE064E56
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBKTtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhBKTsf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:35 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E5C0613D6
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:35 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r38so4626996pgk.13
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2cKequipcTVvNC8X9O6rKP+MGRBOoScdRpmzBk0xiAg=;
        b=pev0LCrXzbZl4ZB4GdYApP2AMbjgh7+iql2pzeKDRXDAVsGroF7NdUPDUwLIdpPmZb
         6iF6km5X0EpKxSJGO0mYRjbu5jV0pSbi+CzGmN8EOTnfBFkCf6ipU7/EDwB4HK/oBwRs
         971YiZcwsWXsp8taBXzFes3iaoFBM+W+E0Sn8h1xaDuT+pcn068abSza94KgOwCWLeQW
         Ngk+Gk/40E5ztdLHFg+TktX1OKTeVic7M+3LYGeeIC30Dvu1j6ZwBs/MA9YiyqJo8fRW
         m1jJzg2wvAjYeJ6mdD0EmKeKXsr0nax63Ek8HmUbxXfhlvHiNgDzm0aBvpbJngoi7sMt
         dJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cKequipcTVvNC8X9O6rKP+MGRBOoScdRpmzBk0xiAg=;
        b=K9BIof9+vY4MJMEdUGW+dm/MuqFg+7hkQ6JN5pzoYXIdoBntV+noFvGdor2HP58XXT
         7q4+4u9xOnNrfuLkQi/R0T3PhXrOLfzJsMsGoMqA2bBJu4FmiFt/9uOfuE6a7DPoVBB9
         pqRFsn2WYZk1tDrqrT8h7AkiZhBrOz7sVrNghRLAi7jsV1vzusxsvxFUK/72VvmRMXYQ
         wADzb98OuYyQkGzRnQ27OFcQtq6cRnLrk17hAWiIJ14r5iMNKB+OaS75X5gZrTzbO017
         EYZpBbKjzgDmKDZDCth0ZwX2rQT/zLgQ6JPcEAmadDQLk/a6lKYZZuKENp5rXv4laeDP
         loWg==
X-Gm-Message-State: AOAM532jfjOQYl/dKekqGqUxiZ4R901POJwc4HQ+SZyB+eGErYTLfDtq
        t3vnHGn6yuevZ+p8GqHOByfi9Xm3Xv/Ahg==
X-Google-Smtp-Source: ABdhPJyv/S+e0YZ4LCLfTCwmYVfkRbiGe+MPErSIxT9vwkfEEPNNVSRTe/qGf8vCCLWQy7bxsTYgQw==
X-Received: by 2002:a63:2009:: with SMTP id g9mr9464190pgg.219.1613072854731;
        Thu, 11 Feb 2021 11:47:34 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:34 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 10/10] t7001: use `test` rather than `[`
Date:   Fri, 12 Feb 2021 01:17:04 +0530
Message-Id: <20210211194704.28913-11-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, we should use "test"
rather than "[ ... ]" in shell scripts, so let's replace the
"[ ... ]" with "test" in the t7001 test script.

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 36a274e96d..65807e4873 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -242,10 +242,10 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 	git add dirty &&
 	entry="$(git ls-files --stage dirty | cut -f 1)" &&
 	git mv dirty dirty2 &&
-	[ "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" &&
 	echo 2 >dirty2 &&
 	git mv dirty2 dirty &&
-	[ "$entry" = "$(git ls-files --stage dirty | cut -f 1)" ]
+	test "$entry" = "$(git ls-files --stage dirty | cut -f 1)"
 '
 
 rm -f dirty dirty2
@@ -332,7 +332,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	mkdir mod &&
 	git mv sub mod/sub &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -352,7 +352,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	mkdir mod &&
 	git mv sub mod/sub &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
@@ -369,7 +369,7 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	mkdir mod &&
 	git -C mod mv ../sub/ . &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
@@ -388,7 +388,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -409,7 +409,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -427,7 +427,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	git mv sub mod/sub 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
-- 
2.25.1

