Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838DAC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6871E60F36
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhKLVwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbhKLVwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123FCC06120D
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:13 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d5so17906895wrc.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ic1VWFPLpda2LrI8ZHZeMZWsT63Tn1zRHoqa9c+HTFw=;
        b=WemldUZjdRkIzNTguxmmn29iKi9HgYWn6889ZlybXJuh1zwrBT9ohIzUL9xC7uCtCT
         fpViOrG21iI1Z/uFRgq4WFXts0Y9+4yb/Dcf/TFgd+/Efi/EIcGzsr7XJ2PWKAHyJujL
         O4cuuFH+ok4IlmNDqqaspai9WNlAKsLn07W3Zp8WXpud2qXQSVP5wk1VHxWtX7DbuuhR
         vEECtaHmK0JCbjOlMgVDywvNExwjdxs+avaNgv1geRHF5PDFg6j5qBKgrDq71QS1iJR3
         CMTsl44IXCyVz9bkaMllSQkGL6rcjyJ8kcxaeWx5iQ+x8pRVwaSM/u05YLqAdOzA0pXY
         NCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ic1VWFPLpda2LrI8ZHZeMZWsT63Tn1zRHoqa9c+HTFw=;
        b=w1fFKZLJprDxE6JjmzBvO59M2HyKqhv5PPiBH9LzX+Q5v7EYdWIfW07uN2YOLBB072
         8zVzRXMP/TVE6Q477/YyioDfFATtae/Tro41nr7XcrWypvx0xvHQfzu0fonGxbi+7wEz
         w8hcEB7omDz8CXhoS+XxC2mAnWgfE91wZp6cUdbkJSKhTZuoxZaYn7AF3Dnbla+VF8Hw
         Qq7TRZFa7y08B9sZouhWDZERty8xHP9gv25XzofolgFD/Bpl1rSLLuvo88qyRv3K6dWp
         xQAE5CSOHvb/qSNeKHVqHB0BEO38xgmWB/Gxqjsws86NtPI2lZEakYbBWgxywWZS4E0v
         TLdQ==
X-Gm-Message-State: AOAM532v/tOrNopHB+Pm+fNyUmZnLD+Pw8NFioUs44qLE2kWxsF0RaKy
        NfUmflqC7GdHrCYIGV1WoOo5dTwos4cBQA==
X-Google-Smtp-Source: ABdhPJz0dUAhehsECveXWN9vtDsBHfacDDDGgRuGpW1RaHP5mbRX3P7KdgnqgaZ1xWVFPt06jV5BPA==
X-Received: by 2002:adf:8293:: with SMTP id 19mr23178663wrc.167.1636753752060;
        Fri, 12 Nov 2021 13:49:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/18] Makefile: guard Perl-only variable assignments
Date:   Fri, 12 Nov 2021 22:48:50 +0100
Message-Id: <patch-v2-06.18-eea89794493-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

