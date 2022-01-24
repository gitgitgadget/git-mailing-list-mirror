Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E78C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352965AbiAXTir (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352220AbiAXT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:29:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA2BC02982B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e2so77660wra.2
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O7HpXaalYCxCk5dynhjgMwF4vaC9v1JOAuJFl5oFBLE=;
        b=mpzoFdQ6xRsx9KeiS5rx2Fu1usGT++GEGIBxlmKivtwFksSQkFH9Ig5//p/9dewHVU
         Ios1du7Ju0frrEdMqDtG2mdozmAndqIToh3/1RQxx+Cr3m3PQd/1LYGcT2tziVp+sg1m
         /IWcvQNzO5pu0pMmlrFREoGopN09BNhA7dJ8qCjAznLiipOFlhebgJftrOSiSkMw3x8t
         52CPivbzyHPE7i5Ba4Z7p5/GanaXOsGNL9NatDzkJch6TdQMlYdt90duFpWgrP92TykY
         shpU40Hc6owemHUfriDuN70t3RCzxj8ix98KRVgvNPCzaVrHEmptumzFOcUOqZQWqLHF
         wyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O7HpXaalYCxCk5dynhjgMwF4vaC9v1JOAuJFl5oFBLE=;
        b=0Tpjumiisv3pzHaFrHQdyHgoT8j+oYknYiglZSeBmSOxWV6E9pjQZ+iA1L2ZBIOx17
         Avb9MNrQmOe7nGQqLaFLZWOtkYoMhIUGw2vOnhkFA70qx1vAPpO4ETZCCI1D60N/ZNs5
         Y3T+DhRs2prjTg5F9MpquRVJ0oMr9YanJRbI9x9dheTtlztEsCY/4Qsc/O6XwHUgBTVD
         wv6PyRKQ8XFXsqnJv2cLsTqiasFGJGUeR+VlM0lgZRtTkFFAbCZrXW5/aQGMsZ+zTyKX
         oGVcODavIfiIet+rTfQDqLcvSbWfAgstEg2GwaL3bkc2cdrVNKbFDXBrFRxPW+iAuM8d
         UOxg==
X-Gm-Message-State: AOAM532I8IxklF6XMtEKZeYwkXZFP6sludEU8fRHOINR0mSKRVVv2SH7
        wds5UUjd58TkKuEFLPDyaC2GN9PvVjC7qg==
X-Google-Smtp-Source: ABdhPJz78TUlHuELEpYyQegrfflik7h0t6X/9uurn/6zUYS5e9BUQJi8ffHzJoIyVv7m6BtnGvTpBA==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr4580589wry.601.1643051629956;
        Mon, 24 Jan 2022 11:13:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m64sm152491wmm.31.2022.01.24.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:49 -0800 (PST)
Message-Id: <e3d575ae2b474c1e4510dd9b037bd61f58d06547.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:33 +0000
Subject: [PATCH v7 05/16] reftable: ignore remove() return value in
 stack_test.c
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

If the cleanup fails, there is nothing we can do.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index e84f50d27ff..f0be0be9fee 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -90,7 +90,7 @@ static void test_read_file(void)
 		EXPECT(0 == strcmp(want[i], names[i]));
 	}
 	free_names(names);
-	remove(fn);
+	EXPECT(unlink(fn) == 0);
 }
 
 static void test_parse_names(void)
-- 
gitgitgadget

