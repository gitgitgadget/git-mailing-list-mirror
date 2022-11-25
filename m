Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A582C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiKYJyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKYJyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226945091
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n3so5961203wrp.5
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnU6EllX4TdTaD4rwWXJlLjdFETlIhF17oF2zscSWwE=;
        b=NTXLdhuJRaTnHPQ0nfB7rkMIkvF+kZcqNwRj0paUUXiJd1vrE+OMcTc85q+kG6Wxo/
         E7pbxsEkm/4lBPC6oVRqAYc7vlnVreg+Qr8XlFp26E+GXyfShnlrBQzEq7l9pLAlWRwo
         qBPH+ES9A2F70a3fM98ejY3LVdkfqm5aJt8wjkeVET2zufGhTIx3yW8Kb/xVIg5aMz1j
         3BwfTnZcxHxzmFGSP90W0n0v7PhPwo9RWPZa+Jqt2DMH1PRkrvUrY1Wq7NaDw0gPzuFC
         3Yeqp6YPOEW8KxYuskzww8AVaOh8Nz0sTfm0XLXpm/0jo8YiYcBNl1lD422oQmAfXCYw
         alwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnU6EllX4TdTaD4rwWXJlLjdFETlIhF17oF2zscSWwE=;
        b=Ln08IvRClLRfPz6EcTZckT9WHS9HCpzuSapFAABJHW5mupiP3OGEdxuoEA2ldRe7bP
         MDFwFM4U2vVYHq1s+1Sio5KCGadfI6nAEDycVaExlC2Kc/GyE12rovzKlt8yYCQ2WrVV
         kMIw7znm8TsbYG/Ts9flZUY09uVrQNRcFFIGqcjZESP0oOACG3+pWiaE4yqrfToHt5on
         VVLFEdudnYKOV56SXhq37VraVXGkmbn/XpA7lB2rOL+pddPJmG47B7wZng68bp/4n2ta
         7zLfp1lA7XaHox1hWJmNFVrnQMQBFXZFqL0MT6BSit9ckwfpwcJHRoN5zb68n2SqeLmG
         qbGQ==
X-Gm-Message-State: ANoB5pkndZ/3DQAgrrOY/Kd5gja7G0p+QUym4mUemT6rl864JWNu8m1h
        kPPZtlS86sdLlqdIwlX/F+zqRTn7e/c6G8Qk
X-Google-Smtp-Source: AA0mqf4fNhj140eZB0Pln6tW1nITKkavGD6ZCpRDBypShfXxV4NjuzPjfbF0zevAuKO8PY7sAjfEig==
X-Received: by 2002:a5d:5f04:0:b0:241:e9a6:fb3 with SMTP id cl4-20020a5d5f04000000b00241e9a60fb3mr7921895wrb.462.1669369885415;
        Fri, 25 Nov 2022 01:51:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/9] versioncmp.c: refactor config reading next commit
Date:   Fri, 25 Nov 2022 10:50:05 +0100
Message-Id: <patch-v3-4.9-cb802b30cd8-20221125T093159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
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
2.39.0.rc0.955.ge9b241be664

