Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3041F954
	for <e@80x24.org>; Wed, 22 Aug 2018 17:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeHVVOU (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:14:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52183 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeHVVOU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:14:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so2785129wma.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8selHQjabjQ3oZAEau1mz802IuUfBQ4gsbIkOV/ILs=;
        b=JQHHYEOlUouI4skIaYVqpuWW9a6D+3LwLRA13MdUH9iCYrBtn7lJJznoimMWyT3kBR
         TFQW+RirYfEO8xbRnkraRKDWhiIfkerwzu1iL1TAiaYwNEcDEjUGxTAKKH2s8btRrAJh
         yvcB0c10Gi2CX6Erl9KDcQ1LmY84+qme8TMQpqd9SlNgWKw7oS8s35zT2ai9hS9ZC+rY
         jnIjjuUydIw4RCgf2RkmgjZA1qPRhtogbLxt0pIMrA1C9tobQ1LiupXap3K4Tsy7//Wz
         OfOlNORNEU/Qf2gT7Sxp97PZJB1yVZ5BvDiyej1kg9fHw08QW2tyxW3IPLng0P3VwWxO
         EZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8selHQjabjQ3oZAEau1mz802IuUfBQ4gsbIkOV/ILs=;
        b=WjyQIcgf9OlHJrR1LV1e0JKJlFWyKFbFB0u3jbkH25fc6N6/KiSVxE6tW/4YPJM4nP
         4LXVHub7YTrhEb7tkuCtn7RgozoQ7/U1Ny5jCXVyhWhCM1Kqj/3vD5ojOfQfXlZD96zT
         qwdiUZ/EDTY7BkoaA9rj5/kjqsDC6SAEdibEbo+SK8k6entvrrLm9PzqF7IymvYl8EpC
         gWgdFSLtnj/BmmEH9YxbC9WOzK/S6fQ4ySQnXJLXUTIYze03zAynqCSn/cHE6Vi4egvs
         pn6St+HPQ+IB4T2GGJIid4UDBKTlII1d/LTfvsm1bWxABvvSdnGUYcnIqzMHFZy6wFOl
         PXlw==
X-Gm-Message-State: APzg51ASr0dxFnG2Mmhby5tKtHsSufCIL7XcVft0biuSTakyG6gtbVAQ
        kwOX/zNwP657znpzWm7POkI=
X-Google-Smtp-Source: ANB0VdYnn9eQGVGnXm/7hSbHvjyN7znm5WoRc2YFl1a93okFzf02xn9EaeqTIN76UH1mCB8JmBCCUg==
X-Received: by 2002:a1c:80d4:: with SMTP id b203-v6mr168963wmd.9.1534960107885;
        Wed, 22 Aug 2018 10:48:27 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id w8-v6sm4578824wra.22.2018.08.22.10.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 10:48:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t6018-rev-list-glob: fix 'empty stdin' test
Date:   Wed, 22 Aug 2018 19:48:20 +0200
Message-Id: <20180822174820.12909-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.136.gd2dd172e64
In-Reply-To: <20180727174811.27360-1-avarab@gmail.com>
References: <20180727174811.27360-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to d3c6751b18 (tests: make use of the test_must_be_empty
function, 2018-07-27), in the test 'rev-list should succeed with empty
output on empty stdin' in 't6018-rev-list-glob' the empty 'expect'
file served dual purpose: besides specifying the expected output, as
usual, it also served as empty input for 'git rev-list --stdin'.

Then d3c6751b18 came along, and, as part of the conversion to
'test_must_be_empty', removed this empty 'expect' file, not realizing
its secondary purpose.  Redirecting stdin from the now non-existing
file failed the test, but since this test expects failure in the first
place, this issue went unnoticed.

Redirect 'git rev-list's stdin explicitly from /dev/null to provide
empty input.  (Strictly speaking we don't need this redirection,
because the test script's stdin is already redirected from /dev/null
anyway, but I think it's better to be explicit about it.)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6018-rev-list-glob.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 02936c2f24..0bf10d0686 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -256,7 +256,7 @@ test_expect_success 'rev-list accumulates multiple --exclude' '
 '
 
 test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
-	git rev-list --stdin <expect >actual &&
+	git rev-list --stdin </dev/null >actual &&
 	test_must_be_empty actual
 '
 
-- 
2.19.0.rc0.136.gd2dd172e64

