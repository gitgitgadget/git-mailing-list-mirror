Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8264DC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4D422B47
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAS4eHce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgH0IXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgH0IXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 04:23:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065DC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:04 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j2so2681996ioj.7
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkNtoeUcJaf7HoXxwX+Z9JeTD94YFWiwi48FNqA7nuo=;
        b=NAS4eHcezpP7h7zucJL74XF8DCYQUv/yf2O85QrFMO/4RFeHUzXug8uyKrOS/ERGgL
         x3beSHPkEUx0YsieX6FNIHDV9boe1H+TlYecMJ3Q3wiaqGx4ZsvOseA88X42WRmdeV0n
         LAYcFJQRMCnJziZMSY8nN8kzR7zi6/vQxTQKfoAfiwtHNhAVKw6/z752mhYczU+Oh3mt
         6+PN78568B+SgwJdF8EQox7QV96xBBSVUFfObBfuXbG/mtPeWSb0TW4ysyAkD67P43Hd
         tiK/ii36LDcbDbgdkE7J1+IEQ4P55Z0Eo/lK+DwMwusUqGk55ziMdTfhoS6Il0A5G4V0
         uNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PkNtoeUcJaf7HoXxwX+Z9JeTD94YFWiwi48FNqA7nuo=;
        b=ke85sFvafwHCOwmHPe9Ye/9ePJUO8tEXGOF86AZyutkEyX7OqTw3Ub6vr0yuzYFMJx
         ateZaWKcUgrqPL8fb2YAIcZI/nqB9axF+iFJKIqaFgnDSiAAE3p96ATnhRBEAxUJG1G4
         QQNk7ELUbhCikj4W2aIlL1TM+bdORFXQ2pzdVsbLBTHP1TEtdg+bfRprF773oa9jv3bA
         IPJV54rr1JLWYTm6VD2pI50H8DLKbfiG6+95rlaoTZXfypSIBQHBvcefVcGKeniXxgYl
         gWiQcS106WIZqoDd9t4rMqtyz6JjEcwRF9gWa8GM0K/y4CP3etxwTdvCw2OgNqh+tpIt
         B39w==
X-Gm-Message-State: AOAM530BwQejLonpSiQcWMXPEoncJfVW+QyYSDPkdP5FwzfE5OKQyx+B
        oo/JOB0cXx4jAhlMQJkZ3kOSblpv0DA=
X-Google-Smtp-Source: ABdhPJwzDeHtKdP3PXtnsMKmxAMkDHY5EvZC5ENlz2ZymtFTPknHp3YqT/ZNjxC75oRckm3skf/7JQ==
X-Received: by 2002:a05:6602:15c3:: with SMTP id f3mr16571701iow.25.1598516583691;
        Thu, 27 Aug 2020 01:23:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n15sm816553ioc.15.2020.08.27.01.23.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 01:23:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/5] add "git worktree repair" command
Date:   Thu, 27 Aug 2020 04:21:24 -0400
Message-Id: <20200827082129.56149-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.461.g40977abb40
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of this patch series is twofold.

First, it adds a "git worktree repair" command to help users recover
from situations in which worktree administrative files can become
outdated or corrupted due to external factors. Simple examples include
(1) the user moving a worktree manually rather than via "git worktree
move" which causes the main worktree (or bare repository) to lose track
of the worktree, and (2) moving the main worktree (or bare repository)
which results in linked worktrees being unable to find the repository.

Second, it fixes two bugs with "git init --separate-git-dir" when linked
worktrees are involved (reported by [1]), both of which cause worktree
administrative files to become outdated or corrupted.

An intentional side-effect of the --separate-git-dir fix in patch [5/5]
is that it closes an additional loophole not covered by [2] which made
it illegal to use --separate-git-dir in conjunction with bare
repositories. Peff is Cc:'d because he commented on that thread.

[1]: https://lore.kernel.org/git/CAHbriek39i9NSHRw6DZm0dftk-GkeAYR74c0xyss0vbeDHu1Hw@mail.gmail.com/T/
[2]: https://lore.kernel.org/git/20200809225316.19503-1-sunshine@sunshineco.com/T/

Eric Sunshine (5):
  worktree: add skeleton "repair" command
  worktree: teach "repair" to fix worktree back-links to main worktree
  worktree: teach "repair" to fix outgoing links to worktrees
  init: teach --separate-git-dir to repair linked worktrees
  init: make --separate-git-dir work from within linked worktree

 Documentation/git-worktree.txt |  26 ++++-
 builtin/init-db.c              |  26 +++++
 builtin/worktree.c             |  29 ++++++
 t/t0001-init.sh                |  28 ++++++
 t/t2406-worktree-repair.sh     | 169 +++++++++++++++++++++++++++++++++
 worktree.c                     | 127 +++++++++++++++++++++++++
 worktree.h                     |  22 +++++
 7 files changed, 425 insertions(+), 2 deletions(-)
 create mode 100755 t/t2406-worktree-repair.sh

-- 
2.28.0.461.g40977abb40

