Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AAFC54FD0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A5C2084D
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZPY2x7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgDTVPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTVPC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:15:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A290C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id re23so9161897ejb.4
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=aZPY2x7yH/nazrVZODT7cyXvMQk1KfKwfabkirxLdEx5kl4l547N/1hw0dCoe6RtVK
         YxwIevmYMAEHF7s0estMlNygjfAPSQzD+Cpq7N5xW1slwIcWR9/0GNTWcfth1LLe2k0B
         kjhlRsYkxCULdKiXqdiYHxpW0uLQzNP1cyk6/UQiunIBxLulb/u7eAUwxhp7hFt4YSI+
         q595m3n+xiGAyV24ApJ6A/8h6rgVR2d6Ji83H7RKxOQrKIGVBG5J7GZ7pSEQizng1jAr
         tVa6ENGel7Vtrxe+c/tfFPvVYyGj0nBFu1oQABXxdsUAWaq421WVm+J0srMu163e0G74
         1HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=KLvxqw84Y4iL94551AXFcx8937A9Jip0cwusidE5iA2GxqvO+3wm/zBM5Yq2MqhG4d
         O0bMqr/76/19i/Q3sJYxvAgWyqIXFKg07itB3+pIm7Fsxkv1xzD9QxC44ibRVAzxihtq
         BuXpJjJfcihNlkR8GgglJBrojG7TLQ/Ls8Jg+Y8TusxsE4WNxyYdqCVRkfEqt4TMUk6m
         wZg1AOyYU2HSrLguJl19RYY0DB6e6WvK3ZeYM1CvfD4noagka2H7Z0o5U7vGDNHdKbXH
         OlQEjlTuMoXtpIjI6hiqMobri5gQ5LFUbHfBeCnJ1gcuCzgrnUSF+5Gi80bfNvAW+8+E
         zRBQ==
X-Gm-Message-State: AGi0PuYD59zsPMMcgOb2wKY+xn7SIQQv0Pz5k1N4V59f8Tyx15XChprv
        7yvUGdd8uEftGrV82FNNCPMRic9S
X-Google-Smtp-Source: APiQypLR2crv6zWcVwb7uO3E5OD2EmsjlMG69kPeY4RQcKJmfkJEiHM9TvXhX/aRCD0mFeUfDTIsyQ==
X-Received: by 2002:a17:907:2142:: with SMTP id rk2mr18409334ejb.356.1587417300831;
        Mon, 20 Apr 2020 14:15:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16sm43219ejy.64.2020.04.20.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:15:00 -0700 (PDT)
Message-Id: <b432c1cc2ae6cc0f8c15d4e13b5b89635f8bc391.1587417295.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 21:14:50 +0000
Subject: [PATCH v9 05/10] Add .gitattributes for the reftable/ directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 reftable/.gitattributes

diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 00000000000..f44451a3795
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
-- 
gitgitgadget

