Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE9C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346280AbiDRQcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346222AbiDRQcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D5E30547
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q20so9037299wmq.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plHMWMnzN19KmhnAept+Ty21uoV5zx5bC6Yx3L1qoUc=;
        b=a91VgacmlxtExUXz8tKpGr88IseQa1CskA85IFOAg2HEGXiKw99I53W0JFRAPSlrVe
         D5uEwIdUwp8I7sdshoEMOMSffup7MIe6lHr8g1WHF10doKgHr8LNHC3fIXCM9phkBEVi
         6RwXVp139yxNcz21lxpWZOyeR3P0VTG3ac40+qbHr6e/XlJCAijzxuo2l4EOnvSLEdk5
         vwQnY9fK/s26j8eoldo0EATnECYTigt1es90y2/QuwFgYG651zW6MMaS05ORtXNplwPh
         NWs7KSeb6REBhLFnQFmF17c8D1h5N3B14AiG3fHH14oDh6Dd+McgCHV//TrWZXVk+qrs
         gV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plHMWMnzN19KmhnAept+Ty21uoV5zx5bC6Yx3L1qoUc=;
        b=s3EqTzbvR1fSELGzFBfYeLm/KOapXC2GAE79rV3JMd5chRKhmRzD3nN+5+/ydd2aCV
         fwuORYMP7V5Yft4NJl+7bVme7PpHhrIM9HOa/i0a2gZx89fBZ5OcmMpo91U9ZfUFv9Rn
         5BqYvLSfkADfqOJTcQqmA9rB06/cstryUNLCTC2LDDTDLj5KVF6TpdFKDYu2MRCCaRtI
         SDIw5c0GlxP44oq5VRxDY3iElGWn/P2L8xCXUrMqVjBDCtfMGm3M4e7SzRkdiptvBfeF
         byS0UiqDzlr369fG3sZXA7kXEMrt+ElQ7GYpLfvY+G3IToDnHM+awQC+ug0H1ASO+R/w
         0Pog==
X-Gm-Message-State: AOAM532Ahcrx8yeYfimVh4cq4stbVY89p6s/CYKi47P7/VO3SmNUhFqC
        i7vZtRXUaqJnVks0vpOAfkEczy9bM40skw==
X-Google-Smtp-Source: ABdhPJzrI+dQ1flshTFHn4Y7R1nO80pkaaedGZ/QlkBvhyn6CQZuDwRzGN1Rqh2cMsd/OSyWpaWa3g==
X-Received: by 2002:a05:600c:3ca7:b0:38e:50d2:27fe with SMTP id bg39-20020a05600c3ca700b0038e50d227femr15997562wmb.159.1650299358800;
        Mon, 18 Apr 2022 09:29:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/31] CI: don't have "git grep" invoke a pager in tree content check
Date:   Mon, 18 Apr 2022 18:28:44 +0200
Message-Id: <patch-v4-07.31-6c2a8ee9c4e-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the omission of not adding "-P" (a.k.a. "--no-pager") to the "git"
invocation that spaws "git grep", added in 0e7696c64db (ci: disallow
directional formatting, 2021-11-04).

This didn't matter for the GitHub CI, but does when running the check
locally. A subsequent commit will start invoking it via a new check
from the top-level Makefile, and without this we'd visibly spawn a
pager when doing so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/check-directional-formatting.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/check-directional-formatting.bash b/ci/check-directional-formatting.bash
index e6211b141aa..de8e6e486f0 100755
--- a/ci/check-directional-formatting.bash
+++ b/ci/check-directional-formatting.bash
@@ -23,5 +23,5 @@
 # U+2066..U+2069: LRI, RLI, FSI and PDI
 regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
 
-! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
+! LC_CTYPE=C git -P grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
 	-- ':(exclude,attr:binary)' ':(exclude)*.po'
-- 
2.36.0.rc2.898.gdf6bbac50ff

