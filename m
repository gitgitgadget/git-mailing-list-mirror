Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025A81F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbdLSW06 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:26:58 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40498 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdLSW0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:26:51 -0500
Received: by mail-it0-f68.google.com with SMTP id f190so4594168ita.5
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8HHPrWtZICockysHxwI+iC7dbwdIdGC3n/kT5okyEU=;
        b=aoYSq5ZoytdYFqicgbLz9p9VO9WsaaMEijoKB2c/jqDtOystceDZF5HwBYEkK/hVZc
         4d9dPifrBBTdemovj4zaFlavcLabWxs8ljx7Mz+RGrQS0RmiRKwHBYwE7x7t2imdz1Q2
         px4X+t/kPioUYvNPZr8BVqw1pMmXLOnl5VB+aFMB5hyPZluft6z2jvGxEJWx/LgETAth
         RuKwQ9K5Nl1RoKi4sCPK4IK+u3BQI5ca5vcKaWvrf7vjh2KwppIHEJaF5L2x5ztDo00U
         pm2s8At7hS3R8ZKZclfNnvo3N9AvjPOJK8HxooQyHHDmBuNaFdYCBMDYHpUglRJdqR0o
         Yn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G8HHPrWtZICockysHxwI+iC7dbwdIdGC3n/kT5okyEU=;
        b=ZxsIwuJcjLbFEwXALKkaZdWNvyWEih5kfZPm4RAaaXbq6eho9A3ODMajRzlC7L5wyA
         u+TT4PKz4+hUYHpqNpE/Dvw3N1FGW/nfHJ/ezn4/4k5uZV2WtiUlJ4clXwaEKkHIYkH4
         Tk72Z9WOX0f30P4kSHFRX4GO0EjroXszd9Ch10ZizYdx7cRCkfvtVUNczVWa82lBpyUB
         4Ns2FQp7a5jjbGg04WoNvBIBEzbg07d/z4suQyM5OSrTdXxvSZsEawD1W9wY/cCPDXV+
         hvjSU8GMBJRJbOHDIjKLLITFMxH8cAJ7D5O4qB+QO/lwV7XoPO98b/oZVxYB9x62bnE9
         d4Xw==
X-Gm-Message-State: AKGB3mLw8T+pftSft36/0gKLP9bpSL5Zl+DuQ8KUtYz1d5BqpGRRnI8K
        0IvNp1pVjL6C/+/iJU73kKrs+gi2BQA=
X-Google-Smtp-Source: ACJfBosB60a7QIap/t0GbH+AYWzb0A+uSG1SJ69B4QEMMcncSChLH/HwTPRG8V+l8LQiTujSsGKIIw==
X-Received: by 10.36.98.78 with SMTP id d75mr5441118itc.44.1513722410574;
        Tue, 19 Dec 2017 14:26:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d191sm8180823iog.41.2017.12.19.14.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 14:26:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] t/lib-submodule-update.sh: Fix test ignoring ignored files in submodules
Date:   Tue, 19 Dec 2017 14:26:33 -0800
Message-Id: <20171219222636.216001-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171219222636.216001-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that this buggy test passed due to the buggy implementation,
which will soon be corrected.  Let's fix the test first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index d7699046f6..fb0173ea87 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -885,6 +885,7 @@ test_submodule_switch_recursing_with_args () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			echo ignored >.git/modules/sub1/info/exclude &&
 			: >sub1/ignored &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file &&
-- 
2.15.1.620.gb9897f4670-goog

