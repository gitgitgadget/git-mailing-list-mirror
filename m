Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BBFC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC561027
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbhHaNrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhHaNrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:47:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52168C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:46:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n5so27735101wro.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUUZ63b1O6dp1G9dgJHVBpu919pArULUOwSZxP6zZ6s=;
        b=CRPZBUkkSxve62V0K9//2EQPSzjPgr/nv1DD+DbbmkrlE45BEgZ/CYGIcS1WqfKRuL
         7ofNlPHYmzRUx/tqk4gNwwxEJWpBShUDMR7xcgNZpYOmm619welv9q/Zsyd0Qmezb/Yy
         kLhpBP/J6ivG2q5dAte1hG4ri87XWhr8g1JoyDJ64DgrCnKfBFFxlNkwASfKOB9c3TW7
         dZgo9fSQc70WeckhlLUN17cSEAxuKp4klBLdm53LMXRUvwWtjlPfQsPlVKXUL+nLf+tb
         xA0/jXpfrxvogTwDyXYeIq2yaPqlLYYgD7OiunXNUNukCQR6AUCU626G08Hb2SDKheWR
         UEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUUZ63b1O6dp1G9dgJHVBpu919pArULUOwSZxP6zZ6s=;
        b=UUN8DBlzWEzjr0mW+O8gUbnukiSG/YPqsqn2dvpp+XykbWKdzXYykgNI4tFv1hGRp4
         ePX8+8VdL5woHnPMTiAlH9KD14SYsYrjXEeygVts6g3h9H2EU+QtDMWzzqdh8kOWz+qt
         MFd8+6+8bNRqNs4s4aUZYy/hn97egL0c/6tZZB3ajibyJsQS2KyRkIzvxcL1V1Q88tjn
         emBwUTjZtU8BIH3aNICxR5jRSXTFcUMZeI3uGASALzvVXIWanblfQye/DZq7lc6025w4
         XYAyfGg0QjwqJXO0la8jv+I8I+H1puarINNU/q8xncVIFL1RzgdAgYNzEw+cReo9QYof
         oasQ==
X-Gm-Message-State: AOAM531+pCyBEKRtSjmFTDsjDf9w4byLyQK5YwQWwJp4zt90UE6DhJ1O
        sRUiDdLI6aEGbaPBKN4jMcgaH0TxXUYXkQ==
X-Google-Smtp-Source: ABdhPJzAsRPVN0GPTEEavRgw3PvMRPD+VxcCHswUBsLpRKKi4IWoYTnthgW53uYUn+ybPznkfNZ3ig==
X-Received: by 2002:a5d:4f02:: with SMTP id c2mr31860520wru.311.1630417604668;
        Tue, 31 Aug 2021 06:46:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 19sm2552311wmo.39.2021.08.31.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:46:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bruno Albuquerque <bga@google.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] protocol-caps.c: fix memory leak in send_info()
Date:   Tue, 31 Aug 2021 15:46:42 +0200
Message-Id: <patch-1.1-9acbc21cdd3-20210831T134632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
References: <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in a2ba162cda (object-info: support for retrieving
object info, 2021-04-20) which appears to have been based on a
misunderstanding of how the pkt-line.c API works. There is no need to
strdup() input to packet_writer_write(), it's just a printf()-like
format function.

This fixes a potentially large memory leak, since the number of OID
lines the "object-info" call can be arbitrarily large (or a small one
if the request is small).

This makes t5701-git-serve.sh pass again under SANITIZE=leak, as it
did before a2ba162cda2.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This was originally submitted as part of the SANITIZE=leak series as
https://lore.kernel.org/git/patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com/

In its v3 I stopped doing these leak fixes & test changes, let's just
consider this separately. We'll eventually want to add SANITIZE=leak
whitelisting to the relevant test if and when my SANITIZE=leak series
goes in, but we can just do that then along with adding various other
tests.

Range-diff:
1:  720852eee0b ! 1:  9acbc21cdd3 SANITIZE tests: fix memory leaks in t5701*, add to whitelist
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    SANITIZE tests: fix memory leaks in t5701*, add to whitelist
    +    protocol-caps.c: fix memory leak in send_info()
     
         Fix a memory leak in a2ba162cda (object-info: support for retrieving
         object info, 2021-04-20) which appears to have been based on a
    -    misunderstanding of how the pkt-line.c API works, there is no need to
    -    strdup() input to, it's just a printf()-like format function.
    +    misunderstanding of how the pkt-line.c API works. There is no need to
    +    strdup() input to packet_writer_write(), it's just a printf()-like
    +    format function.
     
         This fixes a potentially large memory leak, since the number of OID
         lines the "object-info" call can be arbitrarily large (or a small one
         if the request is small).
     
    +    This makes t5701-git-serve.sh pass again under SANITIZE=leak, as it
    +    did before a2ba162cda2.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## protocol-caps.c ##
    @@ protocol-caps.c: static void send_info(struct repository *r, struct packet_write
      }
      
      int cap_object_info(struct repository *r, struct strvec *keys,
    -
    - ## t/t5701-git-serve.sh ##
    -@@ t/t5701-git-serve.sh: test_description='test protocol v2 server commands'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - 
    -+GIT_TEST_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_expect_success 'test capability advertisement' '

 protocol-caps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index 13a9e63a04a..901b6795e42 100644
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
-- 
2.33.0.805.g739b16c2189

