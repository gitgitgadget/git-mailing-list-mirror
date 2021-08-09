Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C3CC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 06:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BDE61052
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 06:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhHIGah (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 02:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbhHIGah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 02:30:37 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B529C0613CF
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 23:30:16 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d2so11701718qto.6
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPQnKW3U7KhLtozdy9G4ru8xa7lfQgDPihR6z+Smaf0=;
        b=sNtvEYoriC2HnuZ+v+L5wEIBHIPNktimxGI+NlHvkRGUAk6GfM+2MUieAoqUA4TAIP
         sbYj4vrzt5TiuUH4aWh574VoQGjoPE6KJQ1WafXc9bhTsMJJ3OrXJEryh1IpU5e1R4XE
         NeT7pjo6j/UpHi8lWUkNN2KXKtUzpqDwKZIsyRkDDZgndLEvwOQo46fZ3L03NHQ+icxP
         bJe/XcKj5l7S1s4W3WEF0R4pmgca+jnxeOqcfI7NrI1ZdevSJuemLgul5EdvE7bMac99
         Z0YGzLW53WKmnKEMcZKJcInPI5drMXp5x2RCUx3YpbuqNB97+FuloozEJW7op0mIDAM0
         uK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPQnKW3U7KhLtozdy9G4ru8xa7lfQgDPihR6z+Smaf0=;
        b=G8Gs8iQpdV4BZZguUR72Y3r4GB++1FFjjSLfu/ZghiF6Bs6QwM6Vpfc0rFkbVx5hWg
         /dUsatrkpR8M73aWRB33sZs7BHZlKQzvzskhhnFh3MOpADR/Z7jzA7UEpz0b5kTATgky
         jE5LwEqv1IDFMjgrtnMUhdAaGf9jxIfr0bdKoT422djEhpzgyUgXIcjL9bDpJI0u+GsI
         UbEOML0UYpu+0tNnVXpuTgOO3/xhWEKW/eHqksX7ULPapqgMhhI/JDpmDSAfHseoyBm5
         Thk5mDuaDQKU3qSxfeT6kU3S1V1nFjR1HpL/zXnM7xnIG6abCPGVhPniilZqp7od8XGA
         TOUA==
X-Gm-Message-State: AOAM532yhMdGBIiYR8QJTuh7THE2fSNzTh8INtdqCtB89nqhXifbjr51
        ujPOtKCxvnrIl+s6XDsNnmrFRLfep3A=
X-Google-Smtp-Source: ABdhPJylMf2gvD4T0AITHpsVnHIpQEojWZuuVTIdUEpExy0B99TUeTv8l89ah+KKqCQZonMYV+w9ag==
X-Received: by 2002:a05:622a:310:: with SMTP id q16mr18766111qtw.168.1628490614974;
        Sun, 08 Aug 2021 23:30:14 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 10sm1239994qkv.135.2021.08.08.23.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Aug 2021 23:30:14 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
Date:   Sun,  8 Aug 2021 23:30:02 -0700
Message-Id: <20210809063004.73736-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

seen with both clang 12 and gcc 11 in seen (including jh/builtin-fsmonitor)
as of a5a42b9f76 (from Jul 1)

it should be squashed into the corresponding patch from the series as shown
in the subject and reroll IMHO; notice Junio also has some bandaid sparse
fixes for t/helper/test-touch.c that should be included.

a similar additional fix for C89 compatibility to be send as a reply later

Carlo Marcelo Arenas Belón (2):
  fixup! fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  fixup! fsmonitor--daemon: implement handle_client callback

 builtin/fsmonitor--daemon.c | 2 +-
 fsmonitor-ipc.h             | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.33.0.rc1.373.gc715f1a457

