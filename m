Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A9C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiAXTdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352680AbiAXTa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE99C02983A
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e8so13692889wrc.0
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s8KHLkLqupAFa85TGasfQB8YpksyOQa7dTuyqNPbJZM=;
        b=gl9LdwkeKA9rVlPXCSOyNw4ZfwE3nPJ+rr9DrGCy8eThQAH1DXUnZ/qI0Fln5vvqUU
         L2sM/YsF6I1kSCbPhBCWPTTsNzlAAWOdPNYftkP8DBK33W+UffqVWAHOse6qhTponqAs
         YEL6bnJdVfICUem0wKZwpHpltIO641ertP2fZ6eYhCDn0u1bAdAXYEBZvtLNa7dJZmL6
         6iBuBuIzxoBQMxsRTZa/akHLncm+fnxCtrgVCDlRRHq95fmj+p5x087p0lNwKNupQmyf
         ipLa7GNXGELsI5xPaqSwbEIeWsP79tZQtq9IXCWBhFvBqqa152pjR62rCRLIocFVuTVe
         X2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s8KHLkLqupAFa85TGasfQB8YpksyOQa7dTuyqNPbJZM=;
        b=YaivSM0AaOhEQEUfew/XIK0ttnpVfyk92SH0N1crdLc+IJCVd5dN1iPNjeOA+YcQ38
         UNVRxbXjlXjuG0d23PG1/8+V6XMhpaNS3zrV2vQFKfdlRljj9xWw79ZaQadrDUUe1MP7
         WIuVIaASErme8x1odDhhdxrnN2nHOBF2wIg+gY5W0oe6O83hBYxLDrjA9H0CYJ2yE93k
         u9puoPLuHV8iwjmhiBkNPzXuXVW53VzPa2oOdgiCdBXo/5SFE/zZySAAGlgIlUuMOqp9
         aFjB4NlGc8u78sonbKE+J6JgytRFVZV0BlYUIhkVx3uh43DR9ce+kTlKKoCI7qembGjX
         oCTA==
X-Gm-Message-State: AOAM530Mvu8zXMUEvIJkBYAk8hvuoa/dCvTeGHSO81O7+VbWIAsI4GRw
        O1Cqnntv9xtO5pQ4oH1+iWOhk/m/tgxORg==
X-Google-Smtp-Source: ABdhPJy/NULrMrpWtXSn0pFxNDLVVbRNyTROKZyFf+3373ftDb54KGdi/5nNMk0Yg/qR5UCfOdibvw==
X-Received: by 2002:a05:6000:1705:: with SMTP id n5mr3059696wrc.283.1643051633766;
        Mon, 24 Jan 2022 11:13:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm891562wre.45.2022.01.24.11.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:53 -0800 (PST)
Message-Id: <a118cd40975e5844050af1a643140a915f9639f6.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:37 +0000
Subject: [PATCH v7 09/16] reftable: drop stray printf in readwrite_test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index edb9cfc1930..605ba0f9fd4 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -696,7 +696,6 @@ static void test_write_key_order(void)
 	err = reftable_writer_add_ref(w, &refs[0]);
 	EXPECT_ERR(err);
 	err = reftable_writer_add_ref(w, &refs[1]);
-	printf("%d\n", err);
 	EXPECT(err == REFTABLE_API_ERROR);
 	reftable_writer_close(w);
 	reftable_writer_free(w);
-- 
gitgitgadget

