Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331F3C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9A460F39
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhGaIXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 04:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhGaIXU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 04:23:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53687C06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h14so14357816wrx.10
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFW/gkq6Ph9OsZu0Q2/6N2wyLn7ybSoQXk+pkbDSkU8=;
        b=Y46B/CsglhwoVOq7w6UZKnJ9lpzK6NtervOdphby4RI1ISNqDc8wufR2t7RSu6UbRF
         u0r51FAq1CVlqfrQmicBXpdo9dj9Y8DclEhoScml8P/EI+2G+RlbJxvpiDvmsRgwUnP2
         2ByqXIrb/iFpfJ6ixBrCTIi9s0JbXwJtTY+Jo52tt9EeRgJko71phmHM7lWgOYz+sKAS
         0TQe+RBTvx5JdFR4qlHV0TSU9mkcDWG23g6QJEqTMEXKuwXiPfX0IvuicV0bTlJX4mzc
         0liFffzxfTXOZU+LG74VcKni3w4d3c0uaJtLUrt46oO2v+5p81QPpp0QOroq0JFQedUJ
         Vyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFW/gkq6Ph9OsZu0Q2/6N2wyLn7ybSoQXk+pkbDSkU8=;
        b=DbTM4AN8e8Aw/4OoRCe9GWlq6KxlBaBL5PdvKr6840HPvznRIDNTrTEby2ppoWBa4A
         Nvl6rTc6PEEyNnKzm2ZfXTd+txj4nrlhzY/UAu1C8Iyzo7DVHjDFB5UUZv0+cN+E3bk4
         I9ytGnMzmy/F64l5Z+pZXNwxxHhDsdhXKGDyKzC11dumbZnYfsCXHGBaIgkVTYsYI/Ir
         tHSh5utJQpYV4B6sM+MXRZBcuGA3xIAjqnxsONwtRM4ryXa8pvJUCNvpPNCGUaL+i1+S
         scQuAJVmGjnxKjAi/dNU9kShSy64S65A9OASMPubI4RX1wguPFjsrB8fYOtfuj97+GO1
         9QBw==
X-Gm-Message-State: AOAM530f2ms5hRtGUljtaDTcm3feKUfP3OaUoUHV9netrN/TjS0UPYfN
        QlJxl/LysnbzI/g91ph3GRd4vfu7p1p4HQ==
X-Google-Smtp-Source: ABdhPJyWcFiy4bz5bR6OVcevJ76IWN19JF1avZnRj8swhRGtx8EAfaK9z3i+4bpIjLp+GCDECh/e4g==
X-Received: by 2002:adf:80e8:: with SMTP id 95mr7242032wrl.388.1627719791708;
        Sat, 31 Jul 2021 01:23:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm4877548wrs.81.2021.07.31.01.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 01:23:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 2/4] bundle doc: elaborate on object prerequisites
Date:   Sat, 31 Jul 2021 10:23:05 +0200
Message-Id: <patch-v8-2.4-5f344bd24aa-20210731T082120Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g545f0888808
In-Reply-To: <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com> <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the discussion bout "object prerequisites" into its own
section, and add some more examples of the common cases.

See 2e0afafebd (Add git-bundle: move objects and references by
archive, 2007-02-22) for the introduction of the documentation being
changed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 37 +++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 339c5b47276..f1f84ce2c42 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -44,6 +44,7 @@ header indicating what references are contained within the bundle.
 
 Like the the packed archive format itself bundles can either be
 self-contained, or be created using exclusions.
+See the "OBJECT PREREQUISITES" section below.
 
 Bundles created using revision exclusions are "thin packs" created
 using the `--thin` option to linkgit:git-pack-objects[1], and
@@ -152,19 +153,49 @@ contained in the union of the given bases.  Each basis can be
 specified explicitly (e.g. `^master~10`), or implicitly (e.g.
 `master~10..master`, `--since=10.days.ago master`).
 
-It is very important that the basis used be held by the destination.
+OBJECT PREREQUISITES
+--------------------
+
+When creating bundles it is possible to create a self-contained bundle
+that can be unbundled in a repository with no common history, as well
+as providing negative revisions to exclude objects needed in the
+earlier parts of the history.
+
+Feeding a revision such as `new` to `git bundle create` will create a
+bundle file that contains all the objects reachable from the revision
+`new`. That bundle can be unbundled in any repository to obtain a full
+history that leads to the revision `new`:
+
+----------------
+$ git bundle create full.bundle new
+----------------
+
+A revision range such as `old..new` will produce a bundle file that
+will require the revision `old` (and any objects reachable from it)
+to exist for the bundle to be "unbundle"-able:
+
+----------------
+$ git bundle create full.bundle old..new
+----------------
+
+A self-contained bundle without any prerequisites can be extracted
+into anywhere, even into an empty repository, or be cloned from
+(i.e., `new`, but not `old..new`).
+
 It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-`git clone` can use any bundle created without negative refspecs
-(e.g., `new`, but not `old..new`).
 If you want to match `git clone --mirror`, which would include your
 refs such as `refs/remotes/*`, use `--all`.
 If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
 
+The 'git bundle verify' command can be used to check whether your
+recipient repository has the required prerequisite commits for a
+bundle.
+
 EXAMPLES
 --------
 
-- 
2.32.0.1069.g545f0888808

