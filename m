Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E7C43331
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4116509F
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhCERHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhCERHr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:07:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A56C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 09:07:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m7so2092404wmq.0
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 09:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=He+Wd5ZnP+7vfagJX6lyetcZiYpi2tHFw0QJOqeznsM=;
        b=uIFMfieD7n7NsiJIF27XrD7Xxnu+xYGEFViNa08VgRVG7EFMmzAUcnXmIHEnAgYGUg
         60RAjK0uBpbLue+2EcIJRxFpU1VZX1Pnzo9VkRFqucUITdji7Cneu/OYPRn7DaKSm9kD
         APoYf9rOvEtqcOU6CtEl1CjkXvkRoAbQp5aGoOQLMk8IAg+UDoOmAHfpRbfHxtv0pIJA
         hdvFqYFQQBQdemtuxMiFbFTaBb320SzKKfRM383wi47/7SPx4BI7lA53YwjxPAxhU6QV
         FH9glUIC65ay5FLv8uwkLEdyGTs5uqWCWDD+xIFAYr+93nmusewszgw+5nq7L/U3viX0
         y8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=He+Wd5ZnP+7vfagJX6lyetcZiYpi2tHFw0QJOqeznsM=;
        b=YVQpSjE1B07Va9cuVYc3dlqKf0VkUtZOCENttDnfo4LNoYnpNNSSiwcNMLizvHKtih
         tseFETH8mToJUn0TRNsT48MwwL6QPXiPcS7FaXV07/ys7nYGblR0hXN5PMP8VQdjz1BZ
         Q5xbh1tlorWD/0tYH7kyc0aEDtXI/4qFWWLJGMYLZED0B1pa7XhTgY/zIkMK1Qso6sZF
         Hj9YjhsoKK9xcbG/i5ih6o4U7rXLFThRDzZ7rYxPzfGmE5k29viu3ppGozIeenpOHEu8
         FH0J8X1pjiTgNDRkECrHKeUQE1PGcahZMz5FPLych5NDVyZkXpsz/74Zz1+JmYxdft5N
         Jsqw==
X-Gm-Message-State: AOAM531m2pv2uoYYHHpz+QYp9cjRKFguHnBsEd1DSNdhY/AWKMkuwLze
        uNFrIb6gX8jl3FVBGJ7mDF5iAcMTPYO9Og==
X-Google-Smtp-Source: ABdhPJzE7XkO7ExAUDnYTydJ8N6uW3lFsCap2SyJGEtSjk4fKodEs53JJYv0WiMF1d/lG23UZ4yzuA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr10022080wms.4.1614964065888;
        Fri, 05 Mar 2021 09:07:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4sm5115328wmq.12.2021.03.05.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:07:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
Date:   Fri,  5 Mar 2021 18:07:24 +0100
Message-Id: <20210305170724.23859-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210302205103.12230-1-avarab@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "xargs -n X" limit for running spatch from 1 to 8, as
suggested by Jeff King[1]. Now that we're not using --all-includes
anymore this is going to take much less memory, so bumping the limit
should be OK.

1. https://lore.kernel.org/git/YEIGzXMDax83cwAx@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9fa715e4037..9b4e350ed12 100644
--- a/Makefile
+++ b/Makefile
@@ -1201,7 +1201,7 @@ SPATCH_FLAGS = --no-includes --patch .
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_BATCH_SIZE = 1
+SPATCH_BATCH_SIZE = 8
 
 # For the 'coccicheck' target; SPATCH_XARGS can be used to manually
 # tweak the xargs invocation. By default we invoke "xargs -n 1", and
-- 
2.31.0.rc0.126.g04f22c5b82

