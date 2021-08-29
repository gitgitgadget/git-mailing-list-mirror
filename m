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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB2C432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 09:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D865F60524
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 09:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhH2J0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbhH2J0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 05:26:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30DC061756
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 02:25:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso7319305wmi.5
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9rPmQfmMKZNc7iK8n1YOknG01OafuYqrjbPkRGDuoE4=;
        b=b6TOfY+7gqaplB05bN1o96DL5IWoH7HZUWwcsQohngC8OMkANP2FtUn7v2dkLkvAr7
         Qnu2EDgoBx3gRB+I20uSCnn+z2jWRkpdZpQ5uxePGbei725gCCh2hXranWuAoAtoD5kG
         ZTYzuZTh9ScQJFvQNxPCYrTqWMPrGy7alE15XRA57z36uHUlZuAl/nyO0vn5sXNKQTBF
         WHrdc7z1nXj3dQXtpG/Hn5w3X3+2iwMdAlBu1JEbmByh/gUvf0cSyIjDMD5Vkkt4eBQj
         jwkcPlXv0NNzdErWqb3IXs+9+o19sgfv4oKuIpI3Ypki2ohZaLDcC5fCMiFZxsAC1xRi
         56Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rPmQfmMKZNc7iK8n1YOknG01OafuYqrjbPkRGDuoE4=;
        b=S+VrWo7Ri0GtHCR0GMIDUp54xsA2FUTkFOcVIR1d1LQQJa/WcBl656MKU91Pdnox92
         UZvlMjMJqRxkuV7+8Onk4ggHn0UZ2VWLQhfINv+hXjmY+HmX64snq76lOU5Yc3wqSSPo
         YYqK8mVSKtDJudPZQ3x7xnodU9cs0sF+xiNC1vZoQD5MPNul0cG+Oj1R1lKKdyxouf8L
         ZTwK8ZejTmXxvX93V38oUTj8w9D9Jm97VLR4bhFhCxGYCLqiYHZadc9vbBRcy7T/9RGt
         JEFJxUcB26tMt+yBYV+z+wJbr6QHFtAbv/cJPSjcEAmukFvzBlpweyZOY8Safm1pG3SQ
         vW8A==
X-Gm-Message-State: AOAM5322obheB2fXlwb8txTDtIzp9c6OtJuaPw7I6RI3FqNK0TOlKte6
        Pug8N+KQlDikCuV0hCcDsJiRBMCBlJI=
X-Google-Smtp-Source: ABdhPJzmNfyNe+HHKj935QNi2DN7iky2OBloUqxIUpTR6hfbiZMdWmenJu/37efdjRex5unXa9toug==
X-Received: by 2002:a1c:ed13:: with SMTP id l19mr28329420wmh.48.1630229142696;
        Sun, 29 Aug 2021 02:25:42 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id m3sm15118441wrg.45.2021.08.29.02.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:25:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] test-lib: set GIT_CEILING_DIRECTORIES to protect the surrounding repository
Date:   Sun, 29 Aug 2021 11:25:36 +0200
Message-Id: <20210829092536.2582899-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.361.g6f8e582daa
In-Reply-To: <20210828121329.1971762-1-szeder.dev@gmail.com>
References: <20210828121329.1971762-1-szeder.dev@gmail.com>
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

Set GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.." as an additional
safety measure to protect the surrounding repository at least from
modifications by git commands executed in the tests (assuming that
handling of ceiling directories during repository discovery is not
broken, and, of course, it won't save us from regular shell commands,
e.g. 'cd .. && rm -f ...').

[1] e.g. https://public-inbox.org/git/20210423051255.GD2947267@szeder.dev
[2] $ git symbolic-ref HEAD
    refs/heads/master
    $ ksh ./t2011-checkout-invalid-head.sh
    [... a lot of "not ok" ...]
    $ git symbolic-ref HEAD
    refs/heads/other

    (In short: 'ksh' doesn't support the 'local' builtin command,
    which is used by 'test_oid', causing it to return with error
    whenever it's called, leaving ZERO_OID set to empty, so when the
    test 'checkout main from invalid HEAD' runs 'echo $ZERO_OID
    >.git/HEAD' it writes a corrupt (not invalid) HEAD, and subsequent
    git commands don't recognize the repository in the trash directory
    anymore, but operate on the surrounding repo.)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
Changes since v1:
 - Set "$TRASH_DIRECTORY/.." instead of $GIT_BUILD_DIR.
 - Minor commit message tweaks.

 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d6..fc1e521519 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1343,7 +1343,8 @@ fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM GIT_CEILING_DIRECTORIES
 
 if test -z "$GIT_TEST_CMP"
 then
-- 
2.33.0.361.g6f8e582daa

