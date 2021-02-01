Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D4C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0C860295
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhBALSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhBALSL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:18:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A15C061574
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:17:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id sa23so7440403ejb.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFToDx4AwPwJCFMNB2EtNSWE0XzVkmUhwRErBRqFyjI=;
        b=OydCNU8Jmh7pDnzOFrT9NaFxgoLxEk+uWUk7yNvrSIzg/GchXuoXOSEBcpVGMSTTz1
         Vq7VbUkNujoK5ifAi6E3pJlLVwNDU60RAzMvY0F28DukUc0HrneEHKmUlijc24Ao8RPK
         YN68ajaitEgV1K/fEOwD1eDiU6dG4ZFD6OWvYe8hvteQhhQ6ewDWWmXB1zEFMVK5Xxnn
         8reL9vqkL6A4HgfLuVfwvU9uzUAeNYNs26QrgSM9RkCpFhYpFjRhKGxHifgv2otlwGrC
         0ar4V3MPht4BhqwGUVycpk4CtzhoublDFePX5+yzV6xp6gvmMhI6+gLBQEYLflz3qTXF
         Oo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFToDx4AwPwJCFMNB2EtNSWE0XzVkmUhwRErBRqFyjI=;
        b=U6QY6dcWXyYDl7KZ5ZD5bMtlkAmJWZ+9FwK/ORHC6jdGm5kxNDJ8srwBb81u6x3deD
         XsNxdGiAaQUC0bzfQyGP3wiuJ7oUYVA3uqbZxJ1Tx+naKmpRJiPa+lXAek8imuyccM4A
         L92YWgliFFbjqDTScJOoDDz+uXSFt6vwv3SPJQVK/9Hx6Q9svnEjF3w+SxIff6EGbkx/
         QeBs+hoIOCHz4FJ8os/THf/d0sIsrdxX8F2Rfooj3jCw+x3x/eoTlVfAtynTyYzN7qBi
         e3eKyhdVBmKeRJm6VO97FfOMkPGxoJF+go3iOtbEuTr2H3vvOyx3NZnBAoR3NQi5IBi8
         q/aA==
X-Gm-Message-State: AOAM531WMI6x+1Ut7FeA5bznVXb5TpiCcmXMJOyU+gWBEMeH0+qp/Qcf
        dhNrV5x2a1QUeug1KUZNOHcBFYUQzSqPtQ==
X-Google-Smtp-Source: ABdhPJyQtIXKREB4iC8tPn6RQ+QgzDovpzKY3LQQ4bWfeNCApY0KXooQO6jGL6wrR+42LpYhc+vqcQ==
X-Received: by 2002:a17:906:3685:: with SMTP id a5mr16906005ejc.544.1612178248677;
        Mon, 01 Feb 2021 03:17:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t19sm7760548ejc.62.2021.02.01.03.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:17:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] Makefile: remove "all" on "$(FUZZ_OBJS)"
Date:   Mon,  1 Feb 2021 12:17:10 +0100
Message-Id: <20210201111715.10200-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210128182310.26787-1-avarab@gmail.com>
References: <20210128182310.26787-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding this as a dependency was intentionally done in
5e472150800 (fuzz: add basic fuzz testing target., 2018-10-12).

I don't see why we need to prevent bitrot here under "all" for these
in particular, but not e.g. contrib/credential/**/*.c

In any case, these files are rather trivial and from their commit log
it seems the fuzz-all target is run by a few people already.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4edfda3e009..65e600713c1 100644
--- a/Makefile
+++ b/Makefile
@@ -667,9 +667,6 @@ FUZZ_OBJS += fuzz-commit-graph.o
 FUZZ_OBJS += fuzz-pack-headers.o
 FUZZ_OBJS += fuzz-pack-idx.o
 
-# Always build fuzz objects even if not testing, to prevent bit-rot.
-all:: $(FUZZ_OBJS)
-
 FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
 
 # Empty...
@@ -3321,4 +3318,4 @@ $(FUZZ_PROGRAMS): all
 	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
-fuzz-all: $(FUZZ_PROGRAMS)
+fuzz-all: $(FUZZ_PROGRAMS) $(FUZZ_OBJS)
-- 
2.30.0.284.gd98b1dd5eaa7

