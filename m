Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1E0C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C490960F5A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhKFVGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbhKFVGG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D49BC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r8so19455918wra.7
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MOjSlMOQs7QNWeXQP6uTTjZZe7uhqDMM0nEoVx7MBU=;
        b=AW6X13NHvcNcmqEkXsUUjEJe3Ud/ZDqssJ+3jriVhro2oAm0dDVt8nVqdWH88AKgY5
         sKp1qaVGLnwK8sN1Sdb0XiE/F/xCnRebbwPQ1RZccsvZV2sJFmIa9zm8xTuvonWFMK/P
         hADSIfpDFUSFk0OUT181yRkKy4muoMyVyek1febOOXvDzOle+RU2u5R93XJYc9LHhTpi
         Xr7Qq4lU80fZLFN760CGNyHbT8SLW77bjH6MeSzNpw+DcTR1ksb6CwDjbKLSwvK3Qb8b
         q5ux2UOQW2YQMB44jhLbHCy4/EoYtBgH0MjBPFftq4fD8bij3F6Ufg8vdufZYMqqq/ST
         q9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MOjSlMOQs7QNWeXQP6uTTjZZe7uhqDMM0nEoVx7MBU=;
        b=5OeL/T77tUXUtvsvvX9SDSGUsdqTi9GF4PxtJB4GG7oHj3ITdU+Sp8Bb9l1hqcYhF7
         1CY7ZkvX0w0kI78hqtF3qRe2/rG9cjtT/Lan/aAE8gXRy2I3ayL1bca+9CMvxnHSyFMs
         7GirSEk+N/I8f+YgLz4UHiRpSWn2FPif1dll2KOaOVIqb0rFU6YV7U2wgTPrI20CWp4e
         lSoPHFQbfuODQvNUN7h9WH6ygL0BOpyNl6CB6//uZlR2ryuQ+SF1VqwOMT3DmHizK4PK
         r/+6WytwfH54cDrVnpIwFogytpyfHEEUmR+o1XPf8LnyIBuy30HFqxhmEQU150bjKCAt
         QSEw==
X-Gm-Message-State: AOAM532iB5X1EnzRSiJBh5PX0mA4iipzVRVerVQZqRCke+lgFNHXO/X5
        r7AcEAo7gMAIzLK1VEEgXbwaMg9Gy9ooJw==
X-Google-Smtp-Source: ABdhPJyyLJ0+QdHapmcSGIYKsviHKKOpAFfsOsJ+zYOh8grxY1sZdrDAWVUb++NhU0Wyc/E5Ewfmpw==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr18730233wrz.286.1636232602676;
        Sat, 06 Nov 2021 14:03:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/16] Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
Date:   Sat,  6 Nov 2021 22:03:04 +0100
Message-Id: <patch-03.16-fa2f10a0cd1-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
2021-06-29) we don't need to guard the clobbering of $@ with this sort
of "mv $@+ $@" pattern in these cases where we're merely generating a
file that'll be used as a dependency for other files, as in this case
for GIT-PERL-HEADER.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 82eb8ea446b..009b08152b5 100644
--- a/Makefile
+++ b/Makefile
@@ -2349,8 +2349,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
 	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
-	    $< >$@+ && \
-	mv $@+ $@
+	    $< >$@
 
 .PHONY: perllibdir
 perllibdir:
-- 
2.34.0.rc1.741.gab7bfd97031

