Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43046C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A616138C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 11:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFELmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 07:42:39 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:35461 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFELmi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 07:42:38 -0400
Received: by mail-pj1-f45.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso2367138pjb.0
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqUSJZ1a7Dz9Zf2Kn4Pbyqu8k2+53/xziiw0KEL+f34=;
        b=mtJwv9k5Ghzf7oNSfrCSQy5pA2/Czx5MmafaGyBVr94TuM6JsO1FChGm7Xbyt9qeJd
         EsLlEooKmh+aBuBwJxg31LutKq1+nES+hvCvHrgxjvlgXbTq2v6m9+CuuHfJfe9GpETV
         j8ayHbqtxfaDYkpu1JjtNMixIZnYPhFqpL/MuMF2SyKv7QgW5gVOmmg1Zlt7Q14GyJ6M
         40ZVib9J0RnCrEyXc7HqshV3wNRcbaUg08USfHkzImkNITyyeFPtKGtQSNG5fX5FFAKv
         3KdRhUFi89MBB2+N6zTqVj8QPdpJVM2x2ZwbQ+mcqktbORM6eYja0xkW0oEWxtGMtsSt
         kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqUSJZ1a7Dz9Zf2Kn4Pbyqu8k2+53/xziiw0KEL+f34=;
        b=Bj5dNbEI8aCetvzwqzRVGv9dnkgcDGzml9UBe28Ux+i8Ro1kf0LD3nfB+ynynRUxvn
         MhZCgVKIF3y+b/Ai1xof4jORf11WS4w4wXPkjEeBDZNXY5J+DZFl+CvVKNK7an1T/QAm
         /QuBF6jEbkJ2UhHiHzV6ymsyxjzdmwR8CLYw4Y0gwxHeVryYdMAl8Bk2UnImSBErPlVj
         RfducGFjEzI/6iddv9pXaMU2hqMBdyWfWDgCKa2rQ7SZBgD/1mkk/XfiPosoAyVjepKd
         38tsK+8eBqiGZO2LzrIuaMty7BYuQ2WpGhZvE9JH7Y5n/Pt2TGCyxRwOiZFhdmtYstCa
         ziDA==
X-Gm-Message-State: AOAM533xeFr3/5Nx6AomottWfRdQbaPH3WzhcrfFRpv/aGWTa9c7zth5
        GuTw4UiJm3k6lCnXt9kOCDbd4Skn4HVBPXA3
X-Google-Smtp-Source: ABdhPJxGKqqHD/ImP1si6qH7KYpGc9+uFdEOAGD75yNAsNt7tSrJAWgU27g7BFrYG47GF8qe+9m//Q==
X-Received: by 2002:a17:902:d694:b029:103:ec01:12d5 with SMTP id v20-20020a170902d694b0290103ec0112d5mr8749583ply.19.1622893175466;
        Sat, 05 Jun 2021 04:39:35 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id ig1sm6901594pjb.27.2021.06.05.04.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 04:39:35 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>
Subject: [GSoC] [PATCH 0/2] submodule--helper: introduce subcommands for sh to C conversion
Date:   Sat,  5 Jun 2021 17:09:11 +0530
Message-Id: <20210605113913.29005-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces the `add clone` and `add config`
subcommands in `git submodule--helper` with the goal of converting part
of the shell code in `git-submodule.sh` related to `git submodule add`
into C code.

The first patch [1/2] has already been sent to the mailing list before:
https://lore.kernel.org/git/20210604110524.84326-1-raykar.ath@gmail.com/
No changes have been made to it since then.

Because patch [2/2] depends on changes introduced in [1/2] I am sending
them together as a series.

The eventual goal is to replace all of the shell code with equivalent C
code. Subsequent patches will replace all of shell the code past the
flag parsing of `cmd_add()` into a single call to subcommand
`submodule--helper add` which will make use of the functions introduced
in these two patches.

Link to hosted Git repository for containing these patches:
https://github.com/tfidfwastaken/git/commits/submodule-add-in-c

Atharva Raykar (2):
  submodule--helper: introduce add-clone subcommand
  submodule--helper: introduce add-config subcommand

 builtin/submodule--helper.c | 312 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  66 +-------
 2 files changed, 314 insertions(+), 64 deletions(-)

-- 
2.31.1

