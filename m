Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C72C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB87C61107
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhDHN0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhDHN0R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:26:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F5FC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:26:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g17so1650952edm.6
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+Id//WiCs3/ku71LLjKJ6vRNoJECrVZT8azRJyUIHs=;
        b=UB/yGRSVGs+AfG28jtTEs34uVyQaniC5ZAhD1iW17eiReP9cA9QeM8TsVG1qg08Ue1
         By4TZoHonAR7vepNqcbnnq7LYDKaVV6QyxdYAIfziXpN5IODMaUhJFIdH5P2PSbbK6vZ
         0EOp6a7D0+Ft7iCUkzw2D/3ds3YfmRvb69ECbyVGS0YaA1U95h2jvIoLaeTCeWhqM+Jb
         05kuCS9rle0I4MT9UFcPND1uTut+qqQNx+9jRIX0Ywxbx6cmrpp+rM6SSQk1wjVMxy2S
         QdHn/72w1UkS6H+/8gqk9bsEpTKRxJ/zr0mhlY4LF18X7d6RutmCpYVy3uJQWTI9XZch
         z4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+Id//WiCs3/ku71LLjKJ6vRNoJECrVZT8azRJyUIHs=;
        b=EdSxFjpq6sNTmwq6G8UB2y2J+zwd++kLOk/VtYFEqbSD4QU9MSPkufGhD814wVCYMI
         8bg4fK2WP1LfhjVopQk2FMFGB4C3/LvvyootsuRczEE8Afg4IqkPieIDxqwnZKEyJi01
         gdicYWapnP1vmFEB6JgRYqZVgqgV98SOfwpco/GluSpOOqBiZbzG+xef2shWj8xJ7dTO
         yLhbWK7UNdmNTJJx0KtmJBDiYB+NacG5yLRudTX2sfvbfjSpSmJBdd8n2LAGVO7r1pL9
         X0qIXziJMCwxsOU7nzLxuPzQOjNu5BQKVETcaqmfoC5FR6/CILYeLgtdFUtdeWKC3Cf4
         5WYQ==
X-Gm-Message-State: AOAM530vfY+M54T2ozBHu37JRtzJosSOgg+XvXZf8mDeKmc/CHgNQYQG
        6Cm7UBK/0PBeQ2hXlg8n5dxxlopoL7+/WQ==
X-Google-Smtp-Source: ABdhPJyrSxapj1zflcrU4WDrR7rT1tfMbrHlV8VPSIo6cgg6Wlnre2kDmqw2CzR3Izo51GkgGA+h5Q==
X-Received: by 2002:a05:6402:484:: with SMTP id k4mr11269145edv.321.1617888363928;
        Thu, 08 Apr 2021 06:26:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u13sm8982865ejr.100.2021.04.08.06.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:26:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] config.c: remove last remnant of GIT_TEST_GETTEXT_POISON
Date:   Thu,  8 Apr 2021 15:25:55 +0200
Message-Id: <patch-1.1-2b2ac8471f-20210408T132357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <patch-1.1-ea968affa8c-20210324T233254Z-avarab@gmail.com>
References: <patch-1.1-ea968affa8c-20210324T233254Z-avarab@gmail.com>
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

This trivial cleanup now without the objectionable and needless change
to the tests.

Range-diff:
1:  ea968affa8 ! 1:  2b2ac8471f config.c: remove last remnant of GIT_TEST_GETTEXT_POISON
    @@ config.c: int git_config_bool(const char *name, const char *value)
      	return v;
      }
      
    -
    - ## t/t1300-config.sh ##
    -@@ t/t1300-config.sh: test_expect_success 'invalid unit boolean' '
    - 	git config commit.gpgsign "1true" &&
    - 	test_cmp_config 1true commit.gpgsign &&
    - 	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
    --	test_i18ngrep "bad boolean config value .1true. for .commit.gpgsign." actual
    -+	grep "bad boolean config value .1true. for .commit.gpgsign." actual
    - '
    - 
    - test_expect_success 'line number is reported correctly' '

 config.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/config.c b/config.c
index 6428393a41..870d9534de 100644
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
 
-- 
2.31.1.527.g9b8f7de2547

