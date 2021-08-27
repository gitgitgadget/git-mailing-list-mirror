Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9947CC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A9360F92
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244536AbhH0IEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbhH0IDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 04:03:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9DC0613CF
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h13so9117928wrp.1
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISX1FdkdbMeDhpjE3cmX3VnE5zTbmQ8p1FsvIsY0MPA=;
        b=M8nP6Ck5Fy4yidOf6O2/RLoPVgxn++agS+52OHaKC03RYaJ1tbqtStLfbgRqnZxNWF
         UONbeLQsXiCG9VELFJHNaogOUhiMbVHI1eokoy8sP3ZlF9w40y/uhY5YAi2knF/rZJCH
         f78UULNAUNdAgrMBxgHKABp/V+7i/p0TUcYFHZjHt6QLKV82txfzG/u2St2Civn967XG
         jOvCQMpm01ywRNpr/6Ua8/+yDsTrUw6GDKXDx6pe/1laQoYEnIOL5GdOw8htXMm1vZGo
         BJdFI9PKlikuoTY3NlfIQdNXRHWHij5sRCWdSJutgcZLJA2T1dbWOuniK7eSLua/3ZJ/
         G9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISX1FdkdbMeDhpjE3cmX3VnE5zTbmQ8p1FsvIsY0MPA=;
        b=o71DyklCTynQ2yUbX9nLWPdet4VTkLZbAF2tNH8skovdE53Xn+q3tvJSgGtoqdapl3
         LSwnIGz+4LRCQwZqfs3mWnEAhUTdrAXSXJunpspumBgfwMQ02w26RWpdGq20x5312wSJ
         mKn0Oe9mPDn6umuoGrDEeo/kEF5uNCSsQdWgeM1E6IkojMCNR9Id1spSJSx9FDemWq95
         itacEes9V9rW3KakreUawla4MaxTkCRqSAWx9LR4BnIpxrwxR2OGusHa9NU6V9ZuyiYh
         dLKIJ2jwk/9AhyXNy8np9SgBohMIoWAOQe3qDyC0xjyfHs3GoMCYmVimLGwywyxZ22r6
         zPnw==
X-Gm-Message-State: AOAM530RU7yU2htB7CtMIYnlqE8EaKILQqlhzd39pX1+eBiQE6ZnU/g9
        ysGLXUi/TheSMYh6q5HSlW/gMm2qQ6KHGg==
X-Google-Smtp-Source: ABdhPJy1FeGdiw4U0xZ25Ki73Je17zBcIYyKtu1o5zVhuVaUv5oG5+jZ44df4B6senPduNFj0RKwlQ==
X-Received: by 2002:adf:c549:: with SMTP id s9mr8769352wrf.344.1630051342930;
        Fri, 27 Aug 2021 01:02:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z137sm10922636wmc.14.2021.08.27.01.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:02:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/6] tr2: plug memory leaks + logic errors + Win32 & Linux feature parity
Date:   Fri, 27 Aug 2021 10:02:12 +0200
Message-Id: <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.736.g68690aaec9a
In-Reply-To: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A hopefully final re-roll with minor commit message changes. Thanks
everyone for the reviews!

Ævar Arnfjörð Bjarmason (6):
  tr2: remove NEEDSWORK comment for "non-procfs" implementations
  tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
  tr2: stop leaking "thread_name" memory
  tr2: leave the parent list empty upon failure & don't leak memory
  tr2: do compiler enum check in trace2_collect_process_info()
  tr2: log N parent process names on Linux

 compat/linux/procinfo.c | 169 ++++++++++++++++++++++++++++++++++------
 trace2/tr2_tls.c        |   1 +
 2 files changed, 146 insertions(+), 24 deletions(-)

Range-diff against v2:
1:  8c649ce3b4 = 1:  306f14a0f7 tr2: remove NEEDSWORK comment for "non-procfs" implementations
2:  0150e3402a = 2:  a999e016a9 tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
3:  1d835d6767 = 3:  45769da953 tr2: stop leaking "thread_name" memory
4:  1aa0dbc394 ! 4:  946140691f tr2: fix memory leak & logic error in 2f732bf15e6
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tr2: fix memory leak & logic error in 2f732bf15e6
    +    tr2: leave the parent list empty upon failure & don't leak memory
     
         In a subsequent commit I'll be replacing most of this code to log N
         parents, but let's first fix bugs introduced in the recent
    @@ Commit message
         system where we could read the file from procfs.
     
         Let's move all the freeing of the memory to the end of the
    -    function. If we're still at STRBUF_INIT with "name" due to not haven
    +    function. If we're still at STRBUF_INIT with "name" due to not having
         taken the branch where the strbuf_read_file() succeeds freeing it is
    -    redundant, so we could move it into the body of the "if", but just
    +    redundant. So we could move it into the body of the "if", but just
         handling freeing the same way for all branches of the function makes
         it more readable.
     
5:  70fef093d8 = 5:  0bea5aa9c9 tr2: do compiler enum check in trace2_collect_process_info()
6:  f6aac90248 = 6:  6eac9986c3 tr2: log N parent process names on Linux
-- 
2.33.0.736.g68690aaec9a

