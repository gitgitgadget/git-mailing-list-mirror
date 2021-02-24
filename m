Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A5C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F3964EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhBXT5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhBXTyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A8BC061225
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so3049795wrx.4
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMxsQH8TvqCF23zGXJVMeFs/8y2sLDsvMR6mtJLBjfI=;
        b=AV0QIYWmUy21ltuRjtZ2C1PgMFW1pS37LazAJSNegbherIEkyOgMgTkWFEmwfwF1+q
         k6v48rVvjNto2iw33PnFk6lHZGBrk8fnuWvbm3T02hJk908bQhBUEiMAcBzTjO44fErv
         TXHDfb7+VI2zfBtOShFwANRhW5WiNOWccqESjLOLQS/HRPu6uiQwMqAP6ULeSmaieXj4
         e3xbAjWVac1O732WrL+XHVImcggLUsz3iYReJf3AXmyW2y5CHAYLrHVWun1i5F5z1lsN
         qVUDf4wM73GEgG+ru3S3HqrepQaPWBENd1hk7MbI14KbENkPisaX7J9QSJ7dp9adekMH
         rVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMxsQH8TvqCF23zGXJVMeFs/8y2sLDsvMR6mtJLBjfI=;
        b=bGGdBZv6LHkEIV+gJOQfQXHA7SuNOJmOEJhYzattdbUy1oHwcj0lvzHYG1b88IgqbC
         tKbDBssBnva/1mKibSEkePirtASOPYxOIxKyYlSNhTroqeXh9JZeOqFvDGfKZ05K+/I0
         0vlNmPEUl2RHcosxIEVg3202GJ8QKwTXS5a8P2q8J0Pjo7dpc58Ld+fPwLEWpF2Wqv6H
         3OF5JWrKVAQtAc/C1n0r6ukEQKpuVRVsXc/euAuwxu8zvTpXTPRIFih1goJeYqyDo79r
         NS+UR35g4XBAV87+yl5qslmST+/7NNnc6ErEtBp+FifNHaeVckOAHHfJvPPU/J8RYAj+
         23kw==
X-Gm-Message-State: AOAM531GADgZBCOAw+MIPfE3Cg1w1VGgckqRTgIckwdUvbUVq0/PhA03
        Y5zifejKaudUrJmqUjxwjYRtuw3pR5n7ug==
X-Google-Smtp-Source: ABdhPJyNVwIPcMO5fC3+h2ods2Jfb19lZ7D27r4PmCEP2gCtzVu2gPN4j93+5/QoC5u/pz7gmY0qQw==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr32896929wrs.220.1614196331261;
        Wed, 24 Feb 2021 11:52:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 22/35] gitattributes doc: reword discussion of built-in userdiff patterns
Date:   Wed, 24 Feb 2021 20:51:16 +0100
Message-Id: <20210224195129.4004-23-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the discussion of the built-in userdiff patterns to make it
more natural to precede it with a discussion about the semantics of
pattern matching, instead of assuming that it follows right after the
"diff.tex.xfuncname" example which now immediately precedes it. This
will make a follow-up commit smaller.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitattributes.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e84e104f932..62c1147ba97 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -794,11 +794,17 @@ backslashes; the pattern above picks a line that begins with a
 backslash, and zero or more occurrences of `sub` followed by
 `section` followed by open brace, to the end of line.
 
-There are a few built-in patterns to make this easier, and `tex`
-is one of them, so you do not have to write the above in your
-configuration file (you still need to enable this with the
-attribute mechanism, via `.gitattributes`).  The following built in
-patterns are available:
+There are built-in patterns shipped as part of git itself. A more
+advanced version of the `tex` pattern discussed above is one of them.
+
+For built-in patterns, you do not need `diff.<lang>.xfuncname` in your
+configuration file as discussed above, but if present, it will
+override a built-in pattern.
+
+Nevertheless, you need to enable built-in patterns via .gitattributes`
+for the pattern to take effect.
+
+The following built-in patterns are available:
 
 - `ada` suitable for source code in the Ada language.
 
-- 
2.30.0.284.gd98b1dd5eaa7

