Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0847DC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJGJa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJGJax (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:30:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09599E31BF
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:30:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h189-20020a1c21c6000000b003bd44dc526fso623128wmh.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdbJF/1XjvDfgbD4G/puDa19Z1q/UZGh+wIQbY3SfhY=;
        b=i3zXKvOf6i34cVA+irRjRfT/s8bZgwOEFp5jSc+5eFvLICLAxbFruCek03SoREKsL5
         /AafBHUvQMf7tXJQt6fHgtQMfyJ4ecaFBVb0/wG9Lx9+rzANzzIGGTotwfiXWuSyOJa4
         ClYtF4kizt1w+RhsPSn3RI8YfE0DItPvkUgRBrBcdsUP9j+cvMWKaP/M9fch3TIMYsgO
         C2EosQ2iyELI4zRWCYf/eevpHtU46p/Q+Cm4gUx8ZSjNyFvXMrlmn15kjDcXftS2/DwA
         7ElXh4I6JJMU5QgVcZh8jndPP4RNqwIQ0fx8dvIX2De93en02y48/oev1awqGF5waEiK
         VFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdbJF/1XjvDfgbD4G/puDa19Z1q/UZGh+wIQbY3SfhY=;
        b=dprhZhQZIn4bmuwR/ea6ernRnPWDyyfamFh142K7tvFyKnO9Khb3x5RRtf8SENqFce
         Vb2DTUCnRRv7Qo9KjEIIvwOwGpg5qCDJCuWW+7iab8+LMINsbSsmz0W+nQzJw8iB3SjE
         PVvaXJ4nXXB+E5Lc/cGShxvEavSpEAbZHcWvBNgrVvIOuuoSjWUwt+5089WCjSg0Ub6c
         ovw1U0t8LIxr8lPy4dXiV0meiB4oxac0e9AUlyRsNh/OhPA+HirJAytgtydZ/ujVyn4X
         CbPu6NKLvY38X3h6uuFFNe0yFxKsgOb4utE2UxRw4HZzkcXD96AHslSJ7gq6gwtyKDtX
         I6Ww==
X-Gm-Message-State: ACrzQf3yDtl2kmNKdjfn2rbVXuwdRbz7YOXZExPY0yNhpYimJescrcll
        BBGkYrD+/H3o0NLZ+40l3vDRGsxDIQHOHg==
X-Google-Smtp-Source: AMsMyM6f+FeR78NZjMciHyWQusPnnsQsgfaX2gqo42xFvz6rvoCQTM6Kcn/btuS1/JQLW2Ae0HdYRA==
X-Received: by 2002:a1c:f20e:0:b0:3c2:5062:4017 with SMTP id s14-20020a1cf20e000000b003c250624017mr3615878wmc.175.1665135048920;
        Fri, 07 Oct 2022 02:30:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm1634945wmc.43.2022.10.07.02.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:30:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] CodingGuidelines: recommend against unportable C99 struct syntax
Date:   Fri,  7 Oct 2022 11:30:34 +0200
Message-Id: <patch-5.5-fc02ae52f4a-20221007T092505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per 33665d98e6b (reftable: make assignments portable to AIX xlc
v12.01, 2022-03-28) forms like ".a.b = *c" can be replaced by using
".a = { .b = *c }" instead.

We'll probably allow these sooner than later, but since the workaround
is trivial let's note it among the C99 features we'd like to hold off
on for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 893f960231f..65b608ca0a2 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -242,6 +242,10 @@ For C programs:
      printf("%"PRIuMAX, (uintmax_t)v); These days the MSVC version we
      rely on supports %z, but the C library used by MinGW does not.
 
+   . Shorthand like ".a.b = *c" in struct assignments is known to trip
+     up an older IBM XLC version, use ".a = { .b = *c }" instead. See
+     the 33665d98e6b portability fix from mid-2022.
+
  - Variables have to be declared at the beginning of the block, before
    the first statement (i.e. -Wdeclaration-after-statement).
 
-- 
2.38.0.971.ge79ff6d20e7

