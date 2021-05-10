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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD1C4363E
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB83E61041
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhEJLNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhEJK6j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 06:58:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D40C03543D
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so23820858ejc.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZ/ClbzV9H8RKqOFFPH4iNkzX01/7hGGAxTOov1k7dc=;
        b=Ty/WBWr8KbCGu+P674ZDfNO2Cc6kXdlQl1SXn14Du/Qpn3dQ/M1LR4qDThbCvi5BAN
         G8yPp7UPNZp2JHIjkom34ZwEi7zU4A/2JHXHf4UhMQtm8ORmlUcc49faVNx6svqY/XSO
         ldljWLuE8rgm804j7rCXx244U6CTajm+bIcDTtQp6hkZdK2ppIhYoxXZotBow47mvk5d
         xWkgs4KzNNz5mHjBe+8GgeYV/pfORKPNXLAftjjxlOdpJb9cs+gU2I6l5J+ZXMd9NMKQ
         p5M93V8t68NTFqr04NkF2Jbdn9ibtU6dZwOwwR26HTWbE0mRtfeAvpeRKUaFNRnudfD+
         Yxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZ/ClbzV9H8RKqOFFPH4iNkzX01/7hGGAxTOov1k7dc=;
        b=OzCFamur/Z5vzUCsSFVattn1h+e0ekdaiNluD83Gr/F2Q4WHgGoo9l/Sqse4bm/QLq
         7QQhgW2Vj05EjpobP5r52CpJYcz2rKiAIxjDw6X666SclqJAjMriNGlhlJ4hA0Gq1m7X
         YB17G2W57bM7ZE3GphU7xUo40YDwbX6H7dioDgDBACu6QNi3DCqvISxRllDDJ3FCT8kE
         tmG26wvMYbqNM1e6ax5y5rb1Z64LgZdqlduYfZG52KU9LNsgIyyNfP3R66LJy9dp/sGm
         Bdw1goBAzMvXZAQAaTCUegMzq2UIv6p+s5iAzX6fprRU78EdpRND93qfxWhkDavoc7Mn
         oeVw==
X-Gm-Message-State: AOAM5308Virr9Yi0vTiWL1LiKF10Junvs6qSj+Xloozh8v9MwJSN0j//
        gkBQti+E5fOXn1SSDiJlgeOqg3IytLwfrw==
X-Google-Smtp-Source: ABdhPJx2rPLyuyS8Acst1sugww1g6K3n9krAEl9RbWgwT4zVsvtl3oV34ub57Lf51INiWJNObThZnw==
X-Received: by 2002:a17:907:765b:: with SMTP id kj27mr24940225ejc.537.1620643830234;
        Mon, 10 May 2021 03:50:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13sm9050741ejx.86.2021.05.10.03.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:50:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] Makefile: make PERL_DEFINES recursively expanded
Date:   Mon, 10 May 2021 12:50:19 +0200
Message-Id: <patch-3.6-7919ae0e546-20210510T104937Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com> <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
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
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ea387b431e1..3ed6828de67 100644
--- a/Makefile
+++ b/Makefile
@@ -2270,7 +2270,7 @@ perl_localedir_SQ = $(localedir_SQ)
 
 ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
-PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
+PERL_DEFINES = $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
 
 # Support Perl runtime prefix. In this mode, a different header is installed
-- 
2.31.1.838.g924d365b763

