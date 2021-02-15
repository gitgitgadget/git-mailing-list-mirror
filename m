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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D491AC433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AB164DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBOAyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhBOAy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DADFC0617A9
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h67so1677060wmh.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TyJk4IIv/NAsJbLemHiJv6uT1Q7MZqVC2kLavE4v/1c=;
        b=Y3Bm7NLzxRT1sMa/ya6l8MhkesLeZ7/3+hhVym4Rmc4qlGmZJV//igmsOakkGgHeAT
         nnbrQ0ZHFR5vvu9dH0D6yt9ezGka5Ke6iq8T20bpbe149DWhBVARx2fIPqzBEUHGM2Zm
         vCyS0FdyaUPOpC1DTpHEL7ByyxF2RcrpDT9jnXBWkuZLVojZjLt6zQycZ59PRlH9xznL
         1yn3ghaU5GPqSgTE0Ij7VZDUEh/I++iOLwTckAC/jbeNeOfxjHR2n9k4gGJPo9mM7YCe
         p3iLaVVYXBvzQpS2BkuX34stwfEnSzMVeEGIYIAriu3x9ys/LIx3IYz9HdFTVC8EuOEO
         F/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TyJk4IIv/NAsJbLemHiJv6uT1Q7MZqVC2kLavE4v/1c=;
        b=tdGIItZCCr1gsUHs44w883wW7Dmmws5fmenbToxeyIXE4UNH0XJI+bMocXUib5pLWb
         nbuf5Db8MBv1uiiA2E6Is7nFmdb0BD3oXhJBl+O53rWw7FeqhOM67zQhYsu84hVyHvi7
         DXuqTIkEau4ilcMMVolJ1uT4mghZ+BgGO3RCGBob8oohVOEFxFFJocf9bx5qFEYB7R93
         O1tV10ZZ3Re+WOFQIVv+mHHgwdAO+EolpOsIQaP7TNTyNilBoflE1PTqks3lYm5vkUBU
         IE765r7OtTVqLlSxAysTFghCJHpStqHh9AEScbr8nhMnZiMADR/Yac933ZzPmQQm20aK
         Ucug==
X-Gm-Message-State: AOAM530gMJJMZ9RUaZ7wiWkcaj6ehm7Y1CfplcW2vt5BfFP6gvxxgC8K
        taFMGXpLJwgCqOftT8a7rMXGGyvbe3Ql5w==
X-Google-Smtp-Source: ABdhPJw7OoHFH3PDPg0r/5TC8J/wv1bpuBbBzXpAlt6uS0isw8MQVkvq9cAGyhlakGDwcE61/M6k5Q==
X-Received: by 2002:a05:600c:204e:: with SMTP id p14mr12112955wmg.157.1613350388864;
        Sun, 14 Feb 2021 16:53:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/20] userdiff: match "package" in diff=golang
Date:   Mon, 15 Feb 2021 01:52:28 +0100
Message-Id: <20210215005236.11313-13-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the "golang" built-in pattern to match "package" lines, as
they weren't matched before changing e.g. the imports would commonly
result in an empty hunk header, now we'll instead show the package
name.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/golang.sh | 10 ++++++++++
 userdiff.c        |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/t/t4018/golang.sh b/t/t4018/golang.sh
index bf22f58c12..cdf9d6f8aa 100755
--- a/t/t4018/golang.sh
+++ b/t/t4018/golang.sh
@@ -3,6 +3,16 @@
 # See ../t4018-diff-funcname.sh's test_diff_funcname()
 #
 
+test_diff_funcname 'golang: package' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+package main
+EOF_HUNK
+package main
+
+import "fmt"
+// ChangeMe
+EOF_TEST
+
 test_diff_funcname 'golang: complex function' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
 func (t *Test) RIGHT(a Type) (Type, error) {
diff --git a/userdiff.c b/userdiff.c
index 92b5a97e12..d99b488700 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -124,6 +124,8 @@ IPATTERN("fortran",
 IPATTERN("fountain", "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
 	 "[^ \t-]+"),
 PATTERNS("golang",
+	 /* Packages */
+	 "^[ \t]*(package[ \t]*(.*))\n"
 	 /* Functions */
 	 "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
 	 /* Structs and interfaces */
-- 
2.30.0.284.gd98b1dd5eaa7

