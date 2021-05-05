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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C7C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06CF613BE
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhEEMWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhEEMWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:22:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22535C06138B
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:21:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l13so1595151wru.11
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PESc9Fo3a+ftFjyRkWBuTaL4g6p0iM/upvXWdhM7lhI=;
        b=YMudChqY7nt76gMSIIFNVjWITYgryrnYwY7fBrGbqRXx9W0WF+9E5U7huPOPAMZBnF
         M025d58GA9MzwhJ1gmD45yXESm8m3UDFZpAPt/2xzHDk1Ja8UUXpBzD7ocJwUpJ53ajm
         MvDlt41vwFgwWvYD7gOKhvdBe1iX7lf08ewdTws7yTVFaugzGkargm7pXB8NnzA4m4RL
         e1DhMZ20tZMCUtzWiUMcnirYoYuCZj9gHE79f5svpdPcLbdZZeUrD2l01miREw9G3c3g
         /Ms2RnpjPB69WpRxK7MJs8r5QCg5bV9OVKJnNKovUoZrIBlXQbPVZZAbGgUqDobpEVMH
         mopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PESc9Fo3a+ftFjyRkWBuTaL4g6p0iM/upvXWdhM7lhI=;
        b=jqg55RLKgnFRUbmkYtQ3UuL393MMMflP4xo5w2/QNmDbnAwAZHgosEWS8IwvTw2s8e
         V/mk0yR7VWgjIDVTJ/oI17vwrI2EscTnhaFt94Z1u+qH2Bdh7df5eiMx0Xlgnb5sa6db
         Prq67Qt4Prjv1wefn940DyRjnp+PgnjJkcZ07uf+5/4/MDeZOHmcV7xannxUcrlGQBNw
         mywHfPNy2alQeyz4V62Gn/2vJFkJAcYOAYccQ3KIs/E6JXsETPHoAvb0j9lGkEJMPxA4
         gyi4Zwil9sxtQRN0hth4fe9PB6my56KSuVuLow9z5qvOcNKap3c5CjYSiwwz4CLe5Jgq
         gGVA==
X-Gm-Message-State: AOAM5308tV9/xQkA3cO9hySvIagClGTRkSOhWruHD5S7fPnKLWcQ9N/h
        NLM4SPOrDxYn2nuWvXiMjongINcnFX898w==
X-Google-Smtp-Source: ABdhPJyEPhcacw57IgzmoyxovfifphjpR3vkuIzkjKYpDkKXq+IDMMsEO5ZkeMnFjO74wQ0Hwa+YAg==
X-Received: by 2002:adf:82e1:: with SMTP id 88mr4880375wrc.186.1620217305577;
        Wed, 05 May 2021 05:21:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k15sm19886643wro.87.2021.05.05.05.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:21:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] Makefile: regenerate perl/build/* if GIT-PERL-DEFINES changes
Date:   Wed,  5 May 2021 14:21:39 +0200
Message-Id: <patch-2.4-49339028db4-20210505T121857Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the logic to generate perl/build/* to regenerate those files if
GIT-PERL-DEFINES changes. This ensures that e.g. changing localedir
will result in correctly re-generated files.

I don't think that ever worked. The brokenness pre-dates my
20d2a30f8ff (Makefile: replace perl/Makefile.PL with simple make
rules, 2017-12-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1d4c02e59d9..a15f39e40ff 100644
--- a/Makefile
+++ b/Makefile
@@ -2676,7 +2676,7 @@ endif
 NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
-perl/build/lib/%.pm: perl/%.pm
+perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
-- 
2.31.1.838.g7ac6e98bb53

