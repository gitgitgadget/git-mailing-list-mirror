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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E47C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA0E611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhFWRvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhFWRuy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C3C061766
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d11so3638705wrm.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLjYUrtyR/yn9sV3eRM9b9OxOfJ4wBTssq2YHbtoHiw=;
        b=EWOURKl/o6W2x5IkrNgkb1ELqreoIoEPkTP7O/wjii2/4/BolyLWr0lc586zxAhQIx
         HXPMsZRNeQnoVqeII1ai8jgo6MzvGRYEw9CpBdlDXWsJ3O1OxdBMIrn9BehNGq3N151C
         9eLSGR5dEfLECvzWV351hrPYCWkRcnF7+rQrnEVRwpoL5yZ4uJje/4PLtguEEMRWEpA7
         deF2C13Au+TGPhNBmEafrW1k4n8+m+GRzBG91K5k6V8pevE7bJNsdg4uz9w8FFVsvU5u
         YuMdxlCok6Pe4+4jCTVDu+YJL2swFklQLYnIovdTUPj8W195Zzbqe07uaI6yfGcFwgUc
         movA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLjYUrtyR/yn9sV3eRM9b9OxOfJ4wBTssq2YHbtoHiw=;
        b=Ot97+QhfoK0ZKqHSsLXaIzi1PhON8T+YZmc4Cp5Ue/b6Zez8VyhWtxTG4S+Hx90ZEN
         fGHkA/iuoJVPukkrd4q1ArnVrqjroKD9LPVoevzzLBS7M3bHPc9cu53Di3c1ANnaAali
         Fii4DYOUzq3CMHaucd6Cluo+obS62iGUD7y7HedDncfMs3gZ5jFEyI5unT2h4wch/LOT
         0JoVuRVq4848xNS1GgvjUwzM7O9vlPd0b2aPVUph9WBICd69NHwxwPTcYwjDjTKjY/ii
         mqccxC/FM2Tt6p9hBOJ7n+J6Z9qQ/LJWLRYV/N5cOw3xjgY2gmpwjTKngCEc6U9L1Y9W
         JRdg==
X-Gm-Message-State: AOAM533VA+NeY+AnWbMIXPBvjfilDXmVByv0iHLhhElQtN6MXzKbmcE3
        JpLBRi9h88miJ+QqUVgnPpwvlj7T99Omkw==
X-Google-Smtp-Source: ABdhPJwp1zxU68Uh3T18/D2grUyvq+/lD2QQbmYj7xObGRim19MRhF438Y7vUcXjqZh8H5TeqWm3qA==
X-Received: by 2002:a5d:64ca:: with SMTP id f10mr1389892wri.331.1624470513425;
        Wed, 23 Jun 2021 10:48:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/25] progress.c: call progress_interval() from progress_test_force_update()
Date:   Wed, 23 Jun 2021 19:48:06 +0200
Message-Id: <patch-06.25-8261d2977e0-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define the progress_test_force_update() function in terms of
progress_interval(). For documentation purposes these two functions
have the same body, but different names. Let's just define the test
function by calling progress_interval() with SIGALRM ourselves.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index 893cb0fe56f..7fcc513717a 100644
--- a/progress.c
+++ b/progress.c
@@ -216,7 +216,7 @@ static void progress_interval(int signum)
  */
 void progress_test_force_update(void)
 {
-	progress_update = 1;
+	progress_interval(SIGALRM);
 }
 
 static void set_progress_signal(void)
-- 
2.32.0.599.g3967b4fa4ac

