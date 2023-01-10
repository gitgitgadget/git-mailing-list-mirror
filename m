Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DDC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 06:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjAJGRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 01:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAJGRl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 01:17:41 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AD91C13E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 22:17:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z11so16018131ede.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 22:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah8+QWrIierlKY284d71fyurJUfW7ar0wGxvxOd7pQo=;
        b=JC8Gs8PFjA0U9XUSqBDTm/waTMXo67qpLd9g6VS5IWX5lZmY46gMwFAEb/AA8Cw/KY
         bdIcbiUgVfo1Ev8oUMlHwLW9O1v2goZ50IhusMo244ZyaCFATPoabMCAWasQNxIiUhU5
         B15vyY36jP+2c31DuLdLfboGcbTmTADNkJR5urA+PaPyfTUyCFLkK5mAHyW+CONE/tqE
         rU5ijYqbi8R1N2QtOUErGxTTNlVNvF3S3EP/tVZvTYkVyyS6G9q3flAOXmBZKJT/yxt/
         PFbLWvL5RhqyTYCqW+KsDyBOMJuLnPwT29klU6Mubvz9wNbuUEpOB4pD2ZJ27XQpM+89
         htwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ah8+QWrIierlKY284d71fyurJUfW7ar0wGxvxOd7pQo=;
        b=SPgeCA130MVQqLft7VEeqzcOHBN5T5nIt4dI0J2WyrsxKTufsMDvU/lGEE+XrXgbQi
         THUYRlVjvG0ov+9Gg6XrJmujXbgvU4JDmBWWL8Oy9RpGjde7cH6SDtnUQ9Ehp2a/2YKP
         t+297u9UQI8VnzH1Pt+/bpXVao6EwfGL+ZAaKa8PMed5UCDG/oNdVM4jK27jgiA2BTSH
         YzBDzFEUyYvztkGpnRif1Ld7Q137iI/nkQW8SNM6RvCZskh7UJn+oylUxHFuG1d5ypKo
         s9jOEbX0MyelGJEJPU7EJ1xtsiY+RZPjYqDdskrb3JfUb20KfJ88QYJk7D9MzZQuF3c5
         XLrw==
X-Gm-Message-State: AFqh2kq1TJOrWZgb65M8k+knydXQcQpZ2656myFY2cMZNGxs83chNGz/
        6Lw1DCUbANk8tfchd4iOzY6sBpYPRgA9/g==
X-Google-Smtp-Source: AMrXdXuV7ujQwiY07ElHGS6Bk0ZKla9843oVLrNrXsGAM57x5sOJFxdrP/NFx7w/CmRras9iR2CYpA==
X-Received: by 2002:a05:6402:2409:b0:493:597e:2192 with SMTP id t9-20020a056402240900b00493597e2192mr16649013eda.38.1673331457752;
        Mon, 09 Jan 2023 22:17:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k16-20020a05640212d000b0048b4e2aaba0sm4555601edx.34.2023.01.09.22.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 22:17:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] cache API: always have a "istate->repo"
Date:   Tue, 10 Jan 2023 07:17:28 +0100
Message-Id: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct index_state" contains a "repo" member, which should be a
pointer to the repository for that index, but which due to us
constructing such structs on an ad-hoc basis in various places wasn't
always available.

We'd thus end up with code like this, in the recent
ds/omit-trailing-hash-in-index topic:

	struct repository *r = istate->repo ? istate->repo : the_repository;

Really we should be able to trust the "istate->repo", but were
carrying those sorts of conditionals because our index might come from
a manually constructed source, so we'd have to fall back to
"the_repository".

This series changes the relvant code so the "repo" field is always
non-NULL, as 5/5 here shows we had various workarounds in place for
that, which can now go away.

See
https://github.com/avar/git/tree/avar/do-not-lazy-populate-istate-repo
for passing CI and a fetchable branch for this topic.

See https://lore.kernel.org/git/xmqqmt6vqo2w.fsf@gitster.g/ for
previous discussion on this topic.

Ævar Arnfjörð Bjarmason (5):
  builtin/difftool.c: { 0 }-initialize rather than using memset()
  sparse-index.c: expand_to_path() can assume non-NULL "istate"
  sparse-index API: fix TODO, BUG() out on NULL ensure_full_index()
  read-cache.c: refactor set_new_index_sparsity() for subsequent commit
  treewide: always have a valid "index_state.repo" member

 apply.c                   |  2 +-
 builtin/difftool.c        |  4 +---
 builtin/sparse-checkout.c |  1 +
 builtin/stash.c           |  8 ++++----
 builtin/worktree.c        |  2 +-
 fsmonitor-settings.c      | 14 --------------
 fsmonitor.c               |  2 +-
 merge-recursive.c         |  2 +-
 read-cache.c              | 23 +++++++++--------------
 repository.c              |  2 ++
 revision.c                |  2 +-
 sparse-index.c            | 15 ++++-----------
 split-index.c             |  1 +
 unpack-trees.c            |  4 +++-
 14 files changed, 30 insertions(+), 52 deletions(-)

-- 
2.39.0.1195.gabc92c078c4

