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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6631EC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379DD64E3E
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhBIXDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbhBIW1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:27:43 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030CBC03C04F
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:20 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 190so77938wmz.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCWOVVEp08Ewsyl41pBxSyLt+lkdxT3pzOJBWGlO9rg=;
        b=V9KUvxIZW0VAQc1VNO9gd3pVdTzj/NH1kfJZev9qtAPjGyvSwfxzHrJHF7fd3ZTJRe
         1Gfbu5h36ojOs2cHhZFl7I6QkLo7NhXGwJU3rY5qLnFk2rK84okYJ/o+43nm/3SBdG0n
         1IN9TE8RunPnhSwTVXoS2Yyw6qSxwja8pnIbQ6UQg1Q/ODoI8tInLxbHh7m295EqdfKJ
         YVskHzBVO4Ev0Dujwr3pooFnlZm5W2J0yLGinFW1KZog8wASFuaAlVz6tt7QljKxFEhe
         vll1A24Xrtg9cY23E+yC5GxrbYlpbY5OZBaf4qbBqk3Y2c5KrmVPZEAUvc3fIH683hlR
         32sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCWOVVEp08Ewsyl41pBxSyLt+lkdxT3pzOJBWGlO9rg=;
        b=BDQCTrWMtMi/p7xoMk3eRd44YhFwnRSYWSFFpA1FpFsfIstw8y8+E3YuUNivo3a5vQ
         8egNCzLOZNmpL/RpLQRPwUs/BARj1ENXbTDmrwxWhKGY4QtcbssQxNQA9JTHFh0ef1FZ
         avBlchL5FYXf/mUR6U2oM2dmB3gNu/4BWR+jFnnSZ2y4ZoNHPpDMau6B8NSRjUS7FOis
         isWeNST8yXl+ZUBwgz4ZyNAXe9dA7IAt32ffy4NdOU2uidxMdQMHjLWZE9kVFiMGcmkA
         qL7jkhyuVRn9FPK/GLkG88R6ZfwxM8pn1fhbmdVaSZds4cT6m99a14jKOq+3le3ad6mS
         YBeA==
X-Gm-Message-State: AOAM532/Tz7wRalyBDVFfD43//r5q2GwFChV53LU8nQyOMWLZE0ZWDjQ
        8P9V2mLAyVyR/nlytOPYcyLHOM4eDsqT3g==
X-Google-Smtp-Source: ABdhPJyDtF7Gc2TLdR7+zQTN2xlS64M8eTBua1FJLOTJP081plqGCmF1lmJNcL6RMv3Z/Nan9JHHGw==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr111831wmc.136.1612906938489;
        Tue, 09 Feb 2021 13:42:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/12] test libs: rename gitweb-lib.sh to lib-gitweb.sh
Date:   Tue,  9 Feb 2021 22:41:53 +0100
Message-Id: <20210209214159.22815-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename gitweb-lib.sh to lib-gitweb.sh for consistency with other test
library files.

When it was introduced in 05526071cb5 (gitweb: split test suite into
library and tests, 2009-08-27) this naming pattern was more
common.

Since then all but one other such library which didn't start with
"lib-*.sh" such as t6000lib.sh has been been renamed, see
e.g. 9d488eb40e2 (Move t6000lib.sh to lib-*, 2010-05-07).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/{gitweb-lib.sh => lib-gitweb.sh}        | 0
 t/t9500-gitweb-standalone-no-errors.sh    | 2 +-
 t/t9501-gitweb-standalone-http-status.sh  | 2 +-
 t/t9502-gitweb-standalone-parse-output.sh | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename t/{gitweb-lib.sh => lib-gitweb.sh} (100%)

diff --git a/t/gitweb-lib.sh b/t/lib-gitweb.sh
similarity index 100%
rename from t/gitweb-lib.sh
rename to t/lib-gitweb.sh
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index ee8c6e30e67..0333065d4d6 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -13,7 +13,7 @@ or warnings to log.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-. ./gitweb-lib.sh
+. ./lib-gitweb.sh
 
 # ----------------------------------------------------------------------
 # no commits (empty, just initialized repository)
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 141610de546..32814e75df5 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -13,7 +13,7 @@ code and message.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-. ./gitweb-lib.sh
+. ./lib-gitweb.sh
 
 #
 # Gitweb only provides the functionality tested by the 'modification times'
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 9cf7ab30a8d..3167473b303 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -13,7 +13,7 @@ in the HTTP header or the actual script output.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-. ./gitweb-lib.sh
+. ./lib-gitweb.sh
 
 # ----------------------------------------------------------------------
 # snapshot file name and prefix
-- 
2.30.0.284.gd98b1dd5eaa7

