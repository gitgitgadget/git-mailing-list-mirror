Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677AAC61DA4
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCRPrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCRPrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:47:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B571D916
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:47:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so31318949edb.6
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBmp1WNBu4l5uyQOZwjLHFcbKQroSBy4oBACTiM2LcA=;
        b=l7+bXkJN+H4YPn3pGIx4o1xD4T7XGWdksVDpza4f2MEJX6IBHrUb63TK0KUfF3wjXS
         xOUR0qQ3XjebbT4u1bA448hY6tdrN+Gm7C3CtHhjFXZewLR/qewkDcBy7bTz+kqLt5Xt
         iFzkKB9gJYRjnwSapp7xA8RMmuDhMmGaP9+1DnrB0GHIM0Or50FhCXoZNYVTp4NhZMTK
         TECyLjPSO5Bi2kbivR5S+vkvLcsQfVMlLyz8F9SJEUeK/6MxyhJwll3xAid2U9GpMhQp
         F3hWANivQUvHc9W9LL7n7sMSLZpkBanOqe6v0Ip6um0cr/h+WbYgomtuyiOJJoUaMmTQ
         Y9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBmp1WNBu4l5uyQOZwjLHFcbKQroSBy4oBACTiM2LcA=;
        b=dVx+65K6VuMM9khu4a61Vs0R1dPByZIBNRm0Z2k5lWzyt817uQ4GrLqg2LAMrJPpNE
         cs4VWmjPxMuzvxinnapE5229bD+WUhXp0yDrd5cMRZ7Ds+WXTHtS4aOJw2KRzdc5FKpJ
         HshHLulRYCeAtmchY6vLGOliP+jJUG22mxYvtq5ENR0g6snJIpAwkooUbKJvIXzUl+Bg
         fNePzCz3XbT0YrhCJyTXCIIau57pJCtzSk9m5AxnaWerf4/5na7QElufgyCPJBQ98jM4
         /BYpUtcZhUd1ZLuaE99jrFkDFhAjCSTYl++Q6Cot5Cgcf/E47LIevKwR++NIY2v66dQq
         UecA==
X-Gm-Message-State: AO0yUKWLm4oeDd1Y7RlIC6q4ocOmI7Y+qSL73JVUQEu24GslgvaUGPic
        ROYAMa0UaklwFrv7+T90obHUypCoUZglclCQUn0=
X-Google-Smtp-Source: AK7set+Y3eU3QJHwJXCHJZ6pNdDM7tIy4ZlMxFadgyuh1tU7IQsRornM0JOro+xsp7QFVcU0qC90Bw==
X-Received: by 2002:a17:906:edd6:b0:932:b7ce:27b4 with SMTP id sb22-20020a170906edd600b00932b7ce27b4mr3458553ejb.27.1679154419961;
        Sat, 18 Mar 2023 08:46:59 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ha18-20020a170906a89200b0092be4b381b7sm2271200ejb.81.2023.03.18.08.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:46:59 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/7] t1507: assert output of rev-parse
Date:   Sat, 18 Mar 2023 16:46:46 +0100
Message-Id: <20230318154646.131344-8-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in t1507-rev-parse-upstream.sh compare files "expect" and "actual"
to assert the output of "git rev-parse", "git show", and "git log".
However, two of the tests '@{reflog}-parsing does not look beyond colon'
and '@{upstream}-parsing does not look beyond colon' don't inspect the
contents of the created files.

Assert output of "git rev-parse" in tests in t1507-rev-parse-upstream.sh
to improve test coverage.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index c34714ffe3..4458820168 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -258,7 +258,8 @@ test_expect_success '@{reflog}-parsing does not look beyond colon' '
 	git add @{yesterday} &&
 	git commit -m "funny reflog file" &&
 	git hash-object @{yesterday} >expect &&
-	git rev-parse HEAD:@{yesterday} >actual
+	git rev-parse HEAD:@{yesterday} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '@{upstream}-parsing does not look beyond colon' '
@@ -266,7 +267,8 @@ test_expect_success '@{upstream}-parsing does not look beyond colon' '
 	git add @{upstream} &&
 	git commit -m "funny upstream file" &&
 	git hash-object @{upstream} >expect &&
-	git rev-parse HEAD:@{upstream} >actual
+	git rev-parse HEAD:@{upstream} >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.40.0

