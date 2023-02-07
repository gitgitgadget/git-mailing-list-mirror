Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED6C636D4
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBGQLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjBGQLC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:11:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01FF113D4
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:11:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v10so16248394edi.8
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOraxG72tzmgx98EALEN5W3ExHljLdOXyeLmtJ5eY50=;
        b=fWM/EcELPhrbq0z0+vow3E00MIGaaKNk4I3hYWKnFSAK6tMAjafPzzAF6GLHuvqSsM
         48oKKXr/65KrAi/ALxoSlkom6oBvHeEPWQ+c49c3oMnTcIfKHvwYmEjumze2VBulTMx1
         4KYd0zQpbOd9I6qABx4FfoS6NaNob9vyovUwaG27riy4M2BKux86+Cd3rhfUy9QCjxYR
         VT9vSH2B7299Oudd8kijc4QRuhG+oOmO5/WhsrBbi3hHzkiNWcFjthUsLRrSAyW/t2gC
         8IGmV/k/7nVVS/6rpn2S8/RZW/1mGOwwn3RlD7UuEVKRpKcYlnPc13R2Vb5a8aCUDyj2
         Ql/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOraxG72tzmgx98EALEN5W3ExHljLdOXyeLmtJ5eY50=;
        b=Iu+2sNrYgaEaAU4WiPzJzLz+H2UKEcQrqma5GD011UIhKoyGwryCu0tcpxSY67gC86
         39mzXqAeQseP9+9FLLSELXfvw2ZWBL1zTkI2kVMLUm3UlGHS9dE+6Sqrg1/lOk6fV3tc
         tdJVFkv6ZIJ7fIwdlhkMqFVQfS9FCnQ10lPguROLuK9abrh5r9P9k1Is0cJGafPpnQWN
         MtPZwHAHkVa6xIWB3Zt+Awhdzb2qt2UOSIgEDyOxgH9T+j7qPdimdHulAgUxoqmG948V
         r/Is+IMBw1T89GPeWQxVoaXcHOg9OO0srpYrnWTrEx2GrCRXH/wLnEP4novK58fOaDXg
         IT2g==
X-Gm-Message-State: AO0yUKU7yFoDfcvRLZaoEUwmXdGL27YoOsASkSsvI/kAtn0Zjhime7Gs
        Gu2y9/K0KC9suTI0LfB01Z2ejxfkkN2ugh1W
X-Google-Smtp-Source: AK7set+HgvCCTKYww1e9WumaJQXCi7T0hP6iXzCVE53/mLUicYsxPkWbrdWfDr47ait3nLNda5uE1Q==
X-Received: by 2002:a17:906:4808:b0:870:827f:f78e with SMTP id w8-20020a170906480800b00870827ff78emr3703734ejq.48.1675786259219;
        Tue, 07 Feb 2023 08:10:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm2401167ejd.110.2023.02.07.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:10:58 -0800 (PST)
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
Subject: [PATCH v5 04/10] versioncmp.c: refactor config reading next commit
Date:   Tue,  7 Feb 2023 17:10:44 +0100
Message-Id: <patch-v5-04.10-382a77ca69e-20230207T154000Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
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
2.39.1.1430.gb2471c0aaf4

