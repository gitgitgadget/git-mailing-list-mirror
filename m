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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD050C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54F16109F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhHDWzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhHDWzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:55:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17073C061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:54:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j2so3936222wrx.9
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUj7Awu517s52vf+83ewn1OOAWq3UA4TbIGIejmbBiI=;
        b=P/lC3uMSfFDTfyUOj/DjilJz7uExhAPxvzU3NLa66K49PtgycwoBrBuFyBcXbdq9mW
         /JeLdvhKNwci7szFOIj0Q+4uZB0ifaF4p4eXXNZn6le+3hDQ6Co6DZ3ceyc7DzRbnG8M
         vH8ghc5MCYxVgkOeiUjRgjFa0fQh/HmHDI+wy6uzPd9RkjVKB9hB18xSqxS0srKXXgEY
         XL1yFqHTCQT/+D7JJNIyFUNbfUyNhq+zaTfklSWn0GFYjKtS8SQqNDa88iy67MlrCNN3
         PH47fQmX24Z0S66bYJKdbhmbuZCOl7H8maPOj9sK0N4cljNRUo80ZgWr2fJwwE2vv6ku
         1wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUj7Awu517s52vf+83ewn1OOAWq3UA4TbIGIejmbBiI=;
        b=eCdYh/lrTS9PBREhs7E5pNQ9KjXeOLt48fQQyH0CNt1+6zFkoKoMkXYvK2HSaXQZpq
         ngzdqFcgAWFJ7nJBpKrRpOdM5NVmS6DiDGOjWWbR2MAPi0NgIeGlwcQ3DjLWh7wLZXxR
         amHJDWK+MAd5YLHuuFT81Mq/bfL4rvzn/+FSq7c1nxNZclNiT4BNEyVDN5vNgcRvF6Pz
         cK1zmdeggsKxze6GqdF3GD7BYTZhPm1OXlWcRMxNrolHsAyQYpGkq0uN+smM+wKgKk66
         /58ajve5Ex6SFE42c3Pb8bLNJqeNsaf3/jrudATORhKkmPokYdaNlLzx2LnQUQHvWmkr
         NhaA==
X-Gm-Message-State: AOAM532MbByEpoxaF9Mg+JEp3w+Nza6ylC5tHKJCaX4+uuVUV3dqHF0i
        WoK5D38N/8cG530aFFQ6WZjlhT3+qhh+TQ==
X-Google-Smtp-Source: ABdhPJw0OTkf2Bd135xEuQ44G4kbT6A6LCQFPqrOwhB3yk3RKH+WJ5ib5BDUjZFnzVdKoq4NFbigoQ==
X-Received: by 2002:adf:fb8f:: with SMTP id a15mr1613788wrr.92.1628117686488;
        Wed, 04 Aug 2021 15:54:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u11sm3968190wrt.89.2021.08.04.15.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:54:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/5] Makefile: remove "cscope.out", not "cscope*" in cscope.out target
Date:   Thu,  5 Aug 2021 00:54:39 +0200
Message-Id: <patch-v4-4.5-643c514e12a-20210804T225222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before we generate a "cscope.out" file, remove that file explicitly,
and not everything matching "cscope*". This doesn't change any
behavior of the Makefile in practice, but makes this rule less
confusing, and consistent with other similar rules.

The cscope target was added in a2a9150bf06 (makefile: Add a cscope
target, 2007-10-06). It has always referred to cscope* instead of to
cscope.out in .gitignore and the "clean" target, even though we only
ever generated a cscope.out file.

This was seemingly done to aid use-cases where someone invoked cscope
with the "-q" flag, which would make it create a "cscope.in.out" and
"cscope.po.out" files in addition to "cscope.out".

But us removing those files we never generated is confusing, so let's
only remove the file we need to, furthermore let's use the "-f" flag
to explicitly name the cscope.out file, even though it's the default
if not "-f" argument is supplied.

It is somewhat inconsistent to change from the glob here but not in
the "clean" rule and .gitignore, an earlier version of this change
updated those as well, but see [1][2] for why they were kept.

1. https://lore.kernel.org/git/87k0lit57x.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87im0kn983.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d1012cf71d2..2a176ba5742 100644
--- a/Makefile
+++ b/Makefile
@@ -2759,8 +2759,8 @@ tags: $(FOUND_SOURCE_FILES)
 	mv tags+ tags
 
 cscope.out: $(FOUND_SOURCE_FILES)
-	$(QUIET_GEN)$(RM) cscope* && \
-	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
+	$(QUIET_GEN)$(RM) $@ && \
+	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
 
 .PHONY: cscope
 cscope: cscope.out
-- 
2.33.0.rc0.597.gc569a812f0a

