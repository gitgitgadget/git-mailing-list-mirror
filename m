Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F122AC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCHJIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCHJIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:08:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C268EB5FF3
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:07:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e13so14599156wro.10
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pmRz3v3Hrht8hHKGL7OOBR85+GFIGz7ixvjtemVP/Y=;
        b=giCyn/TvAOMe4G8Rv4SlDAo5ALlk4BMHfPSOfWu41wAfK2HVy086uGgMqH9e4Vr6Xo
         Adgi/TwJAKN9nRoJpAP8IIdf/+K2QsfRzaH02C3NROfFGcyK+LTnhrGf8oJwhcraqc43
         S6RLawvDYe+UiJcb8wbxczjDhPcjmA0BcNE0V7ZKB31l+/Ozf9n3hm8g+ZpnhrBvWwWt
         FxjnLAmAim7ktWUDESlg3dVPiT4lsc7HT/Mu0aJ2/elcObW+3EaXxJENBDi+9mnKZRRN
         qH8yyu70+51UVWaBL598lA7+fH7aUUvSJLjfFFCXpnINL18nPBr2r3LauHHj+jlEANO2
         YiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pmRz3v3Hrht8hHKGL7OOBR85+GFIGz7ixvjtemVP/Y=;
        b=w2Q35hTrxsfQ4FkL1viYGKmYOUaoH1BhmLnTROsnIypXlQm1yn5FgbT0kfUG79cOxW
         lK3GSs20y2YHW43btZWcWMY56N8ovuX8EoXIuv3JFi55gIy+KbqN73Whx74UwbXGUvge
         jASKMLyiDMc6GaG8vCxOlYID3OM65sKnjM9Nd5x/M9JlEKW3KAcn7oJ8XhCPj9tykP2b
         zZioXunxfUbXqmOOCoOqdVrFnCCo/mH5Pk5m4g60eIjJqPY30XxjKN/63A9fBbCFt7rM
         Th99HlR9l48/Xs1OaNOGFkDto5xYx7z8s42fIMV4B9We+8XwiO84hCYgkheACAKoZ5nv
         M9pA==
X-Gm-Message-State: AO0yUKWkytDYzBo45IvQQCjDsD27kMlC8l53lZ4P3E2cyDpc2gU1GN3W
        JXo79qdQ0WipXPpZoMI5fSIGhOiXVEbLkw==
X-Google-Smtp-Source: AK7set9ryI9Vmv35DZqUg+qNNwCOi3UoCDDUmoJ+II+3GOBymHEiee98FFMB1ZUhA7eMcNviI/20pw==
X-Received: by 2002:a05:6000:1289:b0:2c7:1524:eb07 with SMTP id f9-20020a056000128900b002c71524eb07mr9991739wrx.67.1678266442516;
        Wed, 08 Mar 2023 01:07:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm14435156wrm.92.2023.03.08.01.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:07:21 -0800 (PST)
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
Subject: [PATCH v7 4/9] versioncmp.c: refactor config reading next commit
Date:   Wed,  8 Mar 2023 10:06:46 +0100
Message-Id: <patch-v7-4.9-3a5a323cd91-20230308T090513Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com> <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
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

