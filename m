Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2ABC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjBBN17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjBBN1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:27:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A08F507
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:27:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so3728811wmb.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 05:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fML4UxGMWMWjtU6Ucb7Zg8yKYyLsNwP0LQBotHh9Uk=;
        b=E8U9XKBv+y0OI+XaiW7D+CwK4FkfeP56U76sVwuuiKD102Gc4o+Gau6FG9rDTlLwRy
         Ba32Ex9hjl/GUNSexj8DE++cqolZ1jhNAMuRadipga4AKuskSRJeC6lzL0yU8HQ+HBDH
         ggBTh0qECF3p5zwnd3nBxncNH00m3fR19s5x1clD3DuMmp7GFkbVaJKJw1O7oi6iZxJ0
         fPd+Vd6okGUYVlkz4OgN6bD9SnjyvtjCP5YPSKVdJJ1qPFYywMyyYdaDn4xR3SLsfR6Z
         XKhJjdfnQptl8htw+e8eqmR8gvIv3s79SRm/tioCx9mEW/4yqgZvMoytdDyItEdBWo9E
         xa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fML4UxGMWMWjtU6Ucb7Zg8yKYyLsNwP0LQBotHh9Uk=;
        b=7yJwzvkSktnNzTihP+IoS4LEb2pDxa0yX3xpyPloFxlRPNo+tpBK5qAcgOrkZDlXYD
         KglHTv0m+IJrroX4dCoD21RMu+g3hW7mmr6tGvvqMqfp77c9FhsUA4gnc4dvm8Gz5O0f
         +f27buMoB2djfCPhRJLjsH9hF5vB9u+QSvHr7/2NSf9S/RtDWKJHW1W+iaLQG+uP9gH0
         EtZUX/C5gvDFWrFsGO1lwJSE23oUD857CVkbXn/f864Je1E9DboVXYytlB4VzpB4OAzt
         v6h5tuwPzCDxYyK3t8fMPt+DF6ntRmGTXJENuj/MxIlJ2x7SSq7wrYmEMCVcGAouDDaE
         d0aQ==
X-Gm-Message-State: AO0yUKWzHTzagXSn/0lioExW1I836FunHqAOqWtK7KciyqPqJ7w9ziSO
        il2lH2RN6ozuPMGL9sRxZ/uWPZCl7oU3aQyU
X-Google-Smtp-Source: AK7set+OPVPgX1nCn4TAFE8oqzsJh8O9WczdiqdPN4vFOt4lx0L1CoqrHGJjXRFZxtdMLN0kFG1E3Q==
X-Received: by 2002:a05:600c:4a9b:b0:3de:1d31:1043 with SMTP id b27-20020a05600c4a9b00b003de1d311043mr6017488wmp.21.1675344453082;
        Thu, 02 Feb 2023 05:27:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003dc48a2f997sm4306052wmf.17.2023.02.02.05.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:27:32 -0800 (PST)
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
Subject: [PATCH v4 4/9] versioncmp.c: refactor config reading next commit
Date:   Thu,  2 Feb 2023 14:27:16 +0100
Message-Id: <patch-v4-4.9-aae1d5c12a9-20230202T131155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.g8c8c074958d
In-Reply-To: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
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
2.39.1.1397.g8c8c074958d

