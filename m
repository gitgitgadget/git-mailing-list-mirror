Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7DEC208BD
	for <e@80x24.org>; Thu, 10 Aug 2017 18:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbdHJSuS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:50:18 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38449 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbdHJSuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:50:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id 123so1260188pga.5
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+25WtxUrGe5GKFmBCYH3eCq6i534c4HiEZt3WnMVhyM=;
        b=T4pUozM8GOUPc/vw70v3y6KhRpYzmTrsFfy4yNTuEGw4eUFWQtcWlAK0Bb8nR9PcYG
         krRlh0fCynPM/dxDEn3rgfZn9W5ZYDtP5PZKyFtSQFHDo+EDoVyElDYHgVDz63azCl96
         r7Yvc0c1EgNbsMlU5z8sT9HUdW/gFBDaCpQGtArfb/dpV4XoOx9954x17LWezDIsIsVY
         JeqPRAV5BDvuXaABA4Y0vsJ8mlBPfqVbE88mH3LCib17Fmqba9pHt8tJSENmS6oMObn9
         PBgXqY23XL45/bBheD2xmUG+uZwyz7GhQtXUm39w36FCNAhUvYL/WBsUOvHDR1v2iWK7
         M3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+25WtxUrGe5GKFmBCYH3eCq6i534c4HiEZt3WnMVhyM=;
        b=etOAEA4zgKavA4DQe32aQWwfK3wCaBAb6F/dEYzcNdEB0D9mMM3rLNqejKhGyXvqmc
         DQLWKF2LkbvCoFv5XDnvcV74MbE053OcaDVnq44ibvJRZXtQdy01e2opagmalOTcT9Ls
         xpEeHryY4pFykK+psmFZpuUhr7GDIKZXXyDneP/TfUeoLmsPSHgX1tydQ454mBb204kA
         DcajMmV9SJqCm15TBtJjEbyI/UH2nxs2CKYHYu92hehDWKGg9+3TuWYKGJc2ugSb7Uo5
         ex+Icp5jO2t/j/zisHFPFxZCDP4DQXXH9ifcPT/4aj5wRV/gI4otGGhOB1cx9d/Me9WH
         E2MA==
X-Gm-Message-State: AHYfb5iC0Gq77LB7LgRbA30OXyRYM0w9rTjvGglpj0VHPml/LDNiI4ru
        PydL0ENPF7KQug0DyGaLxA==
X-Received: by 10.84.211.150 with SMTP id c22mr14452803pli.372.1502391016949;
        Thu, 10 Aug 2017 11:50:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010:1::162])
        by smtp.gmail.com with ESMTPSA id j63sm7498299pge.88.2017.08.10.11.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 11:50:16 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, bmwill@google.com, gitster@pobox.com,
        peff@peff.net, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v1 0/1] Teach status to show ignored directories
Date:   Thu, 10 Aug 2017 14:49:35 -0400
Message-Id: <20170810184936.239542-1-jamill@microsoft.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our application (Visual Studio) needs to run git status with options
to report untracked and ignored files. It needs all untracked files
reported individually, but would rather not have all individual
ignored files under explicitly ignored directories
reported. Directories that match an ignore pattern should be reported,
instead of all contained files.

It is not possible to get this output with the current arguments
available to git status. You can get ignored files (--ignored), all
untracked files (--untracked-files=all), but if you specify both
options then you will also get all individual ignored files.

This change is to add the option to have git status report all
untracked files while also reporting directories that match an ignore
pattern. The logic in dir.c was also modified to not iterate over all
files in an ignored directory. This change resulted in a performance
improvement in work directories with a large number of files contained
in ignored directories.  For example, this setup is present when bin
and obj directories are contained in the repository work dir.

Jameson Miller (1):
  dir: teach status to show ignored directories

 Documentation/git-status.txt                      |   5 +
 Documentation/technical/api-directory-listing.txt |   6 +
 builtin/commit.c                                  |   4 +
 dir.c                                             |  48 +++++-
 dir.h                                             |   3 +-
 t/t7519-status-show-ignored-directory.sh          | 189 ++++++++++++++++++++++
 wt-status.c                                       |   4 +
 wt-status.h                                       |   1 +
 8 files changed, 253 insertions(+), 7 deletions(-)
 create mode 100755 t/t7519-status-show-ignored-directory.sh

-- 
2.11.0

