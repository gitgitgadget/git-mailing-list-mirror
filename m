Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A10C433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbiA1AMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344469AbiA1AMi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0F1C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h21so7647910wrb.8
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gzUOFwJTdjbFyf+Dn8UdDY94vfUQnvj8Lr3SyjI2DqQ=;
        b=FzZIHrn5GMYxhEbv4bLM5Pg/16WUA2mZ9n2K/VvN5z683epL8L6TxTyF2nnmVLlv3v
         MElDVG99b442vuKdbebwBeqLsHZXQVnEvi6gvDy5bwHHFrqxcL9Ujakamdo1DXiiiAyv
         8I/BHGUAe399QOeOXAOw3Wc9lcBNK3b4Vci8n4Q0kaG6s7xestY+RpJZwCFqrEBYtsRR
         kHLvd2nSEESrcDI2YrlVVYP8jMi8se19Vnh64HzKTzv9jqUcQjLwx3OFCqRu+0JUEasY
         tHNxLUlCWS+RCYxvw3FjoWoG5zbwYMQN9RafuDWYvq2+Vt10RqBj724Iqf6ewf+wGpih
         /EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gzUOFwJTdjbFyf+Dn8UdDY94vfUQnvj8Lr3SyjI2DqQ=;
        b=4D7snafEPte6F8405531jwzmhQY2W8E147Ci/kB/u89T3eZTkTtZkEIseV4FMpblv2
         D5ubpnQ4gW7ETFvl08Q2JPsAT4n+LKbuSRPUwuJUl9uFv/6hfqL82kPEiouMsuRKOzvf
         DpSvsAam3Jjyrwivyk0/JA1yvMvFpvNI3e75HgnPQpYboBgcgZmQTXt+yoj2H5TiSQL0
         T3VfNi+fLOM5GSrbUl71/CAnhYsfBGwpU4bNHNgXx64Y5moFB6RPQltWp1t1TC7M6CgL
         swXmwV93jxh3/qmLxqupgbYRiEH2ucAXbc6RnM+S31/YXeD/+fS08Uiw1/0TThnT55TT
         /5Pg==
X-Gm-Message-State: AOAM530M6y5WCM1F+s0k6O2TrVTw5XLp/Rv2ONkzrB1SEZAXlCVFvkNh
        abIg+nFQs8gxmad6OQ2Dl1yv+iTQCt8=
X-Google-Smtp-Source: ABdhPJwvWNCBpPgAaSOrRbTRGOteMz4J7wV4VKHv4BLy+NWfsbkWSX+DywM8dDg0ntaHBVq3546JhA==
X-Received: by 2002:adf:ee4b:: with SMTP id w11mr5060578wro.248.1643328756715;
        Thu, 27 Jan 2022 16:12:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m29sm592644wms.34.2022.01.27.16.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:36 -0800 (PST)
Message-Id: <3de4c48b66dbab7c9bff486221cfd29212cee893.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:25 +0000
Subject: [PATCH 04/11] bisect--helper: really retire `--bisect-autostart`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since b0f6494f70f (bisect--helper: retire `--bisect-autostart`
subcommand, 2020-10-15), the `--bisect-autostart` option is no more. But
we kept the `enum` value of the command mode around. Let's drop it, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index dc840736cb5..7ba4be1947e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1172,7 +1172,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET = 1,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-- 
gitgitgadget

