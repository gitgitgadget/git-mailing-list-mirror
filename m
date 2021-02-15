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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC19C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E5464E27
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhBOAyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhBOAyX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC4C06178B
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u14so7183558wri.3
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJQupuIzp7Dz/FBzKFgu59W2T/cdM57ymWlMr3XvSBE=;
        b=Cjmxe+QYYrEGh7feupfWUvkkrAbLy0Fqx83WCGtJUlzm6w10G2iwXR3VQ9xDEL85IO
         H6jheDQ+JjSkkZysS7aEz8jjXcC+LDodyK893R7j1M9l/q+Dgm5HMpFm1NUezfjIUecH
         AzTLUPTvSbvQTSVDQgjW0lqZSHucScURcgaoln8x+XPxMZEIQ6ADh3VWmER7MEvfGMq+
         8jzBfEjGaTUA9c8n4Xei33IphgZaxgDW8LKDcjQNcvtl/4+yodWdSiIuvwr4mq3W9DiX
         mnxfxw331/BfYDpfwGysFRnJ3BP/R20E0B5m9pPhjAHAjqZkBTIJ+6Kp0voJ4J63e/iS
         dPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJQupuIzp7Dz/FBzKFgu59W2T/cdM57ymWlMr3XvSBE=;
        b=C+12xazFcEvLE68xxh7HL9KzYEVrGDUAjlw1WKuJRbOjuaA/RDGgtjx0TUdyWQgYQl
         K3hiEU09tw24bz57kJdgj2STU8d740+kwpOq0gYOuJmOrs05IlDUcpYGEqL5n7mP2CrL
         6QwLy9kzpjR3T/bpJsbMTc+Nq6tL8Nlw0X9GuV5ezGnG+I+LB+ZZrU4ngpWpsel8FN/9
         youM5mWIrICd76t3ZSTvpoi0bbuTEBOnCpYpJ3RLyh8gO04adOOakHNJyi7s/g/YiZe2
         8rx+y7myRExG0uJLsc0HukpO0sNJ5RI5GLOcY9c3WSLs70BqzLuOaP7Op18VFqZCQUnE
         ACRw==
X-Gm-Message-State: AOAM533uJcXlRIlzDVaeZGpb06+uqtovKAUdEHEqRt2Oxhb4SdkV/68k
        Iljxlu/uLYcThnOzrkO1u6UY1twXsPCNCg==
X-Google-Smtp-Source: ABdhPJxRNU2patrzoSMrwJWuYORKi8e1h+UIb3knctSjn1G3RKGsKDmvBvjKtTtiFrP0ZB3Z3TT4Fg==
X-Received: by 2002:a5d:4e41:: with SMTP id r1mr11676141wrt.6.1613350384091;
        Sun, 14 Feb 2021 16:53:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:03 -0800 (PST)
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
Subject: [PATCH 06/20] userdiff: remove support for "broken" tests
Date:   Mon, 15 Feb 2021 01:52:22 +0100
Message-Id: <20210215005236.11313-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been no "broken" tests since 75c3b6b2e8 (userdiff: improve
Fortran xfuncname regex, 2020-08-12). Let's remove the test support
for them, this is in preparation for a more general refactoring of the
tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 8 +-------
 t/t4018/README           | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 11ac648451..5fb5b0a651 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -83,13 +83,7 @@ test_expect_success 'setup hunk header tests' '
 # check each individual file
 for i in $(git ls-files)
 do
-	if grep broken "$i" >/dev/null 2>&1
-	then
-		result=failure
-	else
-		result=success
-	fi
-	test_expect_$result "hunk header: $i" "
+	test_expect_success "hunk header: $i" "
 		git diff -U1 $i >actual &&
 		grep '@@ .* @@.*RIGHT' actual
 	"
diff --git a/t/t4018/README b/t/t4018/README
index 283e01cca1..2d25b2b4fc 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -7,9 +7,6 @@ at least two lines from the line that must appear in the hunk header.
 The text that must appear in the hunk header must contain the word
 "right", but in all upper-case, like in the title above.
 
-To mark a test case that highlights a malfunction, insert the word
-BROKEN in all lower-case somewhere in the file.
-
 This text is a bit twisted and out of order, but it is itself a
 test case for the default hunk header pattern. Know what you are doing
 if you change it.
-- 
2.30.0.284.gd98b1dd5eaa7

