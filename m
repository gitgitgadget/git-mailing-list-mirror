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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5766C433FE
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853196115A
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhIWKcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbhIWKcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 06:32:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E6C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so15779361wrg.5
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rN2Ib1GUZMZZE6+otrlf8KWPJ0Q08KM2dsTeFdhZGTI=;
        b=G/3y+6qX2Dq8bJojUwXkc5qmwSnN8TIaioIZ/tOpdP8yM1sD4SFYUr8R0Nf0PhKuQF
         1hkbq5B5IzPR1aCQkXe35AqexCPEorcCBA492dO8OSoQ7KvhCoNziirAS6TNuUNpBQWj
         WCkMPZtUX4PZx53b3lYTFG/oCHoOk8LMEZE7/E6lEy4xlnYXhskQrU6HpcTLQe8ime+5
         SY28tbJvk33g9SQhQQH+8v8cs8zDufH0cqktR4WxYL6Lpqmexu0S1nwHsDMnE5tsghFR
         5GI8KYw9TiE1Z2SBrSntjq/se7qEZvuDyKxEgUjtnkcApjgPIjFYGEO8wZXmQUB9gop6
         +W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rN2Ib1GUZMZZE6+otrlf8KWPJ0Q08KM2dsTeFdhZGTI=;
        b=EN2kmcCf7I78p5/hjC+Vrgg0q6J33hDs0J05/B8A5lO1h9wSD1gcUTwUlwzCHCFH01
         USuOoaBrA+lKlN+QAGS6oBWgp9ejak73G/oqHyny1yIDIhjqs/WVBjNNb5SONKw8/YFp
         YgG3xgJ39gwIoI+KLFYCeMF0c8qqrKWzIRiptK32F374yTlOU8dVM26MU6Fr9NZWrv2r
         9RbqRqzFHN6cF2CApk0D5z7x5IQWS9dyPFZR/78g9YDeQtoYuD8dAXucVN+tyok6jk7C
         /WtRUHVZYacR02//SFIJFbmglVct/In8EEa5cDfPpkrg2rihwYqxdRnVmgcVLh0pPvns
         06ng==
X-Gm-Message-State: AOAM530rYeMuyWsEY5okrlvWsBZvknZAFG33obL1/QJ/1sORv2DPUbe6
        bAbMG5+BhLPWJJX4D9cD3a4ngFagJLNyVg==
X-Google-Smtp-Source: ABdhPJyV2SQ0yXSW+iyJAYmHsj2TwyuC03PccAbEJ4pvPiFgv8eY5fPMYZReYOl8T9/yxA5wod/obw==
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr4051464wri.151.1632393073615;
        Thu, 23 Sep 2021 03:31:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b187sm9027312wmd.33.2021.09.23.03.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:31:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] Makefile: remove an out-of-date comment
Date:   Thu, 23 Sep 2021 12:29:59 +0200
Message-Id: <patch-4.8-b3cce74d259-20210923T095326Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1229.g50d2591fb53
In-Reply-To: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
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
index c529f283dcc..c50115cd565 100644
--- a/Makefile
+++ b/Makefile
@@ -2508,13 +2508,6 @@ ifneq ($(dep_files_present),)
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
2.33.0.1229.g0a86d28df49

