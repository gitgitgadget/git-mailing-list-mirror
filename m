Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8553F20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbdHWMh0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:37:26 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38700 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:37:25 -0400
Received: by mail-pg0-f66.google.com with SMTP id t3so1392794pgt.5
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKP0L9WDWiNqp8CPAGTT9DGIa9Fj0/pdVPBHY/b0zMo=;
        b=OIkKcIVhumZIrGOPmC3/471us12sLUq5X/dtutais02foyIdV5mUTDZ/CtLJIDd3XO
         h03MZXw/fmFQIdmN2RW+9T7TyMXhJBIaV+xU8g5wOh1I3zkBppKu2Bx3CjAXyz7/Hy7q
         ilsXs1PzEoHxPsheke93YA4NhgdbwlpksdYBFlCQhoFVEAsQ4YIqXIqU+YmDxsCD4igh
         17s6TnviRONvz8QEEdQKI2Yw2NywApwBI0EXnqMcWlgLtBQBRADXZ8IwRIUo+Yyd2L+p
         kWHwVhUVB4TmEWIv5ArSG5MpvGhF18VOrprfgKklKS+Me0FYOVUOJQaepMn6S+3TkPSQ
         t1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKP0L9WDWiNqp8CPAGTT9DGIa9Fj0/pdVPBHY/b0zMo=;
        b=uSJXX+EIn6eIK843pfn0sUOGDr+mfi8qTv2yrmPnIZBIMDSju01W0Narf+6c0V3MV7
         OvT85b47k1DlTgpxyk0R7iVpVv/aphRTERYFCeSfRlbzu7zpHaQ84PtIuOyMrrsJQXp5
         X7vAs0vh7JpLV6gNhzqDpWCfEHmGmQjFprwkTa9DaYwVH3SrJkQ6z9X7fnF7Rh3FPO1+
         GQRv6C1QErrQ5RhGaM48X23CfR91ItDxt1T/28Mqu6vY2hxDbxXhH15mN/Zo5iRbd97l
         kvQbvIA+l3y6hoSBWuuDzxNu7ShHhCSexyOnK0KTKmjBiXQEheLxWPlqiQa89A1JsWSB
         jw7A==
X-Gm-Message-State: AHYfb5hNVfamHiHn+7lUqfba528MoNoDT4WkkQ/5UKurjHLtb6Z/rr9l
        4nm/0JyZlKJm2YCm
X-Received: by 10.99.9.2 with SMTP id 2mr2665537pgj.84.1503491844181;
        Wed, 23 Aug 2017 05:37:24 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id k17sm2824038pfe.16.2017.08.23.05.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:37:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:37:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 00/16] Fix git-gc losing objects in multi worktree
Date:   Wed, 23 Aug 2017 19:36:48 +0700
Message-Id: <20170823123704.16518-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git gc" when used in multiple worktrees ignore some per-worktree
references: object references in the index, HEAD and reflog. This
series fixes it by making the revision walker include these from all
worktrees by default (and the series is basically split in three parts
in the same order). There's a couple more cleanups in refs.c. Luckily
it does not conflict with anything in 'pu'.

Compared to v3 [1], the largest change is supporting multi worktree in
the reflog iterator. The merge iterator is now used (Micheal was right
all along).

[1] https://public-inbox.org/git/20170419110145.5086-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (16):
  revision.h: new flag in struct rev_info wrt. worktree-related refs
  refs.c: use is_dir_sep() in resolve_gitlink_ref()
  revision.c: refactor add_index_objects_to_pending()
  revision.c: --indexed-objects add objects from all worktrees
  refs.c: refactor get_submodule_ref_store(), share common free block
  refs: move submodule slash stripping code to get_submodule_ref_store
  refs: add refs_head_ref()
  revision.c: use refs_for_each*() instead of for_each_*_submodule()
  refs.c: move for_each_remote_ref_submodule() to submodule.c
  refs: remove dead for_each_*_submodule()
  revision.c: --all adds HEAD from all worktrees
  files-backend: make reflog iterator go through per-worktree reflog
  revision.c: --reflog add HEAD reflog from all worktrees
  rev-list: expose and document --single-worktree
  refs.c: remove fallback-to-main-store code get_submodule_ref_store()
  refs.c: reindent get_submodule_ref_store()

 Documentation/rev-list-options.txt            |   8 ++
 Documentation/technical/api-ref-iteration.txt |   7 +-
 reachable.c                                   |   2 +
 refs.c                                        | 110 ++++++---------------
 refs.h                                        |  20 +---
 refs/files-backend.c                          |  59 +++++++++---
 revision.c                                    | 131 +++++++++++++++++++++-----
 revision.h                                    |   1 +
 submodule.c                                   |   9 ++
 t/t1407-worktree-ref-store.sh                 |  30 ++++++
 t/t5304-prune.sh                              |  37 ++++++++
 worktree.c                                    |  22 +++++
 worktree.h                                    |   8 ++
 13 files changed, 308 insertions(+), 136 deletions(-)

-- 
2.11.0.157.gd943d85

