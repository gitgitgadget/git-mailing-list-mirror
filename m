Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF954C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiITUQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiITUQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:16:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D0C1A395
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:16:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w28so5534958edi.7
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Jo3PDuHW0zjfQb5S2LFRgZV3ZPD+J4/Q8WS2a9TIRaE=;
        b=quxzY/WEaYFBeINOO9j70Zh4/runk39KKgowIh/460Vg2xO2c9WwIsLlDsvr+baiRV
         X46ArDB4Y0vpH4rESePwprlo62C6N0hhVbuKRAxP+/gTeCYwNLtTD1ZhSAy7MGtArnNT
         3rqy69nH+DiZPq9KtNPj7FurFMzxglMBR8MnhBS3pSyAlZgBvbieJPC6PV2ys8l0jNZZ
         bQvJMp3zWciduN7Q6JO794npF1hvk0s/2lP72ZM6kXKfHJa5lAltVwsqbR+jvaPE9VSj
         u4NuvNsXdQXVUeDOmU80nJG9gNFywOAR0Jr7ZR3qqVJ+FiItU8OY9lAwl8lLRKCcOlnq
         Jg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Jo3PDuHW0zjfQb5S2LFRgZV3ZPD+J4/Q8WS2a9TIRaE=;
        b=bznCIm3pRm5p5fnEZaBcFzkVAcmH7IkjiDvHHSLp1LAX3HMx6xMPtVx6v+e+X7FW+v
         8P88zd1q4V53JGxE0aY8T0vXWM0Uqakvqe4XPAX5zucfje/dpAR57ARvjh3aw7SGuGdb
         e9qi92mHIqQ+X8n16KAsDAtgITrdLYeRlfGRJDxChQvXeHxqEhB/UHUaQXqp1MeDs9Wr
         ghFuqMVtV8aVfilvoSTVtF5BIi/sy4eeAYpRXOBlbvPSE1I+M9FzFv/o0s+6mOPjVXMx
         vzt1q7bDFbVMsBPNHRwbkiSrcXVAIwaBaLzdH2PMw6HZG2cWA3VONgb5TGW5r0PZ/Mam
         VMDA==
X-Gm-Message-State: ACrzQf07mdv/KUH6H2UXx1W/3g2hsraZzI5W5BeZYnzmKp3g1NUERQoI
        ROHxnkW3NDhKUfGbSYsLE/6QVehBOFI=
X-Google-Smtp-Source: AMsMyM6TMs1vLWLZKFrq/CNeEG39bBeyMAQMLmVXen06wEjfsOWuEfBqasDgym12KplyEYND+liyBw==
X-Received: by 2002:a05:6402:4cb:b0:453:b9f1:f10a with SMTP id n11-20020a05640204cb00b00453b9f1f10amr14350248edw.47.1663704982697;
        Tue, 20 Sep 2022 13:16:22 -0700 (PDT)
Received: from localhost (78-131-17-3.pool.digikabel.hu. [78.131.17.3])
        by smtp.gmail.com with ESMTPSA id we12-20020a170907234c00b007789e7b47besm373874ejb.25.2022.09.20.13.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:16:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] t/Makefile: remove 'test-results' on 'make clean'
Date:   Tue, 20 Sep 2022 22:16:19 +0200
Message-Id: <20220920201619.40972-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.3.1160.g17e5960226
In-Reply-To: <20220920105407.4700-1-szeder.dev@gmail.com>
References: <20220920105407.4700-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 't/test-results' directory and its contents are by-products of the
test process, so 'make clean' should remove them, but, alas, this has
been broken since fee65b194d (t/Makefile: don't remove test-results in
"clean-except-prove-cache", 2022-07-28).

The 'clean' target in 't/Makefile' was not directly responsible for
removing the 'test-results' directory, but relied on its dependency
'clean-except-prove-cache' to do that [1].  ee65b194d broke this,
because it only removed the 'rm -r test-results' command from the
'clean-except-prove-cache' target instead of moving it to the 'clean'
target, resulting in stray 't/test-results' directories.

Add that missing cleanup command to 't/Makefile', and to all
sub-Makefiles touched by that commit as well.

[1] 60f26f6348 (t/Makefile: retain cache t/.prove across prove runs,
                2012-05-02)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
Range-diff:
1:  36a3a71ea5 ! 1:  ccb28d7ce7 t/Makefile: remove 'test-results' on 'make clean'
    @@ Commit message
     
         The 't/test-results' directory and its contents are by-products of the
         test process, so 'make clean' should remove them, but, alas, this has
    -    been broken since ee65b194d (t/Makefile: don't remove test-results in
    +    been broken since fee65b194d (t/Makefile: don't remove test-results in
         "clean-except-prove-cache", 2022-07-28).
     
         The 'clean' target in 't/Makefile' was not directly responsible for
    @@ Commit message
         'clean-except-prove-cache' target instead of moving it to the 'clean'
         target, resulting in stray 't/test-results' directories.
     
    -    Add that missing cleanup command to 't/Makefile', and all sub-Makefiles
    -    touched by ee65b194d as well.
    +    Add that missing cleanup command to 't/Makefile', and to all
    +    sub-Makefiles touched by that commit as well.
     
         [1] 60f26f6348 (t/Makefile: retain cache t/.prove across prove runs,
                         2012-05-02)

 contrib/scalar/t/Makefile  | 1 +
 contrib/subtree/t/Makefile | 1 +
 t/Makefile                 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
index 1ed174a8cf..e0bf2e32cb 100644
--- a/contrib/scalar/t/Makefile
+++ b/contrib/scalar/t/Makefile
@@ -46,6 +46,7 @@ clean-except-prove-cache:
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
+	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) .prove
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
index 3d278bb0ed..4655e0987b 100644
--- a/contrib/subtree/t/Makefile
+++ b/contrib/subtree/t/Makefile
@@ -51,6 +51,7 @@ clean-except-prove-cache:
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
+	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) .prove
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
diff --git a/t/Makefile b/t/Makefile
index 1c80c0c79a..cb04481114 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -66,6 +66,7 @@ clean-except-prove-cache: clean-chainlint
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
+	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) .prove
 
 clean-chainlint:
-- 
2.37.3.1160.g17e5960226

