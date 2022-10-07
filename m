Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B0C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJGJa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJGJau (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:30:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC56C895A
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:30:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b7so6378491wrq.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGxnu3CnM7qG1xh9SLlWBxngLcnMzF2xK1x7bJx6gpM=;
        b=gUv+wOnLnuo2PNeNOxbfDXq1uP/+niUG/TcL9/SLhKZCuJsVrbc0qwUgWzH7juXCqt
         OMFNDXO9S4RHXdZQqzTrj46Vv1XW4QKMFZ+Rom6DeDvLhsaw7m4Q21fhGIoAKNSIaqq+
         q4qeRs9G3CMrAu8t2WeNFMqciqS4Fj9QIDW2lbB9pmpOODZLIf9o6l4awdV3hQ9JO69z
         utcluO96cXFMXx9jDq90G5DpAsdJBLYy1ekd0Nv/OI2NA+hGfzo5vZ6LGZsgch68p9Uf
         nrTKEVZtJ9wh3y9jaGeNopyLGXlcguQbKP1/hXwBOZcI2cADYgvCElfclxjxGAWVw7jg
         xgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGxnu3CnM7qG1xh9SLlWBxngLcnMzF2xK1x7bJx6gpM=;
        b=VjS3xoN7LAGAl+Dpsp9bHhZNTDDpr5rne0JFJ0R7zMm9Z2vHQW/LBqNYnCX9MVvaYc
         ZfU+fATFFRNmMCB7NdEVMVod1IRVrDfuZJnpZctbZSI8VzU2dIucmRbIOB388dOBL/1m
         yh0V5iSSsEnUCaee5VJKR0lpl6U33JP7VLliNBVQUx1dUOdGRDvtHPWy8GKb2mx/sn0B
         N147zYGgoXKJUwWFVW34vi0zOn0s0p7e/okRm8/bH6LOKq1ayxgrBMQQszGNoH4fJjp6
         wtjn7hN5Q2YiTdmY6WEcgDgHpQx4BaGIiAAEPaggrpbsmkJrafZbgM6AhUODREprb+jq
         ZxCg==
X-Gm-Message-State: ACrzQf0g7cto7P139c/ZNfWCjVfzgnGX29ydpPjWM+EQVHMA/9EXUPx6
        KGIzL3j+41tgqfDJguchJfIyIikkw/j8zw==
X-Google-Smtp-Source: AMsMyM4qh4ZoQ3+eGHajtz+G1dyII0IKVlhZjxKUhKlb6727sz9h95STRpoRORhRePtlmRCKX6tVrQ==
X-Received: by 2002:a5d:5149:0:b0:22e:8b85:3d7d with SMTP id u9-20020a5d5149000000b0022e8b853d7dmr1706950wrt.55.1665135047562;
        Fri, 07 Oct 2022 02:30:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm1634945wmc.43.2022.10.07.02.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:30:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] CodingGuidelines: mention C99 features we can't use
Date:   Fri,  7 Oct 2022 11:30:33 +0200
Message-Id: <patch-4.5-17c2a0d88e8-20221007T092505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C99 section of the CodingGuidelines is a good overview of what we
can use, but is sorely lacking in what we can't use. Something that
comes up occasionally is the portability of %z.

Per [1] we couldn't use it for the longest time due to MSVC not
supporting it, but nowadays by requiring C99 we rely on the MSVC
version that does, but we can't use it yet because a C library that
MinGW uses doesn't support it.

1. https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index f9affc4050a..893f960231f 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -235,6 +235,13 @@ For C programs:
    . since late 2021 with 44ba10d6, we have had variables declared in
      the for loop "for (int i = 0; i < 10; i++)".
 
+   New C99 features that we cannot use yet:
+
+   . %z and %zu as a printf() argument for a size_t (the %z being for
+     the POSIX-specific ssize_t). Instead you should use
+     printf("%"PRIuMAX, (uintmax_t)v); These days the MSVC version we
+     rely on supports %z, but the C library used by MinGW does not.
+
  - Variables have to be declared at the beginning of the block, before
    the first statement (i.e. -Wdeclaration-after-statement).
 
-- 
2.38.0.971.ge79ff6d20e7

