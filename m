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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F4CC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 09:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA7B613C0
	for <git@archiver.kernel.org>; Wed, 12 May 2021 09:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhELJvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELJvE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 05:51:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC9C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 02:49:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z130so481247wmg.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rr3FNWqLyEocClfsiOxIWZdFzWUVS1RMgAIgFANnDlQ=;
        b=B2CLZP49cbdK3LLHqn3JDQ8Q/K37inPa3LsJvg+Y2wjHF5M/NdLs94xofGa0WhJVnO
         ++2Eq1RKR3NJp6kOVHHFw5mLy8ce3mW9DrcSphgGMqZBptPWGPUFyqnMps7HqgwzNIGR
         xBqec3BOJLFmmd7BWaJezKSELFyZccnq68GMfrdY1CWCMclp9PplhWnEqAa1LZ3Zt4su
         SXtXS+BbVoEJ3KPrg9tCo8OjG/UQ0YW+GwgERAKxooazImHsw8mmBNZ+zWOdS2Px9TL4
         VSWvzToORPIt8UXBiKGuMz1pWa30AvgdGTdbT1keNKEXDRB0NXG+tgzpIeLkav4aX56y
         S9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rr3FNWqLyEocClfsiOxIWZdFzWUVS1RMgAIgFANnDlQ=;
        b=YS3RmIBFdxUSrEosXP2yvNKYQxGGSEu/o3bTeVqVVuwr+jkmYOv7haKJ+bvPKFRYLB
         5S7PLx17HKn7ocUvFvA3LBHG+X/F8y3WN+7vwSza88opZQmnhEe0rQsJl6l9Kr6aANY/
         oMRSrZ4ZJ3hN5qbpx3xn8rFgu8n3JCRP45Kf002FQjYnGReAwQo30yZMNHfM3W4XG6zO
         7l9q9L10hJ0e2W2a+G4bANrGLPlFI2eaHyKSqmNNETCpLfXCF5XHj+FSuLzO69w+wOBG
         cTdvHKLY5ixUdOZIymGtnEtr7olMBoRXh9T58mrWXBnXnrI/WTFgsualRc9T9FDEoEkw
         CLmA==
X-Gm-Message-State: AOAM530EagltyIp+EZJunewvvd7igmL8PtUqoEF24eqQSz8ltMgYrYlW
        yz+ocBQhm9nWYBOu5j83YLSYvKObXJkjRw==
X-Google-Smtp-Source: ABdhPJzwU645qxdyGD32QaCCyaznkEtBz2vr0KbyNS8yHjsC9s1lyMWbrV6A+qzD6N4LQrLf7kRyZg==
X-Received: by 2002:a1c:804a:: with SMTP id b71mr38030771wmd.82.1620812994769;
        Wed, 12 May 2021 02:49:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm26099117wmb.35.2021.05.12.02.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 02:49:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: make PERL_DEFINES recursively expanded
Date:   Wed, 12 May 2021 11:49:44 +0200
Message-Id: <patch-1.1-92571a8cf7-20210512T094803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <xmqqr1idn41e.fsf@gitster.g>
References: <xmqqr1idn41e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 07d90eadb50 (Makefile: add Perl runtime prefix support,
2018-04-10) PERL_DEFINES has been a simply-expanded variable, let's
make it recursively expanded instead.

This change doesn't matter for the correctness of the logic. Whether
we used simply-expanded or recursively expanded didn't change what we
wrote out in GIT-PERL-DEFINES, but being consistent with other rules
makes this easier to understand.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This is a trivial improvement-on-top for my ab/perl-makefile-cleanup
already in "next". I'd sent a v2 of that in [1] not seeing it was
merged down already, this incremental patch replaces that and results
in the same end-state.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com/

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b8d6b31305..0705fc2d3f 100644
--- a/Makefile
+++ b/Makefile
@@ -2271,7 +2271,7 @@ perl_localedir_SQ = $(localedir_SQ)
 
 ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
-PERL_DEFINES :=
+PERL_DEFINES =
 PERL_DEFINES += $(PERL_PATH_SQ)
 PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
 PERL_DEFINES += $(perllibdir_SQ)
-- 
2.31.1.909.g789bb6d90e

