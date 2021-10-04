Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAA6C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E676115B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhJDBON (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhJDBOF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:14:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A92C06178C
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g193-20020a1c20ca000000b0030d55f1d984so6657575wmg.3
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwuJjoOmSdzpgNKRDleD83+86zD1JgmaoRYpkwakrXI=;
        b=VJeAU+t31fUaYp3ReuP/pMOnLbXVIv2EYkYSptuHVLfrHECnt9t6x1aPSzohjUYtPr
         oshokNJAZbXHgC2XvsZDPjVgUFvVsuY5Yse6PGpvgBu11KpIwh7r6i0nuUoqWvZW2+dd
         PiYSA4tWKMVKiAqFSInPm9b23KOKgh7GcBrruzUfWicYIOvpqFKg9nOr1953YRpsLvW7
         8wH5vTtHB/XJ994ACjuMR4gf+MK9HQlmB2ojQr4VTXTeJN2t05JsmsW7QmzI+kv5VTF2
         9aquYOtGL5DjsG7f+mm717A73eWJvNSiHpIjAJtuikjDUfm7V/QOuqqe3rMX8Ew7OaS5
         sJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwuJjoOmSdzpgNKRDleD83+86zD1JgmaoRYpkwakrXI=;
        b=JY8FtKd65+COTFD3Giiip2JQ6sonq02NT4rh55FGvqaMG6XpqHLFhdnBzhFmIObefs
         0PwzKxvsRB2AjMKO9H1cz2EGoFIOcL4JoboqYzPTYC8Lv4zGO1cODdhQnBXDyRHySBjz
         dejWZx8pLkWEJb0yp0VR9Oepl9b4aF1Sp6XdV8aqritGMHFzFSpq+RWrK/r5pLUcpPoV
         FOE8h5pNUxNLbbfI6d2tYDSV/HJG4zywBs8gjO2oQhXdbTVhrf6isjvvxGYd5EnembQR
         H2VrBWU/ynTWIxv6V3JgTG+TmldQFE41wMDRh4+LnvrUwPfUTl7IXkfDv5B5Yi/4JU3j
         U7sQ==
X-Gm-Message-State: AOAM530K0h7stcIyfsJpE3Pqs9TuO8CnC6aef7Yhvzru1IY+O1LYlW5m
        h6mAw63r7PoKrupy95EIqyDRFOark4cuaQ==
X-Google-Smtp-Source: ABdhPJzq9ynnsiAgYZsU9A96N+IIWLxEbw2i03fKYJ6Cz7Wt/bbQpQ9GcD6AHTT8Xd4kLiw6Um7t/w==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr15938824wmj.120.1633309931195;
        Sun, 03 Oct 2021 18:12:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 10/10] Documentation: call out commands that nuke untracked files/directories
Date:   Mon,  4 Oct 2021 03:11:59 +0200
Message-Id: <RFC-patch-v4-10.10-e88f81baa50-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Some commands have traditionally also removed untracked files (or
directories) that were in the way of a tracked file we needed.  Document
these cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-checkout.txt  | 5 +++--
 Documentation/git-read-tree.txt | 5 +++--
 Documentation/git-reset.txt     | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe44997..d473c9bf387 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -118,8 +118,9 @@ OPTIONS
 -f::
 --force::
 	When switching branches, proceed even if the index or the
-	working tree differs from `HEAD`.  This is used to throw away
-	local changes.
+	working tree differs from `HEAD`, and even if there are untracked
+	files in the way.  This is used to throw away local changes and
+	any untracked files or directories that are in the way.
 +
 When checking out paths from the index, do not fail upon unmerged
 entries; instead, unmerged entries are ignored.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 0222a27c5af..8c3aceb8324 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -38,8 +38,9 @@ OPTIONS
 
 --reset::
 	Same as -m, except that unmerged entries are discarded instead
-	of failing. When used with `-u`, updates leading to loss of
-	working tree changes will not abort the operation.
+	of failing.  When used with `-u`, updates leading to loss of
+	working tree changes or untracked files or directories will not
+	abort the operation.
 
 -u::
 	After a successful merge, update the files in the work
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 252e2d4e47d..6f7685f53d5 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -69,7 +69,8 @@ linkgit:git-add[1]).
 
 --hard::
 	Resets the index and working tree. Any changes to tracked files in the
-	working tree since `<commit>` are discarded.
+	working tree since `<commit>` are discarded.  Any untracked files or
+	directories in the way of writing any tracked files are simply deleted.
 
 --merge::
 	Resets the index and updates the files in the working tree that are
-- 
2.33.0.1404.g83021034c5d

