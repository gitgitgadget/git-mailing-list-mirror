Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3014C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiKAXFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiKAXFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5761BEAE
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ud5so40960845ejc.4
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y1Rpm4YE2eJmGfcSnynjNCovj9mBHkApSCJlWasY50=;
        b=gq1DUA5vR7hd73VFlNVJICtCe3UbdvxB15dkavAQjMjeThxFf9MeXq5zYQdXyuK1Sg
         wMuzqWGDr7gNGI3TclBE1W4j2gVLxgeSVil78a6SpePBMrvrsF11XO8BBpjdB7z4NBSd
         GYtU70QARbPfnwFaVDIc5nZaIC28e2MGz4sSnvP6Gk9zBdHyZ25hqJSZxYJfnHhdRW8M
         9rdIqfHFyTp2garQW9Fp+l9NT81iG1c5N6oEvqmckfKyK7BSNqSdHmDsBdAJvJDCvcMX
         UBR5bE5+6GWAR+Tj+dgBs6VOlLtkyi7fs6DEiMH0rpD64f+VMmEtB1Ayw7FoaGqXDwGr
         dHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y1Rpm4YE2eJmGfcSnynjNCovj9mBHkApSCJlWasY50=;
        b=LyU8qgbC4Q4l/7b8xqw+4IXXyxOlKejcElz5LcqkPBZdUtMfwP6/JORBXMOI6E7u6E
         6V9nMkaBBwnXPjUyw5lEybs4B4cWSuPKk3wK63qigXPESGAFvMQ1JP56W6z4T+LKighH
         TywVp1T0cuwuAwSdodWotBZceanazl/3wSq0ofXvbPR08QkjeRi97mmL5JmhbPiBMtyH
         t4zf+FxwvG1n373qa+jDTEcXOICm67CtLuOPbqluv0SGkrGoYAZMUr7TeOPuKmDnCZrO
         WQf7GMeEq3+NKoCmVh/gYXchaSARzm713W6ZXbWOCOPWWpxpK/o5xWWAceHkl0aanTW6
         FoSg==
X-Gm-Message-State: ACrzQf2vpqb1M/HqtaCjtAFHofXAu+Yo5/WRAY2zAkyjpZ/VhfC2eLf5
        r5JLgcPmzGsiDOmiKnnv0OKo9+i9ESMMBg==
X-Google-Smtp-Source: AMsMyM5GIE97jPAcZal5JshP3TLnmHdO7AT7UCwTBGxpDKm7w50U7Ai68Zjb5SMyRlbAsx5M0l+n9Q==
X-Received: by 2002:a17:907:9d03:b0:7ad:e310:ea8 with SMTP id kt3-20020a1709079d0300b007ade3100ea8mr9139543ejc.400.1667343935960;
        Tue, 01 Nov 2022 16:05:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] versioncmp.c: refactor config reading next commit
Date:   Wed,  2 Nov 2022 00:05:15 +0100
Message-Id: <patch-v2-4.9-42cfc61202d-20221101T225823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the reading of the versionSort.suffix and
versionSort.prereleaseSuffix configuration variables to stay within
the bounds of our CodingGuidelines when it comes to line length, and
ta avoid repeating ourselves.

Let's also split out the names of the config variables into variables
of our own, so we don't have to repeat ourselves, and refactor the
nested if/else to avoid indenting it, and the existing bracing style
issue.

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
2.38.0.1280.g8136eb6fab2

