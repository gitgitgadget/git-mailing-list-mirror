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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700CCC47090
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7E4601FE
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhE2HNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhE2HNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:13:06 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A33C061763
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so5740489otl.3
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rM4o5LYGmIaS5Qh2mpF1UAeKj6J8HLsjfYpcVhBPbk=;
        b=YNHupwE7Cp1QZ3+KqmxRGYcpp2tnH7/G5k496uVRm0J9U9APrKVlcri/byDZ3b2GZp
         qBncOIsKMbLCzgBuRb45C+8sxoPO3H3Fon/YeUjl8eEhdqwuuoSYFxu/MKzLBmO8EuQR
         xB3FoeZij+Q0kpuDeotyJBAX9Zl4XSoqBMYVCxTLoh2Q0vAlSDsaQpGxXPm4rl37g97v
         gAg3MqfkxKCrkDCA7t1mBm/TcLDy2QhoyFJJlT0DwJ+xg3SsWKFl8EI79xHaNxf06oDd
         vwYpszRhEDE4+Z9+E33t7FDo2JAnIOHv3AOj2nFr8IMsQfQ/xntFuUnMy9D8OthElGxU
         3WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rM4o5LYGmIaS5Qh2mpF1UAeKj6J8HLsjfYpcVhBPbk=;
        b=Fc4983yyz80EP+DoEeUpjnm6vRSKb1HgUSrKlRniVIU3Vm9tadeasOJSTc9Gm/3m0Y
         bzNv/Qk73Hpg4iC1/NVbmieekRIrgZqJ/2grHaI8TrZRiSlbceTos9cIxWXGv6SEeZMl
         830iQRmsqM2hWVYeI4sdnmWGwO6Cs/rFcd8moZJ3YnIahgNGfgPIMG2oLmsekXJ75FEZ
         3b+9aFWFxUC4+vQ8GevWSGBtmeWcl9bSUhJL6floruVb1BKp/1Ua3PqJ5IfJGO+fNGHI
         ugykQnfG/1cb1l9i38zQMUuyguWzjwj4uoolZOv3nNEKKY7rGITtB5b4mINNCZenieH6
         256Q==
X-Gm-Message-State: AOAM532tmfuilAIKLqkCAb1M7QKTD+7V5leLLUg6D8H7C3nFBnac+XXf
        cIViBebPTLGzRxEvkZJ6Wh+Qb1c5pS8uMA==
X-Google-Smtp-Source: ABdhPJz5Ym80iZ4jFIihmsBhdG07tcF53N4HRmLFT3lu6vmuLXD/G3Lzjz92w6HyAm3IsAMPeSq3VQ==
X-Received: by 2002:a05:6830:164c:: with SMTP id h12mr9990514otr.321.1622272286544;
        Sat, 29 May 2021 00:11:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e26sm1544445oig.9.2021.05.29.00.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:11:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/6] doc: push: explain default=simple correctly
Date:   Sat, 29 May 2021 02:11:15 -0500
Message-Id: <20210529071115.1908310-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the code has been simplified and it's clear what it's
actually doing, update the documentation to reflect that.

Namely; the simple mode only barfs when working on a centralized
workflow, and there's no configured upstream branch with the same name.

Cc: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/push.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index f2667b2689..632033638c 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -24,15 +24,14 @@ push.default::
 
 * `tracking` - This is a deprecated synonym for `upstream`.
 
-* `simple` - in centralized workflow, work like `upstream` with an
-  added safety to refuse to push if the upstream branch's name is
-  different from the local one.
+* `simple` - pushes the current branch with the same name on the remote.
 +
-When pushing to a remote that is different from the remote you normally
-pull from, work as `current`.  This is the safest option and is suited
-for beginners.
+If you are working on a centralized workflow (pushing to the same repository you
+pull from, which is typically `origin`), then you need to configure an upstream
+branch with the same name.
 +
-This mode has become the default in Git 2.0.
+This mode is the default since Git 2.0, and is the safest option suited for
+beginners.
 
 * `matching` - push all branches having the same name on both ends.
   This makes the repository you are pushing to remember the set of
-- 
2.32.0.rc0

