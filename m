Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096BBC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09AC61354
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhJUW2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhJUW17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:27:59 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D10AC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:25:43 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 145so2531125ljj.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5JoGUzzXGC5Js2l7uhtE3R34WmkrgcdZgcZhBnhgyU=;
        b=X3vI1EDJkXpRHAisYsnZ2RHRxmioBhoApvFfo6J70Fd1OhZN5+1gQUS4GzYPMUSxOf
         ymKX9OQ3gGOYJqpaSBdajtDdTbMEN1RurEFGKydPySNzCi1SlDp/YvOPTRLdsfn3LZsH
         rtxO+yKkszZ6yejf+S2ax25vAISV70O8l1lp0OzgIVtGTOoivU6CKZx+LpaaI34cwuuB
         L7SRHjGdd7k1YDs64JVQKjaUDQVyqn0nJNfY/PMowzI8GOGoPdxZKB8X0cyPko9MZ1yL
         6WKz6hxtC1vrzULb4tO6O1X+5wwuBhOeTBkcPxR/iKGCnVft9xpT+4zkpOFZH4t35lGp
         uFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5JoGUzzXGC5Js2l7uhtE3R34WmkrgcdZgcZhBnhgyU=;
        b=0GWt1w25hIdtKDDrNizl/OUTFxst8l5tPSSiB6effP8ht+BbqWRSuoq1kU8PB1qT4V
         wtZRDlFIuIqfvQEOfviOLlUhdhQv5CvNxVdzv+iumKHJT8RSPt3prIxhfEfJLMp9NscA
         pmn7YB2tkLEsASm64joSxrTFNuQxB1Mz7IVsEoc+cgXVZn83VBEbsQPxigEc4v3PZD5O
         1DWLiDgGHlC9qs/Y6N1TifpWKb1pMbtKsGuAbWCSV2xQ5LNgrmltY2SHqM492CZWYpWn
         miLsVwP1rb/twjDjSmypYDOMnj0VhyCL8FlCWxw3DJ1X/rc6r63qUya48MCO2VZKbdKc
         pOTw==
X-Gm-Message-State: AOAM532HciFcEncHPq5DXUDyC7KgIZCmkV7XM9CQpDLl24Sfe2Coklka
        3QX2D7jDNBLUfT4Fyy7iWYqO0jZsu/R9XQ==
X-Google-Smtp-Source: ABdhPJyED43kNoLI7tRzCsn8H/Wp1YdgkjmBCQ4mvQKoOo3ai8FqEwFjExOm2opty6qCd6/HJQw/nA==
X-Received: by 2002:a2e:9e42:: with SMTP id g2mr8638625ljk.483.1634855141540;
        Thu, 21 Oct 2021 15:25:41 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id o22sm608875lfr.250.2021.10.21.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 15:25:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 1/2] status: count stash entries in separate function
Date:   Fri, 22 Oct 2021 00:25:31 +0200
Message-Id: <20211021222532.463375-2-oystwa@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211021222532.463375-1-oystwa@gmail.com>
References: <20211021222532.463375-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the counting of stash entries contained in one simple function as
it will be used in the next commit.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 wt-status.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index e4f29b2b4c..97230477b2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -948,11 +948,17 @@ static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
+static int count_stash_entries()
+{
+	int n = 0;
+	for_each_reflog_ent("refs/stash", stash_count_refs, &n);
+	return n;
+}
+
 static void wt_longstatus_print_stash_summary(struct wt_status *s)
 {
-	int stash_count = 0;
+	int stash_count = count_stash_entries();
 
-	for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);
 	if (stash_count > 0)
 		status_printf_ln(s, GIT_COLOR_NORMAL,
 				 Q_("Your stash currently has %d entry",
-- 
2.27.0

