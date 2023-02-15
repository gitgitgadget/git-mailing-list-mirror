Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3094C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 05:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjBOF6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 00:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBOF6i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 00:58:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DD55B1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:58:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so17888839wrz.12
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PG0feTg3Ucg85aO8OJCpeAWPTxIkXTlyG25mRCZLVqA=;
        b=Fjz9CdEg7erF+jFS7rQLxPOO9mU6Qqx03rxZjoQ2I9FpvuFOT2WM3ctaIMHrtvKJaF
         J5cjAy0RtDZgeC8ayubSCx1EdeH+Ou+BZMc7aNb24EeWrHQLaV8vjX/O0ju5GGpsOTzP
         cOnfeZmwrf08KEeuhlUoz5pgT3XXA1GOpUkP9GpFD8nEfDg3rLOO8FmYu3kg7D9B6Ziq
         QHMYkofe9+uCIz5e2+Z3HaRk/kovNpw6f61DCBBF5vFwH+KSV7TVVXvgJDBtYQxd9QwQ
         RohDoSIosRQbsmGqkcSPPpoPb73YSm1W0tyvBuEkoLPSvdd0jqqy9aS1VQ2AVXid2Top
         lY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PG0feTg3Ucg85aO8OJCpeAWPTxIkXTlyG25mRCZLVqA=;
        b=3K0TxRXQKGLqsKp6LJM5xVVJfrFZldmERQsy31WS2FoXgPvhiRO0BuILzrR09lIxJ8
         TNNCpb3MIbESt+AtfW22ln7AxXfJcTPkdMiePCJVvUNbxL4qlL5lQbUZbcFDrGSV77HB
         E2eI/QtOEc+X55yfD/tbmiIOuwtGs7UCUkC9ockk/l1mYxbYt0KNGFzjUapYQSgjCx+h
         y2M986hGPjvmKm/gnCKs62ssXi/saGNdRoCiIQz4U11mdGblHs/NoWYgCv0jDuOFnSp7
         Et8BJLuUyBEvVl5AHh0Bl+Gg+5wlMWGGaKdzoUdCaYkKnmWf8zGA/UnGXWWyEJfAxrDD
         G6ag==
X-Gm-Message-State: AO0yUKU3tF11OvUZcwANhIw+++/M79bOPZ4/t6EEKOCLh2xaZ16uOBqd
        0mOFJllfR9jGDR8M16sAOepIxwYL6HQ=
X-Google-Smtp-Source: AK7set9gfKhc7TQB1uvrvKpBvxe/k81J6TTAFO1EK0AS18hwEcNNJAIQ3TAgeh4Cr+I6QxdWAahW6A==
X-Received: by 2002:a5d:49c4:0:b0:2c5:5f95:7746 with SMTP id t4-20020a5d49c4000000b002c55f957746mr518442wrs.56.1676440715494;
        Tue, 14 Feb 2023 21:58:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d4b91000000b002c55de1c72bsm5420918wrt.62.2023.02.14.21.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 21:58:35 -0800 (PST)
Message-Id: <pull.1480.git.1676440714.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Feb 2023 05:58:32 +0000
Subject: [PATCH 0/2] Make GPG errors less puzzling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For one times too many, I was asked to help with a commit signing problem
where the only error message was an unhelpful:

error: gpg failed to sign the data
fatal: failed to write commit object


That was it. No further indication what went wrong. And certainly not that
wonderful error message that the helper that was configured as gpg.program
wrote to its stderr.

Let's show whatever GPG (or any alternative configured via gpg.program) had
to say when signing failed.

Johannes Schindelin (2):
  t7510: add a test case that does not need gpg
  gpg: do show gpg's error message upon failure

 gpg-interface.c          |  8 ++++++--
 t/t7510-signed-commit.sh | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)


base-commit: 23c56f7bd5f1667f8b793d796bf30e39545920f6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1480%2Fdscho%2Fmake-gpg-errors-less-puzzling-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1480/dscho/make-gpg-errors-less-puzzling-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1480
-- 
gitgitgadget
