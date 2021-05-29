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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04220C47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB96613F0
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhE2HrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhE2Hq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:58 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016A2C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:22 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso5721925otl.13
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+cgXzv4KtFKLJ+JNpnvDYVJDcPRsqBQwnRu1/UlcV7c=;
        b=i/Dz95JIllV7GVuzpzma/FZrab9LaloLqZT0sZUgYV8us+xif6q0MZ4vgrNAewE5GE
         N7YJL/Gk927BBa943/9e1qBaPvbcdzGa9xeQhYUWsAyCPYNE3oL3hCyUZJGVUFYNHF9w
         4GKS72s+poh3D69unImRY5+xD1rb/RdRlxxEZ9prPwrP+QZfnCg2vUeROuHMH+NANGrW
         Zfp2lzIlWCWG3nW8TZXhUgcHyv9qtfcFX8uWzA9M1GVCqcB/OKX+h4QOp5+BKG3pyiE+
         3maSARQuDgFM+kLzCodmvsWMMae73bqKjl+EdM5vTwX/SVOs1O6b5zoYxcIc1nUaKmhD
         vjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+cgXzv4KtFKLJ+JNpnvDYVJDcPRsqBQwnRu1/UlcV7c=;
        b=HwGczRO4hClh3QizfYaLpJ45TegEu7zP+8Fx/PRHN+p3rrPxK02+cBRtXtnUZ9sodl
         sbMeRlh4V+zEP+bV7sSaliVfTfEHMwFSIOjsGOxyfvXWuCUfZ2YLhFiRcXK4mMF2hx+S
         xsIQLW/ZBqBiLTvxX3x23WWkvNixBf+x6mthOZGO5Wuvgh2KuksU/FUyb6cTWll9VL2P
         K8iPPRjKq1d87prEdzv4qd3Ex++noASwahxrOkuLC4w8WPMYcYvsxlP8PDIRNqzpOUQI
         qfbig0TY8j+VAQfq+B3X2+ejeLaqBB+t9G/7r++VXJKvdUDhc2h8FZx2K3AFGhA2eVbf
         lUBg==
X-Gm-Message-State: AOAM532Ii9tIgd+G6/pHn1aG0spKY9/E5wVNRE0FcMib2rxiJe7uZCWn
        STngGgwnNi14Sx3X/RyJVv1BS0YV55rSww==
X-Google-Smtp-Source: ABdhPJxUyur3VsJLoiZhpBxfGwZ857ofwFqswKF/RJtPWVPgi//SEL3pRbnX4JaHHbc+6qu82suW0Q==
X-Received: by 2002:a9d:8a7:: with SMTP id 36mr9898281otf.287.1622274321153;
        Sat, 29 May 2021 00:45:21 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m19sm1605022oov.10.2021.05.29.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/15] push: don't get a full remote object
Date:   Sat, 29 May 2021 02:44:57 -0500
Message-Id: <20210529074458.1916817-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All we need to know is that their names are different.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 818ca4c5c9..2f30a97b97 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,7 +225,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		die(_(message_detached_head_die), remote->name);
 
 	dst = branch->refname;
-	triangular = remote != remote_get(NULL);
+	triangular = strcmp(remote->name, remote_for_branch(branch, NULL));
 
 	switch (push_default) {
 	default:
-- 
2.32.0.rc0

