Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A1F20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLIUE7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:04:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36472 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeLIUE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:04:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so9200610wmj.1
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0XC7POI1nB4xdPtuPtyFLxqibsQ3j0UqpYwKjrYKfE=;
        b=p+czlHqYeaPICgA8xDP8OERKdAlEJ8ogF5N3EZ2a8d21ySibjqGAxpvuznfgV34APk
         IgbVIqzjsBcIIbraw58YE2D+L5GVFV7umARtgcyfG5T7cbaqiOfpr+x4pqKqKOyqNCAn
         j+Ky1RaSTqtJQWp0BHkrLthEU3Ar0ODXjwJyFQNlIexr6KP2SOvBooeWkhjHT2alpnrI
         aaOlYcBWQIztEUvV6ZFAO4UCpvbWgVNRM3zo1aCQiTrA732Bc2xpH/VL4VJiPQ7+Sd7W
         6y2tVAkivgy8RtL4wAhmd7eWAQPO/GpOvuEJ/9NYldFCsjAnkkE+Slrk8cDqFA1sKLoX
         4xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0XC7POI1nB4xdPtuPtyFLxqibsQ3j0UqpYwKjrYKfE=;
        b=noD7wg0NhzNHarlO5iT7xztyP/F70vgVDdbjff3f//fg3IDhf/QHVfcOyGmDsqtkyl
         CgtTgxDstXrZn0KhVq9+qrjWE69GYsvTUEtQNFp5lOPNx5iCrwGyjDxIiB2R75/0yVu+
         XLXe45VCcOHZbgUCijADPFvf3w5Qiu9okbOZ83hNUH48XQBg68Ih9ypkIf20SsPyheqk
         HGLZgdNliyq2dVGH43hn0sBj2Rb19rsHJLRAxIGRT62AuhucN9EmIUpWljFh9rLk0xc2
         s1WAzo2RQ/oCUe/T1WY+RmE+EOy84eSZCIW77Iu9BPrqmcf34KH7zfNgvFbsG0jDcA9t
         4OYw==
X-Gm-Message-State: AA+aEWYTS6qzjZTu5rd2cOLN3jQaNRdF7hEQ+iY98NGwsfCQiFJ0Eht9
        LGoFSnNp2tArcuA+QjsAPe5uqnwL
X-Google-Smtp-Source: AFSGD/VV1H5ISLy7wXzJmm6LwIZ5VZfexaznkimZgkA14rZ8Eg69pY8hFfpIsN2j5ywzVIEqZ2JXog==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr8447438wmu.81.1544385896639;
        Sun, 09 Dec 2018 12:04:56 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id p74sm11670510wmd.29.2018.12.09.12.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:04:55 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/8] introduce no-overlay and cached mode in git checkout
Date:   Sun,  9 Dec 2018 20:04:41 +0000
Message-Id: <20181209200449.16342-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the series I mentioned a couple of times on the list already,
introducing a no-overlay mode in 'git checkout'.  The inspiration for
this came from Junios message in [*1*].

Basically the idea is to also delete files when the match <pathspec>
in 'git checkout <tree-ish> -- <pathspec>' in the current tree, but
don't match <pathspec> in <tree-ish>.  The rest of the cases are
already properly taken care of by 'git checkout'.

The final step in the series is to actually make use of this in 'git
stash', which simplifies the code there a bit.  I am however happy to
hold off on this step until the stash-in-C series is merged, so we
don't delay that further.

In addition to the no-overlay mode, we also add a --cached mode, which
works only on the index, thus similar to 'git reset <tree-ish> -- <pathspec>'.

Actually deprecating 'git reset <tree-ish> -- <pathspec>' should come
later, probably not before Duy's restore-files command lands, as 'git
checkout --no-overlay <tree-ish> -- <pathspec>' is a bit cumbersome to
type compared to 'git reset <tree-ish> -- <pathspec>'.

My hope is also that the no-overlay mode could become the new default
in the restore-files command Duy is currently working on.

No documentation yet, as I wanted to get this out for review first.
I'm not familiar with most of the code I touched here, so there may
well be much better ways to implement some of this, that I wasn't able
to figure out.  I'd be very happy with some feedback around that.

Another thing I'm not sure about is how to deal with conflicts.  In
the cached mode this patch series is not dealing with it at all, as
'git checkout -- <pathspec>' when pathspec matches a file with
conflicts doesn't update the index.  For the no-overlay mode, the file
is removed if the corresponding stage is not found in the index.  I'm
however not sure this is the right thing to do in all cases?

*1*: <xmqq4loqplou.fsf@gitster.mtv.corp.google.com>

Thomas Gummerer (8):
  move worktree tests to t24*
  entry: factor out unlink_entry function
  entry: support CE_WT_REMOVE flag in checkout_entry
  read-cache: add invalidate parameter to remove_marked_cache_entries
  checkout: introduce --{,no-}overlay option
  checkout: add --cached option
  checkout: add allow ignoring unmatched pathspec
  stash: use git checkout --index

 builtin/checkout.c                            |  66 +++++++++--
 cache.h                                       |   7 +-
 entry.c                                       |  22 ++++
 git-stash.sh                                  |  12 +-
 read-cache.c                                  |   8 +-
 split-index.c                                 |   2 +-
 t/t2016-checkout-patch.sh                     |   8 ++
 t/t2022-checkout-paths.sh                     |   9 ++
 t/t2025-checkout-no-overlay.sh                |  31 ++++++
 t/t2026-checkout-cached.sh                    | 103 ++++++++++++++++++
 ...-worktree-add.sh => t2400-worktree-add.sh} |   0
 ...ktree-prune.sh => t2401-worktree-prune.sh} |   0
 ...orktree-list.sh => t2402-worktree-list.sh} |   0
 t/t9902-completion.sh                         |   3 +
 unpack-trees.c                                |  21 +---
 15 files changed, 251 insertions(+), 41 deletions(-)
 create mode 100755 t/t2025-checkout-no-overlay.sh
 create mode 100755 t/t2026-checkout-cached.sh
 rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
 rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
 rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)

-- 
2.20.0.rc2.411.g8f28e744c2

