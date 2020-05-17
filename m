Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F87C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E62320809
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMgP8O+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgEQSwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgEQSwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:52:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333AC061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h4so7489525ljg.12
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b1KtnYrkGGuHIRR6rIFGW+8WNtxmMn+llFfLEufUagc=;
        b=ZMgP8O+Q+n6+g3/LaCunrSFHWsPDgi/STudsXuBgZXmwJvjU7cWg8ATd1typumQB3t
         CpzTCn2/v2yyKuPVnUJhMoJaOSn/L4dVUddjKrkFvmmCPmgZnLuvYJQD8ev5aln71SNP
         cMQfpeFYPa2P7VwJbqMDH5XWclVss63tt54z7fD4jKXLc1r4l/QQKePDqsrzs+E1W4p6
         hYeCXgQTRyROU8XIvB5EE6jbIHgSYlgrkVX7A4LOVd5aNKfGCeCeO7jWByffChg1fNEw
         kg33jwYCsjWCj60wA7WH/QKdHsFbLjkMSUDqwaXeQu+jZheR6LXdEYRa8qYlqzr2ty73
         8NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1KtnYrkGGuHIRR6rIFGW+8WNtxmMn+llFfLEufUagc=;
        b=s8Kht8IqbWiEETUUHwZixPkFdiZOFNbXSLxtsjGo5g15rzqW56zrXYp0FupOyyjNPz
         4S/PTr4rppjfZaDua5T2FUcr04186pC2OtQWOLi3iwwapaeOpwV7BU1cmeNDmnqvzDVO
         9kcjNPLNvZaP2sD5yQF2iDb1ioFKG79nxh07galjfHrm6tT6W/TqsXVGka+2NjybuU4I
         CHEztO1Yd2iRJfvuACG5YgnedZulgwXYR75qmBihssQFwxYZmRnC19n/vVmRHG9pmy5u
         kWqygdaTy408iYqfqXYn0s5aVhKePMInWyJCuDTvFZAV7dWc8Ojoo6iVHEjPLN/uzMOZ
         BqFA==
X-Gm-Message-State: AOAM531EuCL0Ka7auL1wHR6/QE/4TRd1wAye6cBelSg4/8u5DUvQRl8C
        vy6q0RCYbM/T16SaHPt4eOBAcSlW
X-Google-Smtp-Source: ABdhPJzjuRHOvMsR5+S40HXuxWQ8JpBBWP84nvhY+YMzuyt+9BMci2mp6/3qiJ5tSccHJQqRId/vNw==
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr8401479ljp.52.1589741559306;
        Sun, 17 May 2020 11:52:39 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a12sm4513938ljj.64.2020.05.17.11.52.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 11:52:38 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] git-credential.txt: use list continuation
Date:   Sun, 17 May 2020 20:52:20 +0200
Message-Id: <e60236e18f73dcabce1a20ec17aee57fd54b11c9.1589739920.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <cover.1589739920.git.martin.agren@gmail.com>
References: <cover.1589739920.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use list continuation to avoid the second and third paragraphs
rendering with a different indentation from the first one where we
describe the "url" attribute.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-credential.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 8d990e92fd..31c81c4c02 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -151,11 +151,11 @@ Git understands the following attributes:
 	were read (e.g., `url=https://example.com` would behave as if
 	`protocol=https` and `host=example.com` had been provided). This
 	can help callers avoid parsing URLs themselves.
-
-	Note that specifying a protocol is mandatory and if the URL
-	doesn't specify a hostname (e.g., "cert:///path/to/file") the
-	credential will contain a hostname attribute whose value is an
-	empty string.
-
-	Components which are missing from the URL (e.g., there is no
-	username in the example above) will be left unset.
++
+Note that specifying a protocol is mandatory and if the URL
+doesn't specify a hostname (e.g., "cert:///path/to/file") the
+credential will contain a hostname attribute whose value is an
+empty string.
++
+Components which are missing from the URL (e.g., there is no
+username in the example above) will be left unset.
-- 
2.27.0.rc0

