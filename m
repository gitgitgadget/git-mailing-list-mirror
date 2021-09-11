Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D59DC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AEC610F8
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhIKJfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhIKJfm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5DEC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q26so6256490wrc.7
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CUJ9JOnHzecSgSzLoU4bq9Gr8Ksw8h20GZiupK5mLo=;
        b=ocfKPZJyzt1VGy3aurFJZQCUNxQJP+Ljmq2mwqEQwxNBFGNv8+lmNohD+629nEpE0u
         1d3Hw6cg/P9OC2o6lIzABt99mUbKxJJkPlZNln/4K9lWNyPNTQDrdKQTI0doMpA1azww
         nUS/NNrRiURuBhC8lyHM05lPXfKhb9hQq1ea8BCanhqoJQj8YD8axJLRAtHZj/giq1T+
         REjtyVhERnKDMfayuwizD7Gi/ZwKMF6YJYQzbgaXNalz4F5AhhGsATgk06nYwlvAgrj7
         E9b25hH3Ic1+AyfXFJmyBYQwsg4EkEv52AJ6qID7w/t1Bt13K8xX4TaZNBhH9I/zRxSN
         g18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CUJ9JOnHzecSgSzLoU4bq9Gr8Ksw8h20GZiupK5mLo=;
        b=fbjP7OCZHEeKY4fkRbj1sfXVGBfmt2Xc/k2ZUReZClgRrNOZvDsJSopUvKpd6OCDGj
         SvaV4TGU6tSvFWfbdBosgXtMep1Rafn+fnejDGtpCqExzG0/rkPdPF3RszyElBBW4aTc
         fPSrBrWTvQulrdpwtJZXRdqWsq27sO8kvX1wARSh+KSa0kiGrfjgL6r69MPiPkdMfG5D
         Yr8tOjZvw4AhxiQAf1ioLvw1CyT7cfVgrSGrAHj0QnFmnx5LKFTGWbqaCaxdVMu8FCUF
         yNax30BynKdvzv+RBe+ngOn4VU5+eKp4zjzB2cmrBSS07j1kbvC4aCdumXmY3axPuzip
         EOsA==
X-Gm-Message-State: AOAM533VepExk8B9FVle1bXXPDShbxc33NjTX0CtOQTGKYXsR4BeGzgc
        emXDrVci7rcbRu+D7IXwi1de9v33mqZ1WQ==
X-Google-Smtp-Source: ABdhPJyqHu8dCqGYzb4IRnAMlcqmKg0rfp5bN6wDpZNwU/3wL9invvZYy9kG02fFbBssBfVPwxnBzg==
X-Received: by 2002:a5d:58e9:: with SMTP id f9mr887985wrd.325.1631352868665;
        Sat, 11 Sep 2021 02:34:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/9] Makefile: drop support for curl < 7.9.8 (again)
Date:   Sat, 11 Sep 2021 11:34:18 +0200
Message-Id: <patch-v3-4.9-98cdb7c35a9-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1119a15b5c8 (http: drop support for curl < 7.11.1, 2021-07-30)
support for curl versions older than 7.11.1 was removed, and we
currently require at least version 7.19.4, see 644de29e220 (http: drop
support for curl < 7.19.4, 2021-07-30).

In those changes this Makefile-specific check added in
0890098780f (Decide whether to build http-push in the Makefile,
2005-11-18) was missed, now that we're never going to use such an
ancient curl version we don't need to check that we have at least
7.9.8 here. I have no idea what in http-push.c broke on versions older
than that.

This does not impact "NO_CURL" setups, as this is in the "else" branch
after that check.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 429c276058d..378f58b950d 100644
--- a/Makefile
+++ b/Makefile
@@ -1436,15 +1436,8 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	curl_check := $(shell (echo 070908; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
-	ifeq "$(curl_check)" "070908"
-		ifndef NO_EXPAT
-			PROGRAM_OBJS += http-push.o
-		else
-			EXCLUDED_PROGRAMS += git-http-push
-		endif
-	else
-		EXCLUDED_PROGRAMS += git-http-push
+	ifndef NO_EXPAT
+		PROGRAM_OBJS += http-push.o
 	endif
 	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "072200"
-- 
2.33.0.984.gea2c3555113

