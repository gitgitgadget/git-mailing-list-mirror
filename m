Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88670EB64DC
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 06:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGAGzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 02:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjGAGzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 02:55:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE03844A4
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 23:48:56 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-402318ef92fso16720431cf.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 23:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688194135; x=1690786135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WnqeonDBv85j4uiye7iK0vpEbQk1Ksj4ialqmGuvttQ=;
        b=LXGlkFZOHKraH6oOPkR5+w497yZMCH/PXaqRp9Ht+279aU5pZRndgMCrZhM/UsastZ
         n66emcY9YQytvrTTmOXjsOoYJmOyZPB4vyU4mWXdGKZHTnLDNEfTaZ3WEkxWL3XgLy4Y
         RmPJqTmI0m9Tfp8wCxSo9xApbbhqPnAVGNIex/QLTMoNuxf07GJPotdWsFKCbrGL6L1l
         t7xb8YUQKs1JEwiCPvmFIeAZCEq2PvoSzaR60Zs5iY6080RDCRaETekbledHs66bX69q
         uVelnV44l4HjNYdva8dwMAt855F3b42HCt1K+ZTXVgP5PLkKrG9XcthLRSmHIKYn+ASS
         bAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688194135; x=1690786135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnqeonDBv85j4uiye7iK0vpEbQk1Ksj4ialqmGuvttQ=;
        b=kMHzWGkrPtOjjTxDfT6qCR7Yc9fkwEgyK7dR86iVAMQXydByP0VsHrIZKjEnvkZljZ
         rGqORiuQPIvnU5nzy9NJDwjU2fgjawc1IjyHNuYA2T5WDP0JV4U82s8SA7m0hMNisJFx
         mhOKIfCJNBfpw4aRpzEQ9gUnGu0hD88cDE4b82M1zb7zlKRsLIxIZQsXwpMd1lu/1MYR
         tj0t1e27GV6foZIOEyYIbIFjhyKryfOrUXrP9WBURa7ETE5UPT1G0TTv/W3T0W050win
         waDzYxk6nnonn7KSkBzD07mptEt2gEOWMZpFXI0JxkTgIklAzEproJgSkLa6ZhHFOPAq
         nkrg==
X-Gm-Message-State: AC+VfDxa0pq0S6KaOewkJDRSY86CBeRxQ/NblFqRGACMGPffFxg/52kF
        gF/2/th1c0kG+ftHvIww98SN6PdutbomuA==
X-Google-Smtp-Source: ACHHUZ7Z+fDR7mozEBOdiEHYSVP7GTH/RwwtvgFeWbFP8O5WoRdzaFYSlrMrfE32RavtLwHjV0yIrA==
X-Received: by 2002:ac8:5d8a:0:b0:403:36a0:bdd with SMTP id d10-20020ac85d8a000000b0040336a00bddmr5441948qtx.23.1688194135356;
        Fri, 30 Jun 2023 23:48:55 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-18-69-158-189-182.dsl.bell.ca. [69.158.189.182])
        by smtp.googlemail.com with ESMTPSA id a26-20020ac8435a000000b003e69c51cf53sm2269720qtn.72.2023.06.30.23.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 23:48:54 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v1 0/3] check-attr: integrate with sparse-index
Date:   Sat,  1 Jul 2023 02:48:40 -0400
Message-Id: <20230701064843.147496-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn on sparse-index feature within `git check-attr` command.
Add necessary modifications and test them.

Shuqi Liang (3):
  attr.c: read attributes in a sparse directory
  t1092: add tests for `git check-attr`
  check-attr: integrate with sparse-index

 attr.c                                   | 64 ++++++++++++++++--------
 builtin/check-attr.c                     |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 40 +++++++++++++++
 3 files changed, 86 insertions(+), 21 deletions(-)


base-commit: 9748a6820043d5815bee770ffa51647e0adc2cf0
-- 
2.39.0

