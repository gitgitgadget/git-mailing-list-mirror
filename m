Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609BDC63777
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3DB20825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvKSbTk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgKLWoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbgKLWoO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DDC0617A7
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so7703412wrp.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/oHpHFtiq2DyR3lbemvvL4wbcNDQbIuM8EyPYLU0XPc=;
        b=uvKSbTk0z0zmqBO6bOKPOAF9yqErQ9gKjREkHw33QjLghblDE12x8D2USUIAhH4kl1
         E9V7FuUITa5nRMSoX7gG9tsc6FzMehUUS2kx3xcZ7Z/3ZUGXRe5DFfxTiJ70aiohGWfa
         tyaESIV5MaIOWxXCiTBtycu1LPXzsD7v2quR36OKGczm79xyE4PwZxNvzMkj9h7i0erB
         rhwvsoy+311t7ob5D2GfKYnGxnLw/ksYARILnQlNopAjICAzNQc8y6pxt1LtaOsylhZk
         SkqxnhBr0vk8FX47OLkgJt3+NmDQzrf8E6FvBYKoBfVjJ7BGo9ayjOc0X7BFfX8Rr/TI
         Gm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/oHpHFtiq2DyR3lbemvvL4wbcNDQbIuM8EyPYLU0XPc=;
        b=fgZ7zubhS/Fq2IsA3xnqoCFu+H47y7MKLhi1SwtwTFdaIhoe9U6aAZv7CS802yWqI4
         uYxLWf8EUUCk93qGwJgtPhuREbvz139YncXAuVSIAnP7WEUQj1fGiF1yuExKBNgMtiz+
         fknibmj5J9zx6oU5zwBctF1N9hK8u1hzHgo8jtKDVnTD4QA7KbAE/PLnhjulbVUbD18D
         icCxdzPmmj7NCcpSr/jqgz5AuWOy9WrHI+KC/MUYCn6F9iB+s+uNl1s2+ojqh4dJ46bd
         XlAm8FlMocBn74bp8Ot1Lnq4AdWV3+AGgmgtci2r8cYwT8QTz2gPHA8W0gnALsiJNwFd
         zasQ==
X-Gm-Message-State: AOAM532KuxI2A8jbNnnR2iG8JaVHuTvyzntclVriPYzTVioWdWaOnbpI
        jVgMEYtnTN0f8DTutuUBY5TCa3Rx39o=
X-Google-Smtp-Source: ABdhPJz53y9E7x7Fe1rnO/s315UhVA6zG7yS0+E3GJ1JA0zhE1iy869t3MiJqzuL/eLABpK2OQqtbg==
X-Received: by 2002:adf:fc41:: with SMTP id e1mr2081634wrs.406.1605221048124;
        Thu, 12 Nov 2020 14:44:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y200sm9461688wmc.23.2020.11.12.14.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:07 -0800 (PST)
Message-Id: <86c85666d558dfc51ff04fc525ed38db692cd802.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:39 +0000
Subject: [PATCH 09/28] t5323: prepare centered comment for `master` -> `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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

