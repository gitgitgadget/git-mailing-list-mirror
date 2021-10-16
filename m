Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF39FC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E4360E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbhJPJmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbhJPJlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA344C061781
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p21so4272847wmq.1
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QoqvCC8pgDyqssDtJxlX1OAAMB1SwHadVriWvlC08qc=;
        b=LW+7wcub1vgHuhE40U22zs///QVPHxVB/uB5FCSGvOCZXUp7C062D09j3X91TQwcLL
         JgKBqK8TxK9nwIem8fGloQVNvLd1094vOeGNL1g/GNXQN0Ey630dnmZQijY8y3HBqEDM
         8f0kJQk5c8qTajUgz/7xJJt4ZoiEwWZTvuGSADV+1OdBq7Az+Fs+dAVfeCYbym/67OHK
         GBtUbTDaJP9jawlhLvW+k1kbqIv1ed9YyfrfqoaS1cO207AVykacXR4INTtMtxEO2yVJ
         UCCLGp2zRaqFUU3uDW4VJpS8xT8Wr4c8L4cTDwFZPbJwYslacxhwKY0OfZlgdfTgAC85
         SJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QoqvCC8pgDyqssDtJxlX1OAAMB1SwHadVriWvlC08qc=;
        b=QzrFw/xGrdMpAU223TblndxQMVwJqYocvJuHaLuxjgatEU2giNnGmFA8PzJ1Ezz8qz
         WsYLbUUToXke4udn+cUmugJz2uGb0oTEXvbTChY5WX54N0mBn8JCrNQzdHg0H0QhY575
         LBDoFi8N75kO99jxL/3u6X49yoh8iCL+FMWrweO1TXOBOlaMcYnSx3oSyxj7NU9X8gIq
         vOFdKymltZEcPbRmhDRDdCQJrHnNXGwJVGckCeDFaGzeWzgYmW2x3AAg+GrXBtDHfThm
         f9ORUcp9H9bW64tzM6xwN2tTU68nov5a3BVOOvkBU32cfhhf5cU8qiwENLRI8mtpBzWu
         X2qw==
X-Gm-Message-State: AOAM531Vym1Od5hRLWth9WcpXgHv0cdPsgIf6hToEwwb9ByBjG0FQ5yP
        ju1X4KiN3SPvYQqsEsqZGac8OZYIsEMu/w==
X-Google-Smtp-Source: ABdhPJwvJA6SDKQ95UjTUmBbPxvL3urfvsvUaYiSqSGi0sxPtx/9m5hBBfgUPXLwPy+hcpu/UdoopQ==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr31152751wmq.21.1634377179099;
        Sat, 16 Oct 2021 02:39:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/21] refs API: ignore errno in worktree.c's add_head_info()
Date:   Sat, 16 Oct 2021 11:39:18 +0200
Message-Id: <patch-v2-12.21-b90e65abd7d-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
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
2.33.1.1338.g20da966911a

