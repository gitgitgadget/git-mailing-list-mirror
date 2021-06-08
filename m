Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480F3C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C6461377
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 18:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhFHSIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhFHSIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 14:08:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA610C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 11:06:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e7so11098135plj.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/K2GrTVyWn8R106VnJ7cebggnc+KLHphsYhOUef1kc=;
        b=GrRKZ4WsZUHWklZ3O70s3RIRT5m4xMIahMqa9xykJA4ZkPXasoE2PL3ly3salVNA9y
         SakllNYLFuAdIE9w/kQtoSZQvW0fCvU2gqCT0/BPIJYRDQQaLglm0tOt43UdlTE49Q2s
         T109xD0tPxDSa0ZxP9J7LBVyBe8Xtu+QCkzPIVYu41bMJXBqeQKB7MXu/iLqecdl2j6/
         icXguhZqFjRi666kXH9ux++KGS0ePjKu/7+h+5L758VDKmnfmB/FD4E4Ax4cofODP09r
         JNAVIoyJaXFaAAPFRLB8BD7mGqSTNaPLIRhpHhTcOj1Hqrm+fYuQQy/QmsswP/YqDiAP
         BUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/K2GrTVyWn8R106VnJ7cebggnc+KLHphsYhOUef1kc=;
        b=P+N7JqJHM00STxFj0AeJfxj0YsEt6QaeQq7QWgHiYWqN8GCvt3rrduET2kUnZjV9gQ
         KOSk2Z57De41rYoZ7+e7eC0vBV3yBMhlDCHpwHymKCrenI9T5euQKICKVf7mAp1I97Rm
         mNOaldO6cbXvXvyoRYM8Mx/Gh3gkgbXikPC2WXT3TtFSo3xpf7dhx9vrbltWUjHTMGtO
         la2lZxHNxyWdJrAU1Ar+DVk2VvWmzIUyxKNdjAdex4cngySIENE/RwxflqmA6qlUxEdS
         HCvypoTLelf2zifE/vitrB0f0ejbh10sQQ/oNPb/58Jp10r9buZxRqV4qtEA49oG7yOb
         OV2w==
X-Gm-Message-State: AOAM5303dbXCjOOgKji7QP8zdPmJDLUPctUgBL700Jeli9Vuj2k/I8H3
        Q3UF0sDOKjJMlqZFe0mGfVMd6Kxs7g1beUD9fPw=
X-Google-Smtp-Source: ABdhPJzmXv2cmuMvaGgGeRzROTfWi5PbqVoxfps3BukAj3qx5f+y0pySFaX1b8bdbF1OAI9x7pRFwA==
X-Received: by 2002:a17:90b:430f:: with SMTP id ih15mr6303931pjb.196.1623175617957;
        Tue, 08 Jun 2021 11:06:57 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id 194sm6592475pfb.139.2021.06.08.11.06.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:06:57 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2] MyFirstContribution: link #git-devel to Libera Chat
Date:   Tue,  8 Jun 2021 23:36:24 +0530
Message-Id: <20210608180624.72135-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608135114.71104-1-raykar.ath@gmail.com>
References: <20210608135114.71104-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many of the regulars on #git-devel are now on Libera Chat, to the extent
that the community page now lists it as the IRC Channel[1]. This will
help new contributors find the right place, if they choose to ask
questions on `#git-devel`.

Relevant discussion on the IRC transition:
https://lore.kernel.org/git/CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com/

[1] https://git-scm.com/community

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 Documentation/MyFirstContribution.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index af0a9da62e..d0bcb8c91f 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -47,7 +47,7 @@ Veteran contributors who are especially interested in helping mentor newcomers
 are present on the list. In order to avoid search indexers, group membership is
 required to view messages; anyone can join and no approval is required.
 
-==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
+==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
 This IRC channel is for conversations between Git contributors. If someone is
 currently online and knows the answer to your question, you can receive help
@@ -827,8 +827,8 @@ either examining recent pull requests where someone has been granted `/allow`
 (https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
 is:pr is:open "/allow"]), in which case both the author and the person who
 granted the `/allow` can now `/allow` you, or by inquiring on the
-https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
-linking your pull request and asking for someone to `/allow` you.
+https://web.libera.chat/#git-devel[#git-devel] IRC channel on Libera Chat linking your
+pull request and asking for someone to `/allow` you.
 
 If the CI fails, you can update your changes with `git rebase -i` and push your
 branch again:
-- 
2.31.1

