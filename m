Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A213C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DDA60FED
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhI0Ale (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhI0Ald (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:41:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD31C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x20so2479421wrg.10
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nyDyDHdlaUbqwumZ8idkuesy7cXnp45esElb0DKlvo=;
        b=DAYxet9xBu/FCoe/qde7oW2qTGtEWk2H8xUr5YTHCN/+sKwmlWVoXYzKRISGq74Awc
         Q7IUXHdVRmdjSeJK9ku9g7eHANvpobI4fQiiE5SEmeOsawyNqyKQwYD1FfpKR7AFzKeo
         ozmulkbgs4KY/SETMhpzamVCKNyK0hYGiRDUnlWDIxFnllpjCUtME82Sd5WGFMxrmOpy
         4nU25Sw8pCtSdEvu/Be+cBe4oKq4nuiPpEIk+6YInLvZoTNcsM6CqtIZ2U7WdfZ82hW4
         lknl85hnm1bv0SYeIzpjYZByZEgl74L+0UeVF5WFZCjwzHKjn0zv0mt8tTc8VpaQ7Aa2
         PmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nyDyDHdlaUbqwumZ8idkuesy7cXnp45esElb0DKlvo=;
        b=nm3xDWPGs8N+geH+QK6wLa+/EXAX5WCGOySEzEDXELAo7mNFjFqGwvc9r+AxEprcam
         BV7WwPbg6hAZlfQwZeCY/mwKaSzGpSBMv0MXvCbaod37YIIb6ysOW5FG2UsB+QCoVZft
         YhaU6/BRvbMePKBHGqVoxb7LfItu7HBkCQ2KwDOWT1ek1s2pbqOcyJDOYrOEfwCgnq+J
         6n8m8G3NzK4RVYROJe/eyJtDYTTtJeZwzmwpdudgl4TcZFLJIT1UOdVx5xNe8NfHjJKO
         lrvC9YRJwUfq3A5TccOq74ckFWGJKdFTT7l7tTROiIOoAecRwt+qWmY6+rDTsmylPToM
         NP6A==
X-Gm-Message-State: AOAM533MFOJL/kq8q6Rzl9f3JzVtXHjlg9hX4GbyAwHZpIyzV2IYrjrG
        KYYpHQHtVOIkT4NModOfmTZSr/nLXEtUzA==
X-Google-Smtp-Source: ABdhPJwazUSoLt/ht85pcbWvAum52LN33ubTswFSqF65J5h/2HSvOXHP/yg4PwQKa+dkYWIhBNamfw==
X-Received: by 2002:a05:600c:3585:: with SMTP id p5mr13514755wmq.88.1632703194991;
        Sun, 26 Sep 2021 17:39:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l26sm19070162wmi.25.2021.09.26.17.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:39:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] Designated initializer cleanup & conversion
Date:   Mon, 27 Sep 2021 02:39:47 +0200
Message-Id: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some of the memory leak fixes I've got queued up the first step is
often to migrate the relevant code to using modern initializer
patterns. I.e. using an *_INIT macro, initializing on the stack not
the heap when possible etc.

I found that for some of those I'd start with a migration to
designated initializers, but if we're doing that we might as well do
(almost) all of them.

This series does /most/ of that, the remaining parts are things that
would conflict with other in-flight changes, i.e. this merges cleanly
with "seen". We can clean up any stray stragglers some other time.

See
https://lore.kernel.org/git/cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com/
for a predecessor series which already landed as bd4232fac33 (Merge
branch 'ab/struct-init', 2021-07-16).

Ævar Arnfjörð Bjarmason (5):
  submodule-config.h: remove unused SUBMODULE_INIT macro
  *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
  *.h _INIT macros: don't specify fields equal to 0
  *.h: move some *_INIT to designated initializers
  cbtree.h: define cb_init() in terms of CBTREE_INIT

 add-interactive.c                             |  8 +++++--
 builtin/submodule--helper.c                   | 21 ++++++++++---------
 cache.h                                       |  4 +++-
 cbtree.h                                      |  5 +++--
 checkout.c                                    |  2 +-
 .../git-credential-gnome-keyring.c            |  2 +-
 .../libsecret/git-credential-libsecret.c      |  2 +-
 diff.c                                        |  4 ++--
 entry.h                                       |  2 +-
 lockfile.h                                    |  2 +-
 object-store.h                                |  2 +-
 object.h                                      |  2 +-
 oid-array.h                                   |  2 +-
 path.h                                        |  5 +----
 ref-filter.c                                  |  2 +-
 remote.c                                      |  2 +-
 revision.c                                    |  2 +-
 sequencer.h                                   |  4 +++-
 shallow.h                                     |  4 +++-
 simple-ipc.h                                  |  6 +-----
 strbuf.h                                      |  2 +-
 strvec.h                                      |  4 +++-
 submodule-config.h                            |  4 ----
 submodule.c                                   |  8 ++++---
 submodule.h                                   |  4 +++-
 t/helper/test-run-command.c                   |  6 ++++--
 transport.h                                   |  4 +++-
 27 files changed, 63 insertions(+), 52 deletions(-)

-- 
2.33.0.1294.g2bdf2798764

