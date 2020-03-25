Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E2BC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBCB2074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umK7k14i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCYFzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35061 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgCYFzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id k13so1481960qki.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=16tsqpSGL0Tb9ro7a5KLH7NeNNY+iXVqUAOGFG/7seI=;
        b=umK7k14imeeusUvnwWtLkk2naodW0GyURWjzT4/tSzD2cwiZOrZEHRWKzmvdaRejnm
         8aHjyayL6W0QSQy+MWiFeRaxmfBNO0nKuATC/sHCqrjeRMYOF8RBeS1ca0RKBW7ytkiS
         T+yv1hk4pRXQPnBBYLMpfVhL9QxdeDQKH7cfn0EaJF1w1hhWzKm0HvNC4GWdG/ND/tP9
         B45y1jVJ820kcqSx0LjMoF8fYwGvKDgW4VEedQEqnw90dWpn3HHwOq9weLjd7Vd4I5+a
         5VAi3I9fN2pyZXIWOSk6FYhIu6CGNNbLMLeYHuohWa85Jneqg6p0Qv1knKhD/e8NU1L7
         3sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=16tsqpSGL0Tb9ro7a5KLH7NeNNY+iXVqUAOGFG/7seI=;
        b=KBJPD17szFKD07XFg2L4JggakntPeuqEfveDcgr68B4eSrB4mPuSm5TVw8yFh30KQD
         Fw7yIDfAmvPBD/Y2yCh2X2PZpDaYRtnFJpXiioNTtCjYzqn6HEbeJu62WCbg8yGwy5QZ
         11A++7fD9MHBr9aBSV4mJV5+5h8ZlmJVnxEY+Auce13S/3FzRApwyMg3lBHFMHqsYBNV
         2KAB66KZLZ40v6YON7Ee0rK98DYmkqT8GGLao4K/3x7Gdnv4XLt0D4mIt8R2/K0AY/Yy
         UvMqbtszQaEL0scvpgWZlJ6b5lH6/bQBviuPjH5Jb5opZkLSGpsO7JlDss/YQw06kKKh
         PxJQ==
X-Gm-Message-State: ANhLgQ2shCZHZvYs51+/ewlnBHDatibIQwdEa2yoksSAgHxmYuczPKtJ
        ZQaHHgE5dbh72E9KR9+xprjV9+io
X-Google-Smtp-Source: ADFU+vsxVRJTPt/ly/msEJbSTbw5DUDkOdAdcMjGPTNZtBgJhYz1xZf9E69I+tquYCt3dwAiqF/Piw==
X-Received: by 2002:a37:6ca:: with SMTP id 193mr1411745qkg.415.1585115716665;
        Tue, 24 Mar 2020 22:55:16 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:16 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/8] t5550: remove use of `test_might_fail grep`
Date:   Wed, 25 Mar 2020 01:54:51 -0400
Message-Id: <68c911e29b509d75e390aba573921d6ac385fcaf.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Rewrite the use of
test_might_fail() with grep to remove this improper usage.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5550-http-fetch-dumb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b811d89cfd..a06294ad8f 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -248,7 +248,7 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
 '
 
 test_expect_success 'did not use upload-pack service' '
-	test_might_fail grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act &&
+	{ grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act || :; } &&
 	: >exp &&
 	test_cmp exp act
 '
-- 
2.25.0.114.g5b0ca878e0

