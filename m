Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22DC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhLTPVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbhLTPTq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A20C0698CC
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so22796wmb.1
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KwlOealDsYSlT3vr/iAxRQ7tZPRCqQeJ/p6VpI0LNjY=;
        b=FG+qWo4ER8ir1fqK4fEdcWfXp57zr86TohV2cmPKR8l1bOWc6LNHbBCWJ+S34zw9Vf
         kF22TqGmXGBUknztKtxXyw+k+4SvDohLAS1HQb3Uy9hfCGzSqEdYwoP39WhHgZufyOfb
         DOAfbmM8XrJEdX/n6GB5gupTMqFx9i4aYkqHJTXl/e4aQAvU1TTYeJ038ZhBeUNp6Fza
         3021VErdWZTWEFBq6LXJmu/U9/ntnyTtL/2LY2C3bRZN3/mr88BL+C9XT0Ba3MaAUXFQ
         1DaDFNtiwBEnem9g16n/mfcaPYXtF7vFwdtV0BlxqYKd15FSIkXMmFTq55dpW6FCyqhD
         R2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KwlOealDsYSlT3vr/iAxRQ7tZPRCqQeJ/p6VpI0LNjY=;
        b=t58ojo2uacK7FIjOPr5O8su3EQJPEABuAEPQkivZn/44rTqiGSo4xVBUM02AuL8TPX
         ZWNs10TFgXfK4bOWZ5PuJkjvxwYW4kHHFXH9CD99yZf52oeboenkX7+XIpsDZxu3MokC
         HQrSlZ4xTCXYnwHwsGzHSexlQHv+D3rYSxVOAp92zx9c7APpqwZNpJDscAilGvQbFJgy
         sx88qeMgvPAz+AHcb8tqRxueDBUNjUG+wrSxl/suqmw+l5fsIDHfKt3a4090xIlQ7jZu
         GmCVP15zBKrDSFv3BbfGkZDbJUXTyqTdzalZLH5DEEux7GZQxB/RLG64A+PKl6Fmbz43
         GuiA==
X-Gm-Message-State: AOAM531XcSl5Z8ioBrsXhi0kyJ1h/xw+LUWm4IPh0mrMMQ8Kcc+3r4Pd
        OIUfyDY/fjI+yCdnwUpUH5Sq9YEvAKA=
X-Google-Smtp-Source: ABdhPJxXG+Rld+V9xM5i2F9+siNkCyVgLGc9CwBE5hEsA+rAC6/paME0O8gYGl754B6pKzzxQjmWzQ==
X-Received: by 2002:a1c:440a:: with SMTP id r10mr21555894wma.4.1640012470853;
        Mon, 20 Dec 2021 07:01:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm14923933wmc.7.2021.12.20.07.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:10 -0800 (PST)
Message-Id: <96f6896a13e68263b96827e0c66f20178fb9dfd1.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:01 +0000
Subject: [PATCH 1/9] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use "size_t" rather than "int" for the "alloc" and "nr_open_regions"
fields in the "tr2tls_thread_ctx".  These are used by ALLOC_GROW().

This was discussed in: https://lore.kernel.org/all/YULF3hoaDxA9ENdO@nand.local/

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index b1e327a928e..a90bd639d48 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -11,8 +11,8 @@
 struct tr2tls_thread_ctx {
 	struct strbuf thread_name;
 	uint64_t *array_us_start;
-	int alloc;
-	int nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
+	size_t alloc;
+	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
 };
 
-- 
gitgitgadget

