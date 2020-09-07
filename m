Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05828C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 00:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85682078E
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 00:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjhAdoaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIGADe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgIGADb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 20:03:31 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D9C061575
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 17:03:30 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y2so11055558ilp.7
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KeaCPUTKce5yLNUpciFJF4pXv6s+59WsUq6KBmoFHVw=;
        b=KjhAdoaYz56lLAWv3ASopWRXu6vqZTQ2QJy/HtxQ0qXooAvXD5ZEwhowZb5MjvyOfL
         w3ohOJikw6WZK35YxjuCVP7LasJbf8/3WaviXlmJWU6qF8TV0757EHIrbRwoOTqnTab6
         ryLJ0aYUSEiTS9mk0sdc13x4DwIOGu52zIw1yivFJ/D4ihmU5iKv0Op0a5sYIZ6vj9XJ
         DaOaNhKO9Ns4YtsZ6lEyjodfAaZ3hbxdbFM7zbv5QYmLB5T0zV08hIdE27IRe058W9WD
         TE9YmbV7cHI91nfPBbuhosO+MgkKHRNbBn75blWoN9y50Wgz+XvNg9q9jfkWg9RHn7F1
         iH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KeaCPUTKce5yLNUpciFJF4pXv6s+59WsUq6KBmoFHVw=;
        b=BSl7YEszuM3cDJ13+ivCZaMn+TfSBf5sbYh6YBfCQNHLiL8czopYv5Wp5FcQRG8MuF
         3fUN1eHJjEC1GxgkQqGrOa5KbOhoCh/x8KcnyMl9M1zxUXdxzfjewhDCz+D6CMicVkcM
         0hPh4bSXZRdqoqv8N8CY4SZBR085yOSaPFXIK8R9V6OXU91CzoPVF8M9/FFW0vTI7Iy4
         Y1AWkIOOcgt2vUPgmFndWRYorfoQ8dLUZboi1lrnuQemPuLpRkDMoYCPnwXKhpIfgcwI
         hSI/jzWd5YlgUdxJ1WIvFiilmCdK6u9G1hmtk/IhU3JbLT9cuUM5xXHc2NjA1p0SWfGo
         9C4g==
X-Gm-Message-State: AOAM5311ogZZb6qHdcQoRZ35rt5SaWMvt+rZzrZEevHwyFXYdLZsr9lB
        BvHA4LmuW3LLZt5ql2nZhP/8BncWCRs=
X-Google-Smtp-Source: ABdhPJz00mG94mX9hjZ03vLlYQk41N2nAXM41MDz1vabp6fl6PbwdAfeYYYl1oWDIAW9g8eqjiFhpw==
X-Received: by 2002:a05:6e02:cd4:: with SMTP id c20mr17810082ilj.0.1599437004603;
        Sun, 06 Sep 2020 17:03:24 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e22sm6381664ioc.43.2020.09.06.17.03.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2020 17:03:24 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/3] worktree: teach `add` to recognize -d as shorthand for --detach
Date:   Sun,  6 Sep 2020 20:02:21 -0400
Message-Id: <20200907000222.4717-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200907000222.4717-1-sunshine@sunshineco.com>
References: <20200904070703.47898-1-sunshine@sunshineco.com>
 <20200907000222.4717-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like `git switch` and `git checkout`, `git worktree add` can check out a
branch or set up a detached HEAD. However, unlike those other commands,
`git worktree add` does not understand -d as shorthand for --detach,
which may confound users accustomed to using -d for this purpose.
Address this shortcoming by teaching `add` to recognize -d for --detach,
thus bringing it in line with the other commands.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 1 +
 builtin/worktree.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 6ee6ec7982..d252b6873b 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -143,6 +143,7 @@ To remove a locked working tree, specify `--force` twice.
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<commit-ish>`.
 
+-d::
 --detach::
 	With `add`, detach `HEAD` in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 378f332b5d..1737165d2d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -555,7 +555,7 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
-		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
-- 
2.28.0.618.gf4bc123cb7

