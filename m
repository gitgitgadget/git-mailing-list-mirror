Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB4EC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A148A64EEC
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCQVMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCQVMc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:12:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B870BC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:12:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id n24so10307426qkh.9
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c46MJEPHSdT3A+FpwlqEq+OEVM9WzieV+YO/J2hIjQs=;
        b=g1Xg39EkB5TU1zCRtZi3aQDrz+kWCXKv1ivsO6MIgtKGo9NSyVePabhGWXKEC5ibWb
         dK42RJ57MhvNlbp02NM9J6L0Cdhcb82hm9q2bCnnb7mU8TQDnuEWAsc3vIRHYdJbZeqv
         AQ+CIO8KHNPMDuJ9c01N5Dq+cgxzGtcmzb8NY6K9AIj2BxgYv2w1/2nqmzbpVdpYAAWr
         Ncz+yt2KDXF1jCyDkkSwFIKqLdq68CMt5H4qpSGDS9XdJJb5ozmyoqCBd1pHgHcnmbR7
         3zr0s/tRrnkKeCXWP+Em/ptycK3CM3/jWswttzRw9xTuS1s0cqYxb2zYYKFv1b4reRWN
         GJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c46MJEPHSdT3A+FpwlqEq+OEVM9WzieV+YO/J2hIjQs=;
        b=BHVJjTAs0WsNZaGmu5b0mt05er9IgeiYQzG7jlW1gQRXsOCDuZyK/CW6E7pv+QKVun
         ISDJNVHewKJK4JTEjs1HsJj3TZSZAfud2KV5RZYA9FO10QpqIfY0UuUXDD2h0YN7vAbZ
         o3fsyK1msgFbYq+By0Rk0cT00qSP1MPdnlUl5t30dIvZpHoobbkQkq66satoz2b4vM6y
         svaogFRJI1EPybd9knBpGgbvpTBgrptgmBL6SkS4ZHGXGim06M7jEUsvzfm+wXSLlCSj
         ENE6QIbtJrQsg7gAg/hJ3yYDnL3Ytn6s9rvOB30AZsDamJQ4Sw/4pkwUm5bLVhWbrsnV
         sdpQ==
X-Gm-Message-State: AOAM530qU7QEGwh9NBe7HaU2lmfboey0s5LhpMUB8haPoaF89NPE2NWU
        W4znRMd9no/+zTlSzd9875xx+Zie9AvNgA==
X-Google-Smtp-Source: ABdhPJweuJ4vL8JWIY0tVR1ZZ8tQvEHMou0/jrdfVHnyiHb+goVc0xQ1DY2Dg/vU3/ys02K72WhGuw==
X-Received: by 2002:a05:620a:1442:: with SMTP id i2mr1230765qkl.469.1616015550561;
        Wed, 17 Mar 2021 14:12:30 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id f9sm131138qkk.115.2021.03.17.14.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:12:29 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com
Subject: [PATCH 0/5] Parallel Checkout (part 2)
Date:   Wed, 17 Mar 2021 18:12:18 -0300
Message-Id: <cover.1616015337.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the next step in the parallel checkout implementation. An
overview of the complete series can be seen at [1]. 

The last patch in this series adds a design doc, so it may help to
review it first. Also, there is no need to have any familiarity with
part-1, as this part doesn't have any semantic dependency with that.

This series is based on the merge of 'mt/parallel-checkout-part-1' and
'master', so that it can use the "brew cast" fix and the latest security
fix (both from master), to run the tests. (The merge is textually
clean, but it needs a small semantic fix: the '#include "entry.h"'
addition in builtin/stash.c).

Parallel-checkout-specific tests will be added in part-3.

[1]: https://lore.kernel.org/git/cover.1604521275.git.matheus.bernardino@usp.br/

Matheus Tavares (5):
  unpack-trees: add basic support for parallel checkout
  parallel-checkout: make it truly parallel
  parallel-checkout: add configuration options
  parallel-checkout: support progress displaying
  parallel-checkout: add design documentation

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/checkout.txt             |  21 +
 Documentation/technical/parallel-checkout.txt | 262 ++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/checkout--helper.c                    | 142 ++++
 entry.c                                       |  17 +-
 git.c                                         |   2 +
 parallel-checkout.c                           | 624 ++++++++++++++++++
 parallel-checkout.h                           | 111 ++++
 unpack-trees.c                                |  19 +-
 12 files changed, 1198 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/parallel-checkout.txt
 create mode 100644 builtin/checkout--helper.c
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h

-- 
2.30.1

