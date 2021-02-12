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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E7C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CB364E57
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhBLNbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhBLNbS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2436C061793
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u14so7954797wri.3
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxIDX2t9E6vAJFLQHjAWinm2/AuckMw/I/VnyOJ6sQg=;
        b=Zo5XmrXGzzOJxmyED8q82BxqqcyzdOciA59m57CTF9fh6kFOQh2XodlebcoorSsXkV
         kMNY9Zvpoy31Tzso4lD5/it68aAFtHCj/PBQgkpcr1XgpIqGwkv9qJ5qutLtQjzqg97I
         RJOce97rkyVYkJVq8+XoHtzU4XlDMkzgdGeoKsaixbBv6iwkcPoO0wvUYhyjPyPgjA+O
         jRI7zyKk2K8hBIZ5+8B5KVXsCzHoKMjIjbYc1neaBbiIx29HscSFqbIqG/899pGen1cH
         yCbD1T+V1TFQikEZvpT2gxfFseO0S0ZL1Lm7hOVr1267/hnVgfNjMm31DtRnhvq+2/dw
         RVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxIDX2t9E6vAJFLQHjAWinm2/AuckMw/I/VnyOJ6sQg=;
        b=Ad98flv3K65qp6C4o5xk9utiCa/x3t2kuU05if8OK2OGbZueoO519u1+0v6W0zJTl8
         B58UDrzqdKcJPMA5i0C4VJnqqZNC5qRKKA5+zZbcZuWhGkUDWNWCivxPDA639WkPPM9m
         Wj8VYpiemY2xnJP46qpcNXT6SLxtKgXoWfJJnp4Yr1l32fNshkRsFyk6u7ItpZwXpwHd
         ThWI9xZX4eHoMQyychOuuI+8bcd6h01WBA0nNBVccHFQSbcolR5UK9kuS4J0OF3WWErB
         bSXKYmB4Vwtug+Rs8Em9n41Qb8CM/BIfoGUmY8AD65qSb5RjLx5m1BfUrZcx/zfLzJdv
         Y2BQ==
X-Gm-Message-State: AOAM530DRMZQPfKtaosT68paja1MvMWTTWJtLKScbZSx6nYjGyO+aSYm
        /x00Ppnz84n6Rm0+adgNbRj5Vz/rzzD+sw==
X-Google-Smtp-Source: ABdhPJx7fSQHzANCjKse3Nj0YiJmNJzH3hEzoMpLgB4Nl0gjHeW+2O3qI1z3SGIaHXRpCyvx+o7JeA==
X-Received: by 2002:adf:b350:: with SMTP id k16mr3422286wrd.190.1613136599151;
        Fri, 12 Feb 2021 05:29:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/11] test libs: rename bundle helper to "lib-bundle.sh"
Date:   Fri, 12 Feb 2021 14:29:36 +0100
Message-Id: <20210212132942.17325-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the recently introduced test-bundle-functions.sh to be
consistent with other lib-*.sh files, which is the convention for
these sorts of shared test library functions.

The new test-bundle-functions.sh was introduced in 9901164d81d (test:
add helper functions for git-bundle, 2021-01-11). It was the only
test-*.sh of this nature.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/{test-bundle-functions.sh => lib-bundle.sh} | 0
 t/t5510-fetch.sh                              | 2 +-
 t/t6020-bundle-misc.sh                        | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename t/{test-bundle-functions.sh => lib-bundle.sh} (100%)

diff --git a/t/test-bundle-functions.sh b/t/lib-bundle.sh
similarity index 100%
rename from t/test-bundle-functions.sh
rename to t/lib-bundle.sh
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 42f55030047..c1e0eb39231 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -9,7 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/test-bundle-functions.sh
+. "$TEST_DIRECTORY"/lib-bundle.sh
 
 D=$(pwd)
 
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 6249420a806..da5fe1ba6de 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -9,7 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/test-bundle-functions.sh
+. "$TEST_DIRECTORY"/lib-bundle.sh
 
 # Create a commit or tag and set the variable with the object ID.
 test_commit_setvar () {
-- 
2.30.0.284.gd98b1dd5eaa7

