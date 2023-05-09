Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD92C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjEIAoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEIAoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:44:09 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905759EE
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:44:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6aafdeab6b0so1411523a34.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683593047; x=1686185047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qxzqgFl3TFhfzFY4W25Eo42bq2dNP63eyfzhIETXBE=;
        b=rgB/sYODBH4msdnQFT9TH5uIksskB7e6Jl9LAeOiVjg1m3SAfRw+qQSBAOrKLTnN4W
         KJJUniS7XaeLOjygf4DZqCc9JcoAXCbgKUS0lpw1iReQvikGlqxt/gC3M5/HtcTeOtN+
         RBgfdSPxHfkiwDGuwMil1YqoXSev+x+R7tOV6DlonKjH2zdl60kFapLCtntU3gMVVATJ
         ef/nJFJUJdwgZjCkPfNwyJF9O1K7D5r8Yk9jpsHfyvWKYeETYIkYPzYK8yjkIjETEfTi
         2SXcVjrTd+P5SmKGhJpQVpbhxnyRymluI3lbsESpqEpCT4WorL74faiO/mZV98BgXSjh
         YrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593047; x=1686185047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qxzqgFl3TFhfzFY4W25Eo42bq2dNP63eyfzhIETXBE=;
        b=J5aD3liK8SHDK+So58OfTjVSp6bgt/rmZ2jM7c7mYWv7dmrUx0baM31zIjc9/05eoM
         bJoNkMnaAiyzb7r3h7hHQpjt1kk+VNlfPkfx44/X83asDN5za8qetPCOJwuGnvVAbnA6
         vEiMjNcauvwm9SCmDgLemfjOEFkjzRxWt04VGGvuh/uAMGFoWyGvUE6X1g8juGpv+Lj+
         tXyRxzAP8HDJHlCZCEOWMhSeq5aFuAxMTqgTAzvzLvhU0Da5mvvmtYHcVpvFZFVycC8M
         KQHNY8Ut54d1lDI1oEVS8SaFQcKHzvqPrp9twMfPQTerxeFl0TO75ITeEmv6Cvos6DR+
         GYbw==
X-Gm-Message-State: AC+VfDwRBW76LMlRB2v+G61FjurCiCWaHpAYsveWvYBFA6JVsZuj0+uG
        qDnTJOYm8DSSDit2w1gVXJX9y+LL0xY=
X-Google-Smtp-Source: ACHHUZ43CQmoW9axOd+LGZSZxHS8hnBTVqqpUfWw8EwrdQnDQhMyUPEw+uHgEKd3qYfK+vpG3b2T/Q==
X-Received: by 2002:a9d:6657:0:b0:6a5:f8b6:ccd2 with SMTP id q23-20020a9d6657000000b006a5f8b6ccd2mr543736otm.16.1683593047682;
        Mon, 08 May 2023 17:44:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b1-20020a056830104100b006a42b16ec7asm83953otp.38.2023.05.08.17.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:44:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 0/4] diff: fix default/no-output
Date:   Mon,  8 May 2023 18:44:02 -0600
Message-Id: <20230509004406.1786033-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The diff code assumes 0 means the default, and --no-patch means
NO_OUTPUT.

The problem with this approach is that it doesn't allow distinguishing
`git diff --no-patch`, `git diff --patch --no-patch`, and `git diff`.

By introducing a DIFF_FORMAT_DEFAULT (which is not 0) it's now possible
to properly distinguish these arguments, and get rid of
DIFF_FORMAT_NO_OUTPUT which should have never been considered of a
format, but the absense of the DIFF_FORMAT_PATCH format.

This fixes an issue Sergey Organov reported.

Now all these 3 work correctly:

 1. git diff --raw
 2. git diff --patch --no-patch --raw
 3. git diff --raw --patch --no-patch

Felipe Contreras (3):
  line-log: set patch format explicitly by default
  diff: introduce DIFF_FORMAT_DEFAULT
  diff: remove DIFF_FORMAT_NO_OUTPUT

Sergey Organov (1):
  t4013: add expected failure for "log --patch --no-patch"

 blame.c                     |  6 ++---
 builtin/diff-files.c        |  2 +-
 builtin/diff-index.c        |  2 +-
 builtin/diff-tree.c         |  2 +-
 builtin/diff.c              |  2 +-
 builtin/log.c               | 16 ++++++++---
 builtin/stash.c             |  4 +--
 builtin/submodule--helper.c |  2 +-
 combine-diff.c              | 10 +++----
 diff-merges.c               |  2 +-
 diff-no-index.c             |  2 +-
 diff.c                      | 53 ++++++++++++++++++-------------------
 diff.h                      |  6 +----
 line-log.c                  |  2 +-
 log-tree.c                  |  4 +--
 merge-ort.c                 |  4 +--
 merge-recursive.c           |  4 +--
 notes-merge.c               |  4 +--
 range-diff.c                |  4 +--
 revision.c                  |  6 ++---
 t/t4013-diff-various.sh     |  8 ++++++
 tree-diff.c                 |  2 +-
 22 files changed, 78 insertions(+), 69 deletions(-)

-- 
2.40.0+fc1

