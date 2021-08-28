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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83598C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58ED860EE4
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 12:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhH1MOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbhH1MOY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 08:14:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59830C061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 05:13:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g18so7158678wrc.11
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtFpnCqMy3qARFYHHA6bJsFhQA/4Tzf7VLboqbaRWYQ=;
        b=u1qhfXTixykuFNJ+5V7phfxsJVAQFMihlsk1Vp5NYwaQHfgqOUwG3NlqorPQ4tOTW5
         wALDNnHHtJrTr/HCOfyE/QIQ6hwu/kByyDOz70PH9KrxYeUilZ8MtCipX/c6mLkAB3L8
         Z0NBaT8wfDGJFstly6t+EmZbISDZJR1+1eZpKGpWCvpE5kO1kY6lrP7w+VRCCDO4rer0
         7b3ZoqqVnIr+iSmeIjIXEfbER7zu3+ksyEdVi5YIMnd9m58YNPEhf1wP4+rAXhxkWU3m
         VcZowqtZ4IdIhVWsxlXUvHqKKnmQXfMkgUikJjiSvyQ9LZGeBEOPPfsloE2U2q5IMX2+
         jbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TtFpnCqMy3qARFYHHA6bJsFhQA/4Tzf7VLboqbaRWYQ=;
        b=HIRVs/fd7nR/NBAQ9VcyhwVbSMerJOLOFQNlUy0f26cXyxuhRfVmM+fai+ODbx6n0I
         p35jU51/Ky1C42oRE00rlEdFSHJya7GU2FREt7oB2DSavJTNV9EuzeKIXQT+g3r7lF5a
         sfTBgnp+PCenmq1MZNV+pIyUQV7coLmitEx2puzknLG+uH0Gf5j15zmLsvbte65Hk3Ba
         Fe4dTDGCjF7ibP/iu7S6s1Ow6Rj+FspQMgCtV/4vgBCBgpdJvXdO15Gg203FaydyQ2t5
         72V25NyNlkbd66OgXX4PUmTa9N3WeWiGTC61dLpbP070osOVJPeUYDk/I7v5NRC2xXZb
         58/A==
X-Gm-Message-State: AOAM531fWKdRAU0rzwQClUtn3m3D+qQ/XOLkWGDMhf8BzkYRFw+bPHsi
        ++58NJK9fNKNtw6iTiLaEJNa6nYh9r8=
X-Google-Smtp-Source: ABdhPJzKTDd58pP3LhQmXZABzQ4HlJvrp75Z7QgDv4rnh5qzHSboKvyYfHZ6osiPqNUkoIek1ZIzig==
X-Received: by 2002:adf:e30c:: with SMTP id b12mr15518651wrj.347.1630152812920;
        Sat, 28 Aug 2021 05:13:32 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id l15sm9298377wrv.84.2021.08.28.05.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 05:13:32 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib: set GIT_CEILING_DIRECTORIES to protect the surrounding repository
Date:   Sat, 28 Aug 2021 14:13:29 +0200
Message-Id: <20210828121329.1971762-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.358.g803110d36e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every once in a while a test somehow manages to escape from its trash
directory and modifies the surrounding repository, whether because of
a bug in git itself, a bug in a test [1], or e.g. when trying to run
tests with a shell that is, in general, unable to run our tests [2].

Set GIT_CEILING_DIRECTORIES="$GIT_BUILD_DIR" as an additional safety
measure to protect the surrounding repository at least from
modifications by git commands executed in the tests (though it won't
save us from regular shell commands, e.g. 'cd .. && rm -f ...').

[1] e.g. https://public-inbox.org/git/20210423051255.GD2947267@szeder.dev
[2] $ git symbolic-ref HEAD
    refs/heads/master
    $ ksh ./t2011-checkout-invalid-head.sh
    [... a lot of "not ok" ...]
    $ git symbolic-ref HEAD
    refs/heads/other

    (In short: 'ksh' doesn't support the 'local' builtin command,
    which is used by 'test_oid', causing it to return with error
    whenever called, leaving ZERO_OID set to empty, so when 'checkout
    main from invalid HEAD' runs 'echo $ZERO_OID >.git/HEAD' writes a
    corrupt (not invalid) HEAD, and subsequent git commands don't
    recognize the repository in the trash directory anymore, but
    operate on the surrounding repo.)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d6..a1e0182c2f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1343,7 +1343,8 @@ fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
+GIT_CEILING_DIRECTORIES="$GIT_BUILD_DIR"
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM GIT_CEILING_DIRECTORIES
 
 if test -z "$GIT_TEST_CMP"
 then
-- 
2.33.0.358.g803110d36e

