Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D423FC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF3D613C4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhDWHWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbhDWHWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5BAC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cq11so12716042edb.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQkAHZxPbZg1lWB15Ac5eA2xTa2m+/IgB8T1GmhbxV0=;
        b=VFyWFyIuQCyiGa0E22MeXeqfjI0NBDwms9xk4wQPVW2Q19jwNSKuXWRrpCe3HkKuG9
         pwfD8HhSUAXJOsRHzABTgaj9d9rLJhj4ysI9y9dLNyiS7KGYbp06IfCuB+C3k6fcD4ug
         vnviRw+9tJrsHyjad0yNqTJtjRH8UHWjJnENKMm9Mx2d7Tt4fLtuRwKjmiB0lvctOO7u
         V1PXwPwXLwoJpVUT1/Xj3sSzpQfuZ/J+HzG92O15QdeTAt5PZnhfzcQ7jLWQ3GdUF/n0
         dgxRWX9zDIs5ps6eZgENyLZJFAIPBFJnFKCJuiXeE1WOO0iaor/d3bHW/ycgaKswCtDW
         0QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQkAHZxPbZg1lWB15Ac5eA2xTa2m+/IgB8T1GmhbxV0=;
        b=swJScG1QyXwj8yyif6DeqKbifjfpJeroLjpZ6EX/0YcJIdZzYFqfusJsdbSA0DVW5Y
         3CYFu9vZJRRSIkU01qNRseg7qMATrtogM35Ugw29wv8Up5H6dchL3xlTYSunrTUHgaGZ
         PhHghr68/EYqw9qbq1M9EwTrHs84okLrFoAVQFA2oaCUqm8sXIurjg44hQhkYRXErRS/
         VLdHDxKz4m8exXjmARabls6SI2VsXIyPXwcTltWCbxIrIu7v5pwTE4YxDSrfvSZzFp56
         TdDibPamIoOzP+8n7B7QF7HNIDy6IjzIHVqHA2Q6fnXS1h+NVVucHxyrkoJWs0Eom7m3
         0l5Q==
X-Gm-Message-State: AOAM532kK2/Jrinn6oRFex5kNPFVh5jQ+WODrfdTu3VJx1WJaA+pVT5E
        IYeVf6u8317hmBsAIVR2SMRAIZGrc0hvhQ==
X-Google-Smtp-Source: ABdhPJwaBYbCsadLly8atQ27ggHS0pNjqHbL3Au5OwVGYgIEkMifVeKpr3UuoTvCNvqvm2BlMMGZgA==
X-Received: by 2002:a05:6402:2290:: with SMTP id cw16mr2939736edb.162.1619162485728;
        Fri, 23 Apr 2021 00:21:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/11] test-lib-functions: document test_commit --no-tag
Date:   Fri, 23 Apr 2021 09:21:08 +0200
Message-Id: <patch-04.11-2db68a4ac7c-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 76b8b8d05c (test-lib functions: document arguments to test_commit,
2021-01-12) I added missing documentation to test_commit, but in less
than a month later in 3803a3a099 (t: add --no-tag option to
test_commit, 2021-02-09) we got another undocumented option. Let's fix
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1f787ff0726..c6d07f4ce32 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -177,6 +177,8 @@ debug () {
 #	Invoke "git commit" with --signoff
 #   --author <author>
 #	Invoke "git commit" with --author <author>
+#   --no-tag
+#	Do not tag the resulting commit
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
-- 
2.31.1.737.g98b508eba36

