Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74893C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjEIRyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjEIRyh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390346A1
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f42c865534so9212015e9.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654858; x=1686246858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yKpq2Ca+lhOHbWaFh9olcs7e29h/AKzxVKfOW6WUW4=;
        b=jdu0WodiV7ihXw24lU8h6O8d4TU2Uj0nLth2+H2t0OBBgbWH2Cal5hmlGQADR9OuKs
         bI68W0tuu9aENIEAbfkjboL4etLPCQknoNElo2aXlPal7QqteIaqS0kix49klGouozN/
         cY/BpWIasua+prOuNz9U/bQ2Vd65GskKMCfNhmtGuHm7xMZX2blkOgQdiTjnvDsYpitx
         Q+eT5DosCk+WIR5N1Z4/g/kQo7GGE56v2y2ncdAb4whhj9D22KPq4xsr2x8RnCTYxrXf
         4KX+ojWWvjJR8FDOwhk/mDuF4uF8PnIKj5FZ9GtkxXm+Zk8abPUTOoZcyk6A34fFNyf2
         6PzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654858; x=1686246858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yKpq2Ca+lhOHbWaFh9olcs7e29h/AKzxVKfOW6WUW4=;
        b=k4Yjfp6QkTKLWtJwgtzIwk/tU0PJOTTUXBoyUcCE7zdlaJMOibQwTcllmi1G/TK5+W
         5dxDW7+hHkdZeb3VjKZQhfYngs++jWxTTPyTICcST/pEoVwgLvE1OIw8ZWy9fqF8ucHr
         ZH44GSzIG/m186XycNRBmAUsM5+C2UGFks9AYtF+NyF8PPzK/g68bbX3EQWd3p8yinxs
         1lJ2f+qiCQ6QNh56DAqHAHfqw62G3zRbvzHPlvXHJkCBubGl7D8m875DawvvMKtyd5Y4
         7qfzfVu7JTYU+q1BkGrOnQxnjTpKLRZmreHbCv5dxOMdBENXqPBSXnXu4ugk2MVMU7fi
         Rung==
X-Gm-Message-State: AC+VfDyCVjP9FwGpOPCCPmKcHC+0dV2iVWIfdrL3A3rQceKcKOoBMpnJ
        /oDakRcJxC3wjtfGpfHkVR1TBLwmh4Y=
X-Google-Smtp-Source: ACHHUZ5W6pXGiEIZTquiJg+sB0ypPnM7wJ3rQoIR/tcTCSbJ3wWpQrQdoTCeIz/ulTE7P8zy2cmU+g==
X-Received: by 2002:a7b:c381:0:b0:3f1:819d:d046 with SMTP id s1-20020a7bc381000000b003f1819dd046mr11302189wmj.5.1683654858297;
        Tue, 09 May 2023 10:54:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 07/15] replay: add an important FIXME comment about gpg signing
Date:   Tue,  9 May 2023 19:53:39 +0200
Message-ID: <20230509175347.1714141-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to be able to handle signed commits in some way in the future,
but we are not ready to do it now. So for the time being let's just add
a FIXME comment to remind us about it.

These are different ways we could handle them:

  - in case of a cli user and if there was an interactive mode, we could
    perhaps ask if the user wants to sign again
  - we could add an option to just fail if there are signed commits

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 9f6cca2972..a9d88ac6df 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -60,7 +60,7 @@ static struct commit *create_commit(struct tree *tree,
 	struct object *obj;
 	struct commit_list *parents = NULL;
 	char *author;
-	char *sign_commit = NULL;
+	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
-- 
2.40.1.491.gdff9a222ea

