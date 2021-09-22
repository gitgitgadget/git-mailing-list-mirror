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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3359AC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1497E6109E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhIVS6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhIVS6m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 14:58:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7152C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 11:57:11 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e16so3635895qte.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQlVeoYJ7lVbvKu40aM90XnlyFB05SwGdhWbmmDD2N0=;
        b=FU9vGJhbr92chFffbXEi1fqWCMlW6iCTipZe3JZTuyO+q7vcFMqsa5MXpOpG0SN2TF
         cV68FxWJ0MC5HokXJCsNA8r/W2begicZvTbrakquvLVWIXPSiEJ0NzkKh+rDG4aYAr55
         pYjKFpmD3Pwf8JPWm+uP12h4Hnq9EqNP1Z+VDXdKxBNvlm12pAM7xF0HxZ2ciYLLA9Hm
         YTHGEofTnouOXyzVfQqxozz6uvCb6Bz0VCNNNfezftaZgxxau0l+eXdt34l3gZvRl1xt
         IYtKv/VVGYMCCq4+34YqxdL3LnShx8ocLhlLlvkL7aS1bes4nwC1jb59BW2nryO3EQzK
         Di2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQlVeoYJ7lVbvKu40aM90XnlyFB05SwGdhWbmmDD2N0=;
        b=O92hasTfm9OhZhks+OIZAbXPjzceJ0OBqYhrh7s9diRJxlIcpIaFG8YKAsdY/hYuvM
         TOR1Bud0RBP2gux+ZD4nFNVBN22Xu6r84P3MhBmYdv2gH/MDdTel32s4sUP9MMAdXNzO
         ynh43ll/dQfRpPmRcr8CItsC1C/mb4BWzvr/q8qH6YsEL1yk0wLbsUw6o2YVEILTCF7P
         jOoDCxz+1TH6Z93BMmXVvDKu6+xehnpRkAABPsC8UJRFWegQ/FPqNj7/bqFQGqWpVu++
         P9SeYfdRP56RQlhueGFylj3vi2K92zz5WKmLAan/hCIZAFiErHlDXZutf6LH4nhodNFn
         iQHg==
X-Gm-Message-State: AOAM531LR4kWRKMe2/fHWcGXST+Z5yrNR/GZGAnKOpinCNQY/bYPk1aq
        VYueDgPFpfQn61/btrEvjJYmpKZ7Mh8=
X-Google-Smtp-Source: ABdhPJzprQWnm7o30ruSevLF9p7pE8ZnGlUTFQELEKjqTLhIReQDe5KryVrkUHW1Z7eQ8jHsvQHP0w==
X-Received: by 2002:ac8:7050:: with SMTP id y16mr878716qtm.44.1632337030765;
        Wed, 22 Sep 2021 11:57:10 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id y22sm1853664qkp.9.2021.09.22.11.57.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 11:57:10 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, levraiphilippeblain@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] Makefile: avoid breaking compilation database generation with DEVELOPER
Date:   Wed, 22 Sep 2021 11:57:02 -0700
Message-Id: <20210922185702.4328-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.911.gbe391d4e11
In-Reply-To: <20210922183311.3766-1-carenas@gmail.com>
References: <20210922183311.3766-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

3821c38068 (Makefile: add support for generating JSON compilation
database, 2020-09-03), adds a feature to be used with clang to generate
a compilation database by copying most of what was done before with the
header dependency, but by doing so includes on its availability check
the CFLAGS which became specially problematic once DEVELOPER=1 implied
-pedantic as pointed out by Ævar[1].

Remove the unnecessary flags in the availability test, so it will work
regardless of which other warnings are enabled or if the compiler has
been told to error on them.

[1] https://lore.kernel.org/git/patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com/

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9df565f27b..d5c6d0ea3b 100644
--- a/Makefile
+++ b/Makefile
@@ -1302,7 +1302,7 @@ GENERATE_COMPILATION_DATABASE = no
 endif
 
 ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
-compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
+compdb_check = $(shell $(CC) \
 	-c -MJ /dev/null \
 	-x c /dev/null -o /dev/null 2>&1; \
 	echo $$?)
-- 
2.33.0.911.gbe391d4e11

