Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08C1C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 07:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbiETHYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346410AbiETHYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 03:24:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332514ACB8
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:24:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h5so9113456wrb.11
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62LHopTH5Ei2jtHOuBIhMLgwmJJx5YtQPPGStK/wz5o=;
        b=T1mKyXAGgtON1p/YdfDQCNGDxzgdBckJ35zZCzhRpbo2QwQl69MjqK+4Moetp96rVg
         fLxRELE+kRGOa/gxEWEJm6VO1cZ5JAzzf+aKb+6Cb8oRt1WD27x6i7oEtX8F9auJ8AJN
         3wBracLBjpcHoPMfLEAw0M+T6ZolsLJdTr6eOujqHFIJNN0KU/BZqUnlL2zhnGDOahyZ
         gyNiHcnOWQj3BizRFKjlz54MDv7RWgvC5Hixxup1gjnt5z/XzNesAv9TqzsxiZAwVo3C
         jYBOzDocfW6tTmA/0S0xSlJH6PCaiCSZYMJP4QbQqPWO2qXqIbEXLRrpyX5D/NB4F9VU
         HScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62LHopTH5Ei2jtHOuBIhMLgwmJJx5YtQPPGStK/wz5o=;
        b=3m18L6sZRBCBUpa/Ya3oljrDSi8gteqk0KmDoIDbhXqoOr83qHvrLBdBTc+Rep46MY
         d8sprsi9LWfvYDHIZq9oEj2elHgKutb/BslPg1UZy4RFtOkhg7BnzocfqVZsm36cLvNT
         UmCookHG8Ic5qxHNRvVExrkj502/1Wywd/ypCe24KYPRIxH8caOfd11VXyIt6h8iAeBg
         7rw3uDh/Tfsez+1E1MF8p3B7j8rmWnhLN17vQ2bV2BHXZJEJpE9VJ9+dIi0hhPqN14Db
         2RKvC/sVjPGnbfEsBf3+sbg3DiFEhgVqGEAphVVSHYBBTVvEF52Eemb1bKUtM4JLgXwr
         Jy/g==
X-Gm-Message-State: AOAM532Jv6lzNlue6Ny7pq1LLR80jOqv7DpiBrhLJf3saEsLSt2M7sZp
        Y05kODXbmiudo+ifJFoaDIt5Hb4U3S8rLg==
X-Google-Smtp-Source: ABdhPJzVlzG7hrlKq22Gxei2TGdEPwBJzAhcsqxdeP7KtE/HaEFNaZoCFA3X++Ns7IfqSpzya+WOFA==
X-Received: by 2002:adf:e70a:0:b0:20d:e3e:f79f with SMTP id c10-20020adfe70a000000b0020d0e3ef79fmr7163314wrm.105.1653031487751;
        Fri, 20 May 2022 00:24:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16-20020adfa2d0000000b0020d0a070c80sm1668429wra.35.2022.05.20.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:24:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] run-command.h: rename "env_array" to "env"
Date:   Fri, 20 May 2022 09:24:38 +0200
Message-Id: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.957.g2c13267e09b
In-Reply-To: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up 32ec72c3e1 (Merge branch 'ab/run-command', 2021-12-15) and
rename the "env_array" member to simply "env" in the "struct
child_process".

Changes since v1:

 * Added a commit to remove the coccinelle rule after its application,
   as suggested by Junio in
   https://lore.kernel.org/git/xmqqzgjdkxon.fsf@gitster.g/

 * Minor commit rewording for 4/4 to adjust for that new 3/4.

Ævar Arnfjörð Bjarmason (4):
  cocci: add a rename of "struct child_process"'s "env_array" to "env"
  run-command API: rename "env_array" to "env"
  cocci: remove env_array -> env migration
  run-command API users: use "env" not "env_array" in comments & names

 add-patch.c                 |  2 +-
 branch.c                    |  2 +-
 builtin/difftool.c          |  6 ++---
 builtin/receive-pack.c      | 32 +++++++++++++--------------
 builtin/stash.c             | 16 +++++++-------
 builtin/submodule--helper.c | 44 ++++++++++++++++++-------------------
 builtin/worktree.c          |  8 +++----
 connect.c                   |  9 ++++----
 connected.c                 |  2 +-
 daemon.c                    | 14 ++++++------
 editor.c                    |  2 +-
 hook.c                      |  2 +-
 http-backend.c              |  4 ++--
 object-file.c               |  2 +-
 pager.c                     |  4 ++--
 promisor-remote.c           |  2 +-
 run-command.c               | 19 ++++++++--------
 run-command.h               | 14 ++++++------
 sequencer.c                 | 18 +++++++--------
 submodule.c                 | 38 ++++++++++++++++----------------
 submodule.h                 |  4 ++--
 t/helper/test-run-command.c |  2 +-
 trailer.c                   |  2 +-
 transport-helper.c          |  2 +-
 wt-status.c                 |  2 +-
 25 files changed, 127 insertions(+), 125 deletions(-)

Range-diff against v1:
1:  b943ed5d5b7 = 1:  e3f33fce566 cocci: add a rename of "struct child_process"'s "env_array" to "env"
2:  51063a31b16 = 2:  5aeb6ec9117 run-command API: rename "env_array" to "env"
-:  ----------- > 3:  ca09da570ef cocci: remove env_array -> env migration
3:  8af76f39b9f ! 4:  5419f839c74 run-command API users: use "env" not "env_array" in comments & names
    @@ Metadata
      ## Commit message ##
         run-command API users: use "env" not "env_array" in comments & names
     
    -    Follow-up on the preceding commit which changed all references to the
    +    Follow-up on a preceding commit which changed all references to the
         "env_array" when referring to the "struct child_process" member. These
         changes are all unnecessary for the compiler, but help the code's
         human readers.
-- 
2.36.1.957.g2c13267e09b

