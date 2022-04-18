Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5754EC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbiDRQdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346213AbiDRQcO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F23054D
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12048287wme.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AqPkmjWhPUIoHp447onayPTkB/ltBEPexVUFdcAnp70=;
        b=pX3h4r+fCThDnTKjhTXeybeuZfUtYIjWvOtwEqaIGWg6xKjNb553eXSlx6VZj1A+5A
         YRmJqoo2Wr+gpUmlml/hNThSDqgkDq9NP3jSpjRPBVBrkHB0Qefr1Ie1ZtEsbTa3rO6a
         pCrwAO4gJhykIoxNz8Lw7BW0/WmJdhsltFRn/mfD+7GjHeqTLZZnk0tgQrGhEz6+iQsI
         luaYQU2pJSBv7r84AR/RnLSwKAfXVoswF4CqV0M18sHzX77DiTmic+uut96q//7mT8BD
         429yeb39KiX1V4QqsmJ/WuDCxNf8WpGMmNinUsrrJAOtBM1EH1cV+qkGhQaEcjTRAfRP
         7ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AqPkmjWhPUIoHp447onayPTkB/ltBEPexVUFdcAnp70=;
        b=uxRe5BNs8S8iVlgDxp9VvsNe68zP9H0sYarC9nJd9n0RitZ44J53YcK6J/xBRmUPzA
         aLy+iMXrFoz6wA/wx32bTU0TBpsf5ecEPu93nVo4AGAYSoHL9Ezeio6bHFc0W6R2JPdz
         ONy4Wg8bayFE2z+oL8VzWF6B49oT+B7R/JBA/pvrA1/sdgWzgpRCOYEm7PRBEZtfIEY9
         J/O+0Bw0Ljtld2o6xw1geKuxOJrtLYGehzHxeIV4oiQCaiQe9WZ5IBkVDP2Pc1/3yDUt
         8uxHTu/X+K1Z4XIn9tHEYuTzKhyzQyJFnuaxdm05ebUioMCeGDkLLAD1wgBegEBp0NCH
         /Y4Q==
X-Gm-Message-State: AOAM5319049UYn2FrwHsPnREqrTZ6C/2N+5jOVy56fey6qh6Uz2R+K4l
        GnYcooSq10KxrqOLZl6FE+sjjYs8G/D0eA==
X-Google-Smtp-Source: ABdhPJxpDl3WuBz2h+o9KvgmOnvwlH0bHzDpFecyORkahf/MO4BNsDxx6cQZf886oAc1Kup/jDuGYQ==
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr15859796wmb.157.1650299372519;
        Mon, 18 Apr 2022 09:29:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:31 -0700 (PDT)
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
Subject: [PATCH v4 21/31] ci/run-test-slice.sh: replace shelling out with "echo"
Date:   Mon, 18 Apr 2022 18:28:58 +0200
Message-Id: <patch-v4-21.31-fdbe8554f5d-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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
2.36.0.rc2.898.gdf6bbac50ff

