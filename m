Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31EBC433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE5B6113B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJNAJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhJNAIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAB1C061775
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r18so13822935wrg.6
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivS5BuUXx6xI3vzfLGCUk6QPCf7Z5o0K9/GWjz7Pkuo=;
        b=cqklIL85clIFbVstdO+SGenSW5Vx8qXXk0ro6cIyyFluuCcxHzF2W+wg1ezLZoSL0T
         bAlh2oi/v2X1DxSkP9wIHwIPWrg7QawETCJkTWe+viqEkhQ2VyZ4+m/jZR+v0pf2RPjr
         ZRsDBysjEEVh3S8KisXtn1+6t3cyYn6ZBBwgcSvSMmqJZSHKpoyuXTdy/6UCrpiEEZPU
         HukOS6ZjIsYwOzesz0lz4z5E9fZnxgjzclL9JRmE1zi25RxmTgb3VBbYcbhLHPgayS7O
         LOy5/STXT31+nGyj0FFayF6AJg+RwyzAOLOJ6Soze7y1+wC9RlKa2aS480xPG9BSbk9Q
         f93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivS5BuUXx6xI3vzfLGCUk6QPCf7Z5o0K9/GWjz7Pkuo=;
        b=nnC93uNR5BCY8qBsRT0Nr6i1XhPQd6W/4b7Bqek3c+3f0Eq+18DV6FSlNoWjTBtjJY
         sWElzN/E8Opk8+mOhPMxWyRrEyZSOrZJQ2k/P2jYXsa70thGD3eofaaKqkl4RoTvbMU3
         P7lRsSsGNhuvV6GhEtkf1gvfnnqE0Mkbww8wmVKDWCfRCoj1GYphOE6+KaaxZdt+zwSB
         qglvj9nPy2/B2CgXqNCtVvTs0eikP7PdafSJjr35OCYJy9qFGr8koxIjqK3rJse1uOnP
         gnti+RtODgkdfhcxnwWDufJFlaslFWnstlVbSB/cFEKIkmbOzdOvhHXROAobNwkmObFb
         LAfg==
X-Gm-Message-State: AOAM531m6w58Tc7uaCU1mBcsbiCGFsiZPx7ixhe+nrsFD6cgFopAnF/q
        C9cClZjX2SscHmZ8Lu+BTaiLAS37m/yVCg==
X-Google-Smtp-Source: ABdhPJytcaIe2wUdJm7qDQlUYmRhgcjnISUhGkO6gYQ16AeC4I4B1/zh2OJj1rS8wWjGyMilnp8yzg==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr2740411wrc.25.1634170004998;
        Wed, 13 Oct 2021 17:06:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/20] refs API: make refs_resolve_refdup() not set errno
Date:   Thu, 14 Oct 2021 02:06:26 +0200
Message-Id: <patch-14.20-fbbc08d3ebd-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move refs_resolve_refdup() from the legacy refs_resolve_ref_unsafe()
to the new refs_werrres_ref_unsafe(). I have read its callers and
determined that they don't care about errno being set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 001f54845a7..c64ed6285a6 100644
--- a/refs.c
+++ b/refs.c
@@ -267,9 +267,10 @@ char *refs_resolve_refdup(struct ref_store *refs,
 			  struct object_id *oid, int *flags)
 {
 	const char *result;
+	int ignore_errno;
 
-	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-					 oid, flags);
+	result = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+					 oid, flags, &ignore_errno);
 	return xstrdup_or_null(result);
 }
 
-- 
2.33.1.1346.g48288c3c089

