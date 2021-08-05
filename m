Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61088C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1AF6103B
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbhHEXDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 19:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhHEXDt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 19:03:49 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3790C0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 16:03:33 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id db14so3870224qvb.10
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xay5QVKK1LeweOPz1S8PdnEBddS+Z9N1R4ovM7oKm7w=;
        b=kIqG+SKEmYgwmGJlo9cAmq4TY1g3Nwg41Jy0yxa+qHb1D2KmPcnJGnbDoF0XUsETyu
         dtFUy1e9xpLfUbJ+ri09bWlJMjua4GeEa5aXPMTQvcFFC96OtCIZpgE0e+KeV7smjksB
         Vwd5yvWBO12kPhQ8QhCsYEWxUg/eJA7wFR3wQsspQwHHfOuVZobnU3nfedNk6g0lhP7V
         lXcYaI6BhUNl+BB9CJjpyUVTMiadtGJoJ8+QrWorPtO1t8QrDdXscsc4vJEjJMp+XWgS
         PHZv7bSbWy5mKwaw9fqsTDy0K3b93J9oVvwyQk7F/ButBBeJvtOamNGJKqxtBKil3wNX
         RDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xay5QVKK1LeweOPz1S8PdnEBddS+Z9N1R4ovM7oKm7w=;
        b=C5Jp9dmbwYm5zy0O8fjswYDtUopmd+VsX+/2XyZSLqCyEf3vDn/A/H/hNUFCl3Ekvg
         2P+qFFTpS6XyGbgw75GL20jsBHqdu4mCA0iXH/N9KraMEgnDkW+vXlsAwXTJshRtyI8o
         93PkaMs8Hdkid/u/63R3QZ97qf4kO44BRsrPBVBxeWb2rbvCAjc4MoLOG/r3bln0me9z
         sVKcfMxdzDjrlV1fCVQ2FLdLzIRdWk0/t0ReFKaA8vv16GY5UIdPW5prF7UOy/tHPDXP
         lGLqrQQlVoRQPLzXPpPmgMjhFhrIlCGrAiEgM+8w7KRC0iwyEXfayY8FRKSXFvV/fRKx
         DxUw==
X-Gm-Message-State: AOAM532jiw8JEoWvoOoGPb7M5HdONiMSPL7gxuaqiqOFHiaeUs+g55Lx
        mEQsRTUyIN5OPCVUGooVRr/ioaZRo04=
X-Google-Smtp-Source: ABdhPJzKj2jOywUNAvguEBGEYoctMQIPSBC5ZjRvrPxIWt1P+Xnhsdp8AzDeQg1oDoM/QOo9QkGiHg==
X-Received: by 2002:a0c:ab1c:: with SMTP id h28mr8018768qvb.39.1628204611033;
        Thu, 05 Aug 2021 16:03:31 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id p19sm2645858qtx.10.2021.08.05.16.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 16:03:30 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] advice: remove usage of `advice_*` global variables
Date:   Thu,  5 Aug 2021 19:03:17 -0400
Message-Id: <20210805230321.532218-1-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731022504.1912702-1-mathstuf@gmail.com>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When looking at global variable usage for my `branch.default*` settings,
I found the `advice_` variables which were simple enough to resolve.

This concludes the journey started in c4a09cc9ccb (Merge branch
'hw/advise-ng', 2020-03-25) to update the advice configuration API to
help avoid bad coding patterns in usage of the `advice_` global
variables.

New `advice_*` variables also in flight will conflict with this
patchset, but the conflict resolution is trivial (if not at all
automatic).

Thanks,

--Ben

---
v1 -> v2:
  - improve commit messages to mention the history of the current state
  - split the API updates between readers and writers of `advice_*` into
    separate commits
  - reorder commits to better show the progression of the replacement

Ben Boeckel (4):
  advice: add enum variants for missing advice variables
  advice: remove read uses of global `advice_` variables
  advice: add `advice_set` to update advice settings at runtime
  advice: remove static global variables for advice tracking

 advice.c                    | 88 ++++---------------------------------
 advice.h                    | 38 +++-------------
 branch.c                    |  2 +-
 builtin/add.c               |  8 ++--
 builtin/am.c                |  2 +-
 builtin/checkout.c          |  6 +--
 builtin/clone.c             |  2 +-
 builtin/commit.c            |  4 +-
 builtin/fetch.c             |  2 +-
 builtin/merge.c             |  4 +-
 builtin/push.c              | 12 ++---
 builtin/replace.c           |  2 +-
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 commit.c                    |  2 +-
 editor.c                    |  2 +-
 notes-merge.c               |  2 +-
 object-name.c               |  2 +-
 remote.c                    | 12 ++---
 run-command.c               |  2 +-
 sequencer.c                 |  8 ++--
 unpack-trees.c              | 18 ++++----
 wt-status.c                 |  6 +--
 24 files changed, 68 insertions(+), 162 deletions(-)


base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
-- 
2.31.1

