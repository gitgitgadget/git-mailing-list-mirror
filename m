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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC05C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4826135F
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhFMXBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 19:01:42 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42910 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFMXBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 19:01:41 -0400
Received: by mail-oi1-f173.google.com with SMTP id s23so12482661oiw.9
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWTeNABEujHxG4bFYTR71RWN5RYFRTpnd3Cjx6YCkS0=;
        b=iHBozdfAXHYmuLFGsSLRk3gkVxTwgp/95TPEk+V0V8GDbpYDkVP2f9sAiMOSF8kevz
         yA0Xnf8CJ93b3CSl2F5EuLaXV2sKJ6E4L9X4glIYUjEM7zdIpXxMC0DuNxd/Ohrg6h3n
         wxBcDcrSgoa9YXZt2PkcN428wBoXAJbVm6KcGI4xvEXDESWqK4rMcpWATWLKmEVkE6k7
         UWAPyU9+V03aEHSCnrtkYgQDVjAqEnGOWtqg4CfA7nxqdnkDrdx1JB3bOH171cDGOvyt
         7KK2oHRvgbFpRdpn5vQ6ZQkELhORBRJcmh7VkTYMtjdZJy0fp8ipjzEUBSDqwcQk1ovU
         eQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWTeNABEujHxG4bFYTR71RWN5RYFRTpnd3Cjx6YCkS0=;
        b=U9LocRAVzOezIo0nn4W66hkT5cUR3GR7c5mUgcSEd/UEp09IUzeukfCxFC3QTYkIf9
         BN5LhKtZ2O6ubxT9R0qR2HBugn9UAaFDHkxNluIkro5WmEnR2kSe9gZISJNKUjlpf7gD
         JJpk9XygdcXXuZ8X/rSHKS9pBO1roZgEKwfrs7+n9saCEb2W0k/3LWfvo/vvQJP5vj6M
         mEcHlhKxaDgLxZnLBRAye2DmvsZTMTDxUcmC9Ida6yijPnDBE07dkaz/16HlvtF904L2
         mCd0scAtKSoSCuAk1Es9ArwiLlNNhanm97VVa3irYr89oibZ9HUVNlpJwC3iZOIK3RoE
         pLAw==
X-Gm-Message-State: AOAM532xl6HCjfk5hQykV7HyNbt9av5+odc7Y0DkjKq4ZczX8QWcgDPS
        as8AsLQBeAWyp0nyVC2GOS4kFqEdLD6rFg==
X-Google-Smtp-Source: ABdhPJwRZHpA0W9s8TBQRJrpL/xJXyv6nW7vnk8ZlS1TpPSPSIGzBcN7qjInKNisYIOdkTqzWaPKtA==
X-Received: by 2002:a05:6808:919:: with SMTP id w25mr10004363oih.30.1623625119617;
        Sun, 13 Jun 2021 15:58:39 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x29sm2845450ott.68.2021.06.13.15.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:58:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] merge: simplify initialization
Date:   Sun, 13 Jun 2021 17:58:33 -0500
Message-Id: <20210613225836.1009569-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613225836.1009569-1-felipe.contreras@gmail.com>
References: <20210613225836.1009569-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 06a2f90c48..0186f4156a 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -28,7 +28,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	const char *names[3] = { NULL, NULL, NULL };
 	mmfile_t mmfs[3];
 	mmbuffer_t result = {NULL, 0};
-	xmparam_t xmp = {{0}};
+	xmparam_t xmp = { .level = XDL_MERGE_ZEALOUS_ALNUM };
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
 	struct option options[] = {
@@ -48,10 +48,6 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	xmp.level = XDL_MERGE_ZEALOUS_ALNUM;
-	xmp.style = 0;
-	xmp.favor = 0;
-
 	if (startup_info->have_repository) {
 		/* Read the configuration file */
 		git_config(git_xmerge_config, NULL);
-- 
2.32.0

