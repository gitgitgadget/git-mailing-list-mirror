Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8464DC63798
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22373246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BevnI/sS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKRXpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgKRXpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920FCC061A4D
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so4263034wrc.11
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/oHpHFtiq2DyR3lbemvvL4wbcNDQbIuM8EyPYLU0XPc=;
        b=BevnI/sSgRbkgbB6MB4ZEr4wVaFr6S7WNp3a4KuOKFjSO71Hk08hOVSQ+ExXn/fwmq
         y5Hj8X9gy+NnX1LdzYUoM3QmUgDc06KyXOY21G1vJ+lWymddJziPgf6om/3oMX2eiogi
         bbXdhQtDj6l+mgyK/BQkx7tEWHisTWWCu8SVeuJs/oMCkRaZuDnpzCK5ljaACPf3qojh
         6VqmJEOlNmDrfyv3427NscT9QWloJQ5+mWRltEK/PTbvlPM6/0shBHLduz2/838WbOR9
         3UbdJl5lv65vWoaAQkZwChzABT4nGgw+pJUmlKQ7nLZ8BiGXKbvC2bdiSY1is1SYAfXc
         BULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/oHpHFtiq2DyR3lbemvvL4wbcNDQbIuM8EyPYLU0XPc=;
        b=efjqfxLlQrwON9gNmLz1hsUulkHUjCSz2XHb5lieNWXl3dDmtBXEdJnxcw6WvxUBdJ
         fgMHOOTZjKVJOcUTt9LI50BKC2YsxSjHNLDNUpvAzKX4lk5oIulrsOaHpNbwkZr5ti9F
         OARW7VcJmrbxgIOWpntus+HAIqoetDlDYtf4F1OJDkTm13W61TqQ5hbFnTK1DiNRjhGb
         RhOxfk3Ab4d+WTT+J6AXa5p7jrBmBouHYMIZtMBD1+2w5vAL27ngA/N0VgyF8uMXrDYj
         g54AffBiOm5iF+s9xZj9+XsjlnpwwPNlnT1uMhEJ5WeVPispEZGG2Z4MQMa8ywaJMVVe
         0Z/g==
X-Gm-Message-State: AOAM530MqWmct12D0bid6zb3ikez/KCjZ1AGpUMco0bSmNN6bbgfe6UD
        /BSg87XY6D6QshRet4cP7YWEB/HOMH8=
X-Google-Smtp-Source: ABdhPJwlh7zTYRxzpp0OKPsJOac1oxLneGpT+LQDi6z1kfNfVQ/6bJ3EhGAzRMU96VH7ZorZPzoIyw==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr7697821wru.175.1605743100217;
        Wed, 18 Nov 2020 15:45:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16sm36498427wru.92.2020.11.18.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:59 -0800 (PST)
Message-Id: <36d633a5ec90c960df51a004a2d097ed4c31dfae.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:28 +0000
Subject: [PATCH v3 10/28] t5323: prepare centered comment for `master` ->
 `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to search-and-replace all mentions of `master` in t5323 by
`main`, which is two characters shorter. To prepare for that, let's add
padding to centered lines that will make them briefly uncentered, but
will be re-centered in the commit that performs that rename.

Doing it this way (instead of padding after replacing) makes it easier
to verify the validity of the patch that replaces `master` by `main`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5323-pack-redundant.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 6b4d1ca353..3903148926 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -312,7 +312,7 @@ test_expect_success 'shared: all packs are redundant, but no output without --al
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================ master.git ===============
+#     ================= master.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------+
 #     ----+--------------------------------------             |
 #     P1  | x x x x x x x                       x             |
@@ -394,7 +394,7 @@ test_expect_success 'shared: no redundant without --alt-odb' '
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================ master.git ===============
+#     ================= master.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------------+
 #     ----+--------------------------------------                   |
 #     P1  | x x x x x x x                       x                   |
@@ -426,7 +426,7 @@ test_expect_success 'shared: one pack is redundant with --alt-odb' '
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================ master.git ===============
+#     ================= master.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------------+
 #     ----+--------------------------------------                   |
 #     P1  | x x x x x x x                       x                   |
-- 
gitgitgadget

