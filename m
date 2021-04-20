Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDD3C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D6C613C2
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhDTMWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhDTMWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56CC06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y124-20020a1c32820000b029010c93864955so22429519wmy.5
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CecjrqhZu5jr158EfKTQNkLxhfn9+U4Xzq5YaTdHXKw=;
        b=kxn+QyzUKLY3669x2eVh0904T7C942OkcMErXg6Aqoul2hoD6fRSBUG6UNbW7GX8DF
         oMJgS8PGkliWVUb2HZfAF/dJXUzcGJJOtrT0vY569Dgo2ToMqiTNZgekP3Ytssa8zD2G
         DmVIfQGl1Rwcj93gI9lVe2XnnJY2zMjoIGN1R4ENXLlOdk6RtQz5oR6O+9qS17tBxSyS
         iSAEKOUWxIBAWhJozcGOMJfd8/TzKhSE1/e9rT3pW+PQ0tdNI5OzMWC6GuzAU+X1KLe8
         PgKTho0jojUefsmXHaWLFdP1cgh/Y3w3GCOTLwebK4+qgPlDRj2jCAOTZdxPrqV4p3xC
         zjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CecjrqhZu5jr158EfKTQNkLxhfn9+U4Xzq5YaTdHXKw=;
        b=dZ5EY470JvZsCvkVSHo2hZ8CzDB6zdSQaDZJoLkXC5WGxJ5a99niH5SdjX/gWbqCb/
         +T29lmLIo1a9IGSi9Arxd7LMmqNhkXnnsz7OeKAfHzValjyI04AtXj/qSXzAocr7xyNx
         rxffqZX0PsSnEqeqXwZ4HzjabYJh6MQWaqaR7ScmfubR4bxRqHow1bq5MYoY742BMhfU
         ux6n79PhPoRoeVUK6IXF4zLBagPMHA1xzsCgUiMkCQFscDxTxmEzTN9ZGmNumZPwNRLB
         Tshy2tiWSujd5kvcYnMbWAQEpD7zlriqepaYq1Jqjf1sG8mEvXmGOtXVcjx2DfSECmf8
         Il2w==
X-Gm-Message-State: AOAM531SraRZzTKAy4ooTVaDIGI5fFUEUP1JAAVz9xWeljNo3jRdSklv
        Z5+X6hyszfnfLepl+ZqL985IA3JCQLElSQ==
X-Google-Smtp-Source: ABdhPJxaGtAr7HCQ2JjDZCLp7L5AgGGq0lvk16+B/TdCLUEBBNFzdv3sNa7V+ITGSDsb7b1akI2i4Q==
X-Received: by 2002:a1c:c918:: with SMTP id f24mr4328704wmb.12.1618921330657;
        Tue, 20 Apr 2021 05:22:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:10 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/12] test-lib-functions: reword "test_commit --append" docs
Date:   Tue, 20 Apr 2021 14:21:55 +0200
Message-Id: <patch-04.12-9313d35bf8-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation for "test_commit --append" added in my
3373518cc8 (test-lib functions: add an --append option to test_commit,
2021-01-12).

A follow-up commit will make the "echo" part of this configurable, and
in any case saying "echo >>" rather than ">>" was redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d733..d169fb2f59 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -172,8 +172,7 @@ debug () {
 #   --notick
 #	Do not call test_tick before making a commit
 #   --append
-#	Use "echo >>" instead of "echo >" when writing "<contents>" to
-#	"<file>"
+#	Use ">>" instead of ">" when writing "<contents>" to "<file>"
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author <author>
-- 
2.31.1.723.gf6bad1b9ba1

