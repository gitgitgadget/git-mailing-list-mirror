Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839FC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A0C61B31
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhKPMFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbhKPMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9FC061224
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 133so16723196wme.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zgie3GtPWoA96xu+bKyUrQ3tuGsqk6+zGm2gvh763ok=;
        b=TemQOGiasTS/OZw96c3K5sf5js9sQ5agl9DcnGyQE/RkRAW/TmPFAS5thS+82HxJKA
         CJdUq+dmDKSE1ouDFqJjfwAZhhHSUrRwkhvLQT322+ubPZqJ44WApZ50bIv7c8dFu//h
         5GT+gGDaBf5O9KbhJpvqu6LbfKodIdgNu6P3iQUxRTsezOCwoYRqpTKUsJZtJPhxLF4m
         HOO8uh4oog3Dmixy8fspMeXy40KQCAPD7NQkzmwzuB7O02IsIy7sH6K4o5PEEl7RcFTo
         kgcrTwVGcgBGVAdT4VVocl7yB/z5KUgbCt+G+oV2gTKFcH1rU4+/uQzzL0I3vbeCdZWn
         L+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zgie3GtPWoA96xu+bKyUrQ3tuGsqk6+zGm2gvh763ok=;
        b=gxijOusp19ayO49PQB3/Kdh67xNneL6wZMePqtY8plMN0wJX/k4yZsWmv+d9BETOct
         cHdYG8vOAGgvtttFIdG+xc3sH6vKJVuFpvPICJM4U5hFC7moI9P439NBZn0IcgDd+0ft
         NyQ7K9oBUSBkS5O8DY9hYuD6OUz9xtMEatPXNR+SZK6/fY4oix3i3srqqyWzdU8+glCD
         6pADzi9ji8X+OE4oBdGZH4O/HUEiib7tuhqXJySrfnf1CklOeiaM1XBpliQBobZvtnKt
         6xAaN2jrQeg9FQcGYRc4tqo/Y4mDM25Pwy0gpcdEck97nPJi4ViAxpXP8TKQHlc8AFZZ
         c6OA==
X-Gm-Message-State: AOAM532OC4sYCfS8GOAg7iDatXtolyDlv2FGzTDQiYb5cY3HatwWo1Wf
        WtkGS634cZyC3rdwdTAuxJ0AK12JvtIgQg==
X-Google-Smtp-Source: ABdhPJywnCx4jVsd0bHny3uQmypiGxBA3Noucv6piXlVp4y5q1Ew+EoG+OJUH50GKqL5Tti7G7P33A==
X-Received: by 2002:a05:600c:35d4:: with SMTP id r20mr7265294wmq.76.1637064039623;
        Tue, 16 Nov 2021 04:00:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/23] Makefile: guard Perl-only variable assignments
Date:   Tue, 16 Nov 2021 13:00:06 +0100
Message-Id: <patch-v3-06.23-98e14c7eba9-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "ifndef NO_PERL" a few lines earlier to encompass the
"perl_localedir_SQ" variable. We'll only use it under !NO_PERL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 284725099c9..0cb10f00ebb 100644
--- a/Makefile
+++ b/Makefile
@@ -2291,11 +2291,11 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
+ifndef NO_PERL
 # Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
 # since the locale directory is injected.
 perl_localedir_SQ = $(localedir_SQ)
 
-ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 PERL_DEFINES =
 PERL_DEFINES += $(PERL_PATH_SQ)
-- 
2.34.0.795.g1e9501ab396

