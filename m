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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BF9C11F65
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF261941
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhF1TWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhF1TWC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902EC061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r3so7682097wmq.1
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wA1eKElB3w/MW9OGt6dcaujQcyaR8T/ROg81FShaK2M=;
        b=ZEjHzruX0/cdkwWA32tIXKsqkQk9Jb4QTIkWb5ooh+yYDkYdb4yJwp/1CklTEtLZo9
         98JSSSk+HzQUD6yZUSZkingjRQMM1lIVguctCIUbq6z6y/Ns3zq+CYN0u0owRWaGZmbU
         r9C+s7hZ1rdK3jZkqBxi34LPe2EcPJ1+qToZ+cvFIDDi8eru/E2maMfwoZAtna8TKHs2
         LKR34v7qfBV20dqA4EBGlaYL+kPAHTS0YhFaYCtvHauHV7ZIPGkThSltFkoBB8fk83ik
         p6g4AYrKsM/zhdUyZN62Ocr9Gk+dBnrp5lg3ETitAxSk0u+PQYoin1HQ7eeetXxcq9VG
         2vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wA1eKElB3w/MW9OGt6dcaujQcyaR8T/ROg81FShaK2M=;
        b=ChWfGtQSj5Ta7Ut4su26Ec/AKn6CXqSd8hFyoK/PsyXUltphmkL7HfA2WGD6vxUn+k
         nUS9lQKNTGWj0KJjLTV7bTJpdsr04ENMnpiRkqLEAz6nww8KAj9djyyioEh9KzKIYnEM
         lvs/98mUm5ouGHWqta099hoGlagYWtNbNdgNRGeVUPfvEm4J5sN7dyOoB6eXQxquL1UH
         hDtQ3yOVKAVYZdm9KomtL/xD9s6RzZYuaCUhXBFfMFqb64Qm3I6BhF4/UjMW8aBOMWwg
         x3sQbK8B6qeauL/mNaQt3GQ5WnXOjsdSFhE/5yPTzS+HYYT7TXUPBNdsI4gEVwy5yX0T
         k0Fw==
X-Gm-Message-State: AOAM533MjY+lxN1xGy2gVEJqurJhJQSpK5wSP7XBynxmcLeLsAiMVma2
        gn5LivAghfiaod+UwJnalQoO4zFtuvWfJQ==
X-Google-Smtp-Source: ABdhPJy9REYqEMe3xaGQtd2QUKLKZW2zSXQRJWv3WoCdHtBH0iGAGYPY6wGrYHm9rNGv43RdQNGGLw==
X-Received: by 2002:a7b:c7da:: with SMTP id z26mr28450036wmk.29.1624907972775;
        Mon, 28 Jun 2021 12:19:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] serve: mark has_capability() as static
Date:   Mon, 28 Jun 2021 21:19:18 +0200
Message-Id: <patch-1.8-fdb0c5f4df1-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The has_capability() function introduced in ed10cb952d3 (serve:
introduce git-serve, 2018-03-15) has never been used anywhere except
serve.c, so let's mark it as static.

It was later changed from "extern" in 554544276a6 (*.[ch]: remove
extern from function declarations using spatch, 2019-04-29), but we
could have simply marked it as "static" instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 4 ++--
 serve.h | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index aa8209f147e..6748c590b74 100644
--- a/serve.c
+++ b/serve.c
@@ -156,8 +156,8 @@ static int is_command(const char *key, struct protocol_capability **command)
 	return 0;
 }
 
-int has_capability(const struct strvec *keys, const char *capability,
-		   const char **value)
+static int has_capability(const struct strvec *keys, const char *capability,
+			  const char **value)
 {
 	int i;
 	for (i = 0; i < keys->nr; i++) {
diff --git a/serve.h b/serve.h
index fc2683e24d3..56da77a87af 100644
--- a/serve.h
+++ b/serve.h
@@ -1,10 +1,6 @@
 #ifndef SERVE_H
 #define SERVE_H
 
-struct strvec;
-int has_capability(const struct strvec *keys, const char *capability,
-		   const char **value);
-
 struct serve_options {
 	unsigned advertise_capabilities;
 	unsigned stateless_rpc;
-- 
2.32.0.611.gd4a17395dfa

