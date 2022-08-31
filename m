Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C0FECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiHaU62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiHaU6M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C71D3EFC
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso276015wmq.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W1RwiYz6EWFBsHYila6NAStlnA/WTwounioX2F6DTIQ=;
        b=VG00ufZDrp+r0vb2nnDecmj3A63ur97azzYE2mfXx+KgZWjW9kbVduprgia4vz6NUJ
         /5SFIkjVp6h2riVNojGxze6aDH49N2IxoD1d/2+PW1Sv+woqDJsDI9TTC35HjZOiXEAx
         I/nbpwvMUE/ES2sVC0DSLIhcD6IzjIlMbJ4UVxwYwSttDAOAQHs0VgIbYVOxy/+WHqqi
         fEgYYKo1epESX/kVNZpA9yjIPFTGkgUVKDJ+N3T5cudRmd5Y4zpVc6fvEA8fAGjaY6K5
         0Z1f8bEDbXpENS3uh70YcgvT3dT7bTWmj+fZOEdqUmC1l9Wr9VfL9jy+CVE2hAjhyTtm
         qsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W1RwiYz6EWFBsHYila6NAStlnA/WTwounioX2F6DTIQ=;
        b=71CvVgsPe8RyOWM2xpdrim2hMvmJJRVbAz2DRnkHrsQBox8Xg5Fl1/cB3UYO3bkzJa
         771T9fupQuXTGBXpp5gvm4h6e6+gsAlM/XbjesxhDj9WEeLgr6zVIOM7eE8Cz7ZQ1YJW
         K3eI+NyCcXMsbSRiWM8/rNWj2YISNJRGAwAWPjcowpvXySwbW/3/oow7rYu8TRk05Mmp
         3rHCWY9XdeDN9fcrp5GVUNJOmvqnLcp9rVHuqzlp3Ka2wBCqNLvycoqXCMDklN78B80B
         JldEQLLrV5zy2BuIGinOuMVOaBDRCpKp6pklNIcijJ9QduLTNiSz1yqp8OWRvVdhPw5v
         edXA==
X-Gm-Message-State: ACgBeo3EE4eRBC2PC7GGcKX+4TWvzcyf4flJuSrPjFwZwk9uP6DMvYJn
        LOZbq6X54/lXJzFs5kKFSVJt5yXupGYKnA==
X-Google-Smtp-Source: AA6agR7oIXFGdazekIHl9Yks0gnpcyLpVqHrl2m4rEL8MAwVTvFUwwulQfx0WyRe9Nkg/aOTYP8t0w==
X-Received: by 2002:a05:600c:4f89:b0:3a6:243d:3bbe with SMTP id n9-20020a05600c4f8900b003a6243d3bbemr3102735wmq.16.1661979489116;
        Wed, 31 Aug 2022 13:58:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] cocci: split off "--all-includes" from SPATCH_FLAGS
Date:   Wed, 31 Aug 2022 22:57:53 +0200
Message-Id: <patch-v2-6.9-c74d09f4825-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per the rationale in 7b63ea57500 (Makefile: remove mandatory "spatch"
arguments from SPATCH_FLAGS, 2022-07-05) we have certain flags that
are truly mandatory, such as "--sp-file" and "--patch .". The
"--all-includes" flag is also critical, but per [1] we might want to
ad-hoc tweak it occasionally for testing or one-offs.

But being unable to set e.g. SPATCH_FLAGS="--verbose-parsing" without
breaking how our "spatch" works isn't ideal, i.e. before this we'd
need to know about the default include flags, and specify:
SPATCH_FLAGS="--all-includes --verbose-parsing".

If we were then to change the default include flag (e.g. to
"--recursive-includes") in the future any such one-off commands would
need to be correspondingly updated.

Let's instead leave the SPATCH_FLAGS for the user, while creating a
new SPATCH_INCLUDE_FLAGS to allow for ad-hoc testing of the include
strategy itself.

1. https://lore.kernel.org/git/20220823095733.58685-1-szeder.dev@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 143c012b3be..662f950e075 100644
--- a/Makefile
+++ b/Makefile
@@ -1295,7 +1295,8 @@ SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
-SPATCH_FLAGS = --all-includes
+SPATCH_INCLUDE_FLAGS = --all-includes
+SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
 # Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
@@ -1305,6 +1306,7 @@ SPATCH_BATCH_SIZE = 1
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
+TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
@@ -3172,6 +3174,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi; \
 	if ! echo $(COCCI_SOURCES) | xargs $$limit \
 		$(SPATCH) $(SPATCH_FLAGS) \
+		$(SPATCH_INCLUDE_FLAGS) \
 		--sp-file $< --patch . \
 		>$@+ 2>$@.log; \
 	then \
-- 
2.37.3.1420.g76f8a3d556c

