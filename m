Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A18AC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AC5611AD
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhJNAI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhJNAIs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEBCC061766
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e12so13821299wra.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WYqeyardRFERObpiiRjNvb8/9ZqvqzS9Ne9z87LDwI=;
        b=Jxzlg7gVZFej2zUoG4HDMFdeF7G62bstoVWfYI9Xdblsng3/Js/qa3LGyYYuu4TjG0
         OixgYXTNITISvbYlCM3O9kM23/2QjElETcaC5msjV7l1DOCp4BZS8IM1SrBR5N+thT0U
         ov6WYxzDp+uRJUkk1RtmjzxqBDyYuePzHjLtdnrRYrxd8WPnG/maJKTjdeJVhrNo/9Tm
         SCGZmSoOGKH0ilrnLfjHvBapMBFYcDpIjfiwZ5MEdronahyS9h7Wp2fNVDJuz2+pxvVF
         O+p9TQ+TgNMM7r/S9gYd9gJZ5qzwe0YnMgHU+qUWrVaWAGzwRLaHdD9K9Y0JTIo9bHNs
         v4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WYqeyardRFERObpiiRjNvb8/9ZqvqzS9Ne9z87LDwI=;
        b=pkYVnx1HYV83IBnOzKWVAa09vogXYglUwAvCUlDA3z5RMujX+vE5ZnBBXTPNuYkXs3
         w58rJReuF4M+eUCS5ECtjs8pwJQ8RDW3QzehIDKi0ICZOFemC9ZWNhtod+83c4oPE+d5
         jFAw+UAQl0TGZ4KajQzcUbqay4PP/oA5/87mni8ZY6dR7oN71eQtqAvNYostdwuD7JHs
         djnnkNDSuiVlmOa1bUwJi6T7srZAAH2Y2UQM92FlnRmVMItgCJrzoAp97saiT775tCrs
         aGnG2bnQN7PD3TSliTEro9RjQIDCw4ZRX4ssBhEGrS6+FW7JeXXnkYdr4Wiex0CF6pSO
         bTag==
X-Gm-Message-State: AOAM532s4XQRVwRjlI61Rj0nO+nG/lO0wnlfPQMuIYDBKzFQ9phB87sm
        LCjWqzawEvFSMY93W9Ge2hfHIoa7stUKPQ==
X-Google-Smtp-Source: ABdhPJxSqB7CbU1pf5l5AfiwDNwrAVubWuF+/IsMzAMaIL5weGVg9AfMFoTp9yXeCnhQZCCo5gQWkw==
X-Received: by 2002:adf:a4d5:: with SMTP id h21mr2614920wrb.203.1634170002948;
        Wed, 13 Oct 2021 17:06:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/20] refs API: ignore errno in worktree.c's add_head_info()
Date:   Thu, 14 Oct 2021 02:06:23 +0200
Message-Id: <patch-11.20-9fe85926140-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The static add_head_info() function is only used indirectly by callers
of get_worktrees(), none of whom care about errno, and even if they
did having the faked-up one from refs_resolve_ref_unsafe() would only
confuse them if they used die_errno() et al. So let's explicitly
ignore it here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index cfffcdb62b3..fa988ee978f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -28,11 +28,13 @@ static void add_head_info(struct worktree *wt)
 {
 	int flags;
 	const char *target;
+	int ignore_errno;
 
-	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
+	target = refs_werrres_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
 					 0,
-					 &wt->head_oid, &flags);
+					 &wt->head_oid, &flags,
+					 &ignore_errno);
 	if (!target)
 		return;
 
-- 
2.33.1.1346.g48288c3c089

