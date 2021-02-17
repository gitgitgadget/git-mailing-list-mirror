Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B73C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1E864E02
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhBQHba (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 02:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhBQHba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 02:31:30 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD138C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:30:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c11so7849133pfp.10
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsjFoPCAURMJQ8J3dpPg3JK7nFHfZOQxMWB5d06q7Ak=;
        b=Wh582M8Iyp6drDbvPH7MPX2GvhKKQxcOdF/+QSmWLGmDTciGHoPq3gFShmVZdbdbnD
         /0fJlNPIZu5dUeg7uRR/Z4oaq/WXaHBfXcdpcQNC8AAGew7g3Dm8BInw/bQY/taHpK4/
         IxcehmNUzOoGva98zEfquJc4jniTG6DIe3FWred22jUanwnTMXxUUxbE5NCQuNtlBmzI
         x/vgaJ2E0VtVHbv4N7WfgkR0LJrbCaGlvNXt4c8SsFm3DYnKsKtQO/0mEB5ehtmAS83W
         2rM4LqerzVEPQvzkZxE6p5jz3IrlaCbHx1ulLJ90INtDI7VpLqeE7z0vjZT+JiE3Yqf+
         cD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsjFoPCAURMJQ8J3dpPg3JK7nFHfZOQxMWB5d06q7Ak=;
        b=hgWYExGqRV8oKiNvdnI1ZHIaT/wFXQ4bf9cv8PAo18vBWBFRStIEvlfAYgdcLDfrAX
         aOUnjpnVloEQUscZUnjZCJPzSfH0LNOsVIh6h301ry3PzKQ0ZcGO0/joI/IsBJ12apLu
         /yUY1jsW2CKS/7oBPD4q3SCPYlwSsugXITqaey9BlsDfzG3gBQwXvBJGG1mrjBLN0Fp0
         hq3PtnikmffYMdeLnvdOOhy14XGE453od8PRvkOaD4Q+yv3cKKqnQRkc/glhp9HZpAKz
         WvVvaNjQAt1+dcWZd78Wz5jlJetrXxsWg02clc5ZpJ/IKEF9jlvnqLZWQYdywc+suCED
         pEgQ==
X-Gm-Message-State: AOAM533x3N+2/A668guQ/zN5on3H9cA6Io0hGoRcK/UpE0Dw2hbAWFtm
        UWofDtxqENFnV9F6UC7DZu0uDWghH1JsSQ==
X-Google-Smtp-Source: ABdhPJwfopNrfsSvLUncXRtmJK7MoWz1W4IAXhsc4OdoQQG2CpXL0j07OnOzy+T4QL2LITA3/Pqz6A==
X-Received: by 2002:a63:1b1b:: with SMTP id b27mr21965088pgb.377.1613547049108;
        Tue, 16 Feb 2021 23:30:49 -0800 (PST)
Received: from localhost.localdomain ([106.201.18.198])
        by smtp.googlemail.com with ESMTPSA id gm3sm1059869pjb.24.2021.02.16.23.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 23:30:48 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH 0/6][Outreachy] commit: Implementation of "amend!" commit
Date:   Wed, 17 Feb 2021 12:59:06 +0530
Message-Id: <20210217072904.16257-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series teaches `git commit --fixup` to create "amend!" commit
as an alternative that works with `git rebase --autosquash`. It allows to
fixup both the content and the commit message of the specified commit.
Here we add two suboptions to the `--fixup`, first `amend` suboption that
creates an "amend!" commit. It takes the staged changes and also allows to
edit the commit message of the commit we are fixing.
Example usuage:
git commit --fixup=amend:<commit>

Secondly, `reword` suboption that creates an empty "amend!" commit i.e it
ignores the staged changes and only allows to reword/edit the commit message
of the commit we are fixing.
Example usuage:
git commit --fixup=reword:<commit>

** This work is rebased on the top of cm/rebase-i-updates.

Link to the related discussions:
https://lore.kernel.org/git/CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com/

Charvi Mendiratta (6):
  sequencer: export subject_length()
  commit: add amend suboption to --fixup to create amend! commit
  commit: add a reword suboption to --fixup
  t7500: add tests for --fixup[amend|reword] options
  t3437: use --fixup with options to create amend! commit
  doc/git-commit: add documentation for fixup[amend|reword] options

 Documentation/git-commit.txt              |  39 +++++--
 Documentation/git-rebase.txt              |  21 ++--
 builtin/commit.c                          |  97 ++++++++++++++++--
 commit.c                                  |  14 +++
 commit.h                                  |   3 +
 sequencer.c                               |  14 ---
 t/t3437-rebase-fixup-options.sh           |  30 +-----
 t/t7500-commit-template-squash-signoff.sh | 118 ++++++++++++++++++++++
 8 files changed, 271 insertions(+), 65 deletions(-)

--
2.29.0.rc1

