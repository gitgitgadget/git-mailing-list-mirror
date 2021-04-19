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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1948DC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9886101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhDSKyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbhDSKxp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C24C06138D
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so10895853wma.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=algQ1aErS+lLlLPZ3mA8qMJLPQJXrWgJAe1xDKA+riI=;
        b=SKkSB5GghWA9BWrBAVhkgj6lsphW8oZO8J0H8KPt6+HHcvBpB+ri6hmhPQUKkcqjwh
         y5MBnYRtuYexmLh+ZLuyBGiZQo08jTXNm86NNmF8367JkbSoTreHSw2ST8jzuqEk4eaq
         MWTtk5spMDo6DdjWq4A7B93j/AhUIfIxlVJxs4/9koK15+uR1yxcSQI9ClI7Cqn0Bps+
         l7a0jf8TGcBmnbgzwqp3GmSIwdlDvrUzIRpp0+6IJOkv8FEdpt/MGbOFgcLP63Re9S9h
         Gs5+/HI8xZ8pF8z/UZMfhOkIrCJ9tI2n56hrQQyqFqXU3bGalhyaGvrgJIGVQ8ifBNSc
         o0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=algQ1aErS+lLlLPZ3mA8qMJLPQJXrWgJAe1xDKA+riI=;
        b=A0/8AuwGH71u7cOrm3imA3WFsNkCBZOz45J/Heas7h9EIH/Gvh15NtMKR/IOlCry9V
         7/Pg69MkTBT+IFIfMYJl7wuYBQgicZol/jgNkWrhYrxny6Q0VNMwYifoGmqDDeCODjkf
         qzTXJkLAGDgpZ2HSJm2SN1UevtWwj1X5ak85YxswfiL/ePvLEuHhrBWS6MLEdi0ve8+k
         SPh0lRR4gshLt/Kc9rDz7MDhrAKi59PImODSeTE29i+8JwyWjGyPTSphx7GXqhBgO6bO
         pXtp4RaIGTcj3D0GL+2eQH7tIXT/wSDk27yvGCjB9B+6PnfbHUWVBnF+v1a6RYV7/Uii
         mfvg==
X-Gm-Message-State: AOAM533w8/oKXcOp8NoVy41nxBjpUari70ey0HprR0i9RO2w9PtTfi2W
        +mDdBPaIgLVbc9Bh9tLytlG9n7XbwxI=
X-Google-Smtp-Source: ABdhPJyzDcSIdkdVKFrjAQKgaDRozP418SIopRy4jQFSxWswa8ASaK0rbco+HsNlcYuEtZ/aXRSV8w==
X-Received: by 2002:a1c:9850:: with SMTP id a77mr20387638wme.174.1618829591740;
        Mon, 19 Apr 2021 03:53:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm23023260wru.12.2021.04.19.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:11 -0700 (PDT)
Message-Id: <1ce545043846ee06070d1a4bc05fcd5221847eab.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:58 +0000
Subject: [PATCH 13/18] t2017: mark --orphan/logAllRefUpdates=false test as
 REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

In reftable, there is no notion of a per-ref 'existence' of a reflog. Each
reflog entry has its own key, so it is not possible to distinguish between
{reflog doesn't exist,reflog exists but is empty}. This makes the logic
in log_ref_setup() (file refs/files-backend.c), which depends on the existence
of the reflog file infeasible.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t2017-checkout-orphan.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index c7adbdd39ab9..88d6992a5e1f 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -76,7 +76,7 @@ test_expect_success '--orphan makes reflog by default' '
 	git rev-parse --verify delta@{0}
 '
 
-test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
+test_expect_success REFFILES '--orphan does not make reflog when core.logAllRefUpdates = false' '
 	git checkout main &&
 	git config core.logAllRefUpdates false &&
 	git checkout --orphan epsilon &&
-- 
gitgitgadget

