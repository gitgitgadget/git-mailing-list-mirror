Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60AEC433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF9A60EE4
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhIZTFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIZTFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7FCC061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i23so45508266wrb.2
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gb+f/BJ51xtw2n/dWvdWWTto5tqw0aSHjIr8Kl07ff4=;
        b=mFZUi3IeKdMT1Clk4P6+0KRsn3jTBto2Rma7N9xPofnxJPkuJ9H3NITtk/HxhScaQR
         iCHDn6XScE7sVhm7H91s9DOP6amjfOKtVUThkT2VJuMJjG+3eXiKOrlle/u7vF6qBHaO
         hvbVfqesSRfRFmpwXRlNgREiTVw3wCEeWXRV9uvIc8RlTMENt+mxs/wPPIrTNF3aTqI3
         fg809DlcT3KLo7R7/rY8wryGQilRjreziVP2Wp56k2dleQTb04ghgkdAJgXTzfdqvlO9
         OTyVKnCrf0ctKAXwItolgmDYlqXObk5To2FDgGWlgvAqLp4KCSxB1dRLqJ0RU1LRojgO
         Vyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gb+f/BJ51xtw2n/dWvdWWTto5tqw0aSHjIr8Kl07ff4=;
        b=n71Y/AmQtBChfoS/bY0FRF0AkQQeiOstFdhMzUxMjAbh+hfkKuC6dF0fkvyFlitE+L
         tCTyI+knjCKg/cgaeIuxUZxWi2qutpFdfImEjnJS26MyNrLRt4PKzmEBEZafYeTGmRTf
         k3x/RKWL3cZ6cNnGT6/3y4qwDkDLIHuEHQBvu/J/iwRm1DmdYS/5TesulpIOzrqDkwEO
         +i0ggoT0dIQp/HqZ0YWedtoXnJcvfjD3TsKcAJhlM+0uOIGR+/syrfz/5QlARsu7LUjQ
         L7lLQegr3pMC5rpmcSVYIp15umX3iKLBQDPhC6Q4kfXHRclNv67qLwLHod/H2u/lVRz3
         27bA==
X-Gm-Message-State: AOAM530uwZsd62fmMGMN/gOGvxo6ps2UDJ6SKMXWcYooaDnHg1efxuQ4
        ytgcTlyMfX7+omrjH7hJeNs4tJD2lr8qPQ==
X-Google-Smtp-Source: ABdhPJwxHKyX7HAmgszXB9j2N2DSG8YSzWfYz73Z9D8irqqdZqlRzkN2P2rVRQPlClmm2o3XVb2gIw==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr12465450wmq.146.1632683013012;
        Sun, 26 Sep 2021 12:03:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] Makefile: mark "check" target as .PHONY
Date:   Sun, 26 Sep 2021 21:03:22 +0200
Message-Id: <patch-v2-1.8-095ef66c29e-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
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
index a9f9b689f0c..2777284b0f1 100644
--- a/Makefile
+++ b/Makefile
@@ -2925,6 +2925,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
+.PHONY: check
 check: config-list.h command-list.h
 	@if sparse; \
 	then \
-- 
2.33.0.1291.g8857a6a91ac

