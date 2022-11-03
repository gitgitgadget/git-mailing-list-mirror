Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73065C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiKCQmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiKCQkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C6C19C1B
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f27so6859184eje.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kj/hyxWrJxZanYEp1dVTw3H7XRtAu2u7NFI0MqXGFk=;
        b=KWjh9GA8wGGXGOZjEHB2Jp7Yol7Xkp6eF0AQBlnp+l/hjP//Slqfxve7K4C1kpU12z
         qUrd6z6BJzXZY1qbZnzIp/yPB64TTPmEvcXTd9/vuNCeNP+kY5lb7Qb78wzt/G8z7nnk
         NrErfTSqDLTmyE2XeM1pinHnwZyLlTH+NK8qvj91ngJou7Fh6+TJkPEpgYrRRZwMGxjv
         SXA7EOo6r9DEblvvPriSIAPr886LcxBBeQuO0Vrlitvtrc3E7phl6L/aLbqB/GfxNLtY
         2nfAZRSBL/7McHCenBxulPih+3O7POgcvaQGWa3QK+uU44WtXZa1SFjmUlreyjq2MSZh
         5VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kj/hyxWrJxZanYEp1dVTw3H7XRtAu2u7NFI0MqXGFk=;
        b=J5g/B06J6myxQEPGQUbLWPp/c3UPjBygCH9Vxl8YWNJlyCJGNZswg2hNXALmj8edM6
         2LKgfuKNaTpaleQw7hTe4lwRkh2BvP3x+IqIX6ZmLjf1a+Ulys1c3t6pco8KS1nW+CSN
         D+QZG1AgCKPvrTa2cXnmK8tqmABY0w07TNMo/XOH4nbrU2ASwyWX3Hg5lV637huU0qbj
         GIeFJ0k8PJc3V9nZiDb7YGjLaN3LyB01njEaYtM3AsRI3hxkWMISbuvSL56bdFvgMfs3
         DmXmWxI+SR2bycShuNGxiPYD+oERMrphipTVz/BZfQX0M33o82BRWrtLOiaVW3I7BPZ9
         mG6w==
X-Gm-Message-State: ACrzQf3xZ0UZ1K76W+1UL0oyJ4d7LXCG+1LYF7Vp4MSePGDsLeqSEZX9
        HYhn8D3kxcYImwwgzpriXK1TAy2iOps=
X-Google-Smtp-Source: AMsMyM4YuOYRkvzv3xOakdlKlioTwFFx8Xj5Xo6oQ85guEvaMLwGIVBD0RQbl8LJ97vlFYqdmmnIXg==
X-Received: by 2002:a17:907:1c01:b0:78d:eb6e:3807 with SMTP id nc1-20020a1709071c0100b0078deb6e3807mr30178848ejc.481.1667493487624;
        Thu, 03 Nov 2022 09:38:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/14] cmake: don't invoke msgfmt with --statistics
Date:   Thu,  3 Nov 2022 17:37:51 +0100
Message-Id: <patch-v4-01.14-78dfc2a69b7-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2f12b31b746 (Makefile: don't invoke msgfmt with --statistics,
2021-12-17) I made the same change to our Makefile, let's follow-up
and do the same here.

For "cmake" this is particularly nice with "-G Ninja", as before we'd
emit ~40 lines of overflowed progress bar output, but now it's only
the one line of "ninja"'s progress bar.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3957e4cf8cd..0a75898ca9f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -897,7 +897,7 @@ if(MSGFMT_EXE)
 	foreach(po ${po_files})
 		file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
-				COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
+				COMMAND ${MSGFMT_EXE} --check -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
 		list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
 	endforeach()
 	add_custom_target(po-gen ALL DEPENDS ${po_gen})
-- 
2.38.0.1451.g86b35f4140a

