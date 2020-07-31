Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6538DC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE0420791
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anb9+/mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGaXdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgGaXdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 19:33:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE7C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g19so21210088ioh.8
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RArvJ2r+niN5CxeWy9DTE3YcMhO/ThVEAVUKztk4rA=;
        b=Anb9+/mh6WhjJhmxIUdQQHxaa4hlCkMKcv/+OjoLwoqj5EKbqwWo6hT5ViF5SwsWcY
         lSGmB4Jf2hmFGxSd0M0umhdnm3pTPRfx+Byq8mm01eqhiFhyP2xQW/gGnp03Tj5yEWGs
         PXV/jDp6IXv0EwlGCo7SF3d2B3XFqFE4xX0391gGWqgr6Vx3JDjeGVXBOfGihYTJ67Hr
         EwNkcXOSza3eohPG4tC3CUFcgl6hAhwNUvQ0XViomdeLPgZdUyCRcykvgNzkUlJBcPWc
         gnGlK/K9iKMbCNjTYHIN7YU9S3W0H/U/mfuJG5YfD7kGPbNmXFnkR6dg4J3X1FOkg215
         +oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0RArvJ2r+niN5CxeWy9DTE3YcMhO/ThVEAVUKztk4rA=;
        b=XVR7NV4RvEA20YrRFNstgNgrjbvint3KTBu/pU2qDp3lGXHs15CaZnxjjzM65aVz98
         sFK7qe8nvjgB7lVhjlOdNQq+F1Up9mnt6OzsJ4iw0WuQR8gzaooZ3WRn/LlLCxJOkMjh
         WzVoqceb5VWIpF7mKYifvHpb0+KdpfFeDDiOZZCiqkXmsw+MdpfOlZ4tVw8R/I/1Hj/V
         7xGsdsWmyyusJ0II7gLG27gKgsB+00IHCol9Subzytdc4KlOh4geQtYHhYN918SNslGg
         iX+2aG6c2rlM+jjsYyhokLA3aHuZJiGDxvFcGXLJs8i9JoDapcb/dP8yvgeICizHe9dL
         C1LA==
X-Gm-Message-State: AOAM533IeEdLvyrhWu7qJHUQePnchtAbOmzo9fDmB5b09n/96cCIHy5T
        B+pePf7GOHiPqK6fJGdrdGN8kKvSAvQ=
X-Google-Smtp-Source: ABdhPJy9tZMFldiIDvIRLbPKBqpnBYYwl8AvK5agDfzAnO0Wkw6BOI7x0tXVRgxKG1IcMIA/rD1qXw==
X-Received: by 2002:a5d:8d12:: with SMTP id p18mr5928407ioj.148.1596238400532;
        Fri, 31 Jul 2020 16:33:20 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id t18sm3336758ild.46.2020.07.31.16.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 16:33:19 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/4] worktree: drop unused code from get_linked_worktree()
Date:   Fri, 31 Jul 2020 19:32:12 -0400
Message-Id: <20200731233214.22131-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.203.gce1f2e0ef1
In-Reply-To: <20200731233214.22131-1-sunshine@sunshineco.com>
References: <20200731233214.22131-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code has been unused since fa099d2322 (worktree.c: kill parse_ref()
in favor of refs_resolve_ref_unsafe(), 2017-04-24), so drop it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    This is a companion to 02bbbe9df9 (worktree: drop unused code from
    get_main_worktree(), 2020-02-23), which also cleaned up fallout from
    fa099d2322 (worktree.c: kill parse_ref() in favor of
    refs_resolve_ref_unsafe(), 2017-04-24).

 worktree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/worktree.c b/worktree.c
index c0df5e2c79..fa8366a3ca 100644
--- a/worktree.c
+++ b/worktree.c
@@ -90,9 +90,6 @@ static struct worktree *get_linked_worktree(const char *id)
 		strbuf_strip_suffix(&worktree_path, "/.");
 	}
 
-	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
-
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
-- 
2.28.0.203.gce1f2e0ef1

