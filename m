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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522CBC43381
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACD06509A
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhCERHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCERHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:07:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0700CC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 09:07:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b18so2872844wrn.6
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lK9zpVNwptBA9NPWnfRxHDoC1OlGVxt3RhdFYsIzbUc=;
        b=mx1klXErYv9XISpEJyugP9yQwk+3JZvsxYvulbJhYZyQCJ/WsLPaiT5lMYlUFBvux+
         1QMCBH0/eBwpjP+J7I6Bbm5VfB046Na+pIVawBDhdZ9vkxklH1fe6UPd8Hc4QL7O0IKx
         KCKa4W+4yRR5TpEm1uQUUnAMDkxHIKEdeyRIqmZWknZjBY6fdeUHOETXyCJK9hSRipUH
         +91RP8t2+CzHvvLl579mpaPJCTAJS1f4Pr/J1bpIViUjaoiWrDLfcPtEQyPGEtk++SZe
         gNnEiQfxJYPkqneiAmI1wvbAqQfU+u00F0TSEn3n12+Bcp+bbzqGDXaCunGEd9UFeWUg
         gT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lK9zpVNwptBA9NPWnfRxHDoC1OlGVxt3RhdFYsIzbUc=;
        b=W10fsFf0A0OX1QPkvqidsvZXRtcli8gvV1Jsv0x/TKXRNrxTWlansrnXPnrWflCoLy
         XoDBX1QknKDdOUUt1gxwpKE3fkKQ+u8YcY2M0O/8gSy1TsynRNZHCJYWsxWkUUGA1Qda
         AyVUj5cxrDRaMDF9Z6YYvNofzxBmKMtitfKRIkyKOazoudctZA3wB7bJA0vpE3o/KoXf
         ohTk5XHlGFh9kpkqyDBMVg+Zfy79O5M7i+ChEvL5C5EgpWoHqxkCkDCkXch9OPMfhDwy
         JJ4AQmorTI2BzYD9/mj5vrrSp3m9MO4afYVSVC/aOMlG9VtoHq9yS6GyPykjaSzcw/sN
         5+0g==
X-Gm-Message-State: AOAM5332/92jt7r9FwWxjc4jzlLwcUk2brNFlqiCvS+1t2bpNaOpNdZJ
        M2Z415mDevVJFzKMEZmuIn3JWGw1+GbPsQ==
X-Google-Smtp-Source: ABdhPJwgy69OskwnjD4MLa2l2EEfHTZm3qWnqg68AfCoMIoPnW5P6aOl3mwh6GIOaeDR7AVCK8Bo2Q==
X-Received: by 2002:adf:b1de:: with SMTP id r30mr10542170wra.125.1614964063107;
        Fri, 05 Mar 2021 09:07:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4sm5115328wmq.12.2021.03.05.09.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:07:42 -0800 (PST)
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
Subject: [PATCH v2 1/4] Makefile/coccicheck: add comment heading for all SPATCH flags
Date:   Fri,  5 Mar 2021 18:07:21 +0100
Message-Id: <20210305170724.23859-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210302205103.12230-1-avarab@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 960154b9c17 (coccicheck: optionally batch spatch invocations,
2019-05-06) the comment being re-added here was amended and reworded
to apply to the SPATCH_BATCH_SIZE variable.

If we'd like a separate comment on SPATCH_FLAGS now the diff to
introduce it will need to also move the comment. So add this heading
back to make subsequent diffs smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dd08b4ced01..f881b558c44 100644
--- a/Makefile
+++ b/Makefile
@@ -1195,10 +1195,11 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
+# For the 'coccicheck' target
+SPATCH_FLAGS = --all-includes --patch .
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_FLAGS = --all-includes --patch .
 SPATCH_BATCH_SIZE = 1
 
 include config.mak.uname
-- 
2.31.0.rc0.126.g04f22c5b82

