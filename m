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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17105C71156
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C572020809
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0ftu6Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgLAArq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389163AbgLAArm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:47:42 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A72C0613D3
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:55 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id o25so16375489oie.5
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1g5xme2kvGlgzs6jtn9FfjzffOMoj1QipCaxtjl+0HA=;
        b=t0ftu6NnWJFupT70OvWsqs7OSZ/aV5t6l25Xoq0Tb6MmjQMjdyRsUH5WC7vjVHP4Pw
         RoZTePFLVcoxudvaiYonp8ICODH2zRd793YazE3T2tR3xmOEQ+JE9DpMmKpcpc2mOsaV
         LWnho81zuxzslCeJQjV+m0FcgnYoAlUmA5VIuXg1kyRh72+P4coJj5ttdAuCZYCLuVak
         sJx6bGSDF1uSUr9kECyhQSZ6XD8WGKAp0n0fDB6lKShmGbroXJzO/comMq7wBf9V4FwT
         dnYjuylDlaoiseyXiQEpOzgaQdwxAKDj1jdYVJw9jdqGWWGpUQJ4Pn28UYF11QN/0s1U
         pohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1g5xme2kvGlgzs6jtn9FfjzffOMoj1QipCaxtjl+0HA=;
        b=QjAil2cAHehFqMXRdjYMfuS7KH6cSoToP3fPbOHED66E0hHvgjzav+uD+dwAVT2t9H
         JOThsl7bP+r1E4Y/dJ+n9UQIZSWZZDKdJe/Jf2kJRneNErJCwfkcRjTBpUl4OqZmcng8
         jSSiEMHOBok7uNEqvBxFBVt3Ix0rTdLr2gutmvDJWUM+bIJnoH9TqN/9Hp+7dPgr8t1K
         lFDh7qUnMbOfUcK1DGxPudcNtDpAToAatvngGVKLDQ34cszveNLZ7peW/eBULq5nX0xX
         9jWjJHAEqn3HFbmDL1R3Rm762CvVAunN5qQRaJLeutTtcwALTG3N2p9XsEACOx0z/vm9
         DDsw==
X-Gm-Message-State: AOAM533CJBiFqU5X9IOLOBkoYVX31bbr4EMBB+TunBgA3bRbJqsHx895
        N/m9rqA1o+8O5i8DwQY8uGqRbrsAJ4pumA==
X-Google-Smtp-Source: ABdhPJzjxhjQhC16SfZFdBt5TTCTkmhpilyITgwo5PrtlSa0qNB8m9kWliYsIhjoRlNbCkv6mOBmKg==
X-Received: by 2002:aca:fd86:: with SMTP id b128mr167260oii.103.1606783615043;
        Mon, 30 Nov 2020 16:46:55 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p28sm10633ots.0.2020.11.30.16.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:46:54 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] .gitignore: remove dangling file
Date:   Mon, 30 Nov 2020 18:46:47 -0600
Message-Id: <20201201004649.57548-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201004649.57548-1-felipe.contreras@gmail.com>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The library was removed 7 years ago on commit ae34ac126f. But not from
the .gitignore file.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index f85d02c854..7c5096aee5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -135,7 +135,6 @@
 /git-remote-ftps
 /git-remote-fd
 /git-remote-ext
-/git-remote-testpy
 /git-repack
 /git-replace
 /git-request-pull
-- 
2.29.2

