Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF5C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A4620829
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwJn+vKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgERUbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgERUbc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:31:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F9DC05BD0A
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h17so13343451wrc.8
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=MwJn+vKUyTu/rZcEkAjAEIPHRCYfbzNQxtgkSlkPYzfnX8HfGuo1hsg8BDSF0tqtJe
         TeJiAKqJ24+K3sfqzjPEVPwryy6ABgBsWV12cCmTl9vPS5xlWstFaWSRnLoJm5WafXer
         +0U6Ykt6A7tR6odwjVUfGGcXfgozvXvYL9kNk3zrp+7b543VqI46UZy1OopDaW4bJ3fU
         cYNFEQalexMqo7DKhL8LdRnVAg5xPMMFYXS1C7uOSAldTfWZGnntCESwuywcqXLbnECP
         XV1hhhhSshcVrpHs7KoV7p9KNBHkcs72vUk1Lr3PLD5vi2z+iOba2P75jQbMASygxlrk
         mAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=PbzqfApWL7SES7+LGuJTWIhIIqtU21hxX7Dc+DeC1TAjWf6WXRr7WfgF2FLh5FTxWe
         IrIHbAc8FqaFDFzMCPq2jBUyd/mxe/UU6mP/1UklbZylmhGp6H5peVfAyI1C3OhjeEeI
         WqOX+Uho4K5zk201twtPx9t2XCoYMO4XhyFMubcwRtTzrHzSq8euyvDKJOc586ECjWMp
         umotioOPYsHmtYfL+ZQG3qHDWoZlBaNXumYL2Wl2g5Svnlq8bhzPlSKswz8FfN11gEu1
         FSmG7sNVVek2B5+TtSLwlZrUo/ifDdUGtUd26RIpmcqeSscI80SSlJ22vpzhes8zRdij
         ztXg==
X-Gm-Message-State: AOAM5305g2TFjl2ZcP4rjyqIYxiX4h42R4uUhNmIGP0GyQtgYbJ/8XBt
        dZY+Q5j17qAC02YQbueh6x1qfQn+
X-Google-Smtp-Source: ABdhPJxBkZ8Y+iTRU29B2XF6oo6og3R3r5ECELTLdHNfjdXl/F/7LHJXWeU9UHZNvHjuZWx7nARQ7g==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr22942316wru.40.1589833890335;
        Mon, 18 May 2020 13:31:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm17615812wrs.2.2020.05.18.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:31:29 -0700 (PDT)
Message-Id: <206b7d329f846880b71b61b766dad416d2327276.1589833884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
References: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 20:31:19 +0000
Subject: [PATCH v14 4/9] Add .gitattributes for the reftable/ directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 reftable/.gitattributes

diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 00000000000..f44451a3795
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
-- 
gitgitgadget

