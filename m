Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69051C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354459AbiFUWed (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiFUWe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA89C264E
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so139277wrb.11
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DF1sdrpNAYnXZRFsn/4tHewBRbmrzl9gBUCFXHx7gU=;
        b=G+KC9g2cQ7SC4GsnpB8oeHYHbX4ZIR04tuRSpDeUgEGuF4mA9xAyUr4IEoOjaIdlto
         oreJMaw1USNqG6mM4Zmu0E+pv7LJbgeuMjJKUEswe5iCwIkoUndjNcD84rIplMh6VNMw
         jwfHF9ZlYbSxV31k8MVZeoc5Hi/35izatqHGXNpm8jrBaD2cOHDP5IhAAE18YhxKglKE
         OTTMgaiPUxMnJrWw139Jg83izrgCpAOcvQeIfFSwyo9uwRUNmsL1XMZjMKmqNDqPXzQa
         EOGIdMrA8mppNr+3DMDwZWBNDtqInG+9xRZfwlwhtH1BI/X0fjOc8Rjqnnm4P2t9dZUq
         XT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DF1sdrpNAYnXZRFsn/4tHewBRbmrzl9gBUCFXHx7gU=;
        b=qqMVXzmq5vgkVEqibknRW6TZeGa88CKWbbeSrVykhj2g35bxDvnS4m0LoT/3IPkkUq
         9aiG6qCRKugplwG4ApsxpF3Kr3w7/kAMEwN0IjqDCu1me7psISmhzhvb9XDH/HbmDIQz
         3313ewCkwENcYR05aAQCs5Y275IRC42Oksh7OD0HFLpIvaB1qiSlVmhm4G+RNb4fyukD
         KQv7re21Sz5puMHo2kVYaysMUEcqYYvqAzjxgqLZ9rAokQk/CAoRP5vV7u/5N0JgHcIL
         wzwx79cRx2hna7BFGavd5Qh8V5pKGNzUdurRoeuQ9GtWRSqbjGa73Ij6yOc1OWj/isGr
         y2uA==
X-Gm-Message-State: AJIora+97/ZK+3aOnHPr2eLhQqFzsDDI5Ctu0a4r9HAhiHSpVasap51x
        JMVLqBSMzXaVKqk+2Uwm7oMxFAU4STHmig==
X-Google-Smtp-Source: AGRyM1tYQmTp/Dr9bnFdK/oGXWBU/Qst7FT2AdFYrizy9+NPBsqMT32sJXmc8Sr/pBltl7plOImbbg==
X-Received: by 2002:a05:6000:69c:b0:21b:9280:9b2d with SMTP id bo28-20020a056000069c00b0021b92809b2dmr201818wrb.203.1655850866085;
        Tue, 21 Jun 2022 15:34:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] fetch tests: remove redundant test_unconfig()
Date:   Wed, 22 Jun 2022 00:34:13 +0200
Message-Id: <patch-01.10-6236f4475fc-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_unconfig() calls here were added as boilerplate in
737c5a9cde7 (fetch: make --prune configurable, 2013-07-13), and then
faithfully reproduced in e249ce0ccdb (fetch tests: add scaffolding for
the new fetch.pruneTags, 2018-02-09). But they were never necessary,
so let's remove them.

This actually improves our test coverage, as we'll now be asserting
that whatever configuration we leave here (in the "one" block below)
won't affect this particular "git fetch" command.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4620f0ca7fa..d784a761ba0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -874,10 +874,6 @@ test_configured_prune_type () {
 		git tag -f newtag &&
 		(
 			cd one &&
-			test_unconfig fetch.prune &&
-			test_unconfig fetch.pruneTags &&
-			test_unconfig remote.origin.prune &&
-			test_unconfig remote.origin.pruneTags &&
 			git fetch '"$cmdline_setup"' &&
 			git rev-parse --verify refs/remotes/origin/newbranch &&
 			git rev-parse --verify refs/tags/newtag
-- 
2.36.1.1239.gfba91521d90

