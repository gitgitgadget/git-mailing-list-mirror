Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2FBC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08846214F1
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEE2qlh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIJTIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgIJTEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:04:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95186C061796
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:10 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x69so4201136lff.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJMiaa1kh/x8DHZTd9ip+DvzZSE8k8+nmz9DEVmqn8g=;
        b=TEE2qlh8XP0Jolhxfv/58gCdioMw4ic/ah1ggJpa6vHZNgR7PMAZfUELg5aISj8TRD
         CMlTiwd578HFO1hSsfnuOjehTjNthr+ydpIDB74SW4xxIzuyMFL7HbBnY0ZDgublKFii
         2O2oQ9nJdRu7Hj8sLoA4qrFHfxqNrlB9+s2wm3ZbKwoZOXfzDPAWApzVW7mP//GJX4rh
         /J4Vqi/4JOC7i5F0eGNaGnasphnhQCGGlyvaipvDRLdMXkeZAapHTyJ+tFfwofX0cUMZ
         81NxyyB7iDb3I/tY1nBQkobjL8cGmPEK8r6Tu5P/CktFhzT3XWYf5x1ZMpJMXtuv+BEy
         z7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJMiaa1kh/x8DHZTd9ip+DvzZSE8k8+nmz9DEVmqn8g=;
        b=R2ATI5JV/tvi075PczirfE/TbjiPAnFbx9tU55ee24R2pNvPolkyPo1C0eZAZ4tnkL
         AcH8QY/QpD9RkB3oNfE3fbvEZem4kj2esk1VTlNdrnkPdzMgg3wu6AMMC1hBFLar46s3
         +BvpQ3Rm5rQQTjEjqzuKsF45WhYhCYwScmhZqqdXdWXmSW9ag3UJIB1f4eKnBhT1VsOS
         DLyuBZWs+2u6j5Hr8kAuoq6sKqRwtDG21HMM6nDOPWCFQnLq1uMv5edzCiWkdiLTd2BA
         8CKwhDJt1va4TqVIRTzOtsjtBRmZfgq7z7ifcphKdsUxdoFnfwVZaejQbqgAdyWQhG4V
         L/1w==
X-Gm-Message-State: AOAM5307B//gF5ebSRago3nE1ZMOSzKrCBSRVZdZLj+cd1ZatLvwsUL5
        tMZBg8NTCkjU9SkF35ylWkx9tywlAlk=
X-Google-Smtp-Source: ABdhPJwr0iAcmCad8qzZFsww3/nMhz4nbwcCNV/fZeY4hSysgKsQxtUmgyJGFfxCSUi0vr6oyeiSuQ==
X-Received: by 2002:a19:430f:: with SMTP id q15mr4885208lfa.191.1599764648801;
        Thu, 10 Sep 2020 12:04:08 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm1549815lfg.39.2020.09.10.12.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:04:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] worktree: update renamed variable in comment
Date:   Thu, 10 Sep 2020 21:03:39 +0200
Message-Id: <9c1e321fbc281414e5d4202e83790ae08dce11da.1599762679.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment above `add_head_info()` mentions "head_sha1", but it was
renamed to "head_oid" in 0f05154c70 ("worktree: convert struct worktree
to object_id", 2017-10-15). Update the comment.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 64a9e78997..050f22dd65 100644
--- a/worktree.c
+++ b/worktree.c
@@ -21,7 +21,7 @@ void free_worktrees(struct worktree **worktrees)
 }
 
 /**
- * Update head_sha1, head_ref and is_detached of the given worktree
+ * Update head_oid, head_ref and is_detached of the given worktree
  */
 static void add_head_info(struct worktree *wt)
 {
-- 
2.28.0.277.g9b3c35fffd

