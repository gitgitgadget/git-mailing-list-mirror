Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D63C43603
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FEF64F3B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhCQV2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhCQV2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D1AC06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z2so3308596wrl.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+xOuyHuwEJ7xExcXUDqaEEbFiL0moeTL9ZTKBxI7icE=;
        b=n4UHrgek/Qkj3Ru+XKs57x6DgKmFyMjgmM9ENQR3rfsNNDm6JbRa913ki5TPhRkuPG
         oxxALr95aWdo80Ct5gwcPZwRg8XdWruGrb13s0vHqJLoek1MPrGPsGONUk5qguQ2AWeM
         5hMENXwxZ0kcP69ZpXdItVzzB8vYSvqEb6ALxitRfCRij9ViNSOp/usZtPA4tYqw22Ia
         9/UzAoX7q/iso8GDpKYxkz24dcpu+1HFZHZDCP5ks0/du+vzt/iZb00/mBGefTZHJFU0
         fCsuXDgvDC0HVZLEbiLU/srJ6Wd45uPqUlznGvPHoEvngOsAgBmYlat06vxkVLrluzYK
         22zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+xOuyHuwEJ7xExcXUDqaEEbFiL0moeTL9ZTKBxI7icE=;
        b=m0U8KtxrO3laa9HPm5+fwIyTIn9HlK1fpVmKKmZYxnHfTpiuUr94WcQoW3AMvS6XUT
         NjL6XAfU849/ygyP1G4+MFLNfuv0AcpauQMpU1aFxhs82vBAxnbydX7GxHDs6ZrcJXEj
         Eaa5oL8eBUi8e/Y1+KU72qNx9zEhm4VUF1HmhXI5BhtPKPsrR+hZfW/r0xvIIlo7ot2U
         bUiUqojHYmoefv9J9lm1k2ULmkE5yYa4Mrk5773es4PzwRuE07e0Yt1UfLkyZ1DL6vZM
         Ti61nuX20PSLA7YOUp04yvMx8ysiVi4DDWthKxZta8u4cCzXFbdN7sy+fcid+NAIX/BX
         JdIQ==
X-Gm-Message-State: AOAM532mXhHOey5WVdDiyAGmTk+ghmT43FB+2OS9pQhFQieJCZztK6gu
        QpEISwJE3pf88etT7+HvTE5+TBG99Mg=
X-Google-Smtp-Source: ABdhPJycovraj3Rc3rjsz7yyiY11G2ppohNPcYXTKlGzxjy75AWlsh4CaSJReoZjOE9NRFF+5DT8wA==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr6257108wrw.421.1616016494475;
        Wed, 17 Mar 2021 14:28:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h62sm122148wmf.37.2021.03.17.14.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:14 -0700 (PDT)
Message-Id: <d8536f56ab296171c09e667e5c9299e95078388e.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:28:05 +0000
Subject: [PATCH v2 13/13] Add testing with merge-ort merge strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In preparation for switching from merge-recursive to merge-ort as the
default strategy, ensure that we are testing it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .github/workflows/main.yml | 1 +
 ci/lib.sh                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5f2f884b92f6..e1f59861a2ca 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -252,6 +252,7 @@ jobs:
         MSYSTEM: MINGW64
         NO_SVN_TESTS: 1
         GIT_TEST_SKIP_REBASE_P: 1
+        GIT_TEST_MERGE_ALGORITHM: ort
       run: |
         & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
           # Let Git ignore the SDK and the test-cache
diff --git a/ci/lib.sh b/ci/lib.sh
index d848c036c50f..2a869b598c7f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -182,6 +182,12 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
+case "$jobname" in
+*-gcc)
+	export GIT_TEST_MERGE_ALGORITHM=ort
+	;;
+esac
+
 case "$jobname" in
 linux-clang|linux-gcc)
 	if [ "$jobname" = linux-gcc ]
-- 
gitgitgadget
