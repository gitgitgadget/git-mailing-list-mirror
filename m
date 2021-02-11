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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3CCC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC364DBD
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBKB7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 20:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhBKB43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 20:56:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A6C061756
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o15so1774041wmq.5
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rq2oXo4eRvpdMRF2skzampiTNg3YlTh8drCZjRjARqI=;
        b=MB7m41KJ8U4/DqSG3Sevm5025HWvvuzhGCsRZivEaDlairfeCOAe6QJPzEwMU+MI+O
         1lK4oS43yRmCqgYE0vO9UOa4Am0nb7M4LNdO++1pOaq2CkEK3I4ZF79/SQUwQ1fvqqzs
         qp5kN114g14JGjKAuNALkuqZXbG52zoX4g+5WCPwgVsEHJ9dEkWU3jnZMeKjP1WdP/Qf
         bF5Iik/yiy1U1LBgF9yUbeoXodI20ckCyM1wUBMiTui7imTz2bjzC71SBoPWtiV21w2F
         abIEAiMSD+tGjVchedUnPuuip76w2vKaJJwML9WCdHNxAGfhpialVyKifad8C7fMVebi
         mpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rq2oXo4eRvpdMRF2skzampiTNg3YlTh8drCZjRjARqI=;
        b=LzHpXbmSIuV9xNnjTMqPXg6FjuVK/djprWtVWlSI54CfEoqd6K7c21Qv6Jk0Vn8S3R
         kmIr4oVL95s/15pMqQ6AnOy24gqbDNf3CIfACmNGpH51nHh0L4AwjoWiVW9q8o80iHZn
         8QzvGQVkAsMIpbOb+qAl47wQDxWSA9DQEQezf28AlaW+UMrS0UxUYNFBesGcna20e52i
         TPWhGxfFbFAejBbP0IjGvsSuo09wtiuznaMcOMeqrqDZ1YymsX9xL2G/v0ueDe2MBKNK
         Yg3g2611OdfJgUz4IdA2fS1RCXjLJC5WudWHAg0JruGOvnP1iHKSB4fBCa8G7yupIJ+a
         aOlg==
X-Gm-Message-State: AOAM530vE8uFm17eTeIvuU0xvR4EJyMuPx6K7zQ5eDRQY4B7VrTk9KLE
        6idQXhzmnyZ+od/uV4DhYjLPSyAXYBed4g==
X-Google-Smtp-Source: ABdhPJzYTNCc8IBoelnmc9WlBiG+UF0dBSIpOXhxxhGy8BcBhWm7EuGXnWAvT0Wt3CW47pV+qIAunQ==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr2214010wmk.41.1613008450272;
        Wed, 10 Feb 2021 17:54:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2sm5362486wml.34.2021.02.10.17.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 17:54:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] tests: remove last uses of C_LOCALE_OUTPUT
Date:   Thu, 11 Feb 2021 02:53:52 +0100
Message-Id: <20210211015353.28680-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210120182759.31102-1-avarab@gmail.com>
References: <20210120182759.31102-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the last uses of the C_LOCALE_OUTPUT prerequisite as well as
the prerequisite itself. This is a follow-up to d162b25f956 (tests:
remove support for GIT_TEST_GETTEXT_POISON, 2021-01-20), as well as
the preceding commit where we removed the simpler uses of
C_LOCALE_OUTPUT.

Here I'm slightly refactoring a test added in 21e5ad50fc5 (safecrlf:
Add mechanism to warn about irreversible crlf conversions,
2008-02-06), as well as getting rid of another "test_have_prereq
C_LOCALE_OUTPUT" use.

I'm not leaving the prerequisite itself in place for in-flight changes
as there currently are none that introduce new tests that rely on it,
and because C_LOCALE_OUTPUT is currently a noop on the master branch
we likely won't have any new submissions that use it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0020-crlf.sh             | 6 ++----
 t/t9003-help-autocorrect.sh | 7 ++-----
 t/test-lib.sh               | 5 -----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 375cf943985..f25ae8b5e1f 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -87,10 +87,8 @@ test_expect_success 'safecrlf: print warning only once' '
 	git commit -m "nowarn" &&
 	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >doublewarn &&
 	git add doublewarn 2>err &&
-	if test_have_prereq C_LOCALE_OUTPUT
-	then
-		test $(grep "CRLF will be replaced by LF" err | wc -l) = 1
-	fi
+	grep "CRLF will be replaced by LF" err >err.warnings &&
+	test_line_count = 1 err.warnings
 '
 
 
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 03cd5c54236..f00deaf3815 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -56,11 +56,8 @@ test_expect_success 'autocorrect can be declined altogether' '
 	git config help.autocorrect never &&
 
 	test_must_fail git lfg 2>actual &&
-	if test_have_prereq C_LOCALE_OUTPUT
-	then
-		grep "is not a git command" actual &&
-		test_line_count = 1 actual
-	fi
+	grep "is not a git command" actual &&
+	test_line_count = 1 actual
 '
 
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 431adba0fb3..6d188a8075d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1519,11 +1519,6 @@ test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
-# Used to be used for GIT_TEST_GETTEXT_POISON=false. Only here as a
-# shim for other in-flight changes. Should not be used and will be
-# removed soon.
-test_set_prereq C_LOCALE_OUTPUT
-
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
 	GIT_TEST_CHECK_CACHE_TREE=true
-- 
2.30.0.284.gd98b1dd5eaa7

