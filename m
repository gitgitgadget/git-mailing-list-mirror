Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD82C6FD1A
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjCGSPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjCGSOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:14:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E9A336F
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:10:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j11so36425806edq.4
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678212605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pmRz3v3Hrht8hHKGL7OOBR85+GFIGz7ixvjtemVP/Y=;
        b=Y98foybvRMLZN0VYX0XllGRtYHiBP6xhC+dtnx2Z8FKH6YYVmeVoUVaX4T/uEf2iB3
         M2UkbmMcy7anX5ldO7nBeCt3KaFBhx2AdcKZEto9GAnnebFbla5YQ02qogJLg21TmC3m
         xtzgIY6bHzyN3wDWYu4SRNyajP2U2OIpG0NxOP1ApyYYZeUmONzUo9d56Wv0YbeZC+bv
         VwLloFCCXoztWM2n6Sb+hXEKyRpqttvezYFj/rzS7j6bs6tiOFf0KI6fSpA36+cf3N8F
         YMZSGqR1jKzIya6aBMffJbon2Znn7ZD0HHykT6fQhdQrlyfdyGPhxYpdmnPTdJSBbAqS
         SxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pmRz3v3Hrht8hHKGL7OOBR85+GFIGz7ixvjtemVP/Y=;
        b=8AOJYjlwoQaGrRECkUW2UVsahxVn8cS8iWspYZUQddHIlLkjgjLvebvenBECYfVApO
         pl0a6A05dVFPK/0fpwVikSwm+Sv/EBmHofFh8LjGR9693f10s0qY18Rco51w1L37Uvfl
         YOfoiVEdVmqevnT8GqbiarSwVMoV0NpmhNSPzr5NpmVuEwy6mXi7zlu7+VJvHjlXwLUj
         XxqJ28NMrgFNdsiCp8olGTRBhq6S8i6pLLrbmwmKMqOVwvn0txKerfKWHwZ0sFulwiqH
         Wdmcfx9X9OBCj9UIZvLc4kVlSHLSrzxWnVDsnGWI0L2+9c+NYTPoA52JzitYjJdja3hf
         gYHw==
X-Gm-Message-State: AO0yUKXX39m/GXxZHlQ2opldkpil5efjhMTvfD1zt6EwepDhrC3akoGf
        lO+q4VTE8/81Gmgh9fiZumqaSHwpvO/hrA==
X-Google-Smtp-Source: AK7set9c4zSV0dbP2tj3I2blWwcaqEO2CeScrjXcxoq+UXlf4updYNXXVzMYgPH4rYG9X53MyQviVw==
X-Received: by 2002:aa7:dcd7:0:b0:4ac:b2c8:aeac with SMTP id w23-20020aa7dcd7000000b004acb2c8aeacmr13041990edu.40.1678212605585;
        Tue, 07 Mar 2023 10:10:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709063ec500b008b1797a53b4sm6401008ejj.215.2023.03.07.10.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:10:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 4/9] versioncmp.c: refactor config reading next commit
Date:   Tue,  7 Mar 2023 19:09:35 +0100
Message-Id: <patch-v6-4.9-e36303f4d3d-20230307T180516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the reading of the versionSort.suffix and
versionSort.prereleaseSuffix configuration variables to stay within
the bounds of our CodingGuidelines when it comes to line length, and
to avoid repeating ourselves.

Renaming "deprecated_prereleases" to "oldl" doesn't help us to avoid
line wrapping now, but it will in a subsequent commit.

Let's also split out the names of the config variables into variables
of our own, and refactor the nested if/else to avoid indenting it, and
the existing bracing style issue.

This all helps with the subsequent commit, where we'll need to start
checking different git_config_get_value_multi() return value. See
c026557a373 (versioncmp: generalize version sort suffix reordering,
2016-12-08) for the original implementation of most of this.

Moving the "initialized = 1" assignment allows us to move some of this
to the variable declarations in the subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 versioncmp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/versioncmp.c b/versioncmp.c
index 069ee94a4d7..323f5d35ea8 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -160,15 +160,18 @@ int versioncmp(const char *s1, const char *s2)
 	}
 
 	if (!initialized) {
-		const struct string_list *deprecated_prereleases;
+		const char *const newk = "versionsort.suffix";
+		const char *const oldk = "versionsort.prereleasesuffix";
+		const struct string_list *oldl;
+
+		prereleases = git_config_get_value_multi(newk);
+		oldl = git_config_get_value_multi(oldk);
+		if (prereleases && oldl)
+			warning("ignoring %s because %s is set", oldk, newk);
+		else if (!prereleases)
+			prereleases = oldl;
+
 		initialized = 1;
-		prereleases = git_config_get_value_multi("versionsort.suffix");
-		deprecated_prereleases = git_config_get_value_multi("versionsort.prereleasesuffix");
-		if (prereleases) {
-			if (deprecated_prereleases)
-				warning("ignoring versionsort.prereleasesuffix because versionsort.suffix is set");
-		} else
-			prereleases = deprecated_prereleases;
 	}
 	if (prereleases && swap_prereleases(s1, s2, (const char *) p1 - s1 - 1,
 					    &diff))
-- 
2.40.0.rc1.1034.g5867a1b10c5

