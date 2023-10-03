Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FCCE74903
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 17:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbjJCRtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjJCRtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 13:49:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ECAAD
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 10:49:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so2025196a12.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696355380; x=1696960180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPjk3AaUt4+5jpswYw3DlJARhDhWJwT+fuoyV122gBY=;
        b=MAUy4wZGP8Ewvjl5LITyKOlF603r6o2zPogXTW3faXAibVVa+txlow8CeFE9XRdMpx
         WXMfQiQDwJIdPq0p8fmMQkSvMrw4uSzVmo6sZ1uho8RgRL57b9wi5tOc/gJstXllK4vz
         KUY/50R++AwnAksXmam29AbzEQ0wP8jnvoqptuX43hUzRm9L3wEDroy9OjOByXZpkGtC
         m5wJ5o5sA3AALaPDnL/aGsTCZ585sShO5a6lzDtuIU8xIGI/GqdISKxdf/GDUgNPChvi
         KhdHt+ZFUKgVPb4Qu/wRiLQ4c36s6lnvrBDwmSadrrkgZbovMG0dUqjxhYamIxzLuUjb
         Npgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696355380; x=1696960180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPjk3AaUt4+5jpswYw3DlJARhDhWJwT+fuoyV122gBY=;
        b=crgn47OBkm6KxvQliC4Jz0x5OMqZqa23C9t9i7rYkfsue1JczkT4Hyu2cCs5grK0TK
         gZMtiSs4G/H4RwXyyRl1Gb4xdcAp0s2oNYW/5MkQXkSWhhnglJCvWRQcSH4kopEZvaaY
         mH+vqu9bxH2H+cprPnNVyoIgq5R8N+fhY6vjiTE/ZvVb2Uo0ZbNJaLJ86LPF9gR0H730
         JowLFMwwF6CeE+BJzWKT2CCqVMKdotcBlfaiHMQ/xUvyz7o/+DzYs9YidHbAY+SELz4A
         l078Y+0r3a/AyCtDhCJ94L8eRb//1ZnXuZJ5nSh0ao4Fda/bhtV5BX6lAayjoPfd1Qja
         +r9Q==
X-Gm-Message-State: AOJu0Ywy1eKJHZofcuszK9j3FR9gi6uwFc3FyY4izqR8YxhNbJ9m0/KR
        yxbI2E1InQgeauLQJU/7RTeIDSzEX/x4/edCuUv5Cs6N
X-Google-Smtp-Source: AGHT+IGvzRHCPdsKbPHalLDnWXxweCBogXAIlbsebghfJwbJbYsVtOCaYf44Pd+8DFu+iSYKKcqDJw==
X-Received: by 2002:aa7:d699:0:b0:525:440a:616a with SMTP id d25-20020aa7d699000000b00525440a616amr13524178edr.20.1696355380182;
        Tue, 03 Oct 2023 10:49:40 -0700 (PDT)
Received: from localhost.localdomain ([129.0.78.163])
        by smtp.gmail.com with ESMTPSA id bf26-20020a0564021a5a00b00536e03f62bcsm1186604edb.59.2023.10.03.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:49:39 -0700 (PDT)
From:   ach.lumap@gmail.com
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, achluma <ach.lumap@gmail.com>
Subject: [PATCH 1/1] t2400: avoid using pipes
Date:   Tue,  3 Oct 2023 18:48:53 +0100
Message-ID: <20231003174853.1732-2-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
In-Reply-To: <20231003174853.1732-1-ach.lumap@gmail.com>
References: <20231003174853.1732-1-ach.lumap@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: achluma <ach.lumap@gmail.com>

The exit code of the preceding command in a pipe is disregarded,
so it's advisable to refrain from relying on it. Instead, by
saving the output of a Git command to a file, we gain the
ability to examine the exit codes of both commands separately.

Signed-off-by: achluma <ach.lumap@gmail.com>
---
 t/t2400-worktree-add.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index df4aff7825..7ead05bb98 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -468,7 +468,8 @@ test_expect_success 'put a worktree under rebase' '
 		cd under-rebase &&
 		set_fake_editor &&
 		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-		git worktree list | grep "under-rebase.*detached HEAD"
+		git worktree list >actual && 
+		grep "under-rebase.*detached HEAD" actual
 	)
 '
 
@@ -509,7 +510,8 @@ test_expect_success 'checkout a branch under bisect' '
 		git bisect start &&
 		git bisect bad &&
 		git bisect good HEAD~2 &&
-		git worktree list | grep "under-bisect.*detached HEAD" &&
+		git worktree list >actual && 
+		grep "under-bisect.*detached HEAD" actual &&
 		test_must_fail git worktree add new-bisect under-bisect &&
 		! test -d new-bisect
 	)
-- 
2.41.0.windows.1

