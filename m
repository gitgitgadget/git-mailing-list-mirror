Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8547CC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 15:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA6F21548
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 15:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdx8EUIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1PuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1PuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 11:50:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA6C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 08:50:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so1649244wmj.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9tYBipGi7NZJlBincZLfSKnIazHxvqRr44O05T9S50=;
        b=gdx8EUIj8oyu+vCTp+pweTNwBBE7Ot3hiiXHVdnC5mfNVqa48AwAIdXPeU46aX0JU7
         NfqREvoFxpa6glCe8A3DkArt4bsPG2UQGxF7lAZyPZO43NPHfqoGQj/noUgYsTH2Ipqe
         YNt28V+O4dmheyJ9nXv74kWkXk/gojuVgWjtriQPABe7x15osjVxublDPqZmaNGZ+Kbl
         cJG5BqjALR+1DViKmQnO/5U2yqyT3U9DuSWdjWo/NvJeeBmwTtN/Td4Zl0rdTenyLMvo
         woSx0xBoy9v8XcEhM+iPnnC7Qse0adi4F7bt0ydW4F5iX04fADTv6IpbYdW2QI2jfWOY
         b+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9tYBipGi7NZJlBincZLfSKnIazHxvqRr44O05T9S50=;
        b=HNxGhhH/fnFlQ7N/4aICIo1Pal904N6m9IVmsrJSwYA/lJ1BrR/hvxVQM5xgZSOBfk
         QtKySD97DDcYLip68i9YoMygOrIwhekW8He7ktswymRw1r0KmrvAiEhsD/YlRbxWqFC/
         iK6+BMTCO+PO2zmh/zZ1uQIQTGQ+8ad+qCGJWY4MOzfqM0Rt+ygHjvkzoDg93EsVzkiw
         6PmF5dHZfblQJuWkMzyO512PiFKAoQaDg/fthCQshyJm+mEqXoi6HBYNQXLeqNshikmd
         9tttv8E0fpJUs9nhBHmtHNMoyOaZrE5FhYO2uPdCv0tcr7mLEzKsmAIBmMT9DakuJA+b
         7xEw==
X-Gm-Message-State: AOAM531jaFsTWqxXw6wjJeOmUsSJtzMquSZDaQ63uNvJQ08+DjJ+EzMF
        K3ZQHPjhDKLoodbthqpur7b6zwpJCwE=
X-Google-Smtp-Source: ABdhPJzuE6FRxh72kuw2t0vxEdhMJkpA3nusL2LzCdo4sVG/RdSgOGy9A6pgsTukciGeMcRohWA1gQ==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr2225090wma.43.1601308215358;
        Mon, 28 Sep 2020 08:50:15 -0700 (PDT)
Received: from contrib-buster.auto1.local ([79.140.115.160])
        by smtp.gmail.com with ESMTPSA id o15sm1717067wmh.29.2020.09.28.08.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 08:50:13 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [RFC PATCH 0/2] teach `worktree list` to mark locked worktrees
Date:   Mon, 28 Sep 2020 15:49:51 +0000
Message-Id: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.28.0.856.g4762557030
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces a new information on the git `worktree list`
command output, to mark when a worktree is locked with a (locked) text mark.

The intent is to improve the user experience to earlier sinalize that a linked
worktree is locked, instead of realising later when attempting to remove it
with `remove` command as it happened to me twice :)

The patches are divided into two parts. First part introduces
the new marker to the worktree list command and small documentation
change. And the second adds one test case into t2402 to test
if the (locked) text will be properly set for a locked worktree, and
not mistankely set to a unlocked or master worktree.

This is the output of the worktree list with locked marker:

  $ git worktree list
  /repo/to/main                abc123 [master]
  /path/to/unlocked-worktree1  456def [brancha]
  /path/to/locked-worktree     123abc (detached HEAD) (locked)

This patches are marked with RFC mainly due to:

  - This will change the default behaviour of the worktree list, I am
    not sure whether will be better to make this tuned via a config
    and/or a git parameter. (assuming this change is a good idea ;) )

  - Perhaps the `(locked)` marker is not the best suitable way to output
    this information and we might need to come with a better way.

  - I am a new contributor to the code base, still learning a lot of git
    internals data structure and commands. Likely this patch will require
    updates.

Rafael Silva (2):
  teach `list` to mark locked worktree
  t2402: add test to locked linked worktree marker

 Documentation/git-worktree.txt |  5 +++--
 builtin/worktree.c             |  6 +++++-
 t/t2402-worktree-list.sh       | 13 +++++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.28.0.763.ge7086f1eef

