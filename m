Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67404C433E1
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DF42067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRR3vgq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgFHGZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgFHGZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56726C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:24:59 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q8so17317524iow.7
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aXbm4duFzbrI6sb7KpOpHnrEri9YkUGm7B/4Y9E8OEI=;
        b=bRR3vgq3kYttTEXvSnd7iBajxtVhLD+DnE+H8oaWaH8dXmw3W4QbMKQEpJ/e7ey+uF
         Pn911pQE6k5DjvB1yJQysGh9kE5t2+wQyc6n7g/LayYaEcrkd1txX+SLn7U3UVeaYr1j
         oyo5HTej5SQPUSC7zqEcZUV2XpVQ4fItrSKcNUVX0o+mlhyVvzHKLcrnC0afuOZ70kAy
         FKYNKw9wl+OhJeNyUW3fC0e+E5bwvsFkJLs6vQeqjjygc7NOsuNe6YxFOsdFz4Ndo+ps
         Y95roD8AeTfZYzyuK+E+LEwHkr1RUgFm641kxxcfrW9hmcDeKZJSeRzr4kyP1eA0Y5MS
         vgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aXbm4duFzbrI6sb7KpOpHnrEri9YkUGm7B/4Y9E8OEI=;
        b=e1FYIFAYpHOmOqGM941KT0EV4ZjaGRRaLpJ77O7uoXMvPbobhu2X/PdfXW8GxptfKz
         7Cc+lYOKRo+MSu3tXFpXBMybVx+JBejDmo+IYj2xRAf1UxCyvbV+bAc+q5v8QgeVnwtb
         sUs1MFX1BTieo85hvshTyQT08QgKbFV26PDvS7oq/SlxCMh0RdnWg+BFsLWd4ZM6JFtH
         DjePwE4hJULccd5WihvuAoRZAITfEHV9IcTdn+YNXDY0QvpZruDQ155+Jqx0ikJrTfEF
         5uYAjeShyinayVjPhHT2d5NJ3Cb1+qtw5dkKfDihDgb8w+lh+VKUDbrnwGfLp5PXXEwB
         SWKw==
X-Gm-Message-State: AOAM533QB76dyJxuXHKy4E6wMhddcfU0MHeJOEVd9DONv+8m8Li17Gxq
        Or1ukjaRdA7hyOtImJqI6dBLX/4WgPQ=
X-Google-Smtp-Source: ABdhPJw77soVgfrbXaqoa5QR1Pb74RI+JsoTwzw2t+q4R2+2JmxM5PiZ9Lx7bI8Llo4bAkFXVvIbcg==
X-Received: by 2002:a02:cc36:: with SMTP id o22mr20802290jap.58.1591597497797;
        Sun, 07 Jun 2020 23:24:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:24:56 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/8] worktree: tighten duplicate path detection
Date:   Mon,  8 Jun 2020 02:23:48 -0400
Message-Id: <20200608062356.40264-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series started as a (presumably) simple enhancement to make
"git worktree prune" more helpful to users who shoot themselves in the
foot[1] by causing a linked worktree to point at the main worktree, a
situation which "git worktree add" tries hard to disallow but which
users can accomplish merely be deleting and renaming directories
(without even mucking around inside the .git/worktrees/<id> directory).
The series grew as I realized that "git worktree move" does not employ
the same protections as "git worktree add" and happily allows multiple
linked worktrees to references the same location, thus that also had to
be fixed.

[1]: https://lore.kernel.org/git/CAPig+cTU8+N6Chimpoa2_T-TcXxw-3B9-9pjCLz7WeOh472P_A@mail.gmail.com/

Eric Sunshine (8):
  worktree: factor out repeated string literal
  worktree: prune corrupted worktree even if locked
  worktree: give "should be pruned?" function more meaningful name
  worktree: make high-level pruning re-usable
  worktree: prune duplicate entries referencing same worktree path
  worktree: prune linked worktree referencing main worktree path
  worktree: generalize candidate worktree path validation
  worktree: make "move" refuse to move atop missing registered worktree

 Documentation/git-worktree.txt |   4 +-
 builtin/worktree.c             | 142 ++++++++++++++++++++++-----------
 t/t2401-worktree-prune.sh      |  38 ++++++++-
 t/t2403-worktree-move.sh       |  21 +++++
 4 files changed, 157 insertions(+), 48 deletions(-)

-- 
2.27.0.290.gba653c62da

