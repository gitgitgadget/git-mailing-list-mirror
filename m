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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F311C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E237560EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbhHCTjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbhHCTj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5754C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m12so21698688wru.12
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvoPSieD9ctzfcwINzAJ0zt1YDPrk7OA+CqjlRPDqZo=;
        b=eGpOSVafo7IuoTjTxzMWrs/evvBVhHKa2Qm/3QE2ZVEpMOs30VPuchzaugO6rvCHP1
         oP72deD3LqGOiS68GrjtEic2p8SS19oxP1SKV09p1rukcEzBLLcoovOBMyUwwccumN8d
         jHXDJgUQDYrqCefTH0zwPOUwRqLlDOyfVie6NEvHTeqjxCDwBnQSFhAy3vZ/dBQOBa/5
         jt6Rw48KukDmoSB5LJegzXA78oAzApbPMJrzTMNPpgPaL5/ZZoRvzWsJkeIc2jAxrUeL
         VtfHOCoXrgWclVk9Oy2rlNEwleukUlwLj7BhHZ3Nmfs8DFv+SMGTw0uMFVyYBDxnLSCf
         gjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvoPSieD9ctzfcwINzAJ0zt1YDPrk7OA+CqjlRPDqZo=;
        b=bjWl2r4bzrQnkxL3LgZbxDGB6SDtoBMj/9ZwyVF4Vg07sDEHPe1arKuOeU93hOHHok
         A0C7wY5wzAwxvIgh9q5pE6eywxQGiqWM06TqFI4KHeAbOSW1CgittPly/M9Rb02NXgOT
         VkJjyeiCWYvuK4yj1wcqJuCfm/GjdAdII59GoYdoO/sjJcXhX6+P8uRBvMNT9Z+uChAo
         CrgG0DU9nsHXmxrntcwakKu8xAJVQ7ZFe6B2Mpb32P8d1Ezehzb47avYG3ybBcGTfj0D
         CNoquM+YIuTldr3czIpu1XfFeGv2+loMoPddVYyezvJRhPoWCm3Ky69lqUgV59lrC1DT
         kAeQ==
X-Gm-Message-State: AOAM530tSLA/9K+E7mlB/0iU+hudIXMh70lrtrbhL7U7lo4SuFZn0/mV
        XFC1TWFW3L+CzhF0KUTtL2VO6MzNLftPUw==
X-Google-Smtp-Source: ABdhPJyDo2WEgBSUsZPonjANdIPtSRS+jU9grWEaWl3L80RlLc0PrRjTZo6aekQ4fM+U9YoeQbjtkg==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr24277625wrt.227.1628019553291;
        Tue, 03 Aug 2021 12:39:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/36] Makefile: remove an out-of-date comment
Date:   Tue,  3 Aug 2021 21:38:29 +0200
Message-Id: <patch-v4-03.36-644b31fe281-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This comment added in dfea575017 (Makefile: lazily compute header
dependencies, 2010-01-26) has been out of date since
92b88eba9f (Makefile: use `git ls-files` to list header files, if
possible, 2019-03-04), when we did exactly what it tells us not to do
and added $(GENERATED_H) to $(OBJECTS) dependencies.

The rest of it was also somewhere between inaccurate and outdated,
since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
it's not followed by a list of header files, that got moved earlier in
the file into LIB_H in 60d24dd255 (Makefile: fold XDIFF_H and VCSSVN_H
into LIB_H, 2012-07-06).

Let's just remove it entirely, to the extent that we have anything
useful to say here the comment on the
"USE_COMPUTED_HEADER_DEPENDENCIES" variable a few lines above this
change does the job for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Makefile b/Makefile
index 89bf0dd7332..0a540dcd34e 100644
--- a/Makefile
+++ b/Makefile
@@ -2519,13 +2519,6 @@ ifneq ($(dep_files_present),)
 include $(dep_files_present)
 endif
 else
-# Dependencies on header files, for platforms that do not support
-# the gcc -MMD option.
-#
-# Dependencies on automatically generated headers such as command-list.h
-# should _not_ be included here, since they are necessary even when
-# building an object for the first time.
-
 $(OBJECTS): $(LIB_H) $(GENERATED_H)
 endif
 
-- 
2.33.0.rc0.595.ge31e012651d

