Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A57CC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D2761A7F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353608AbhJAKjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJAKjj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:39:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79625C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:37:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j10-20020a1c230a000000b0030d523b6693so291911wmj.2
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOSxsOiUZe8Zie+WrcfVs4LCW+XdvrzCVamdaJtdpDQ=;
        b=Epws8uoUN3AaZBliQAAqPWwz6UgsdXskhKjC16t5YBW8Ig7uBGC9zJ+cOE6LguvcS4
         mmRtQG8p4EadpPkWvhe+8Mwqrt9uH9xR5htWQSZ3zO9R9W9cu+LjRx8s2lRlk68H5CB8
         jsviSUNEmqtka2hLwdv/+vT6h3cu2ohQBj8QqsASZUa4x2QbRHTY/QsxWzB8/vtIXxJ5
         x+cMvC61LDBvKRd29frUFa6QkVBSrqfadGKeMxYnEnVUqcqP9gwE+WwFTxwSrQ6pkM0q
         wbuLM3hl3/VQSA/nCKtBLZr0Le1XvDwovAw8H1u2Z/bC55ehxya6oYfVEdwIPKtfQAK4
         5Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOSxsOiUZe8Zie+WrcfVs4LCW+XdvrzCVamdaJtdpDQ=;
        b=cn0Zf7yCgS4zLu0xySv+aW6aaFJuc9KPfByo44JtnZNXHtwbIfjA7cbl6oqxCoccBj
         pPdTtfmlqdzQSrfSfIIV24W8MANTf6Tcogu0diV5HBUyNmKrHbg7UL3sodfxexgtqYi2
         mkh4z1NUoibYF2fUTF+vXRmDoimzN61dHSNy4HxI0mHJ657sCq7HISBRjueD/Vng9gJI
         Y4x+wRcDmuvsdEvR7EpdOMiDZ7iCKdYm4jJCGfXfZWh3AZBfV+iSxijOCgJe5pDGRzSw
         Xa8gLf/8xoAtPyUc94NMHz6N1u7pVh+flPW8IOzds64ktwzjrkBAV6LNZweq+G6PSg+e
         C0eA==
X-Gm-Message-State: AOAM530hD4h+0zqFV7jUKyyMA+ehMg1k0xNiJxdH2zxLx20FlBJANCFW
        Jkwc9XRLqGJXuDn4UDlsdj4VA9v+VqBm4g==
X-Google-Smtp-Source: ABdhPJzzN9QVk/8nwYcbOfWLpGOwX6iCJ8CyoIslr1weqWodpIZq0bbU7fWKf/4LilUXAjq8HjBLdA==
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr3744107wmq.16.1633084673880;
        Fri, 01 Oct 2021 03:37:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm7235586wmr.32.2021.10.01.03.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:37:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] *.h: remove dead function declarations
Date:   Fri,  1 Oct 2021 12:37:39 +0200
Message-Id: <cover-0.4-00000000000-20210928T125228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial series to remove some long-dead code, the oldest is
something we've been carrying since 2006!

Ævar Arnfjörð Bjarmason (4):
  builtin.h: remove cmd_tar_tree() declaration
  grep.h: remove unused grep_threads_ok() declaration
  log-tree.h: remove unused function declarations
  config.h: remove unused git_config_get_untracked_cache() declaration

 builtin.h  | 1 -
 config.h   | 1 -
 grep.h     | 1 -
 log-tree.h | 2 --
 4 files changed, 5 deletions(-)

-- 
2.33.0.1340.ge9f77250f2b

