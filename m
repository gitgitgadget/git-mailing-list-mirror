Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F16C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1480610A8
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhJVI6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhJVI6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50641C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e12so2837436wra.4
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cl2OTstRwVBueHuC1bszwAhHlHQ95Ug+QXtyu6OiplQ=;
        b=jIPKNi2NhmlVR6HzezuHpMeKax9WlX4n7HkkC1TR3Yo3xXkMf/z7qjxhClJSl2pOOX
         3xCWGM3Kf5K2Rh9fmQXroUnd8AxmT4lzXK22T23+cdmkhWMaA+Al4ihAfi2WgcB9TXlD
         /PGZj0TeMtJPBqtaOXl2S8J6y616XipzjiZNLEljswB4AVtSgYU8Invh50PQT2MCfrTF
         9Z/B/l7MeDMUFNMj07+18o5vaUpcRul731Rv84pPqvH3EInID8dUvHpDukyZqO9d8EUC
         xXofPC6fG6/yCdN8z5qir+gPF3nncAEsjiXrgG0YZoc4tPUQ44kioVxjsx2LpfElNfNW
         gyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cl2OTstRwVBueHuC1bszwAhHlHQ95Ug+QXtyu6OiplQ=;
        b=R7GYNm00cxoDJbnBBps7n2ybTSX4LL3+IJ2eAQMXFTVh0L8pdR9h/12tEZCybLvfkA
         H2j9FZUNT7kagANxGYfP2HWo891tE21+PbNPyCpSwNi9ysqCfLo/Xd/0KzRbG7jP8R4y
         kujEQ9yE34m+CiM+bLW2tK0x0sxzYPAp3JjhbKQzLy1fkt3XeNhBheGO+FidIUTVezjC
         NecK6xsh64ZeOLq6FHbOeI6hSSBO78prWB6dD6wqwEuzGUT2a2JwAPQhe+Zqb5F7mHpo
         wx2nss2HK4gI5UNN06KwVAs6Y1ptedlBDCjG1SA9aAhCpJEJ09G3TafFQC4i8BpoxMX2
         5UAA==
X-Gm-Message-State: AOAM5336e95enuvNwFzO50A1c58Lwu9OUzHKg1zFHfMHTxijWrL+dUzu
        KM2KF92wnBzfQ/WyAgPIO8CjNpBvoa+N3Q==
X-Google-Smtp-Source: ABdhPJy+nIN/a5Lp5fXna+/mHE8aWXbjN/0TT7qGnWESnvd4pFpoYBIreId0p6dhW6o8GvhZtqCSPQ==
X-Received: by 2002:adf:ee8a:: with SMTP id b10mr14657430wro.335.1634892948625;
        Fri, 22 Oct 2021 01:55:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm10609069wmj.9.2021.10.22.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:55:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] leaks: miscellaneous small leak fixes
Date:   Fri, 22 Oct 2021 10:55:38 +0200
Message-Id: <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of these miscellaneous small leak fixes to a address
comments on v1. I ejected the patch that conflicted with Taylor's
version (sorry, didn't notice it), and fixed an additional leak in
grep.c pointed out by Junio. Doing that allowed us to mark a test as
passing under SANITIZE=leak, with only the minor change of replacing a
"git checkout" with "git reset --hard" (as "checkout" happens to leak
currently, but I've also got a pending patch for that).

Ævar Arnfjörð Bjarmason (6):
  grep: prefer "struct grep_opt" over its "void *" equivalent
  grep: use object_array_clear() in cmd_grep()
  grep: fix a "path_list" memory leak
  clone: fix a memory leak of the "git_dir" variable
  submodule--helper: fix small memory leaks
  reflog: free() ref given to us by dwim_log()

 builtin/clone.c             |  4 +++-
 builtin/grep.c              | 14 ++++++++------
 builtin/reflog.c            |  1 +
 builtin/submodule--helper.c |  2 ++
 t/t7811-grep-open.sh        |  3 ++-
 5 files changed, 16 insertions(+), 8 deletions(-)

Range-diff against v1:
1:  2bdd21e4e59 ! 1:  66c838fd800 grep: prefer "struct grep_opt" over its "void *"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    grep: prefer "struct grep_opt" over its "void *"
    +    grep: prefer "struct grep_opt" over its "void *" equivalent
     
         Stylistically fix up code added in bfac23d9534 (grep: Fix two memory
         leaks, 2010-01-30). We usually don't use the "arg" at all once we've
    -    unpacked it into the struct we want, let's not do that here when we're
    +    casted it to the struct we want, let's not do that here when we're
         freeing it. Perhaps it was thought that a cast to "void *" would
         otherwise be needed?
     
2:  727fdb27a2a = 2:  033ca3f7b4f grep: use object_array_clear() in cmd_grep()
-:  ----------- > 3:  8e941e40711 grep: fix a "path_list" memory leak
3:  86d928ae2f9 = 4:  0d0e6359cf4 clone: fix a memory leak of the "git_dir" variable
4:  9c3c0529ad0 = 5:  a529c04a29a submodule--helper: fix small memory leaks
5:  85b7b7aef37 = 6:  6ea5e611ae0 reflog: free() ref given to us by dwim_log()
6:  526d5649156 < -:  ----------- repack: stop leaking a "struct child_process"
-- 
2.33.1.1494.g88b39a443e1

