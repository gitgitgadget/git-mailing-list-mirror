Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCBDC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0398A23A23
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgLSOHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgLSOHE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:07:04 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA77C0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:24 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x13so4727211oto.8
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFLS/lMw25JKtsMQ6TPsMgUJRkm5qsuDAsHu0aFeZTY=;
        b=YyyermMH9p7fGpDzUnugBH76aMN68Wb8CHihIqZjpCtazUV1q8zMnHX/OJJ20jvsdb
         UUqIjB+eCJM51o79xvV/IPpbZ4s1V8M9M2A2T9iCr0Zbg/kDNj7dD7LhQHWqcNpYJ7LB
         Hvg4SuAbk2RALpDLJPNnMWN8ZdjKUtE+QAsiBGHO537ifFQZo8IQ0oT0c6574Duwilpo
         Q6VbVqkaafGHhqTmjT1vrhhZ3v4zobDUHfrYPLruREco9lcraKQxWJXiKF3b5nN/1Wd5
         MOiiLECSN5jTPle2K+2hSo2cGiThZqFhrwTENhtREWPj/NK5wR0Qmt7j240bc2BLXUOm
         AmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFLS/lMw25JKtsMQ6TPsMgUJRkm5qsuDAsHu0aFeZTY=;
        b=eO+M2TfwoCBbkywa/liv/sT0+8PDQXhxUXRj35JdZE82BqX80b0DsqIDhFHqZo2fNG
         UxXGX2ba8A2FpIyOZobXeRbKOrxXdpgEGnQcuHVmlwBnjGuB+YW2ozE3P+tp9W+iUE8t
         AaYFN+8GzzjxOSSVOLm1syINK5N4LVWZpD1fckttbpGpL//iLLmvYBc4oLKmLICP6Akj
         x0ND01E5/A9ylLhFnIoV9L6omZFcAAvBO+TLNQAVAB6PQS4kaV0sfIgFUe/a3Saie/AL
         E7mfEWp2mVVoY11ivvKBYOEzuxYbzsQyv6umQ8c5wFlnunWr4FbMHYCQtDuOnE5mG6ZW
         Y88w==
X-Gm-Message-State: AOAM532YWe3/hhFLuN4jHin9f8dW1+4iCrCNS8FJhAumrlFvtA0Y1qPR
        RhYTs9HIm/KEBNR61zj2MIXyqD55PsS3HA==
X-Google-Smtp-Source: ABdhPJwaJix4ya076uYDjaN3rm8pyQhnBnx43giKUHMHcgpiO0S2JcENyE+llJ3/arXu2DtHNwgOyQ==
X-Received: by 2002:a05:6830:20d5:: with SMTP id z21mr6217546otq.310.1608386783809;
        Sat, 19 Dec 2020 06:06:23 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s9sm2408884oie.53.2020.12.19.06.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 06:06:22 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 0/4] completion: bash: a bunch of fixes
Date:   Sat, 19 Dec 2020 08:06:17 -0600
Message-Id: <20201219140621.1961760-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is just the bug fixes from the previous series.

These should be pretty obvious and straightforward.

Felipe Contreras (4):
  completion: bash: fix prefix detection in branch.*
  completion: bash: add correct suffix in variables
  completion: bash: fix for suboptions with value
  completion: bash: fix for multiple dash commands

 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.30.0.rc0

