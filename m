Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A6C433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30236113B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhJNAJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhJNAJE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:09:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911ACC061749
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k7so13665371wrd.13
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6j3yp6C58c0SnY0buPOfFanHYz9OMOAQb8QO7SzTYU=;
        b=nwF2MR9cBOOEYcVxnty1+yW7nqGzNRfD2MR/juCirr4MCPq8WFDglYkU5vDi+l4Bdj
         UPEwizM0tkCW9qUBpof4q/oINOzTC5AxPjwRHe9qLhEn9D+0vAE603vMY9iE/JPV0sqi
         VKVWEEgu8fUdHVSQXVHUZI4dvfSWL15CiGKsrIB9yd2tjWH7ZYmW76QqJMSa2z2Mhet6
         EDkxIU4Ic0If11YbZ5MxVVjx/BRwhDDv5qmhyhrkf75jVwYaH/CU6sUDl7jJpB/KQfgc
         9wz6XD6v/qEua8DEJQBBtwO8VCHqWuXS8pESrlc1qZ8MKJiyu8AtetGDAVyJIXWgAShN
         QOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6j3yp6C58c0SnY0buPOfFanHYz9OMOAQb8QO7SzTYU=;
        b=hpNfexX4CUhyWvVxOwRlBlgFGEo+kjSEQbkWYBUQ59OW5iClGv+QJmVdGhi3ykLpeB
         RpMf3l8eIXn2mM6APw7M8SkhJ05VvZvBdjoTwiTVMgPtBKzqM+HBZocgeiA62g5izm5A
         SIQ/v9npQQrv4/Klk9bxFfe+bthKWE0DPXtEXgkRPyWmYvJ2+owiQr8t25l7zDhXwcMe
         5jqNuQoFD/VVQnOq96d4e+7zU69mEsmESC4I4ZRuhTbA0Bn2YhbmPo4tzRpDwhRXBP5O
         RsOpcxGHDhpoYUHSHsBz+VbZ1oJqFg6haoEGeZ3bLrfY0jfGTOhx6luUn2thDkjVAl4Q
         YtwA==
X-Gm-Message-State: AOAM531UKpUCEDTdKsbu+Nc6Jk9zxMY65f2XFfJL9UxibHQQuiqHj/H4
        uz+jly6tbVVWQf45Z/pHEEwTiLZcvzOUpw==
X-Google-Smtp-Source: ABdhPJz4mV95lEf6p+C7tyZpOJMMlwA2yR9eDySgmTRKPZjRH0IBJlD8o9VjcajncFv92sTJq5Db7A==
X-Received: by 2002:a05:600c:3b24:: with SMTP id m36mr2371071wms.176.1634170007957;
        Wed, 13 Oct 2021 17:06:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/20] refs API: don't expose "errno" in run_transaction_hook()
Date:   Thu, 14 Oct 2021 02:06:30 +0200
Message-Id: <patch-18.20-df50373a272-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In run_transaction_hook() we've checked errno since 67541597670 (refs:
implement reference transaction hook, 2020-06-19), let's reset errno
afterwards to make sure nobody using refs.c directly or indirectly
relies on it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 16f8220b108..9aa41b55c7b 100644
--- a/refs.c
+++ b/refs.c
@@ -2095,8 +2095,11 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 			    update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE)
+			if (errno != EPIPE) {
+				/* Don't leak errno outside this API */
+				errno = 0;
 				ret = -1;
+			}
 			break;
 		}
 	}
-- 
2.33.1.1346.g48288c3c089

