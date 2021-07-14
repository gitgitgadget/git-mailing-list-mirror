Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5A6C11F69
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985366136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhGNAOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbhGNAOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:14:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686FC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:11:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso2759341wmh.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFjM4CZg3A6PEG+tMAle6YD/9by3LGfvS39FH45h3pY=;
        b=rhk9oF2CshiDWFT/o9y/HVHorY6a0VXryAdi2+ysZUL9LOoepa9Iw2vj3ix7MIfB6P
         5+OpfauBD9xMwz6icfpw1pP7rUVdS37hzRsgWV2XNH5j0ZuwqjMNedcS5xX9EvffLfVH
         27SDAv771GwBSiDhUvN0+MezKHM/GIkedF5MNmzwqSyC8SOTCTbsC4SbqZ2rJIpUxP/q
         7/ijutlR1KHJAvYAMEup0bq29hKAl8ZL+PYaQmaiDCvl+4X6ZhbVHZaorFTm5m0xPrDD
         cwi8krwqdUbRnUDDuRILbO1Iv+/hVhoKZskRj0Ura4okvRluIlWSngF9sHQJ8gKIVcum
         tJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFjM4CZg3A6PEG+tMAle6YD/9by3LGfvS39FH45h3pY=;
        b=EZVPJ29tZ8evu8w3cW73uPI/7bT+jlMwRsAC8YAsqoWDoEOTPWezzHGdM2Mu0eJMqM
         XV4u0oQrF7jMyZg5oLJC1H/4WShYMbbiYZtlJykry1uwg81TPihrdNnqKFzt1uSObrZW
         pifI4DeER3gWl6RWqDV8qlIczjaaYShDKwCT4asMp+8f/4IFpPpnkYgUmjSpz2yGqlMK
         pBj7pIb3sFsQW3Ef5yZzCKOWrNw7WkhuuP3GmH0MuQNCN79Zquk9HSQLUUAUHgGmoLOv
         1rb3juXORxzr350tJsojp2BcCR8dfXw05+NlLY619QRImfOfnJs7rLq3LKHxrmlUVKKU
         bJ/g==
X-Gm-Message-State: AOAM533XfMbk41lBkza+R+TeexMu0O5VbUFsstj4tqg9eNva7lmTKh5z
        V6XZQgKqa4avmeLW891uDP47dNKwlXKJDQlA
X-Google-Smtp-Source: ABdhPJz6KxmEvmF87FyshYEQZLZ9ZkS5iYJKLuyGodYf/fUrZF14QQm9m/kz+7l74ygv8d36GtN/Kw==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr7963750wmh.186.1626221514320;
        Tue, 13 Jul 2021 17:11:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x1sm442382wmc.31.2021.07.13.17.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:11:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] SANITIZE tests: fix memory leaks in t5701*, add to whitelist
Date:   Wed, 14 Jul 2021 02:11:48 +0200
Message-Id: <patch-3.4-2aeb3e8038-20210714T001007Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
References: <87czsv2idy.fsf@evledraar.gmail.com> <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
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
2.32.0-dev

