Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F6C33CB8
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82291217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi1LLWir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgATOjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:39:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54213 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgATOi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so14728867wmc.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mN4wVup1TbxTBWbrWa8w4Sm79LVObxeYH2Qg+4mqYn8=;
        b=Pi1LLWir4JopY2BjZP9NOvJYNFw3zvjpLj4SHMBdWxhKDqiV8/p+F4KObWBj22syY0
         MTxCJo/Rx+tukDrlI9553M+7yAbhWFMXYSbFxf+hiQUNxf0F5S6EFu+p6yGxe7dHM42S
         +a7+cvy1ZTK5rf+kWFDUOMXnHkNpFzN9Qq2yDu9XB/etPmYKIcQ2aej32xCuEPcd5E5i
         ItYG1LoQNvJ2WmqswVmbVuAlIRFx4IzHwKxESpKNmBW8r15aFl/XEUmZCLHXcztlAXo/
         9qRNANltPa2o8PTTOeF5bnEFgodSdthWjx4Rr9Ilv1WVmBcDpC2dHFzFi6LrHDioBASY
         w4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mN4wVup1TbxTBWbrWa8w4Sm79LVObxeYH2Qg+4mqYn8=;
        b=mKtY5nn3M+EYauYuEIxClmPNdlWTCfLbboFGGu6vHLKjtu1H2lEViAixCQ7XgJp8oO
         jz8wVHVduCGiu7jKQjTiLbqKgOgItIMym0W+cZiXSXMbMTsvIplWj4WfZKMDZ51Z7w/u
         0eH0WJTJ6GkB9CbkTQQ6O8jZOj603KaR/9MvO1zJLY1DSG261JCGqiG4zSAJGl1nRtvz
         wdGVljc3RL/6nE5HOHya8Fy/sAEYN4rTPuq9BtE4patQOc7EK9YmuHpqpAd9kR/ZZG/D
         rNjEybfYURsA9nR/xJFYwuC6/ySLJlOLcAOmuH4UAXt7nDap/NoJgbwROFNvxefx3OVc
         Kedw==
X-Gm-Message-State: APjAAAX92Yzw7Q76oAZyjui8sxaBVUUIuv0HaJyNNMsR/1fmt/czs8pU
        lu/cQzTdW7d820AG5lZnBx5NeIj8whE=
X-Google-Smtp-Source: APXvYqx4h5XSotMzFhr7bTq0VyLaka2keeojbZkXSQZ8GzMxy/tYKrkBbXR3qqfpDeP6FGyO7we7Lw==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr18797150wme.132.1579531136666;
        Mon, 20 Jan 2020 06:38:56 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:56 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 23/29] bisect--helper: use `res` instead of return in BISECT_RESET case option
Date:   Mon, 20 Jan 2020 15:37:54 +0100
Message-Id: <20200120143800.900-24-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Use `res` variable to store `bisect_reset()` output in BISECT_RESET
case option to make bisect--helper.c more consistent.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 95ac1a4558..378b41cf70 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1077,7 +1077,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-		return !!bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
2.21.1 (Apple Git-122.3)

