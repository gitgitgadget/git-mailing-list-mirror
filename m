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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B064C11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9029613C1
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhGNR06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhGNR04 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:26:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CCDC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g12so2081945wme.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rINXkdbXhlGhldlZ8EoFoo8l5VMWkSR/uY3izJeywqE=;
        b=i0huJwRwX4Z+XH/HyVCW6Lmrcj4k6CEViOcI16UvLDZfWjbOfJzdO6lnbksGLhEak2
         PlLROLffy80tYjcvro6OzGionxd1SjGVgUFwybwMCXQLcfcyjtbEu7EpZtaSY7Q/kyND
         oR2OoPPZQLA855xbKKOZN1IDIyw6WJ908Mg3BnRSYgBChxjY0c+qz8hdf1wfNJVOzcXK
         Du6Yuf4+MiaO5olXGGipxpGX2XuOIEeIIEaJkd+/sWY1WC5Q0siJu8XmvqEoi8zbwGFW
         1Gef3FoXjtBMb4Cy3E/BpHLeogzaOQp2kzDNriJM7bifbxTC35infXIsvzoh0a3Bt50V
         Ppmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rINXkdbXhlGhldlZ8EoFoo8l5VMWkSR/uY3izJeywqE=;
        b=DYmEOqkCgljWVG3aIL9GxdznlmqAmMdfVoNXMiTl5kt8HNP4kMfFYLrP0R8YNQ6zBk
         RCHIhP7Rnw2scVAH2+pHuQrQhAfIJlr8fKBh0AVOKaqCLXIUyph5AW9FH6qarNLt6Goc
         8eOitHyg6Fz/hdxpiI4LuO14cXmW6nCfZaUlrLBX8WwUgDyaGKqbHijLLNZEALNbTeUa
         tlmorpJC4PNAjXaOGuNiwCzqd05UFemPJbnLHz/hMT1iUu0jhyvsCdK4gOm6tTPs2mR3
         8OyEu9vuJqi/udzmheYXAehiutkb4Mm1LJAX9ZoLaU+0nPgjZZkaZhAa14ikQi/Zye+y
         IaTA==
X-Gm-Message-State: AOAM533NNUYDyRGt+vKskpnpPV+CTLCrpk7xg6ESuOJw4nT+mkh4bRR7
        8XpEgWKcuAOtlAOWZldlMDskYev9Rii3dDAv
X-Google-Smtp-Source: ABdhPJxxNrmkg+L4pGzeCu+/ZerFKwRzz20E+w7vKa6vq5tP47342Y0Sdvdd47I41lNL9qmM1smF/g==
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr5415541wmk.79.1626283443087;
        Wed, 14 Jul 2021 10:24:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f5sm3823795wrg.67.2021.07.14.10.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:24:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] SANITIZE tests: fix memory leaks in t5701*, add to whitelist
Date:   Wed, 14 Jul 2021 19:23:53 +0200
Message-Id: <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.853.g5a570c9bf9
In-Reply-To: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com> <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in a2ba162cda (object-info: support for retrieving
object info, 2021-04-20) which appears to have been based on a
misunderstanding of how the pkt-line.c API works, there is no need to
strdup() input to, it's just a printf()-like format function.

This fixes a potentially large memory leak, since the number of OID
lines the "object-info" call can be arbitrarily large (or a small one
if the request is small).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 protocol-caps.c      | 5 +++--
 t/t5701-git-serve.sh | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index 13a9e63a04..901b6795e4 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -69,9 +69,10 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 			}
 		}
 
-		packet_writer_write(writer, "%s",
-				    strbuf_detach(&send_buffer, NULL));
+		packet_writer_write(writer, "%s", send_buffer.buf);
+		strbuf_reset(&send_buffer);
 	}
+	strbuf_release(&send_buffer);
 }
 
 int cap_object_info(struct repository *r, struct strvec *keys,
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index d58efb0aa9..e2f4832adf 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -5,6 +5,7 @@ test_description='test protocol v2 server commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+GIT_TEST_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'test capability advertisement' '
-- 
2.32.0.853.g5a570c9bf9

