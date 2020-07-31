Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551FBC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAC920791
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GanNvYsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGaXdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaXdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 19:33:20 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41757C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so20923970ioe.9
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCMrxd5dz72w5zTffG6R4Mu6cpLfVn+LNnf+gEq8jyU=;
        b=GanNvYsgN8SveB8C0dvTyvdJHgZUEe4VK8nZ6RzsP1loX9sKhWqCJlx4xV9WLUR0Fz
         JbidLYSGRTzdU/AF+Wt6QATiXXnm6qFifR29tPGsl4RbBe601fZdpO0j4dz0c2kHwRvZ
         c2rL/kl4ndlk8wgVPfXTWCleQBtfvZHHyIdfzilxyU/2mgv+mwhpu1r2JrcxgKT7fpgj
         BAcY8yU/zmTLbp+ZTofHKFVAuzfIt1eW4OGnLQ9w7dRCgPL5/Jiz6N9g+8luqNuZNNV1
         0iUiZy/v5RuIKT9odE5VK8oWLn3qE3NumADlXvG0GApuYeu/DGgCDJMdyyLwDOANBfUh
         TFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KCMrxd5dz72w5zTffG6R4Mu6cpLfVn+LNnf+gEq8jyU=;
        b=tSWGcEoql4vtk4rJM2aGJiSnOgBQyatJjW+3DL4svmxVvcqzYCT1qqtFvJZqXsY+v4
         URvgZSOpsxjItzm+fwGLCyBr5YExbDd5xGyNt46h43q+w1LlDlhPW8RBvWT1RCzMUPZR
         K0vM6SZo3o2OWyvKqE6utPpvOYyVpKH3bIhhRdPb1wQlhHfTAXbCbisX2aSs7FGyC8mG
         OI2sUzsdFFc0KZSOcGmGdBaeSM5UrXZQ/r9tChiBYAk4nWOFmxI2133+M7YPPl4NwO7I
         1CIdV0u2HUhaeZE/EyIjsgg00xdJjullc07MT6+SnloO+XB5TBFsrdf5YyKl106HpuGw
         +MQA==
X-Gm-Message-State: AOAM530sw/kgpug8L3Qwug5lotZqmCSe5EKtcQiBAO8puNMYSHZm28Ad
        JGBJLDUy/0MfJWwEQlvAMEZ1gWqXBPM=
X-Google-Smtp-Source: ABdhPJycMqNEWh29M5Bqv/Wb+FS+fhX97p5wMQaCYRxL6p/5hzw8IBOyqeRhtiFjif0D+BPpzVJBow==
X-Received: by 2002:a6b:b7ce:: with SMTP id h197mr5984008iof.60.1596238399243;
        Fri, 31 Jul 2020 16:33:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id t18sm3336758ild.46.2020.07.31.16.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 16:33:18 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/4] worktree: drop pointless strbuf_release()
Date:   Fri, 31 Jul 2020 19:32:11 -0400
Message-Id: <20200731233214.22131-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.203.gce1f2e0ef1
In-Reply-To: <20200731233214.22131-1-sunshine@sunshineco.com>
References: <20200731233214.22131-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The content of this strbuf is unconditionally detached several lines
before the strbuf_release() and the strbuf is never touched again after
that point.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    I'm on the fence about this change. On the one hand, I spent extra
    cycles studying the code to determine if the strbuf was used again
    after being detached. On the other hand, the strbuf_release() at the
    end of the function protects against a leak if someone ever inserts
    code which re-uses the strbuf. So, I wouldn't be bothered if this
    patch is dropped from the series.

 worktree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index cba2e54598..c0df5e2c79 100644
--- a/worktree.c
+++ b/worktree.c
@@ -66,8 +66,6 @@ static struct worktree *get_main_worktree(void)
 	worktree->is_bare = (is_bare_repository_cfg == 1) ||
 		is_bare_repository();
 	add_head_info(worktree);
-
-	strbuf_release(&worktree_path);
 	return worktree;
 }
 
-- 
2.28.0.203.gce1f2e0ef1

