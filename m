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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E41C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2553A64FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBDVHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBDVHd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:07:33 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DFEC061794
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 190so4331039wmz.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrxhJITvh/JFLu/TQm4W9HxXuDchoeDmPm9ANtG+qqY=;
        b=o9T78UxClv6BuYu0KTODfdBQQXtNHkzyxCVfi/Oe/wSa/RYMJNBAgJ/xxkGKPzWAE3
         OVYany0c5LNZhMexWOzp60gLmE3X5gS/uqqpy53jCqSIUqV1CbXcwCwixSHkF89RakU+
         Um+f9mKETtUpU/BRwAWIMlcs29pSKEjzwobS8VFTeciwLlQ9C0X7F9mSRWVpEpupmTk5
         NTuFrdXgghPKZhwAPb3pLckDJ5Kl9znSIXOgNiIUvw7w125we+UCGSJSjkiACCIROKkC
         PDow8afoqaoLGO9iE7VhCPKWBXOdGgqQVh8M0D3aVgHywqffHo7GesA3pjgyYnb0AceY
         +fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrxhJITvh/JFLu/TQm4W9HxXuDchoeDmPm9ANtG+qqY=;
        b=WWnhuVLJf79ULBtbScaL0HUtu1ZLvO34V1UoSYsdWexZW9B2lelJ4M575mlMD2ppt3
         BsNgCYGUsmS8G/VykDNVIlEuP3Q/bjHyfGu1Hdzez2Wcw1psH0ylyFD8jCf+ZZmP98an
         mzVeaFkMRaD2SWmEKh/048kDP6KxiFeuEx9jBlNl26FtunJwLaZNSMzbW1YqJgg7i9wK
         pWjDOEz8hNMg7VJNnv07gDg2wRqvh52huf/qY3t+a2WhGcLNER9JYYsTSU9NBz0Jhe6W
         rK2pE43CYq1qXpBLbSUAProHZq9DcdtZjAo1N14Myrlu0Wcdc59W4UrjHcAvIHoyXvKO
         XKPA==
X-Gm-Message-State: AOAM533FKgmyUWfnu4yK4lHbeNccQfR/ivMZZHf3I2BRn1U6Fu3j8Eto
        qgwEBlajBFPfDWspLHZQzqzxcK5M1pqQLg==
X-Google-Smtp-Source: ABdhPJxpRBeAYEi9J/GRNzI053dFTkY3hVyHLYcpT30TNDYUE8Gaayl8Ura8wmUkir/E8t5/Zk4fZQ==
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr883295wmc.168.1612472777629;
        Thu, 04 Feb 2021 13:06:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] grep/pcre2: use pcre2_maketables_free() function
Date:   Thu,  4 Feb 2021 22:05:53 +0100
Message-Id: <20210204210556.25242-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the pcre2_maketables_free() function to free the memory
allocated by pcre2_maketables(). At first sight it's strange that
10da030ab75 (grep: avoid leak of chartables in PCRE2, 2019-10-16)
which added the free() call here doesn't make use of the pcre2_free()
the author introduced in the preceding commit in 513f2b0bbd4 (grep:
make PCRE2 aware of custom allocator, 2019-10-16).

The reason is that at the time the function didn't exist. It was first
introduced in PCREv2 version 10.34, released on 2019-11-21.

Let's make use of it behind a macro. I don't think this matters for
anything to do with custom allocators, but it makes our use of PCREv2
more discoverable. At some distant point in the future we'll be able
to drop the version guard, as nobody will be running a version older
than 10.34.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 4 ++++
 grep.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/grep.c b/grep.c
index e58044474d..c63dbff4b2 100644
--- a/grep.c
+++ b/grep.c
@@ -490,7 +490,11 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_compile_context_free(p->pcre2_compile_context);
 	pcre2_code_free(p->pcre2_pattern);
 	pcre2_match_data_free(p->pcre2_match_data);
+#ifdef GIT_PCRE2_VERSION_10_34_OR_HIGHER
+	pcre2_maketables_free(pcre2_global_context, p->pcre2_tables);
+#else
 	free((void *)p->pcre2_tables);
+#endif
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 54e52042cb..64666e9204 100644
--- a/grep.h
+++ b/grep.h
@@ -7,6 +7,9 @@
 #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 36) || PCRE2_MAJOR >= 11
 #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
 #endif
+#if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 34) || PCRE2_MAJOR >= 11
+#define GIT_PCRE2_VERSION_10_34_OR_HIGHER
+#endif
 #else
 typedef int pcre2_code;
 typedef int pcre2_match_data;
-- 
2.30.0.284.gd98b1dd5eaa7

