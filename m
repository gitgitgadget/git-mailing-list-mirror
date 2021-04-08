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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB30C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE5961103
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhDHPE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhDHPEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A956C061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g17so2069484edm.6
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SdUtIdk8Z944TLl9WC+jioSzhOQ0QTapNRoc7do+JeI=;
        b=defo6R2zdYsJMoljQgoXELRslqTaGi/bmJJSrLEcgMuwKuAXfHmakAdkIjFCpxFDon
         Cm+BzlpXEVqIWzYhKvrskW4ozsNpnPb+6JoN++wvFaOiuuHAvoONePGyvtV+3+y5/Ani
         j5ALFkS+y/tA638hjuJJ78PCKaJ3xoEZUCDb5roRIbugQ61AHuZBc7yObiYtjavHBjjY
         BQaXMyUZWaN+HtXpEOpbzQFbbef9znl27tYhY5ZSfFX2YGuqYrdGHaChx4kqT8La3nQr
         hW0RmlPMTcog4Z80TgW1tWVU0CHDaD6UqoJLTkMow9rOOWsnVHzZBKqehzITJ2gPX7g7
         bRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdUtIdk8Z944TLl9WC+jioSzhOQ0QTapNRoc7do+JeI=;
        b=gwcYQAiO8qXybbmodq2mrT2QhTs28Aew+YVWctFHoXLxCPs6sAulDBzDITio+YE3n9
         WaBSnybc+2gEx/r0Z+T6Phf9/X6ZWqNt37YQLzD7Mv5TkPd4ieGJYGB0PhNzSccU3/C4
         lZQJwUL+g54zT9x45TovziRyH5TP4jwJ012VQJJbejvfVjd8JyUQRC6icndWnL329PUS
         RbP9SQeJch4U7VWTK3/ihqHswNeao0wg5K0qQ5Z5G1sFSbT5jRIByL6fKsCrS2qPoznv
         4A4avguqRxNi98ciThQ+B7OFgUCwMiep1rMzb7OGkThLkN4PS6iUa/U6DKciE+jq3KSx
         g1sQ==
X-Gm-Message-State: AOAM530U1TxBCaz8i5kco5h/2YI0OkPMlGmR7r2nWn/BjJWaXDwYG6YD
        EiEvOPOOjcjVH3BQMsY5O15E2RnPPWT+KQ==
X-Google-Smtp-Source: ABdhPJxrVPy7o0mNBnCigwj01QzO8mFWEnRVSnTz8F87/P1IvqifpDAMI22uhxxHcV0sILI/VG2zOg==
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr12416539edc.210.1617894276726;
        Thu, 08 Apr 2021 08:04:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/9] userdiff tests: explicitly test "default" pattern
Date:   Thu,  8 Apr 2021 17:04:20 +0200
Message-Id: <patch-05.10-3eb7abd121-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 122aa6f9c0 (diff: introduce diff.<driver>.binary, 2008-10-05)
the internals of the userdiff.c code have understood a "default" name,
which is invoked as userdiff_find_by_name("default") and present in
the "builtin_drivers" struct. Let's test for this special case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9675bc17db..cefe329aea 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -49,6 +49,7 @@ diffpatterns="
 	ruby
 	rust
 	tex
+	default
 	custom1
 	custom2
 	custom3
-- 
2.31.1.527.g9b8f7de2547

