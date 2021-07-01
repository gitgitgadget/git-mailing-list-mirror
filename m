Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01DAC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91ABA6140A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhGAKyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGAKyF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 06:54:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68104C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 03:51:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t15so4261597wry.11
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcDtfArWhAeIMMDaRbRteyE0izCtX3TrsO7qxLls4hw=;
        b=aJyEyHKcXyGlHN0HOmoptveDifooNavW7VdE75q18l7EZYBbaSFBBeEsda0x3JXiZ1
         Dqw45UY0lpzfsKBkr3MIqHEMKa28LIQnCvgJEKcX/FkB96iciX2XzdkzbU28pRXwa4qW
         NtKRTPEmHfnjkY1H1fCpmVXai64p9StRTq0ZIZ2OO3o2EN3nO0Vs3QtEIfnytdtQnVJs
         /TQhxmyhQMb7xjsP/bgpoutd6aftXlZzQQwi3BcPbUw3yEC9/pNtf3AdMCn52z3D2HHQ
         9gbSpWyXjZnFfFFDRAUhLjPqa3L9Y+CGAo0tYPiyNJn5Nme4/Gik74rqVhNlWbWm9GQi
         vC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcDtfArWhAeIMMDaRbRteyE0izCtX3TrsO7qxLls4hw=;
        b=AJ95PA7hfKqkezrcvDcgbq+p84C/PXu2+TKWnLnx0m5k8e+TICr5/SwepTBR4H8552
         xr1wtN2TTDvV+rnl50BMKxBzwd5okpdbxSJW11tLW7s9WRaANFn2QDNkTiRKGjU/5/uT
         jNHUoTI465y5wI8uQxsAyOahALOIhb/J9lW25L1xQBuNRgDgyPPqSnjkuxzZBIAne6YZ
         52P9P6fhG7D1wk6viFdN/hPZJ6dkXizFTFtkqx4c6bzWl4Z5oqVm1gakmU8CoupmMYH6
         YBN+KY1mHYS252dE+rHEPHJo1JFG/D/NxX9HIg1mvRXtMLspA6KYHOIRto3SkKzyd+nl
         30FQ==
X-Gm-Message-State: AOAM530UynAnUQE8TpwGZPk7hsBhEIMqoatsNUmUURMpO19pTWE+wXJp
        sbBzLksZxf3Qh8FWI2V02SWkHzapVI7RfA==
X-Google-Smtp-Source: ABdhPJwowoUI+rN8WFBWL63Lsjly5ZArjrrBtAU0vu4ikTi4W0VohOcODaYV4HVYtdFQgjSr6h8l6w==
X-Received: by 2002:adf:ef87:: with SMTP id d7mr11289542wro.204.1625136693776;
        Thu, 01 Jul 2021 03:51:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9sm8015699wmm.17.2021.07.01.03.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:51:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] *.[ch]: don't duplicate *_init() and *_INIT logic
Date:   Thu,  1 Jul 2021 12:51:24 +0200
Message-Id: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g11c1df94a06
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series implements a suggestion by Jeff King to use an idiom for
*_init() functions that avoids duplicating what we've declared in the
corresponding *_INIT macros. See
https://lore.kernel.org/git/YNytp0JAIaQih0Y4@coredump.intra.peff.net/

Ævar Arnfjörð Bjarmason (5):
  *.h: move some *_INIT to designated initializers
  *.c *_init(): define in terms of corresponding *_INIT macro
  dir.[ch]: replace dir_init() with DIR_INIT
  string-list.[ch]: add a string_list_init_{nodup,dup}()
  string-list.h users: change to use *_{nodup,dup}()

 apply.c                |  6 +++---
 archive.c              |  2 +-
 builtin/add.c          |  3 +--
 builtin/check-ignore.c |  3 +--
 builtin/clean.c        |  6 ++----
 builtin/grep.c         |  3 +--
 builtin/ls-files.c     |  3 +--
 builtin/stash.c        |  3 +--
 config.c               |  2 +-
 credential.c           |  4 ++--
 credential.h           |  4 +++-
 dir.c                  |  9 ++-------
 dir.h                  |  4 ++--
 entry.c                |  4 ++--
 json-writer.c          |  6 ++----
 json-writer.h          |  5 ++++-
 merge-ort.c            |  4 ++--
 merge-recursive.c      |  4 ++--
 merge.c                |  3 +--
 refs/packed-backend.c  |  2 +-
 run-command.c          |  5 ++---
 run-command.h          |  5 ++++-
 strbuf.c               |  4 ++--
 string-list.c          | 18 ++++++++++++++++--
 string-list.h          | 15 +++++++++++----
 strmap.c               |  3 ++-
 strvec.c               |  5 ++---
 transport.c            |  2 +-
 wt-status.c            |  3 +--
 29 files changed, 76 insertions(+), 64 deletions(-)

-- 
2.32.0.623.ge833f40cd87

