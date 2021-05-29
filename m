Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8380C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B995A613CD
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhE2Hq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhE2Hq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:57 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2C8C06138E
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:15 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so5774222otp.4
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrgfCQcKuArFAPYsV2apRajzLxZqKbGX8Jrt07fmBwI=;
        b=UBZVLxRcMszu3hGSz9UY3qjT6HalzuVzouRqV0+uCCgDo4RqJSE/hrklGjm7J9u02a
         WxtJ5IN3I5bBreB9K+53LNKKEgsc9ZanU0btVZcxAM6fG5P4c8KRYTp+gqvOUQ7zveCd
         1psf/UQuuRUZNf7ANZSkHPdD6MOwYprDgcKySsnaUtLnjQ1m+zRgu0IxkPvvrEwfWmzA
         k5AB8Hh7LQ6HShpwtzvk0KNvbWcGF4aZq2lX5JuMxeJj2fYAuEGjgSygdITdmob3q7si
         K45MldCi4tPq7VaeUaCr5Pbgo9xE9ImShy3+Y4Ft0JX9B4IsrqeYwUdNohd4UpnHizBz
         DU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrgfCQcKuArFAPYsV2apRajzLxZqKbGX8Jrt07fmBwI=;
        b=aOxGehe4wQFhx23Z+36AV+wu3KZ+e5a/RD2poA6KVwlfZQLo4njS31hoO6JKNivS5D
         RaX7aKd6JkuNSmqyE7KeoFCAMGg7OvQERvsqLSPeDhfCbJpFEbpvHle5AuFlPljuQ0B6
         0R5x8MfCX7o4GdgGiSqqpCaDvmQYK53QSn4z9ZiDpuZCG4V1lFSsLD2Q+MmZ9qYmW1Em
         hrtvvCCgNlE6p+jvfYTzoioKT5/z+f74JX7ZtUifuwfxqshBqTH/29G5Py0ZThur16hG
         /GaIw7NPnVdl32xx56Ht/9u9dO5cQZZoSihOaE93rXD1TLqBb8PmT30VQqu4RlmRoCpU
         f6AQ==
X-Gm-Message-State: AOAM533pcWxyy4xAoPZec7+Tp98jmLMTiffDHgEh+CbeLy1F5o7UFOxj
        scUlaept9DXi1QRQGQ/WU5FcX1OGq490Lg==
X-Google-Smtp-Source: ABdhPJwdWvOXscbZjhTQuSnPcjl/JlwIn33RkyyhIOamCiQLFBbu3d+xDuq00HmXn1q0z1aA/NxHFw==
X-Received: by 2002:a9d:4911:: with SMTP id e17mr10128366otf.38.1622274314823;
        Sat, 29 May 2021 00:45:14 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o18sm1632452otp.61.2021.05.29.00.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:14 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/15] push: remove redundant check
Date:   Sat, 29 May 2021 02:44:53 -0500
Message-Id: <20210529074458.1916817-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If fetch_remote is NULL (i.e. the branch remote is invalid), then it
can't possibly be same as remote, which can't be NULL.

The check is redundant, and so is the extra variable.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 94cb2eda63..7485522807 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -204,8 +204,7 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 
 static int is_workflow_triangular(struct remote *remote)
 {
-	struct remote *fetch_remote = remote_get(NULL);
-	return (fetch_remote && fetch_remote != remote);
+	return remote_get(NULL) != remote;
 }
 
 static void setup_default_push_refspecs(struct remote *remote)
-- 
2.32.0.rc0

