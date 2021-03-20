Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C679C433EB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3D26198B
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCTAEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhCTAEH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39FEC061761
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e9so10741297wrw.10
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wH3Tr51rGAAE+4nCUAfXiu1KdqwsDLPXqJ0pU11I4ks=;
        b=S725j1xGqs1dbSHypayRqw96KQVEcOY8/sAli66dsSG7XU4UgqlYay07SRz0BdjQhr
         rahEvusKhzuxCB1y5D521kNCgVBpAbdBNgenySxYYAfBsEIIwp77hSjSKiH90wC5sOc4
         43GjwFhO6n1z+qhplehcIqLYSMDCdS/ptQEyoL+S4NOo1eMN6NgLzlTEfSDH/FArkNyO
         fYmQeZiMcLswoKw346o8P0NjbXzgAxKJgDBiawdMier2ENvXY/60+vKdicetbS616QzF
         7Ul8J/EQRaaZwYTGfCQklAua23ob5g1lWKon0Qw/XOmrqqbN41qDpr+hcTUGF+fLrscb
         CtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wH3Tr51rGAAE+4nCUAfXiu1KdqwsDLPXqJ0pU11I4ks=;
        b=GhQMD6y+cje8sBU360qpV7zdZ+u997C71/rMk9TDcMd7JH4Sx+b348ONv5Pxkm7+tX
         vXPXV2rrzVwGwxeFPbmxM6znnIVWa/0cjdQUxMLaxhOsubTiMXa1YHl1pvJ6j5gq9Bnb
         +TBu90s1D+FxYBTsO2fcvV50v/hwU3gu/0C4ZUduEU6iwcTvFwnnc/WpcxmbjxmBRFTC
         JBMd7o3pC/LOCXrQzo9r9OISCDDYqyMB1JomhwNCtF3+57u6ze1lAeBHPBuS2jkU+Gfq
         uJXrAhIUU7k1QDK1Fk04lgpE+8L1CF2meHMTzGRDvzfjSirwO1Bt7INX8Rq1vcbABlzr
         UOoA==
X-Gm-Message-State: AOAM533TMSO8tZsofch+zt2hlJKzpp1ZUwf5p8cAZNeWW+vJiutd6qnm
        AiQDQFbizt7dQQoqn1EweUPMz7g7G74=
X-Google-Smtp-Source: ABdhPJzcBWTygGRoBF8L+VBLxk1/JSNOX5GB+lz0PLuyyCpf31+LazXlB6Db16A1w3bWYoiRIGcKLQ==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr7067966wrv.92.1616198645484;
        Fri, 19 Mar 2021 17:04:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm9858358wri.32.2021.03.19.17.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:05 -0700 (PDT)
Message-Id: <c2d2a1ccaea70b7dc8c0539ba9d3a132f9687040.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:56 +0000
Subject: [PATCH v3 13/13] Add testing with merge-ort merge strategy
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
default strategy, have the testsuite default to running with merge-ort.
Keep coverage of the recursive backend by having the linux-gcc job run
with it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 ci/run-build-and-tests.sh | 1 +
 t/test-lib.sh             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 50e0b90073f1..2279ff70a735 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -16,6 +16,7 @@ linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	make test
 	export GIT_TEST_SPLIT_INDEX=yes
+	export GIT_TEST_MERGE_ALGORITHM=recursive
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
 	export GIT_TEST_OE_SIZE=10
 	export GIT_TEST_OE_DELTA_SIZE=5
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 431adba0fb3f..6f4185037183 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -448,6 +448,8 @@ export EDITOR
 
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
 export GIT_DEFAULT_HASH
+GIT_TEST_MERGE_ALGORITHM="${GIT_TEST_MERGE_ALGORITHM:-ort}"
+export GIT_TEST_MERGE_ALGORITHM
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
-- 
gitgitgadget
