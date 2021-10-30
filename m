Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC11AC4332F
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF02E60F38
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhJ3W1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhJ3W1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B6DC061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 71so8469462wma.4
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPnosbg/F6snHQYMJHWrZMdr0iR6kMAR25K63GDZnVM=;
        b=fXg+BzLHyXCONtq7OsVG0r61ydmBVzl6qB9DdPrR/3Sd4mCiN5gtqHTVj7xcO6vOkc
         BHvbz8N7AGRMSVeYYtMU5J+fOB9Ln3+iaYzJABZauaEhF29eH0NyRDp/okat1XxZ78Aq
         IMEE6ju/RFpSbCZ3o6z6b5IcqXYvnEE3GGQ34ESraPM3vcg7FFN08dzmCgf/aM0pabia
         dH2mfyaZ53l6x09tq6MGNo4tvBr2SeJoenkVfGmXlueE+nKDpVSreqX3oyQM4Lfx+TLc
         YsTkZPB5vraRKqjklDsRhLzLmdcAPWubysIWnZgRx5H6sLC18/DSYG5KkrxiMGht+JsI
         YyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPnosbg/F6snHQYMJHWrZMdr0iR6kMAR25K63GDZnVM=;
        b=JJYd51Fzk3dPHA/Q0M5ecZALWq0avUFd7HUji18EzBukwrhxypyCIksmUBkjKTIW/a
         cp9qzZgHJzOjWY14nx8cMOr4Z6z6U0YHiZ89K8pJALJ3L6BjoshzzonGXvTPsSZrcN2o
         sDGoQSinMN32oZIBv1A0ilxCLgydW5UnoXXJn8MbSCqu2uDP58V9D9Nrs6W5LOLvQAfJ
         Y3JA268w2+BpBgyCoXNUlJm3ZMfViVtnzPSFNJW65hyn5Grg3iQPZA9qaiEPyLEoiTij
         e9VpXYgB9geRUL5ZPzFafH8dRskQP9ZyoXFC0ttNLwFgTjSSxEHIRnWuvuu4n/H6S7vz
         L2QQ==
X-Gm-Message-State: AOAM532+AkOg110ZdjDxUXT1boC3sbCTG3AzMKjPBKjJxYtGAwk/kmPL
        UGs3W9ISPJmft76Yx6Aq04JCPDq7hAsGVQ==
X-Google-Smtp-Source: ABdhPJz0d/lmR40mkLt4vG3AEFCumZVSteqqit9lT7xCIQvBH16bxNqUcoVCBWCLi+X7mvF+hiQrbg==
X-Received: by 2002:a1c:a904:: with SMTP id s4mr13156760wme.163.1635632669887;
        Sat, 30 Oct 2021 15:24:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/15] leak tests: mark most gettext tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:12 +0200
Message-Id: <patch-03.15-414894345ff-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark all but one tests that match "*gettext*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

In the case of "t0202-gettext-perl.sh" this isn't very meaningful as
most of the work is on the Perl side, but let's mark it anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0200-gettext-basic.sh           | 1 +
 t/t0201-gettext-fallbacks.sh       | 1 +
 t/t0202-gettext-perl.sh            | 1 +
 t/t0204-gettext-reencode-sanity.sh | 1 +
 4 files changed, 4 insertions(+)

diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8853d8afb92..522fb2ae696 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -5,6 +5,7 @@
 
 test_description='Gettext support for Git'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index 6c74df0dc67..8724ce1052d 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -8,6 +8,7 @@ test_description='Gettext Shell fallbacks'
 GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=YesPlease
 export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
index a29d166e007..df2ea34932b 100755
--- a/t/t0202-gettext-perl.sh
+++ b/t/t0202-gettext-perl.sh
@@ -5,6 +5,7 @@
 
 test_description='Perl gettext interface (Git::I18N)'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 if ! test_have_prereq PERL; then
diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reencode-sanity.sh
index 8437e51eb54..4f2e0dcb02b 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -5,6 +5,7 @@
 
 test_description="Gettext reencoding of our *.po/*.mo files works"
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 # The constants used in a tricky observation for undefined behaviour
-- 
2.33.1.1570.g069344fdd45

