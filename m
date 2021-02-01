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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D7C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5176F64E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhBALSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhBALSL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:18:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C47C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:17:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so18395278edd.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvlVW3spyFeGJFHXMh1JhMXMbkIUfEJgahOeALEjRo4=;
        b=VgsMyLf0s6Y191eyYpGtsNppQ+VnAJc9y/UZEXka4oDJkwjffmwP1Lc8QJ7IpTA2rT
         68r823J623GxwYMlDWEdvQ/zIpbB7kpG+e8oms5NivWuI6RZJg/amD0BfEx3hpab06nJ
         zSdIoggaEG0fNrOrNYIJAghrAQHCDOI1Shi7HcLBhthXXD14J3w//lZBqVpyZnlrTioW
         DNdJ5Bb3No6v9bjev0VrRbKERiXlvIML5Az1yE/72B5BDFA+JKqs55RG37lgcSag8EA3
         abmYy2YUxhe1RgDiD13bNwiylw3JklXUtSjJ+eW9A94ZV/EXYrPDZKfkn9516a07oyx7
         ldKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvlVW3spyFeGJFHXMh1JhMXMbkIUfEJgahOeALEjRo4=;
        b=t9znQ05PCkwYPCkAJy5YN0Gk0brpQK244LFIh8UR0dqO7e2+cST3TiJP1LS9rnO5tH
         PXOcD5yqYZSrBUNvqNZHIgNZ9KECwap6EOjMQw6xmtAtJQkc6QKhnD2szvGULBVkMoTr
         giRBH/gX2WDtyInfEF5j6JCon0vl5ZalevDALyCJOoC0v4IWHNtv3GSJ4uSCB5p7o8fc
         uC8Dww23C5J8CJCeGRvw/wRyiHVLQHZlEdCpg1o/+DWtlSas+/Kfk5p5FQh+ZBhfy4Eq
         KlPyAhFu15gpVq6opR/L7DibjLU3gRpgJrSYky05wm/KTiB5GCnAv54PkoarghJ2QH0A
         mYdw==
X-Gm-Message-State: AOAM531LlYDfxylNIwij70wLKli0wxkq9xAZ94aXf8WDhRBXLQYji3eJ
        tWSyl+7W2bn9CTbocDzVxAY4sUbbOmB6LA==
X-Google-Smtp-Source: ABdhPJzSNqezmUkJADJXILxNH3I7+lBvNOxNumVWKhVP74hPwpjiLzxsi5lYwvJnxgsi61TWk5z0hQ==
X-Received: by 2002:aa7:d5c5:: with SMTP id d5mr5055470eds.139.1612178249693;
        Mon, 01 Feb 2021 03:17:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t19sm7760548ejc.62.2021.02.01.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:17:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] Makefile: guard against TEST_OBJS in the environment
Date:   Mon,  1 Feb 2021 12:17:11 +0100
Message-Id: <20210201111715.10200-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210128182310.26787-1-avarab@gmail.com>
References: <20210128182310.26787-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add TEST_OBJS to the list of other *_OBJS variables we reset. We had
already established this pattern when TEST_OBJS was introduced in
daa99a91729 (Makefile: make sure test helpers are rebuilt when headers
change, 2010-01-26), but it wasn't added to the list in that commit
along with the rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 65e600713c1..ce18d9ceffd 100644
--- a/Makefile
+++ b/Makefile
@@ -591,6 +591,7 @@ SCRIPT_PYTHON =
 SCRIPT_SH =
 SCRIPT_LIB =
 TEST_BUILTINS_OBJS =
+TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
 
-- 
2.30.0.284.gd98b1dd5eaa7

