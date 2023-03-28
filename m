Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56584C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjC1OG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjC1OGV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:06:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8766818B
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4194559wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pmRz3v3Hrht8hHKGL7OOBR85+GFIGz7ixvjtemVP/Y=;
        b=MXPuzCg+yZW4dtFdXpdhyIXKCqUPeU/d+DTdzHbQRcF8I0YzgOA88BE00pA+wlnZbz
         FUOFBADwSH7k8XXLlwGpZ1XkM143dg0VGKDFPW8bKich8Z6/GDN6OmuD8MDRjFlv6jPD
         RFrg2K4I9PTB8veS/Dd4bvcomPP6cvdb7tSsrQPTIH6xWv0Jq6Bp+hyBGUq2NSzfme4u
         7CkYpASTOkkgKqUrbdxluUrWMVdlrFjQP0BLoS9Ft4jS8kSdxVofJUzJLsfLmoi9UUKx
         JGDrzwBOLPrSPZi2PJbr7KYpdbLlnkySjsqRzULqryH7mQRvK+zdcg0ZR1i6GxmQh8q/
         /tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pmRz3v3Hrht8hHKGL7OOBR85+GFIGz7ixvjtemVP/Y=;
        b=GAHXMAa+1TjFDr26TWpPlzRN6jW+40OH8LArgz47OVvJwH7pkMiYacXvuKisHpS8vB
         DQDcwdQ38yP3bTH5QbxIEw/AJxE76AOqmjF7g9sNNBxPQbegPl0OE60THmAlpzdAK6MH
         bVJL0eKQp0e1AK40HZdRWzBzHRcO0SJrjw0Z274SUCb+vZgrR71HqeeVMDR4V96QLQUA
         61vLBEJWy6wu4+pnTq0coa9KoL5CyUzSmAfDPiDXTYBodyx62Ro7yGcGAX27aAVA6wu2
         X8vXwEOglUSXCoN1LcE4ZMxmbzy40CZVFWHsK+ob52jp73Mr7KQpoQTEjj2SdqtVc5ED
         N7Kg==
X-Gm-Message-State: AO0yUKXMx5A23QRTH0EY45OdWb1iCLb8gOvWbVH2yJl/H0Yx3DnLxLNX
        Jsv4/ll3yVBN9xIFOv7rfIkA2OH7c3F08g==
X-Google-Smtp-Source: AK7set8NUTcGSSN+huGbJWIvF/ahO6DpYHt+3uzQy326NHOhlYFE9hschThkiwas4NPrfdN8l+dq4A==
X-Received: by 2002:a7b:cb44:0:b0:3ee:672d:caa3 with SMTP id v4-20020a7bcb44000000b003ee672dcaa3mr13377667wmj.18.1680012280165;
        Tue, 28 Mar 2023 07:04:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm12903622wms.41.2023.03.28.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:04:39 -0700 (PDT)
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
Subject: [PATCH v8 4/9] versioncmp.c: refactor config reading next commit
Date:   Tue, 28 Mar 2023 16:04:23 +0200
Message-Id: <patch-v8-4.9-d7dfedb7225-20230328T140127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
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

