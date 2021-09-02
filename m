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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FFC4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8312E610D0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbhIBNMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344960AbhIBNMl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822BFC061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so1414411wme.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvVBOJdBBtfeZCN94yNP2MKEWRBK9krfZjxpV8DXyQg=;
        b=BKAm3Q/Qpx/EmA2R2eVDgza+KQV2OaGUDyB6a2w9myx7n5FZtr1Q+APzqoPsvr/y8t
         0TLk9TAH8Y5U/7WPvmQ6ZhMZfVvZa6DNmOG+WddQPHHld7UnLmJJbSM7Bu52HtO10Gap
         YaIa91Mf17nwrQhakgq1cYvDzfoYOc9QgrZae+UKmWxHQJoVMMAsfqDli8JiiGNwi+07
         9P5oCImCGsWgWpkX6XuIT2GQaPET4d/voz0LsWhwBBsHMK+knXnUDNutBU1dFregC9F8
         X6D+tM7Up2RO88fC5sKGH0yGktFWe49BXU896OFr02snOuO+5XNbqCPGXK53zjkpcu65
         Dkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvVBOJdBBtfeZCN94yNP2MKEWRBK9krfZjxpV8DXyQg=;
        b=PFZbKgvsYPOTYM65vEH/bpp5HQHqLheqIdt1Re7bo+WniHeeJri659+cBxQtPE5vmF
         Id7Lr5MUonVTPcPthk0cOap0hYXinzGO7ijq6g0GlZG4dbGpuroY0DgD4lR4d/VxJEGY
         N0OtnhJG9K5aiZdZxqngPhoH5fs9+l3/sE6R8bZ8HsBGjJD+mFuFP8/rh/juYLN+64hn
         43p/I+dkKDcrvE7PUa9IDtaklJ85YuP5OAHpHBImFcw9FnSTCI5v5spa9a+G6Zab3F6u
         jZbwck4dlbNn5NeGBZbcDl3l2rgfMUosI4RoJgDGRXD7IsgxoiQ3buu4lobIKT57X5dL
         aafw==
X-Gm-Message-State: AOAM5313rTW2QAXB5FE+cmhSJLGSKzPsf2nEc7sSKwDD8rEvzCnGnzyc
        TCLYClgbCuF7sLVRDf1mTkQKcddxLT1wLg==
X-Google-Smtp-Source: ABdhPJwFm7qM1EuyL6q5c/vkT0DtcDC799aGGPMHmTQfU9FuTzvicgR33U8bmQ0b1Uzkq1mjpXcvuw==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr3141901wmk.80.1630588301773;
        Thu, 02 Sep 2021 06:11:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:41 -0700 (PDT)
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
Subject: [PATCH v5 01/36] Makefile: mark "check" target as .PHONY
Date:   Thu,  2 Sep 2021 15:11:01 +0200
Message-Id: <patch-v5-01.36-ac419613fdc-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in 44c9e8594e (Fix up header file dependencies and add
sparse checking rules, 2005-07-03), we never marked the phony "check"
target as such.

Perhaps we should just remove it, since as of a combination of
912f9980d2 (Makefile: help people who run 'make check' by mistake,
2008-11-11) 0bcd9ae85d (sparse: Fix errors due to missing
target-specific variables, 2011-04-21) we've been suggesting the user
run "make sparse" directly.

But under that mode it still does something, as well as directing the
user to run "make test" under non-sparse. So let's punt that and
narrowly fix the PHONY bug.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index d1feab008fc..5ec23e6b59a 100644
--- a/Makefile
+++ b/Makefile
@@ -2941,6 +2941,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
+.PHONY: check
 check: config-list.h command-list.h
 	@if sparse; \
 	then \
-- 
2.33.0.816.g1ba32acadee

