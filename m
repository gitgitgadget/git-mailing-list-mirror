Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E98FC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhL1BIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhL1BHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:07:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19635C061401
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e5so35224876wrc.5
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOVZenGFKHZ70QuszFHf2ITC6vG8jJ/LlC6pOxcEyD8=;
        b=IZkR/iJdKmYERKaemQgRf3w4tnfB0d8h+XeFjj5D64g3TEXrNAcnMw2T2UBaHY9y1a
         jErVTnQySLdbcgHs4yMzRkB8LN/LUdDiqUNvq8Li2Z1254/wwf4xnExahNXT4e4gHdHq
         xDN4Ac/hgw6dzU5IxNhjr+UrFq105QwVfBxAksD0RpOYu25vA55d7Cr4BKTY0IqqlR5f
         3jkiXBWCWNZLvTZoDv57QM0NM+MsMnj9ca1wz8tO57/l3Xtufhm3ZOZvSsFp4mi+2TtZ
         To56HqNxeJiw5yCpyLAc1EceJdl1xnbLDmEr/Jvy/ZMewY+G6qrdCUT9QUli/rbM5Ps6
         eOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOVZenGFKHZ70QuszFHf2ITC6vG8jJ/LlC6pOxcEyD8=;
        b=Tg0ezvBEZtXDcsHN+uVWozXHuaupEoImfEmtrRqtUU0fCxtMPbRNTh8UFlaksvpqcj
         T/gYmGQudMtz2QiixhurAEzHGtRu+qQEarA1rwFypWEfxIAcwzBeqhjs0nWKtJvB6c8C
         UU7OdSMT4o6U+Yxlnd8uy3rdy9+kwyK17znBvLB0C4L3POHPtAsIjQgBlZjn0zpxwCOZ
         De5NLrIKawOoO0whY1Qu/AB+Od9o6gTibXnbMRDN0/UIZ+qs0JQ8WdIrTjNhW6B7blwc
         8TYT5BO2Q+KGSr/pdV9Z/lTO01bNFFNaHMvfOOoZuILd93olmUopFZYU7zFYbV4vuFAa
         YryA==
X-Gm-Message-State: AOAM531JHIjhFYhfcAVA6nsGeIpRC7R08wJutxRlJbS1YTaZFfo/lepB
        HJdNj5aTcFuo4oeygPYCl9PvksnPMZTGx+kl
X-Google-Smtp-Source: ABdhPJy6M5UHu+1hAFz1Sfb99BAzL+lHJjbBlJSIjtDB6IQaRTMsmkjCYMAtzcNDRdGu+1DQn7J3ZQ==
X-Received: by 2002:a5d:64e8:: with SMTP id g8mr13823678wri.504.1640653671493;
        Mon, 27 Dec 2021 17:07:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b197sm16910973wmb.24.2021.12.27.17.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:07:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 05/10] grep.c: don't pass along NULL callback value
Date:   Tue, 28 Dec 2021 02:07:40 +0100
Message-Id: <patch-v7-05.10-844b4727ca3-20211228T004707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1250.g6a242c1e9ad
In-Reply-To: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
References: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.34.1.1250.g6a242c1e9ad

