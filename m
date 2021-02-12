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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB56C433DB
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB9764E6B
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhBLNbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhBLNbT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:19 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DEC061794
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g10so7962079wrx.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCWOVVEp08Ewsyl41pBxSyLt+lkdxT3pzOJBWGlO9rg=;
        b=jiLV0eL89Vqth0TZIIc8Ri/X6x1GWtXkBxAiXvv/t4DksEylbseGwVFnmglgV/VfC3
         GU4UfrBdE1BQe47XXxglqNELJGKL3NvnT36ONa4FFkQonFHCplFQyDS9A1Rsm5087Urv
         zBbn7zkC7rB7ry7V/ZaRZWti7gIAtI7feg197RMU56doMQy631SgcTK93+fyVCXzj7ob
         kTIC+/YRYR39yFU78+8p9FgsBGjoUqL9GPKMbi3MNNdxn+t4tKrB+o6WkYIH5I5DKOw8
         51FDt8blGaAn4cJ2qnHmqmV7eK0/LP0jCGDkM+z0v2wzIU7mmkySY5UnyBotsAdzA7H6
         b1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCWOVVEp08Ewsyl41pBxSyLt+lkdxT3pzOJBWGlO9rg=;
        b=RoLXl8O37pq+dbcV3BT3HXfMz81Z2ykDA9CxHk3d7NF1a3jXC+6A3/eiPYORBlC3Cv
         mXCfKajYPdpapR9gSX/NQYoOSdfdyagN/L3tk2M5eznB7i8lGtkh8fSr0yDFx/i52mOz
         t4oARTXC2RVxiI30dhGWIXBMZWLQeVOpV5Xwq5zaloEI40Z7uQ4e4GQUGE/gPxZSEyIh
         eTDA4t7oIIA3zStOEAYA2xILjWOvmlu2kST6vJOol2YWgXAg6H5cxSxLRuagjE9xjBl3
         jZLf3GGi3WRzxYm4o+b8qqaRQ5W4NQYy5QmJvguwkozg+74tLvSCGa31fcqKVWI+whUI
         xD9w==
X-Gm-Message-State: AOAM533BKu9pV3I2P8UEwDQrMmFPpnsAqg0PdULoBTWzmHkv4uCJ3oD1
        AtgpiXTn+IkUDJafiLt+xSK8x5Bm3j114g==
X-Google-Smtp-Source: ABdhPJzTJpG9aLUjIcm9GFezmZx6EvK29QUlzIEMfewNIl0gatcd5Q1mhIYzlf1wP51L0pepnHPZwA==
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr3465021wrs.224.1613136599983;
        Fri, 12 Feb 2021 05:29:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/11] test libs: rename gitweb-lib.sh to lib-gitweb.sh
Date:   Fri, 12 Feb 2021 14:29:37 +0100
Message-Id: <20210212132942.17325-7-avarab@gmail.com>
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

