Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D372C4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 21:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3788560FC1
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 21:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhHAVxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 17:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhHAVxY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 17:53:24 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA8AC06175F
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 14:53:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t68so14936299qkf.8
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RNTlamNP7EGxtKJW9QFZ7Ed0BCIofefA7Yqh2ReX5M=;
        b=fbX7BO8+/Lbx7E2Mc7jbagzePIYDNvNkvxeqS4aCDOYmwqZkdcG8ZrQk9TSVE43S0A
         GExtTiqGZ8srrwzR3SdXoIytRQ/vtRmqbVSEWnnxVMlkn4zeo5asmOsOGO6IKsJdbDEE
         C2agil/MjAj0d05YI2Tom/iAcaFUZxCtGo5q4O6eUqyuQbn4296zUUQ6HoIFezYjgyun
         SGuYNnNQxBrI5wlQ9Ibd2JyXYGtIWZBDcegbm/V/8XhM5ciWK4YK4FpfA9aNOiIqAMxo
         I9GAdKgJ0GERSRqbOQydfc3a8A6kTlK5RAQPQf6E4rrt28yjy2i4MPWSr/EWY4NSPOab
         bQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RNTlamNP7EGxtKJW9QFZ7Ed0BCIofefA7Yqh2ReX5M=;
        b=M2wehgYnhol7zrxUV5O+4NEf8OvGMPNxuX9vg8lhnXugjatbd33AsWhJRC8YB2Qehh
         N1gm5qxGqXtAiw5KSp5rAEcdW+3h6qYYezOZdfmlsuxqZ/GigfjpibO7p53xIYkbTw8B
         DtzywYmOqo7xzfPFC3AAr2VcN/YTztBT3Pg2Uqx3RkVz0i9KyEAQm1smUptU+EJx0+OB
         C+JNOhlZn035KjtK8lEJ0EnnhK5DeHb/CYIXmMfeGYtWi+PGQEMC58nLByiwYzXdMlqV
         xIM02ccYrM2NsCM9IBFPm345tsM1B9H0fc14aC7TJ9VekeKZh4BT438L/RrjBayL6xd/
         I/wg==
X-Gm-Message-State: AOAM531TrMpcyPXG8XvRJaX5tvz9FrF3SqNKIZpNA+RckkPtBAu+uZ/G
        EuDxkHECN7n5AYu2cPe4OB7YZy/rqmM=
X-Google-Smtp-Source: ABdhPJyS9FGGyXhmn6WUm5LFvcPZvGDACi3v1fp3b0Ke3PzsH2O6+p5NOVSzwbHxuzzWtPqd8w+xug==
X-Received: by 2002:a05:620a:2a15:: with SMTP id o21mr12067469qkp.132.1627854793495;
        Sun, 01 Aug 2021 14:53:13 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id j127sm4755819qkf.20.2021.08.01.14.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Aug 2021 14:53:13 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] t7508: avoid non POSIX BRE
Date:   Sun,  1 Aug 2021 14:53:00 -0700
Message-Id: <20210801215300.53781-1-carenas@gmail.com>
X-Mailer: git-send-email 2.32.0.826.g286871f41a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

24c30e0b6 (wt-status: tolerate dangling marks, 2020-09-01) adds a test
that uses a BRE which breaks at least with OpenBSD's grep.

switch to an ERE as it is done for similar checks and while at it, remove
the now obsolete test_i18ngrep call.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 2b72451ba3..05c6c02435 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -882,7 +882,7 @@ test_expect_success 'status shows detached HEAD properly after checking out non-
 	git clone upstream downstream &&
 	git -C downstream checkout @{u} &&
 	git -C downstream status >actual &&
-	test_i18ngrep "HEAD detached at [0-9a-f]\\+" actual
+	grep -E "HEAD detached at [0-9a-f]+" actual
 '
 
 test_expect_success 'setup status submodule summary' '
-- 
2.32.0.826.g286871f41a

