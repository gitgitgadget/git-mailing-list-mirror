Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8ECC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiCYTnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCYTnY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:43:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3E021590C
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:13:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r7so4977025wmq.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaiLNY0z62uUAT85E26oAG0JsvjCbzl+1UpOaTSXQXE=;
        b=PIylgha/iABVT5hfUcINR8o09ZxjMqCzs+rzFNQey6glJtbNMTibzxrjJht/lo8/sL
         y7FHzP5qzbvUNj29UAuOhDXl2RG7lUkU3ko0trumOQ2O+3ZBfJMXM1VmufG+cq4MYEhW
         hjR5xeLqmoSeAKlvYIH6C2oLnOyN8tqONeltkB9kDxFcVSwhjE7fNvrtuJXu8HSb57/r
         GjF7y6eziC49DQ1G3RYV3/5NqIZdNPadpqBxBo4HL+vbh3RP99OBKdyHodCqjzSQ302+
         Cu5DD4mmYd26wknpxpPorRe7G7UkKzj8di+akN7HdBpiqTyeVLmXioicIMDmifNoGdLQ
         DfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaiLNY0z62uUAT85E26oAG0JsvjCbzl+1UpOaTSXQXE=;
        b=lyYuR31kqf6g8LFpWfjJwjlhyk8ERjgmiHejhgq0xHDMX1/50BHY8nDVMzSf43SyoW
         c4APggJogIJ1of1KlRnCK3wzRz5mVBUESbyMyXNrbnQZ6fsH3jETiKzbeNy+ELCKwXMZ
         VMtlozvewCw9IVzwCVLbjSiybSZHUj6oneBOLk9yok7kyPkHB/GEpfag7uAVK+SlvnYM
         TJnBGf7hOGEzaXrlK9rllq6H/05JfEyfs79b43/VsOdMx3PGHf8Z2/wKj7WID2LTp85k
         Ib2cG+R3yKEE5wiWv4Bbs9NmidJfEnHECAaTlEzB5AV4Rry19FcWzvmmAcMrSv+X6m4N
         THTw==
X-Gm-Message-State: AOAM530L+LxPJfSvbQqXTXxyQvhrDE24RfvR+/glX1RfroBteVOt1/n+
        +BM9T7FKBvyxobocoT5zs+xT8q2XWrfA9A==
X-Google-Smtp-Source: ABdhPJxT3P3P1Rb5Ig853V7ODZI6ykFW6mj7ZU4eYiG9yVPKV5zSolwwWNVclXxqcGsyJlCUC37MWQ==
X-Received: by 2002:a05:600c:1e04:b0:38c:9b91:db07 with SMTP id ay4-20020a05600c1e0400b0038c9b91db07mr20797051wmb.55.1648233515920;
        Fri, 25 Mar 2022 11:38:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:35 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/25] ci/run-test-slice.sh: replace shelling out with "echo"
Date:   Fri, 25 Mar 2022 19:38:09 +0100
Message-Id: <patch-v2-18.25-571f4d0f441-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend this code added in b819f1d2cec (ci: parallelize testing on
Windows, 2019-01-29) to stop shelling out to "tr", all we're trying to
do here is to turn '\n'-delimited output into a ' '-delimited list. To
do that we can just use "echo".

None of these files will contain the odd characters using "echo" might
choke on in the general case (i.e. '\'-escapes and the like).

This has the added benefit of not adding a redundant ' ' to the end of
the T-parameter, which didn't matter in practice, but as we'll see in
a subsequent commit makes for slightly nicer output, as we'll show
this variable using a GitHub CI-native feature.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/run-test-slice.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index 70326961454..1de6a18ca47 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,6 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-make --quiet -C t T="$(cd t &&
-	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
-	tr '\n' ' ')"
+tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
+	t[0-9]*.sh))
+make --quiet -C t T="$tests"
-- 
2.35.1.1517.g20a06c426a7

