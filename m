Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E29ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiHaU6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiHaU6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB53D3EFC
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so236544wmk.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Xcd0u5sX46uyp5gvRct9QL9P6aQDzvPVWI6B40FZSe8=;
        b=P2lDQ8jG6aNxrQYFcgPYiFqE0w3VttoVxPtXS868csygmBE0RPrYuB9Y/6/IdFeM9P
         r29nwr0f+NeJPwPSfDY+KulC/4BWfyxKxkplaYxGB56sby+LAQ02yM/7S8ZWhkrUQp5d
         xeBBf7tcCM+Gg+6Wt3Ald/WrcTJmIt/j0P6sxjs0Ci5PNqrk0P337DeVIg6EtNHXIcbr
         +DNigTs7/CfnbGcrAUOisup5IPVdkdJLagXumEce6jRGENqZ9NWsaFwtN16qMTZKiQmW
         COviQyMcR6HkoYMZY9soizxz5u07xM59oVG8ZM/qoZSLLq/bFjq7pFwrmobA9J9KKpvo
         UWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Xcd0u5sX46uyp5gvRct9QL9P6aQDzvPVWI6B40FZSe8=;
        b=5iW3WkX24Qgye43/lINKiy+K7g+qEUYmCuq//qVKRpCNT83hhzQAc3F6lA6NNuMi+B
         eBjrfXYdPeIN9ar9vUJgAVxtZYdGcbJoQOQpAnD7WRAxsXlhegrZn92AhmhpIAlvDwlU
         9pKfjzarNuw7G1l1FLhaQ4hQe7E/XrHwa/3p53Sv613XVhvUjeo1bkGQfijWcaBOVdqa
         y6lAyVuwNkzozMbKA9IFtM3mjniJvjn6eCkwHE9eElh0qf57ElL3NA7b1bs8RZ2qbdWf
         XQySV9Rus9VsnqqKaz1dgj5EGaAIntmfSxyD1IiAAnzc7zH2wWuDmgNDnYBDXVhEqEPz
         XYlA==
X-Gm-Message-State: ACgBeo0hMOu7lDGyHcRI+Rup1Rpfe63NgAysbWW3Bi3FmNCXir02fE5w
        yNWyLUE7rtB0yqRaHTgMLld4fscC7AJjhg==
X-Google-Smtp-Source: AA6agR6Zzl43FtbbaunBLMysqgxEshHe4RbYRObA6j5Qzllv/xu7VRpg88vTsGSX1tWevQZ1x6wtuw==
X-Received: by 2002:a1c:4c03:0:b0:3a5:d65c:c1e7 with SMTP id z3-20020a1c4c03000000b003a5d65cc1e7mr3170954wmf.4.1661979484628;
        Wed, 31 Aug 2022 13:58:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] Makefile: add ability to TAB-complete cocci *.patch rules
Date:   Wed, 31 Aug 2022 22:57:49 +0200
Message-Id: <patch-v2-2.9-0998948b881-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the contrib/coccinelle/<rule>.cocci.patch rules in such a way
as to allow TAB-completion, and slightly optimize the Makefile by
cutting down on the number of $(wildcard) in favor of defining
"coccicheck" and "coccicheck-pending" in terms of the same
incrementally filtered list.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index eac30126e29..42a70eeaef4 100644
--- a/Makefile
+++ b/Makefile
@@ -3139,9 +3139,15 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
+COCCI = $(wildcard contrib/coccinelle/*.cocci)
+COCCI_PATCHES = $(addsuffix .patch,$(COCCI))
+COCCICHECK_PENDING = $(filter %.pending.cocci.patch,$(COCCI_PATCHES))
+COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
+
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
-%.cocci.patch: %.cocci $(COCCI_SOURCES)
+$(COCCI_PATCHES): $(COCCI_SOURCES)
+$(COCCI_PATCHES): %.patch: %
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
 		limit=; \
@@ -3178,11 +3184,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
-coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
+coccicheck: $(COCCICHECK)
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
-coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
+coccicheck-pending: $(COCCICHECK_PENDING)
 
 .PHONY: coccicheck coccicheck-pending
 
@@ -3450,7 +3456,7 @@ profile-clean:
 
 cocciclean:
 	$(RM) -r .build/contrib/coccinelle
-	$(RM) contrib/coccinelle/*.cocci.patch*
+	$(RM) $(COCCI_PATCHES)*
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
-- 
2.37.3.1420.g76f8a3d556c

