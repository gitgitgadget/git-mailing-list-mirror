Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B0C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BBE613BE
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhFURzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhFURzE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:55:04 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7370C0617A8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 10:52:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so18601717otl.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1RSDVIXzL16eP/wYryKjqdUp8qh0nSPpORg2F6w8wm4=;
        b=EJ0CGQrsIsG/Z8k3QEp7qkxrtM2Uz7zUToGDM+FvZlfuIvvP7/mcyC/bmu2vitoBro
         I5GBl1jqEMuj1e7a9AILWO+txuUHwVjROuuR5mIlAYMpoW1FT0MzbA40Kewg5zUJgTAr
         vlroEesxPtfCvcQLK3hpRmF0Dxo7mB1ctgl75j5H/6sW5pYTKRbeacH6KnOMS0Dzp7yd
         sOf/2FEkmX1fglgFPKK1/Akm/BaZaYo/9goZKg75HKu/eK/MpbhtwP6EunHDnM6kLyLl
         bik6jUo0hRB6cFVXU5JdsUHUGB7M/CXSDh/jDRiNSdoxfPdusOElHHzGRhPc96+Uu/f/
         CyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1RSDVIXzL16eP/wYryKjqdUp8qh0nSPpORg2F6w8wm4=;
        b=AC7/jFue6JEkdKqu2pnD36s3ZPuJIGJpBHug7gTzswF5akitaDezoGi0vIM4sj3Idd
         spiSU7mQ2CSCzTHl480ffIfKWJ2dP8o5sGWIpFOc3L/dhi+pKMqN/powAKtsRnEsmzZH
         HnqpE2kAH+J+x4+6D5vWlXtllaFfDm0j4UT55Ar6b5Yg5QORGHVf7CwXT43p5xe/eg0/
         NLk1oGKhhna5xsxqlWq+0uKX3n6o8XSymKv5HpOAUeAIPr9hdJXLrBL4weWXv+LC6tJo
         icyKdkDat0ajFE6R7+kKWewKFDqWr9hrlQDfwEJc9C/j42jHIotLn5DoBviu0b1uaElm
         owLg==
X-Gm-Message-State: AOAM532p82LKcHasgMFUdd6mpD5SbheHXgFJAQAIZ0O7nO5Ar+TcpHDV
        gEHbH/C1eME15cOu2KNnCt3EA32xC80Kig==
X-Google-Smtp-Source: ABdhPJzrxE2N+Iv4VB8I/jyc2YJU9vkfaBSnGEN3U9sE7UOqMwTjMjC6qIjcDwN7NIPAQWDYyHd/BQ==
X-Received: by 2002:a9d:147:: with SMTP id 65mr21199926otu.315.1624297955892;
        Mon, 21 Jun 2021 10:52:35 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r25sm19377otp.21.2021.06.21.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:52:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] pull: documentation improvements
Date:   Mon, 21 Jun 2021 12:52:32 -0500
Message-Id: <20210621175234.1079004-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are the non-controversial changes from last-year series [1] which
objectively improve our documentation and don't have any reason not to
be merged.

Not everyone knows what a rebase or a fast-forward is.

[1] https://lore.kernel.org/git/20201218211026.1937168-1-felipe.contreras@gmail.com/

Felipe Contreras (2):
  doc: pull: explain what is a fast-forward
  pull: improve default warning

 Documentation/git-pull.txt | 41 ++++++++++++++++++++++++++++++++------
 builtin/pull.c             | 22 ++++++++++----------
 2 files changed, 47 insertions(+), 16 deletions(-)

-- 
2.32.0

