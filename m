Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED4CCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiGSOKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbiGSOKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:10:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45356550BF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:28:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g4so13493151pgc.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFK/cTTjkDsw+iOku7akQMjz8Q8xoDc+IgP2Lz6+J3U=;
        b=nUiSHm2py1a2jUb/mZGSkAUhfofihJb7U9RrxZAzb6AHXfWTHXc9yWKcVnb9Ky8enl
         TCuYxIRzh5RQm326/xo2ybTvG9aTDagnxa0R/lNyslNQMHJE/QH7rzRWqX6kW85auz7D
         Sn6IhgiUq4CQqn0PFlHEayX3Cr8c/uM+sUfLSiO4CyV/gIU386m0dwjrHIf0NmB+viI+
         aY2RiPClx0ZztZSzUhwQsabB8qZx2sdpvC2O2KrNxOc681NzGoxIWI7nVJWNJ9Kqc1px
         VTCCM65EZeR6piMywREXt1tZrGJtiMHYT57UpRsavbPJXQnreZ7leOUljQpUlAU8XZ//
         NzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFK/cTTjkDsw+iOku7akQMjz8Q8xoDc+IgP2Lz6+J3U=;
        b=equWGSwMybYimdVHvR0ybiQ2SYDKR4glHwhAdkgZxAYhl7WjSEyHUTI/WRKgP3Mxb5
         cMGmdN6gnmrZOBElejpvlgQU0HzgB6w/3stHa7lkuLItRSzCWtQiTN6vGUnP32RkX7gx
         GRNXNkCCSZHoYrnKmlGfvcSQ2WrmzUOK5wOQ+Yt9AhD4IThoZjMlaQ5iPW4LCCvr1EzL
         iqxpvZpUUJkXgzN3L26UVGMgpX6RkckobWS8rd/eD7Q0NcwDW+6DFftt6b1ES30ynRIW
         dQFFQT06s9NcBN6Czf5Mhbvwz/HlMnI8tVWTGkQQNhJCnu5nC4pjBB3kFR7B6P6kot+z
         RtHA==
X-Gm-Message-State: AJIora+DNOWfCmvEy1r6my4UtOClsSiieZFW2BMmntyb3bkkGUKie7WM
        G27q5Bp0GEi5Ey4VY63cVVrWL5qC3sM4FKtV
X-Google-Smtp-Source: AGRyM1sBLgCgsKytes7k/9dZQGnhK2OfoOVn3P/8Ym6Y/s0CpWwwIyifnCmHXdP7RgrvmigW20eUig==
X-Received: by 2002:aa7:88d2:0:b0:525:92bb:cb3c with SMTP id k18-20020aa788d2000000b0052592bbcb3cmr34001661pff.2.1658237333233;
        Tue, 19 Jul 2022 06:28:53 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.227.243])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b0016be834d544sm624424pls.237.2022.07.19.06.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:28:52 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 0/7] mv: from in-cone to out-of-cone
Date:   Tue, 19 Jul 2022 21:28:02 +0800
Message-Id: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a sister series to the previous "from out-of-cone to in-cone" [1]
series. This series is trying to make the opposite operation possible for
'mv', namely move <source>, which is in-cone, to <destination>, which is
out-of-cone.

Other than the main task, there are also some minor fixes done.

[1] https://lore.kernel.org/git/20220331091755.385961-1-shaoxuan.yuan02@gmail.com/

Shaoxuan Yuan (7):
  t7002: add tests for moving from in-cone to out-of-cone
  mv: add documentation for check_dir_in_index()
  mv: free the *with_slash in check_dir_in_index()
  mv: check if <destination> is a SKIP_WORKTREE_DIR
  mv: remove BOTH from enum update_mode
  mv: from in-cone to out-of-cone
  mv: check overwrite for in-to-out move

 advice.c                      |  19 +++++
 advice.h                      |   1 +
 builtin/mv.c                  | 100 +++++++++++++++++++----
 t/t7002-mv-sparse-checkout.sh | 148 +++++++++++++++++++++++++++++++++-
 4 files changed, 250 insertions(+), 18 deletions(-)


base-commit: 71a8fab31b70c417e8f5b5f716581f89955a7082
-- 
2.37.0

