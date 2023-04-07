Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C30C77B6E
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbjDGHZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjDGHZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD97AA5E7
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l12so41583435wrm.10
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCHu72tliax/6QnCO3CIqeARYQNoCHdi+JnM8Kz2BKw=;
        b=fHlNx2hw2B7XpikQ089CGm9rtRi+Z8jRDLc0X0SGwk6QlYrOVTPq5areH/xu5ctxa6
         IlufoKVYpqjVgsuipEZYQyzRe/ZDmA4anORvo0TGoNf/ZfCf3ZtyydF7D8Q29teyKU2I
         LeyClkSTzDtRPxsdnXYzBECkaRfN4UMYHED9lsSyCW7Ttt3mWocCXAah7Flqyw87Ma0G
         PV2eZsmYCC0kV9Xa2bJsITDifvNfJTXxYuanQ1JPlGBwxT7OZXEh36PCpQHuXBeS3ZWg
         In9kNN5c+djZ8e3dqvafF2R9OA/0Mq9cwMfNpCHQTT02ZDQCeb8MsGwsK3r4I8ZYoD6I
         yBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCHu72tliax/6QnCO3CIqeARYQNoCHdi+JnM8Kz2BKw=;
        b=4jcC5aFaHAmhPzz70dR5gJK1/pAuZpXyxKmyQzpRgJ+ACs1zUlTKwQuBQRp1RJKpUH
         UyiQtgkZEms+mAbMn5KdBhrxPLppGlATNbQSB97Mtov6U8DrG9AK3T6ya+rD0yxoJTG5
         4MgCXXZ5Ixmyc5vmPoSB4uvOhibsY62VCY8DJkuUm1V7N7bAwNKjS8GZWBWzxn/4Uq5v
         DTUvugOASOhZBskuiT57GjCJkzKTdwThvNWgp+xRWhMG2/I7/KQX+njpi+8grK5+WLjY
         UetH4JyytnWsS3PpAL4Riq4szvHh+hQaWcW1dHgiaF+G0ZRLIuQ6x21AVmMqCzXZ+3IU
         vRIg==
X-Gm-Message-State: AAQBX9fA9mkFecs2MY/Y1sGz957oPde5wqhrQb6ZkuUrCZP4QjDENsf7
        ksbs7qyeTk1bm1wpz8dTNAzMtS42HVVRZw==
X-Google-Smtp-Source: AKy350YBZnal6FjvJZNA3casX1j8Y3A5Yy747WRSGcFjAw8O8yYhlfbRUSBGYNAyRdoSbUM5ZFukMA==
X-Received: by 2002:adf:f84f:0:b0:2ef:5066:7bd8 with SMTP id d15-20020adff84f000000b002ef50667bd8mr750613wrq.43.1680852286269;
        Fri, 07 Apr 2023 00:24:46 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:45 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/14] replay: add an important FIXME comment about gpg signing
Date:   Fri,  7 Apr 2023 09:24:07 +0200
Message-Id: <20230407072415.1360068-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
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
index 59ebbc3b8f..ffd7ce1fde 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -54,7 +54,7 @@ static struct commit *create_commit(struct tree *tree,
 	struct object *obj;
 	struct commit_list *parents = NULL;
 	char *author;
-	char *sign_commit = NULL;
+	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
-- 
2.40.0.228.gb2eb5bb98e

