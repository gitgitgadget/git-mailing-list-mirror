Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA7D1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 19:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbcHOT7B (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 15:59:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35143 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbcHOT7A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 15:59:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so12844440wmg.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 12:59:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ds7VGwBpsIrBV1eVcAUc9zFOsQN9x5uWIi4J1iOuALc=;
        b=fALx0tldjys2O9AzgNKKmPpzEAQvWqHYjUj1wVlaLRB3B30HjO/yH88fzK6zmIDYHZ
         uBHBdOLVsvsbyhlYJvOxl2nZ332K5K8qI5HL+r3OdGWncUT74wU/BNjj2eUEhZvOv8e/
         z93SF0x5cVb302rb/2851LuTYv2VJHkpPDM8bvZcvrXkety+qb0/YG2JJTCXD+ZZu42r
         8o86sBcoVLXfoMt75UK5Nr3PMRLVksMnPjTD6Ioz8sbFfxt+8FTv+YENimJ5expzSasi
         Xe0vT7nuDVIQ1zwYIOVJ7nDQH9757iW38vFmWPd5efWaL4zflO48Xq/X2z1dOKSRqbGk
         5K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ds7VGwBpsIrBV1eVcAUc9zFOsQN9x5uWIi4J1iOuALc=;
        b=CQDGcwVAryunhJfydFavP/of4C+WTC+tP17lddBfjDjdf36NpxhMTJVf+B87iLCa9z
         +WXzzN7RIU0dB8ZscS+uu01kPmWWs9Mam3gt3a9gN1MiOulVi2CkLurygMO9A252twez
         ERRcFa+WbX/DQJovrp7dV2RCehaCHJKDWbL6DAtZRb8Zr3MlLyCjMCjugoR4Ex9WY5CQ
         FVoJEauaz6Q6UgwjNfblPZkTLVnld3i3k+noe4NHXe/NcawHanSYoB33ofXDMaGWZOsx
         lqqxAePaekxJrsxh1LAR+Wcmw09QdTjNCQgLbtDpvtO8J7PtT5zb1mkN3ppRjdkf2hGs
         dbJA==
X-Gm-Message-State: AEkoouuy9hwvhjjx3NoA6IYZMwOdKc8A6EgTjZ+EJaVQmV2jFlBCHN+T5UMxsxB5ZVdHTg==
X-Received: by 10.194.23.39 with SMTP id j7mr33236910wjf.4.1471291139318;
        Mon, 15 Aug 2016 12:58:59 -0700 (PDT)
Received: from localhost.localdomain ([80.215.5.33])
        by smtp.gmail.com with ESMTPSA id p1sm23065623wjd.37.2016.08.15.12.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 12:58:58 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/3] index-pack: add --max-input-size=<size> option
Date:	Mon, 15 Aug 2016 21:57:27 +0200
Message-Id: <20160815195729.16826-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.4.g229e32c.dirty
In-Reply-To: <20160815195729.16826-1-chriscool@tuxfamily.org>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff King <peff@peff.net>

When receiving a pack-file, it can be useful to abort the
`git index-pack`, if the pack-file is too big.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/index-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1d2ea58..1fd60bd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -87,6 +87,7 @@ static struct progress *progress;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
+static off_t max_input_size;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
@@ -297,6 +298,8 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die(_("pack too large for current definition of off_t"));
 	consumed_bytes += bytes;
+	if (max_input_size && consumed_bytes > max_input_size)
+		die(_("pack exceeds maximum allowed size"));
 }
 
 static const char *open_pack_file(const char *pack_name)
@@ -1714,6 +1717,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					opts.off32_limit = strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
 					die(_("bad %s"), arg);
+			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
+				max_input_size = strtoul(arg, NULL, 10);
 			} else
 				usage(index_pack_usage);
 			continue;
-- 
2.10.0.rc0.4.g229e32c.dirty

