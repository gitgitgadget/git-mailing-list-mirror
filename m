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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D574C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1640C61427
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbhDUKQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbhDUKP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:15:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B086C06138B
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x7so40723738wrw.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vpg5hbVTZwSj080ZrlN6mHQqkH/u2jjlisLXw8ZR4A=;
        b=g1PxMKCf4zbLabVD1LlSGZmEusqOhd0eq3BmxevdDArxZJPnwZ82ghS4HhhKcBsSQl
         iaOsAHrM3vETXi9ZCdJYSy7xzeMVVM9xyfB+qIzwMOeQHn/mCbm04LwRRBAyq12PGAmB
         RIRLS91aB2XWPZZhy8tPqHov4ACT8PNjNCp6HGVSz6dywbrGHdcc90MquraM+TkK932V
         pby1eDk7PYS++/SQOFympjY5A72dfCXPOGAWqKAH1MaqkHo00MVPsWRM1zgMPqqEXC+D
         mEd9vC8jEI5wmy5NBCLZJTZG88f3IZRqB1smokVyBolAXVa7Roy86qhUlwNyFX7TkdGs
         ZZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vpg5hbVTZwSj080ZrlN6mHQqkH/u2jjlisLXw8ZR4A=;
        b=sfUWaPXw79TEoGYihv/IzdZ72/pazp4FAxaB4Itl63kp2v+rnKONPB3b25sN/+8Xml
         L7adWk4AiUTovTWNKr8ax1HYCn79w1uEej9VSV5S+PpQ5WMyOaZo8gVzUQglfs15pMXi
         +xmhvDN+O/mDnBw/niXB7SPFRGmGVveO8Dcy9lzRf7sT+J7tUcva3SF5jtgH8zNJZ8mP
         2AEerkaB7PZn9rJcQaar0FmmPZq+cnza2mHzaXix2dYkNqVU/+hmyRv6aPKZq3+7ZHxF
         fcy4PWzo8BF0ut8m6uKYs6MlnjAtjkLrBdifxtzonw92ed5rX7XQqc/ivIv/7bxujMaN
         lIIA==
X-Gm-Message-State: AOAM531xTH5jN23C5l6u/o5PFP2aumAvOkh5lIUpxZEonnss/U9ffiHQ
        7gZxXt3oGV7K6hQeeeQF38jVszZ5EZiBSQ==
X-Google-Smtp-Source: ABdhPJx8jBWww+cYYi8Ase20ouw98AURTMtRPYAN6PbkWO1rjWjPtwtH1XkFbLWRaQDgTbKyV1kdwQ==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr26147646wru.3.1619000121804;
        Wed, 21 Apr 2021 03:15:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:21 -0700 (PDT)
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
Subject: [PATCH v4 03/11] test-lib-functions: reword "test_commit --append" docs
Date:   Wed, 21 Apr 2021 12:15:08 +0200
Message-Id: <patch-03.11-709bc773fb-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
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
2.31.1.721.gbeb6a21927

