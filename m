Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D95C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB48D20774
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxBjVi/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgFHGZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgFHGZC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9114BC08C5C4
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:25:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d5so17329580ios.9
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtTTi3Moj52Wec61Eqd/9nZMIbvD3AKvmVYzePHh0IM=;
        b=DxBjVi/zlv7lDGzglx5Vsdg4xvgEUSeGmPWgdcnGzTwfwoZHXHKbS1t6KrDbw+W0xd
         Uf2ajBhSGMSuf2e7qLmEVRcInrCQCFG66/DCLVwIev1r352wLOta84hDMxlF2gBmF+QB
         /st3fC5VtzX1WYVYNJWRQ1/tspHbnN/lE/aelMMhfpBkdE4Tespp1LDG7DQ5GJGoQVk3
         6qSmsuo4CEAI9XW7s98t+L5asfeUkuB3JZab4OwLelGkWLb3wiiQmEy/zazrf1qP4oN8
         UpGBOTHs9Gl2iwjTRtba2v/nWaC1n0SobjtQloqTF117gC0ThS5ECzqdNHkl7WBroCqf
         jiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gtTTi3Moj52Wec61Eqd/9nZMIbvD3AKvmVYzePHh0IM=;
        b=H2UBC25vfYIFKxnRMWeIGHY1JrF20Ax8JyfRWBqH/6aVM3ZT81frINoS13vNNcY2GX
         UCkYfa5mmTqysDF043cl8wyX3rY94Ot+mQicuTYKqxdIXyBb1LzYWP2Vqjwxvrmoq5vd
         1ERiswUoLnPacyQNkf1HRfCUnXdmi6zLzhgFaj9nQAshh2etqyJohfa78tUfXvLkYyIz
         HrtKGSNE8xqGOsBDhQmeB5v1np9eNptiEF2E5NGYiBrNR9LADjU3p7y/5i9d9RY7I2RJ
         7ZFSaSyHdWHLfih5FVjnoCc09myJeyRCvvbX4Urqqqmk63KKf7ro8gta1oxqaZGuCemR
         KL5w==
X-Gm-Message-State: AOAM531pMuXk/SKTGmqkWppwu+rBoaLsNdRt20x+UG55fnoV4aJsOrt8
        NyVORFKqpF53354pEOFkYfKs90AdPiI=
X-Google-Smtp-Source: ABdhPJwCWATmhtv6+0O3h2d3wuk+t4hF0lrR9eCq0TkHd7qReu4YnFZ8VnZqQDdhDzlw/ybcjwsMcw==
X-Received: by 2002:a02:c985:: with SMTP id b5mr20814725jap.22.1591597501472;
        Sun, 07 Jun 2020 23:25:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.25.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:25:00 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/8] worktree: give "should be pruned?" function more meaningful name
Date:   Mon,  8 Jun 2020 02:23:51 -0400
Message-Id: <20200608062356.40264-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
In-Reply-To: <20200608062356.40264-1-sunshine@sunshineco.com>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Readers of the name prune_worktree() are likely to expect the function
to actually prune a worktree, however, it only answers the question
"should this worktree be pruned?". Give it a name more reflective of its
true purpose to avoid such confusion.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index f7351413af..27681a1396 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -67,7 +67,7 @@ static void delete_worktrees_dir_if_empty(void)
 	rmdir(git_path("worktrees")); /* ignore failed removal */
 }
 
-static int prune_worktree(const char *id, struct strbuf *reason)
+static int should_prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
 	char *path;
@@ -144,7 +144,7 @@ static void prune_worktrees(void)
 		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
-		if (!prune_worktree(d->d_name, &reason))
+		if (!should_prune_worktree(d->d_name, &reason))
 			continue;
 		if (show_only || verbose)
 			printf_ln(_("Removing %s/%s: %s"),
-- 
2.27.0.290.gba653c62da

