Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F58C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C348461221
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhDSLln (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbhDSLiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82FCC061359
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so17869575wmg.0
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z9U0KgF8TaxFk+I/huNnvpBLBhZnQwJVq7gqigKK5Zo=;
        b=lTx/o/SluoHnZLVPxIqNrnx15L1BBAoaZjIiU/Nq0mR3sK9vDFQdP8LJ24ZpUgOllD
         aa8XZ0o9IZAKvUXMVyrKWZg9otgHpXwq2VSq98AJJoBTewIVELkplBrkNxvuqwb02/dh
         v3o+iva2aupxHA31ARCtDNJAG8zreO6loex4UEm9Sgt7eNQep7o7pQ6s1mDLj8tkD00A
         rUGs5n44fNZgCy2z1imuZwwV0J9VlTVYlnrn90NsU21cKl1a+aYeJy8eoOw7p6Ml8bPD
         4Ymtcko0sqROTSweuCrHzZBycGAuLu52IwlMl8T60G+1YLUe5WLupoHT3lOwXYgQafdr
         Ol4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z9U0KgF8TaxFk+I/huNnvpBLBhZnQwJVq7gqigKK5Zo=;
        b=Mj6yYs3OVj6lgAXa/9tf5y0SNT5Rak7rLMwcvXkRslI50FOedbzvn7jxn7WMKI/keX
         eT7PhoBDjkGvICH8t3UV89fxenI7SHaT/iAbqwQS7KcYxCOYFavetZ7aFNoV2PlnoG6i
         bMACvQHtFapJLSqA4tSP7O/EjexEwUH28GYW+oK6eBXKwk/22MUwXdIqGEJrg9QQYcIu
         iGIpTS11OSuHpQ7/eLsiy5SpTqmHtZg1uGsBp19lk1LXxsul/IXiGaDvUyvFIVvjpRko
         5uLJ0R7pqCGySgnby8va1R8DHQC8hSqEk4mO6qIehLuv/YwDNFSphQ588MGDr6wfAUV3
         56Qw==
X-Gm-Message-State: AOAM531VCJhOz6SXIhdNN8sLPZ5VoHjc52nFp/bd6Oc6L/CFoc2ijEit
        LGza5P4VGg6uGLU84gPZowVxbAcOT1Y=
X-Google-Smtp-Source: ABdhPJwh64Q1Z7vjSrDgcIhcbggD6YbLTcWHL0NY66nlpvU9+GtpqloRLSNfl3gXrER/kIVu6wWLzg==
X-Received: by 2002:a1c:7ed3:: with SMTP id z202mr20780286wmc.136.1618832297531;
        Mon, 19 Apr 2021 04:38:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25sm22279589wrd.43.2021.04.19.04.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:17 -0700 (PDT)
Message-Id: <0c1eb69900a7aa9650dcc695ef18793602320cce.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:55 +0000
Subject: [PATCH v7 27/28] t1401,t2011: parameterize HEAD.lock for REFTABLE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1401-symbolic-ref.sh          | 11 +++++++++--
 t/t2011-checkout-invalid-head.sh | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index a4ebb0b65fec..4e130776b40f 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -99,9 +99,16 @@ test_expect_success LONG_REF 'we can parse long symbolic ref' '
 	test_cmp expect actual
 '
 
+if test_have_prereq REFTABLE
+then
+	HEAD_LOCK=reftable/tables.list.lock
+else
+	HEAD_LOCK=HEAD.lock
+fi
+
 test_expect_success 'symbolic-ref reports failure in exit code' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
+	test_when_finished "rm -f .git/$HEAD_LOCK" &&
+	>.git/$HEAD_LOCK &&
 	test_must_fail git symbolic-ref HEAD refs/heads/whatever
 '
 
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index e52022e15229..ef6471cb0954 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -22,9 +22,16 @@ test_expect_success 'checkout main from invalid HEAD' '
 	git checkout main --
 '
 
+if test_have_prereq REFTABLE
+then
+	HEAD_LOCK=reftable/tables.list.lock
+else
+	HEAD_LOCK=HEAD.lock
+fi
+
 test_expect_success 'checkout notices failure to lock HEAD' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
+	test_when_finished "rm -f .git/$HEAD_LOCK" &&
+	>.git/$HEAD_LOCK &&
 	test_must_fail git checkout -b other
 '
 
-- 
gitgitgadget

