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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F387EC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 23:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C646161A1F
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 23:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhCXXgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 19:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhCXXgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 19:36:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE99C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 16:36:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k128so177823wmk.4
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nIzFelBUSJJfXQXWHKurY8fvcdRoLSMehhDC5Z/PJs=;
        b=Mc9XJsNr1hys8LLqCK56Xxemi1bLvwO5+VqSjf2x0KR84JyBfN5k8W7OQfDmo0y0FH
         6Jsf39Rv07ifGaPyiSeg7LNa+S7PKZeatcWUz5F73gKc3EEWVzCdgCePCdtzu+j+2Ng6
         LvxroH3semWYt6Rye1sDfdFjZuVnGCh2geL1JFTA+PRLaSXf7UpSTa67SqDxyijo3Lrd
         XqNrva/AQDezx9JxzqWwTeAeQbuNuXDzGIJtEsT3jY2cOBXdSLFQbaXZJTLr68ICz/Rl
         UvGKqBGLSe23tMH1j1tFlyL9gpPl/ZxuE1UgBW2d0mAjnAKP6cWBOmxk8EzY/0YrgAi5
         9z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nIzFelBUSJJfXQXWHKurY8fvcdRoLSMehhDC5Z/PJs=;
        b=ou914U/H5tO+W+Z8/kxY1sJhQJnyA6g7xzlZCaQ8RqDQW6a5Rk7nmpcDNoLvSG+4Nq
         VKfwGjsmbBwZUnMjwWFQYpe/vHTMXLPe9VO3Zgy8lAH4Y8wkxlCe2mWzFSdrN+714NMY
         pwXZUzRrLx+YxwALifmlJDf37q7PD1YWUMZNlTJCrt0cHQDTUqzXQm6M0VlfUjbaAbqO
         fOaURQEMi1MxwErj7PWZV9L6l9FrymwpKESm5umjGIQCC4O6H8XB66kdX91oUtnQWggl
         +VKdwd40Dvqhe/eCya80xPURHHVl6Zw3Gyn30EanAHEnTjG0N7MSMdyXvwHEIYXBWThf
         eBoA==
X-Gm-Message-State: AOAM5316uxRdUK7P1s8oq0LmeWvnSzMvFIgi6QZWkgQCHHf8bVYo+cjo
        HYtL0g/+GFUUXjH2jBdtgecnyq8Lh7DbUw==
X-Google-Smtp-Source: ABdhPJwgH5nXABbJ6MiL5lGhRHMUCHs/1TKBO6LGBFQV9SDdTReyp0gJLHNW5KLbl5x688Y747aClQ==
X-Received: by 2002:a7b:c1c9:: with SMTP id a9mr4970826wmj.145.1616628973559;
        Wed, 24 Mar 2021 16:36:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j12sm5252002wrx.59.2021.03.24.16.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:36:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] config.c: remove last remnant of GIT_TEST_GETTEXT_POISON
Date:   Thu, 25 Mar 2021 00:36:09 +0100
Message-Id: <patch-1.1-ea968affa8c-20210324T233254Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.354.gc8cbd507b5a
In-Reply-To: <20210111144740.6092-3-avarab@gmail.com>
References: <20210111144740.6092-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a use of GIT_TEST_GETTEXT_POISON added in f276e2a4694 (config:
improve error message for boolean config, 2021-02-11).

This was simultaneously in-flight with my d162b25f956 (tests: remove
support for GIT_TEST_GETTEXT_POISON, 2021-01-20) which removed the
rest of the GIT_TEST_GETTEXT_POISON code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

At this point I'm going to call it a win if I'm not submitting a patch
in 2022 to remove some more stray GETTEXT_POISON ... :)

 config.c          | 16 +---------------
 t/t1300-config.sh |  2 +-
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/config.c b/config.c
index 6428393a414..870d9534def 100644
--- a/config.c
+++ b/config.c
@@ -1180,20 +1180,6 @@ static void die_bad_number(const char *name, const char *value)
 	}
 }
 
-NORETURN
-static void die_bad_bool(const char *name, const char *value)
-{
-	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
-		/*
-		 * We explicitly *don't* use _() here since it would
-		 * cause an infinite loop with _() needing to call
-		 * use_gettext_poison().
-		 */
-		die("bad boolean config value '%s' for '%s'", value, name);
-	else
-		die(_("bad boolean config value '%s' for '%s'"), value, name);
-}
-
 int git_config_int(const char *name, const char *value)
 {
 	int ret;
@@ -1268,7 +1254,7 @@ int git_config_bool(const char *name, const char *value)
 {
 	int v = git_parse_maybe_bool(value);
 	if (v < 0)
-		die_bad_bool(name, value);
+		die(_("bad boolean config value '%s' for '%s'"), value, name);
 	return v;
 }
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e0dd5d65ced..2280c2504ac 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -679,7 +679,7 @@ test_expect_success 'invalid unit boolean' '
 	git config commit.gpgsign "1true" &&
 	test_cmp_config 1true commit.gpgsign &&
 	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
-	test_i18ngrep "bad boolean config value .1true. for .commit.gpgsign." actual
+	grep "bad boolean config value .1true. for .commit.gpgsign." actual
 '
 
 test_expect_success 'line number is reported correctly' '
-- 
2.31.0.354.gc8cbd507b5a

