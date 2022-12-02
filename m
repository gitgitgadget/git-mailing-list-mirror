Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAF9C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiLBL2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiLBL2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:28:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CACAA8F1
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n20so10953866ejh.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nor9ScFNpoOWp/qQCcSBYil7PEqQXebXeXj59WjtWc=;
        b=dzBxZH3us4pBhdO1o+kcR1/nb2tjs6rw96ywrtRS4U4HnlQ7atcEAz1VPAHOX6aRmW
         MrledyYa/CgLa27A5DNh+6vIUD6AuKScX8lr9pfdkD8Tl26vX7tV//oXZCdRKWRZUP6C
         EjJhPyM2MG906vNvpBOatS4aAn0en5Q0dslnUH+DL9HxFA1oSdD0VZelOptX6vhkDXlg
         190iKlZ88GFvIKu0yDisJUls7GVXaymMgV/CUVLelonxAhZGsfLI6MdixMrtnTcv+qRn
         bryWmIXjB7MNzpIxy48xBlVDxx48PrKZrBwV1nMbBTuOiSOgsyMS9ZXyenkoc97M19hW
         5Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nor9ScFNpoOWp/qQCcSBYil7PEqQXebXeXj59WjtWc=;
        b=QURDXC+mQN7aSNVzurpy7jyJ6ZqlvtGE11XYW/1SqsaSHRcRaP/wpOHUQF+XZPk4rE
         p2uAC1xjGuF9xekXRkKlhFj2B2Al/AcfqzcY4w9RxfDPT+8p8S9te6eQ5JtlBnx86hTy
         8pv0/9XnhZgvcIbY1hRNP5fpFgM5bOiye9XJ9kwmzVztKwtdJCTm164qSeZ/HHv8a3iZ
         YuYdqhwY5FEtmjdboF4M4ONj9z/XylCcL2TDWH0YG0c+Psw1LwGKOpffBx7gmo0stW9I
         pnr6JtS2FiDu4IyR578dYbrUQydacV65U4u4vB7oYtBT+mlpoqxdxWW+kl2y17DUdk1v
         ZUUQ==
X-Gm-Message-State: ANoB5pnpJu1bIDUBWYdjrjF7EQwuzKjb736l/N83ZyUpoZ3Go31dhhpk
        nlOiha5X62UaVdQtC6rvJuyuaiI9l8CnHw==
X-Google-Smtp-Source: AA0mqf57kk8nr43pvpzm1QWw5/hlL6KgdDDskkzR/xhjbjQFufV4YGegGEuGtbbsU/9juUwJQGTSqw==
X-Received: by 2002:a17:907:a4c3:b0:7c0:7c22:d70d with SMTP id vq3-20020a170907a4c300b007c07c22d70dmr18831898ejc.707.1669980520633;
        Fri, 02 Dec 2022 03:28:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:40 -0800 (PST)
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
Subject: [PATCH v5 01/15] cmake: don't invoke msgfmt with --statistics
Date:   Fri,  2 Dec 2022 12:28:22 +0100
Message-Id: <patch-v5-01.15-7d83ff44c61-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
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
index 2f6e0197ffa..8f8b6f375f7 100644
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
2.39.0.rc1.981.gf846af54b4b

