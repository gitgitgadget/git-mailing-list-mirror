Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BDCC433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F57261029
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhIFEVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhIFEVO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 00:21:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C2FC061757
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 21:20:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m2so3605006wmm.0
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 21:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=X72Y2JXlkRf06MadaeInEifKFENsLmUYZCAf8FbSmSA=;
        b=IqXUwfenDpyVI+SQeQBVKB+DVwFn8mVIX/YljpnJiu6CbxkL8INcAAzwZEm/XQfnj4
         Q51Pdh9eOcUQNXlzHuWL+sTI9FMMQYom+4OEYpVrMlbCpfruT2exLdXia/eYHt6Nu9v5
         QOYYJqz3ZrVuNfAzsukQ9NTzFfQNm1/N0wiHrhGBw/KmNJQLBUK0Yp/7/MsKNrSn5Uom
         VwkPcuWNaCV99MDZm19UklXTFZwch024xgBeL0lbDyUjK0A3fgi4a1HK1+ci109LS1JK
         Meyl9XBtWI4ROu6MAUaEq2XZQRBuGqCR9QDlxtmpuqQoFArEnKZdQu+JEcmrn6ncCcpC
         SIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=X72Y2JXlkRf06MadaeInEifKFENsLmUYZCAf8FbSmSA=;
        b=bkRUOL5PSBUxXJPMjfBvTgCxKRsKGYK5ESYW9Sa07L7Wbcpt39EFNI2fOPG7AdILrw
         Eygwc3vkvicM4Dn98OisvY6gSptkj9zlfxi5oPia+qa/J2TiayvfVE3FmHVEVXGZYq5s
         tYhV2JpcRk5iivmZcVnP2Pzj8JSewo6VTx8JhSEY0gggJ72AbNGxMJcVdzQFVAHvr2pP
         ahr6gepwvOXR8wAHm90E/P2Y7NKdOiDs4NH9S0n+azxq7Q3ys5JI04R12beSOg/xdFbJ
         ufrbrUTA+gqqjvH8NSxBDh+YZg82xuOmklyoAdgGt1sMZMrep+2e8ro/NVtK8ksq2tqo
         ujhQ==
X-Gm-Message-State: AOAM531WJ01LykOTYpu6CuI96shoVJ2/qttlM4yLWwko5bEJGqW9SexY
        xWlefbq+orvVbqp4eKlRBvmT3l3+q0M=
X-Google-Smtp-Source: ABdhPJzPx0Zvjj5iSyDgxiZHBRRPasnofaxdRG2GK4UC5mfDEvDothCKCNcoulEi8Y8pdyLmpcETmA==
X-Received: by 2002:a1c:a783:: with SMTP id q125mr9222592wme.77.1630902008541;
        Sun, 05 Sep 2021 21:20:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm7376279wmi.18.2021.09.05.21.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:20:08 -0700 (PDT)
Message-Id: <2f566f330e01ed4249edad54671e98301dbeec5a.1630902006.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
References: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
        <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 04:20:04 +0000
Subject: [PATCH v4 1/3] test-lib-functions: use 'TEST_SHELL_PATH' in
 'test_pause'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

3f824e91c8 (t/Makefile: introduce TEST_SHELL_PATH, 2017-12-08)
made it easy to use a different shell for the tests than 'SHELL_PATH'
used at compile time. But 'test_pause' still invokes 'SHELL_PATH'.

If TEST_SHELL_PATH is set, invoke that shell in 'test_pause' for
consistency.

Suggested-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75a..1884177e293 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -139,7 +139,7 @@ test_tick () {
 # Be sure to remove all invocations of this command before submitting.
 
 test_pause () {
-	"$SHELL_PATH" <&6 >&5 2>&7
+	"$TEST_SHELL_PATH" <&6 >&5 2>&7
 }
 
 # Wrap git with a debugger. Adding this to a command can make it easier
-- 
gitgitgadget

