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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7785FC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD9D61037
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbhHCTjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbhHCTjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F7C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b11so21163564wrx.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGhfhM2StsDZotV0FH96QboWHkMW3lg3Gbh/P4LPikg=;
        b=oXDjKUkq9Sc5OdRpLy8Zpm2aIJUNT0vsWSqy+jbieGBQQlwMGDaPkSfdLrhBpKj4n5
         zrU5pu+ty44c1/IZgol8cUDpHDhFIiaLu4eF/abSP/R7Z3+q/F4767CVs3z/kO11BKUk
         KSvj7FbJlCDMnMsZJrdq0yneUTmbaSQETkGVPHTHpdo5JxtRQ+Nw8thpW9idxb2QehGZ
         VyX1S9p34MH1hr7MAhRWfZakuFweg2Xo77/CPEyjBPi5yXOarmFKRA/NLx8vcd8hHIrN
         sZ790HhjVanajlrNL1Fre2BDEEkMnkSseU2VgjsVkM3nAekVJUWyAWWeS6kFg2NMauL9
         wX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGhfhM2StsDZotV0FH96QboWHkMW3lg3Gbh/P4LPikg=;
        b=IUIPu01RqxdMHwvpyqgAO4alQfJ9yZg/C9upPHocKSyxkFpNgw7xqyIOEpeUNw6zwV
         CZtzXzIVlqlZp6jThuDZUulF0nC5qI/38E8bPhgdS1jAftuF0rHINgRY0QX/ADPzfQri
         ui1AmNLxi/VwmpGCLBnoPwGSN/yBDmsZDOZQKfWzS1a76smpU9nBg2r31VwjSH9XvfaU
         LEIgukTbBs1jdd0EyavZu5L6BpcGgV/Egzu9Zch2Sj1O+6lywH4nD5NZafqkGO77LxKN
         zgPI918D6V0bVXUq6f+ArF1cK4uAsVKBKnGwaIje4uTCtPMM8F82XvNOmjg7qMWBLAPY
         j1mw==
X-Gm-Message-State: AOAM5323AWImdd5Rk6XgMj+mGsBKYD4pcrHFJiHM98m5iAxcARuDwu0l
        nlt3/ZkFjgSdJco1JlaEkrhkfngg63aqVQ==
X-Google-Smtp-Source: ABdhPJzuU2KWGtjpT1SR+Q/Zt8nSe1aBi5dcgTeQTPYNCoBg4gTs/yfFcc5muH0nGreNe32uGNujbg==
X-Received: by 2002:a5d:526a:: with SMTP id l10mr25384792wrc.40.1628019551142;
        Tue, 03 Aug 2021 12:39:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:10 -0700 (PDT)
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
Subject: [PATCH v4 01/36] Makefile: mark "check" target as .PHONY
Date:   Tue,  3 Aug 2021 21:38:27 +0200
Message-Id: <patch-v4-01.36-81fe1ed90d5-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index c6f6246bf63..2ff038069e8 100644
--- a/Makefile
+++ b/Makefile
@@ -2931,6 +2931,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
+.PHONY: check
 check: config-list.h command-list.h
 	@if sparse; \
 	then \
-- 
2.33.0.rc0.595.ge31e012651d

