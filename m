Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A78C83012
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F4D221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et6nUP0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgKQQMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgKQQMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:43 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2593EC0617A7
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:42 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so6549419wrg.7
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WSPqSkdDsNmXaz47u8r75k87qKiI3R4QYnp3tYQyjxk=;
        b=Et6nUP0d7f8iWhiWOKtQrWs3btbwYgWxPjkrPAGKS0528Hl1tTpqJBauLlWdtuHZuQ
         c2ZLCgV2YxKToOmqToKusY3xCu49t2i2vYD/xQ2exh2x3MB0Ston5+s3E51gB6W0bODQ
         YbZyVLNXEMWZa+Gb9dY15dL/8yE9bq7MtZT4JQ/5ONOul5vG+ybY0CQbxUBerO4xvOQY
         TNYrgKYtfVF+rc0I8/Z13WvFGNab0StTwLtdk3us9aaSpznBP/3ifLQxX/DM/AIu0mrl
         9RHqS4F75y0iQwcghO/k3a1RHwGtWYNmL0vv8vNJadQ+EzItcSHe9tpfrnVbUzK9ffhi
         sHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WSPqSkdDsNmXaz47u8r75k87qKiI3R4QYnp3tYQyjxk=;
        b=Og6a1rhXxjAliiOnqB8ujqPlbBjC3D7krDzG1aGp+mzarb3lk2AMMLPYtyRbGuCMe2
         Uieb3BKc+/ECJamcNXBTSIeOwAOfihi0oKuf5Jn41yhsD/sk+8qW8O4AMAaEW0MzoPBE
         bhZPLP0ze6o7Z8cfxIV2gD5Qw4BYs4pWnNedCrW6ydBaMhCZuX8oJhXNGazRU+k+5naR
         pJwOWjgP+h0mA8O+VYTlEGpkmr/R040uTydi/SbB0ybZn5CxnBVcDv0Ji8IN7oevFL4J
         QWhNO17N+PHAv0HWM+Rpx2NBywd6N5rEygsuRcihuIU2r1ZdUXM/eJkeaJNHUM2VI0DD
         CmAw==
X-Gm-Message-State: AOAM532AKQWz71TAfIwr1OuQoJhwxD/ujHJE9t5pyEPfu7+ZPAhE2Vov
        f1RD/gh9e88gwZTMpHSFdKFFaLu4Flg=
X-Google-Smtp-Source: ABdhPJzyLx0oHK7a7S6uzhhc94Q6JAFrgwbJgpwlHvG6wTab++5362vHHdmCLsC3QBqiGHMgcgXqgA==
X-Received: by 2002:adf:f70b:: with SMTP id r11mr234374wrp.133.1605629560779;
        Tue, 17 Nov 2020 08:12:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17sm28098376wru.12.2020.11.17.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:40 -0800 (PST)
Message-Id: <5126d90a32fafa6a7de4db06de2583eb69acd7b4.1605629548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:11 +0000
Subject: [PATCH v2 11/27] t5503: prepare aligned comment for replacing
 `master` with `main`
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In an upcoming commit, we will use `main` as the default branch name in
t5503 instead of `master`. This will require extra padding in ASCII-art
commit graphs, which we hereby add preemptively.

By doing this preemptively rather than after the commit applying the
search-and-replace, it is more obvious that we caught all aligned
comments that are affected by the latter commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5503-tagfollow.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 6041a4dd32..6dafbe4543 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -11,7 +11,7 @@ test_description='test automatic tag following'
 #   L - A ------ O ------ B
 #    \   \                 \
 #     \   C - origin/cat    \
-#      origin/master         master
+#      origin/master           master
 
 test_expect_success setup '
 	test_tick &&
-- 
gitgitgadget

