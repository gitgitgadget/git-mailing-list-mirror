Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5160C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BE422D71
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbhASVbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbhASV24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 16:28:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67150C0613C1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y187so1030062wmd.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/u64ZmgRQoAmUvYV26SSFp1TJT72uV1+D4vkjOPyF2I=;
        b=OL1y3zuqZbMqmE1eguXoNyaD0FzUVWqledin+qigvSLKmgUFArvqgfYyN+XhNc6TQ4
         cJ98qoZYVvYuDC2jL0plFya1BeUgkNOrwxClTaHCd7rckL6F3bT5B+iD0lCv0uDCvOJF
         9sN6i2JJAwqmJ2eR4qaiIOXLuGIojDyxIXODQOLjYkgDl43+pSg3rU49pf3jxJ72Hlaw
         aa3d1Baw+f+hm0hAAkMboLb1bQxuA2yalv3A4+MulNBRywxKrEKVysPUfPPPRuVALrJS
         6RHuBBvgy9RhOV9IRCVCNuJE2GmoRBrrbcCkNm7gSYEQouRjiporaE6EqTBAKxPswC54
         tNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/u64ZmgRQoAmUvYV26SSFp1TJT72uV1+D4vkjOPyF2I=;
        b=uoW1pARHawN59nmLm+tmO5BO9YUEBPZfMDASogsi9j/edx9B2ugNI/b93+iZPxzi/o
         bfTyGyGsfAEhZKvEWXpNT2KnDSRC1v91IjdaxEp3rZX9ow1C7RVIq9qRaWM6pEZzmlyR
         DSC76Sb/Qo1oE0MsdmcZ5+P9bM28khSEEhN4WSGVj07lfzZvh3IK84mCZIWe4eoMVtqr
         br8WIHibXan7bC5uR5gY2f/COYjnVsRE3U8mw/jumI+LTwyTX5qLVC5t0zdlO5ObPGGF
         D8hRa8v5BQ2PMTPrAm2sLuB+6XVlhsXXVSNZNV5M0p2sfdYBhdDFeJk1FKxJpuMkdEUS
         rFVg==
X-Gm-Message-State: AOAM532OOVUj5cx3ytn0AWna07pJkXOh/RxIxKJcCuFLEI9OV1qA1UeQ
        9OBqjT4oMKz7+7ba0iffV0aiXt0qeek=
X-Google-Smtp-Source: ABdhPJz4GCDObGWxDsHrrQZOlgn0iwyKbb2OP9Mh8+puKUpaqzIuisznoaTVXjALWsWdUHc0fmuDdA==
X-Received: by 2002:a7b:c41a:: with SMTP id k26mr1364183wmi.1.1611091698937;
        Tue, 19 Jan 2021 13:28:18 -0800 (PST)
Received: from localhost.localdomain ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id r2sm39448819wrn.83.2021.01.19.13.28.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:28:18 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 4/7] t2402: ensure locked worktree is properly cleaned up
Date:   Tue, 19 Jan 2021 22:27:36 +0100
Message-Id: <20210119212739.77882-5-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.421.g32f838e276
In-Reply-To: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c57b3367be (worktree: teach `list` to annotate locked worktree,
2020-10-11) introduced a new test to ensure locked worktrees are listed
with "locked" annotation. However, the test does not clean up after
itself as "git worktree prune" is not going to remove the locked worktree
in the first place. This not only leaves the test in an unclean state it
also potentially breaks following tests that relies on the
"git worktree list" output.

Let's fix that by unlocking the worktree before the "prune" command.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 t/t2402-worktree-list.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 795ddca2e4..1866ea09f6 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -66,6 +66,7 @@ test_expect_success '"list" all worktrees with locked annotation' '
 	git worktree add --detach locked master &&
 	git worktree add --detach unlocked master &&
 	git worktree lock locked &&
+	test_when_finished "git worktree unlock locked" &&
 	git worktree list >out &&
 	grep "/locked  *[0-9a-f].* locked$" out &&
 	! grep "/unlocked  *[0-9a-f].* locked$" out
-- 
2.30.0.421.g32f838e276

