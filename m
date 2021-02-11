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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F878C433E6
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE04B64E6F
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBKTty (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhBKTs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557FC06121C
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nm1so4017401pjb.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w6uxotFd3fl3bEKZPRvoeYnHz6L8s8rSINMCS3nH4E0=;
        b=EwTs6us7bZwKTGD/fBJm0OPckC/tNWq1T3zpwiIGmSmW6PJ7ItWUCSEdHK1daozR6g
         mpdKyp+ZIOtd+uY42pmM/cceuIRNECojGxT7p7Qo0lpvWetMcqmyoqyZpQ2irDWDc7Ut
         kuT5QI50+a1DMc4mwAUTXZiq0LKlSf13NQnOqF96dQnbvsdHN7iUZNKd+jgrG8kd8xkz
         RJzbEdBzflTAYYsjrgKPCSX24eTM4JkiJVwiASYAtvID6/4I7BBhY0T45SKvcmZdV3Xq
         wym1pkP6CCQQSv2va8h5DcgX2qm3OAhO/GG9n3vr+ldjccme6OyVmOv84ZnEaF+BLfE9
         rUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6uxotFd3fl3bEKZPRvoeYnHz6L8s8rSINMCS3nH4E0=;
        b=jn6aaw5p5FEhUWDWx8pSJDnfJjd1L4A8BaSivZQXZ4FjD6/At6AND+uPkUfoy8aohl
         yJdb2hWx9gYar3fVQxUaO2OCKhsXoGeJngnLZqeMw0reUrrlzVWd2eaNm+vjhb1aAbJt
         Er87mo3ftyq1MSanzg5DIbfWOfpZY7OBgD1SHoVicOSsti1hCjf5nniFL2XbhiC1Lyd7
         OqGrAgwLtUXXgKcpAO0UCBCLlfZrz6sE5w4fQJI9WaKg2qJELv2PKVD15c/NA5mtN20j
         /TuHd4tnuuaE7+szEwzO1eJm/nnKQRFXqk+HG+qN382yoS/Zr0C8/WVBnjh1h4VN54cT
         /hyA==
X-Gm-Message-State: AOAM530z6VHhfFXukbNDQFgz9VgI2mZId3hurv0QgnqguE6oeHPFqf7s
        +NCOEaawlgN4TrOgVvucxsXvKS6U1ZUtrg==
X-Google-Smtp-Source: ABdhPJyXzTW2/PDgc7+YPQZgSf0wh7Iz5ZkIgP8BntJ0r/DFRUUjEBVm4/tsdmwzn4zYSSxq+3DsDg==
X-Received: by 2002:a17:902:8602:b029:e2:8386:7aed with SMTP id f2-20020a1709028602b02900e283867aedmr9183996plo.36.1613072849763;
        Thu, 11 Feb 2021 11:47:29 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:29 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 08/10] t7001: put each command on a separate line
Date:   Fri, 12 Feb 2021 01:17:02 +0530
Message-Id: <20210211194704.28913-9-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modern practice is to avoid multiple commands per line, and
instead place each command on its own line.

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index a56580b26d..93d6767951 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -145,7 +145,9 @@ test_expect_success 'checking the commit' '
 '
 
 test_expect_success 'do not move directory over existing directory' '
-	mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
+	mkdir path0 &&
+	mkdir path0/path2 &&
+	test_must_fail git mv path2 path0
 '
 
 test_expect_success 'move into "."' '
-- 
2.25.1

