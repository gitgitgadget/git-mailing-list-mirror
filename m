Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA713C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832D220716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsNuP9zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgA1S0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:26:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35986 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgA1S0u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so3673600wma.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pl9kK0IVJdtZMHXu52/f8Sm0g3stqkcV9VxPh4NkuJo=;
        b=bsNuP9zd9zk4+cpClSH9mpG6UrmlxBUaMdLDXourUztDzE+XtAUO5hWq4Kq2qaG4Rf
         pj5d8DzIq5ZLHK/ZnrdwdrdWDZobj6C3FKq6ZPKQjhEKwt9hKPm1hhGOqCihKj/yS1HH
         4xRvtoRUZiKUdpBcbAnz9J8hM7CYomXVRqvke5oqxA3MfED0swda57viG1/9ZU+fxyvt
         5iGZNdUkCFDeq/rP0k/FCkRRyDrBXE+lna6Ft9xVGmTgKKcQjxjRTzkPzwQV6xeXEnEX
         vxH8w48effC1DysGhCDTY1BhYyUH1VgSJI3XW1F1JV1i7xTvOCtCbqcns4qfGrZmbfQk
         /GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pl9kK0IVJdtZMHXu52/f8Sm0g3stqkcV9VxPh4NkuJo=;
        b=AHivT9yYPT6AUOnVZUs44OcOzx9lupd8E/wgSkYVbVo5/ObwxGWIlIaP4g06g9hXr8
         XwI8RViwui3GoiS3G+Bjsd2fFUHmkPW+FYDeomww8UuvDaiKR+4v9MSgLBsOBp0uoqD1
         pLbYBHRX+dFllAdM8B/z7S4gH0pY8y5fKn2Fs8MoGvwYlaUs8vrr7cgLWC8PMvfcvZTe
         BaJ8vamJZrD18NHh42GLxWYrhLtqTMByhWqv5Dm7U55bV+8K4g6JY5kxcdnFqTSvDEMJ
         eN+48ZswQy6Gj9j2xG6tCIp1QOM8n7j1JYUNR7NSUEanoQXgYrGpaVqGFjqxKjXjXVl+
         Cv1Q==
X-Gm-Message-State: APjAAAWRIJ9yzoIIUCmAjDTpZPwpQcWM4Wk8OdfiHz/ith5uEjiWx3+G
        IIdpd9m21yIk2/7poeepFLiko22F
X-Google-Smtp-Source: APXvYqz8Zc1zsNqSLJ3Ichp+C5an9L1CxMoTXH3TlDXqldkqFSv/41DfuXm4fI7GF07Qsk8INyY3lQ==
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr6388758wmp.109.1580236008582;
        Tue, 28 Jan 2020 10:26:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm4075092wmi.26.2020.01.28.10.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:48 -0800 (PST)
Message-Id: <ae78c3069b08557e3acc544601c71ee932ace19d.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:36 +0000
Subject: [PATCH v3 05/12] sparse-checkout: fix documentation typo for
 core.sparseCheckoutCone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 3b341cf0fc..4834fb434d 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -106,7 +106,7 @@ The full pattern set allows for arbitrary pattern matches and complicated
 inclusion/exclusion rules. These can result in O(N*M) pattern matches when
 updating the index, where N is the number of patterns and M is the number
 of paths in the index. To combat this performance issue, a more restricted
-pattern set is allowed when `core.spareCheckoutCone` is enabled.
+pattern set is allowed when `core.sparseCheckoutCone` is enabled.
 
 The accepted patterns in the cone pattern set are:
 
-- 
gitgitgadget

