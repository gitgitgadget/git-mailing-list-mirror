Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B458C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0F020848
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+sYmLaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbgCDLeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:34:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37987 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCDLeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:34:02 -0500
Received: by mail-pj1-f65.google.com with SMTP id a16so820446pju.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7hi6LMetYmM6N5XcFPGnhPGxEY2OXcAPiB/8zn4WMw=;
        b=g+sYmLaPPeQ8dRFL3tIVWLzB05OZF0ZEHVUoJkiYPiJy6hxZbBjipB+D44PQAuE1lv
         iRkUodDah/eTZ7NkMVl+CvYjgrT0yklsNVV9pU2qQVefdVJ+VGDlEWew0rMUztLpf4ln
         vxM1b0WF88XhpLWdgJ9Sxx7ydvrOS1QjoC2Ny7u0Kk/v4/3Az4Z68Kf+RSxzRRwzHi+y
         csp4s7exPwJQDgF234iFCKbN9WYkIWcXOnzhh2q3ln5luT9q6pvADPQvvxtRThNhJlT2
         KNXt2uC35/CO24jp8ZWbAoNss4wsC/04G72FHQjdUQM89P/8oxChdO8YjGBIxJfHsduY
         WuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7hi6LMetYmM6N5XcFPGnhPGxEY2OXcAPiB/8zn4WMw=;
        b=Q4fwmqRCYvjIFG5gdOHCNO2ZA4kWEaykBHfLSV0WgKnGRhklIa9Z9CdcE9uXF2UcQm
         MNOU8UWvmUjzgVJq3f1AXZKZhTa/+A00iBczD6Nz7AKficfu126tTar7P0l87khGtOTh
         oQ4/wCoEhOfq4bhVnpuQVfH3mh5C2HJDw11Chv5eMa9N5P6hm6ALOkhQaeakL/tdTRo/
         oeP/ON/eKgg1+hPD/VdMwLv8gIjiJyOaWG6NEc+hbGmecH/IfcBZP2yYeynmlRnqSIT0
         BCpxXnoDf4Pq96dFAZZALKCNpoCLeT/CdJsXXpeg7JtLAahuHQo13vkbBAX906yb8rjF
         Z5Tw==
X-Gm-Message-State: ANhLgQ0xZniOQzWqQu87lkVi8t+zheOsGL0bOjD+sipISF+YPtr1bdS7
        1u0Rx7BAaODJkDiyPSMM7WTI5BzkxnWhPw==
X-Google-Smtp-Source: ADFU+vtgHalCMQPtu921QSzN9/zu1t18s5eX7s4MFTiwtjSqQqGzlfuuLGRtC0DXGFvP22JLYNdGPQ==
X-Received: by 2002:a17:902:8308:: with SMTP id bd8mr2740394plb.210.1583321640628;
        Wed, 04 Mar 2020 03:34:00 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id d77sm15350050pfd.109.2020.03.04.03.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:33:59 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] New execute-commands hook for centralized workflow
Date:   Wed,  4 Mar 2020 19:33:05 +0800
Message-Id: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my planned speech at the Git Merge 2020 conference, this series of
patches is a core part of AGit-Flow (a centralized workflow like
Gerrit). Due to a coronavirus outbreak in China, I was unable to attend
the meeting. I wrote a blog "AGit-Flow and git-repo" based on my planned
speech, see:

    https://git-repo.info/en/2020/03/agit-flow-and-git-repo/ 

Git calls an internal `execute_commands` function to handle commands
sent from the client to `git-receive-pack`.  Regardless of what
references the user pushes, git creates or updates the corresponding
references if the user has write permission.  A contributor who has
no write permission cannot push to repository directly.  So, the
contributor has to write commits to an alternate location and sends
pull request by emails or by other ways.  We call this distributed
workflow.

It would be more convenient to work in a centralized workflow like what
Gerrit provided for some cases.  For example, a read-only user may run
the following `git push` command to push commits to a special reference
to create a code review, instead of updating a reference directly.

    git push -o reviewers=user1,user2 \
        -o oldoid=89c082363ac950d224a7259bfba3ccfbf4c560c4 \
        origin \
        HEAD:refs/for/<branch-name>/<session>

The `<branch-name>` in the above example can be as simple as "master",
or a more complicated branch name like "foo/bar".  The `<session>` in
the above example command can be the local branch name of the clien-
side, such as "my/topic".

To support this kind of workflow in CGit, add a filter and a new
handler.  The filter will check the prefix of the reference name, and
if the command has a special reference name, the filter will add a
specific tag (`exec_by_hook`) to the command.  Commands with this
specific tag will be executed by a new handler (an external hook named
"execute-commands") instead of the internal `execute_commands` function.

We can use the external "execute-commands" hook to create pull requests
or send emails.  The centralized workflow is not a replacement for
the distributed workflow, but a supplement. Especially for lightweight
code contribution or for working on a project with multiple repositories.

We also implement a command line tool for this kind of workflow, see:

    https://github.com/aliyun/git-repo-go


Jiang Xin (7):
  receive-pack: new external execute-commands hook
  receive-pack: feed all commands to post-receive
  receive-pack: try `execute-commands --pre-receive`
  receive-pack: read env from execute-commands output
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.executeCommandsHookRefs
  hook: add document and example for "execute-commands" hook

 Documentation/config/receive.txt         |  11 +
 Documentation/githooks.txt               |  43 ++
 builtin/receive-pack.c                   | 228 +++++++-
 refs.c                                   |  11 +-
 refs.h                                   |   1 +
 t/t5411-execute-commands-hook.sh         | 698 +++++++++++++++++++++++
 templates/hooks--execute-commands.sample | 131 +++++
 7 files changed, 1093 insertions(+), 30 deletions(-)
 create mode 100755 t/t5411-execute-commands-hook.sh
 create mode 100755 templates/hooks--execute-commands.sample

-- 
2.25.1.362.g51ebf55b93

