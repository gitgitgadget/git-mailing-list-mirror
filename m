Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC9BC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 15:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjCOPPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjCOPPf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 11:15:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFB23678
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l12so9362681wrm.10
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678893332;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZZo22Pxc2/5yEybW3F8IV/bW/fVlhKz+dbys/q3W3U=;
        b=pJlaLpFd//d1OVL3Lo0rI5njHnQHP627zyVjhWhMXxl2fQXUsIt23zaCCCz3nhi+WL
         Cd9DU2eywJjbukUwuWvUHuLu90QcuZBEZ6xU8YKQ60Tt31GlAaBwV8SKTCt4Lbq/xH98
         kJ9439g3870/CHp80P9e0p3KRSyhHKZLzS/vNxc2OimEIVbdZh+jd+xYBTxCbCCN9C0C
         E8ev9216N/WO0/15YpofwvCT5jBDsjuoIqRF7YLs4L+IepMtDil/+IqvtEAGBgtXbvnG
         cKR7WNoqAE+tBiB512SG2B1YnmGn5p3SWOqDUUTDpfmt6F9q1hTkRnAJaebYxe9oCkAh
         ZYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893332;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZZo22Pxc2/5yEybW3F8IV/bW/fVlhKz+dbys/q3W3U=;
        b=ZbFaMLo0jHOLZjWWNfJjVPvjQFgupMkIDc8PSpLKDTEXNz5ayz3mYZuVOn570bSoTb
         XTUduG7MhvtQc4Zjxb4ax8AIZFom+dSEgyRekLgFnUWwHDUBIDtGPR0LdcfOl7TJmWmR
         TTCJEiB7YE4ilOSYqa6JoSIk8hJPP4puR36LW35tBUZnXzrCfATRe1B1gcPLfsP/Inlb
         8Cg6sERdfzTB3MjzaQJcGt8wfynkYldqWpzdmEylig7bZ+Q1BPiSgyQjBuS5QpB4jigX
         jdK2rWzr9zI0HoXNWgnG0tHztE4MyVkGytprHfbUbFNvoDr023FmSnIChMVQ6st4eFe9
         E/wQ==
X-Gm-Message-State: AO0yUKUCbUSQAZ9CNXOJdZt4sudHjo6ydo5HenQAkB1fzWnoal/A7lgQ
        1HptsgQ1vH7wNlx5C9Mi+Pf0/fUHyYg=
X-Google-Smtp-Source: AK7set/xr4u/obqs224n1GBQCsvnI+hTfw+qE1hoH072UXlys8xYp+bG8u516BcfeEEO3eR328Jo+g==
X-Received: by 2002:a5d:494f:0:b0:2ce:aeab:9be with SMTP id r15-20020a5d494f000000b002ceaeab09bemr2179933wrs.69.1678893332333;
        Wed, 15 Mar 2023 08:15:32 -0700 (PDT)
Received: from localhost.localdomain ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b002c706c754fesm4783191wrv.32.2023.03.15.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:15:31 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/4] rebase: cleanup merge strategy option handling
Date:   Wed, 15 Mar 2023 15:14:55 +0000
Message-Id: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Cleanup the handling of --strategy-option now that we no longer need
to support "--preserve-merges" and properly quote the argument when
saving it to disc.

These patches are based on a merge of 'master' and
'ab/fix-strategy-opts-parsing'

Published-As: https://github.com/phillipwood/git/releases/tag/sequencer-merge-strategy-options%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/c2e329a52...3e02eeff7
Fetch-It-Via: git fetch https://github.com/phillipwood/git sequencer-merge-strategy-options/v1

Phillip Wood (4):
  rebase: stop reading and writing unnecessary strategy state
  rebase -m: cleanup --strategy-option handling
  rebase -m: fix serialization of strategy options
  rebase: remove a couple of redundant strategy tests

 builtin/rebase.c               | 60 +++++++++-----------------------
 sequencer.c                    | 26 ++++++++++----
 sequencer.h                    |  1 -
 t/t3402-rebase-merge.sh        | 21 ------------
 t/t3418-rebase-continue.sh     | 62 +++++++++++-----------------------
 t/t3436-rebase-more-options.sh | 18 ----------
 6 files changed, 56 insertions(+), 132 deletions(-)

-- 
2.39.2

