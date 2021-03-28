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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A6C433E0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E16619A2
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhC1C04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhC1C0W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:26:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC0C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso4921704wmi.0
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+eudZymJLeiGXO8TUGLKBGN1MOkewWMF5qkfXLV8emY=;
        b=u8/TFage8A0AGtx+zkEonjofsDdKTiMp5aiSqUckpK38XSYKcBn7OMzHWnV5zvz8G8
         5yfxXME30bxKPjBI0qEdcw+gHI26MG6V5/x/AUMr1OI/CBmIYjdCT5LSngSIM+68umeD
         cbSo7YHiWXZNTvhGwTYkA4UysLTgEA+j534yvlvv6UQwYJ9raWb5oYKqq/bgKCiyMEAR
         btDohapM8o4AnytxOmDfVIvvENMVDRbTZnTf3WL2yN+u5ufks3LYm9YR1JFKDIkeM/8D
         lJ4zw7saNqT4RqeJSRM7K7b5C9n9oltmqPoCTb1m2fS9Wl7p7jsW+9YkXH9joeOxDi3A
         LqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+eudZymJLeiGXO8TUGLKBGN1MOkewWMF5qkfXLV8emY=;
        b=poO+ZtKSS1ZfXKfrxV+6IZ68s4PJC42gczthWYT3PysPgkovvU9cfoOOYMrTNH1+oa
         E18ugGuv9Y3KaQa7dxsEYTVgFC3nBD/ijsa8yXMjKOvvOk1R6JbisBx5lFNqjXPQjjmH
         CkZ5YIhdYELgpUF0i0/hmIKPMSaJAn+eMPOGfjm/a+bCFpTYciiDNv/UyYzt1GIYTpNZ
         5FB9IQNFwJN30fUsSE6mcLRA9dlf1z+LmnPp0bgKdG4wQvy135bxDDq1KtS8uhWxSi20
         xBs9xW9b0A+TXzmwLYGjLERb3fzkKs/cBLNnXVrcMEdNWiqXq6ed/dp0V2j/z/yn3iqm
         zbbQ==
X-Gm-Message-State: AOAM533c+KzGX6s8tuelKQ0YsmpcxFxfOcwAxs9S8MrCSW7tWm1oSGQC
        iNr/epxJm1T8JdwTE80aNxixhQbKnPcJ7w==
X-Google-Smtp-Source: ABdhPJyd/TMRouHgESFC7DuyT6QizwbjQYyfi79ORYgPI0S4JWuQBen4xvWTz5xLj1WcBPupwWf59g==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr18901171wmq.71.1616898379244;
        Sat, 27 Mar 2021 19:26:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11sm17887305wmi.3.2021.03.27.19.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:26:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] api docs: document BUG() in api-error-handling.txt
Date:   Sun, 28 Mar 2021 04:26:01 +0200
Message-Id: <patch-2.5-8c8b1dfd184-20210328T022343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the BUG() function was added in d8193743e08 (usage.c: add BUG()
function, 2017-05-12) these docs added in 1f23cfe0ef5 (doc: document
error handling functions and conventions, 2014-12-03) were not
updated. Let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/api-error-handling.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index ceeedd485c9..71486abb2f0 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -1,8 +1,11 @@
 Error reporting in git
 ======================
 
-`die`, `usage`, `error`, and `warning` report errors of various
-kinds.
+`BUG`, `die`, `usage`, `error`, and `warning` report errors of
+various kinds.
+
+- `BUG` is for failed internal assertions that should never happen,
+  i.e. a bug in git itself.
 
 - `die` is for fatal application errors.  It prints a message to
   the user and exits with status 128.
-- 
2.31.1.445.g91d8e479b0a

