Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173D620136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934460AbdBQOTa (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:19:30 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33267 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:19:27 -0500
Received: by mail-pf0-f177.google.com with SMTP id c73so14162241pfb.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l514Qwi/SygxSZQG59au5XvmWPLDrWeKgWcCbQ+01UA=;
        b=hJs0AKNxRJ6eOtO5h1G9nMWWDkDEvOxesEi3Flmw43LxHeFjV16jM9L2laxc4MyBAH
         a10o8bf6LJItQbmmUiELahdx+wJAB0fVy2H0b12B/XN0MXhqYp0EG65S8seA52/2AZJc
         r4UKoy8UhANG3s+oBaLSEr0ejS4tdVWxkSrV+PdmnnmgF/V31g/gdTdG1sypEo8rQyyB
         VvQDcF/rNR2ZeeDFGQ558t7uQJRRubMCal8GTHGnCjJ45pTXM7yRhc8iDql7SEhCO+Ko
         QTL4FLiN344bKaQiV5cabiPtKDPJedmF02iCTLOKVmRdnjJSuiDGPHVWq5FEq9zPawRu
         WrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l514Qwi/SygxSZQG59au5XvmWPLDrWeKgWcCbQ+01UA=;
        b=miwTC7jf0GykFMfliUA6BFSVhePQ0Mas+i1OrEIK1Sv/q9CHwYgixG77N1tgsPeFWr
         uKK0gG3331yGM2XZ005xfR2vmJ+6krFssKdt6+rk572fR9kzrSSk3x0GE1ASzh5Qn+uP
         c68IyY5R8dAAeQO6uMq2NaLLo4YyhKdjOiscRYNIYH0cvQEL7ou2vZpN3C8LrPvUQXGG
         gRj/mo5Ajd9RAYOw9lm2LiUDBVb9TQWEoTttnAc2gh6qQ4hNr5NIfw+3Zp7KF2IUc0Qu
         Safa05zhPZXj6es83OczuycfSmEiTKITuXfQaKR9IuOZJPcLD9z7JLr6atJcDDjkf5l+
         zTGw==
X-Gm-Message-State: AMke39lCFCO4Vzp14dJopu2A+HIuCAnxRph0XlPEArCYfw03S6/j8diMh/0bagVGEr7BQA==
X-Received: by 10.98.139.22 with SMTP id j22mr9680906pfe.115.1487341166757;
        Fri, 17 Feb 2017 06:19:26 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id m21sm20282912pgh.4.2017.02.17.06.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:19:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:19:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 00/15] Fix git-gc losing objects in multi worktree
Date:   Fri, 17 Feb 2017 21:18:53 +0700
Message-Id: <20170217141908.18012-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here is my latest attempt on fixing this issue. For people who are
not aware of it, git-gc does not take per-worktree refs, reflogs and
indexes into account. An odb prune may leave HEAD and references in other
worktrees pointing to nowhere.

This series is based on my "kill parse_ref()" series [1], which is
based on yet another one, which is on top of mh/submodule-hash. But
you can get everything from my github [2].

The series introduces a new set of refs_* API and replaces the old
*_submodule() one, opening up the opportunity to access refs from
another worktree. rev-list learns a new option, --single-worktree, to
control the new behavior.

reflog iterator from files-backend.c does not support per-worktree
items, so it's updated here to do that. It still looks ugly, but I
think this is a good "middle ground" until compound ref store comes.
At that point we can separate "single worktree" ref store vs "linked
worktree" one.

I'm adding Stefan here as well since I added a new FIXME in
submodule.c in 11/15. I think it's ok (again, for now). But another
look from submodule people would be much better.

[1] http://public-inbox.org/git/%3C20170216120302.5302-1-pclouds@gmail.com%3E/
[2] https://github.com/pclouds/git/commits/prune-in-worktrees-2

Nguyễn Thái Ngọc Duy (15):
  revision.h: new flag in struct rev_info wrt. worktree-related refs
  revision.c: refactor add_index_objects_to_pending()
  revision.c: --indexed-objects add objects from all worktrees
  refs: move submodule slash stripping code to get_submodule_ref_store
  refs: add refs_read_ref[_full]()
  refs: add refs_head_ref()
  refs: add refs_for_each_ref()
  refs: add a refs_for_each_in() and friends
  revision.c: use refs_for_each*() instead of for_each_*_submodule()
  refs: remove dead for_each_*_submodule()
  revision.c: --all adds HEAD from all worktrees
  refs: add refs_for_each_reflog[_ent]()
  files-backend: make reflog iterator go through per-worktree reflog
  revision.c: --reflog add HEAD reflog from all worktrees
  rev-list: expose and document --single-worktree

 Documentation/rev-list-options.txt |   8 ++
 reachable.c                        |   1 +
 refs.c                             | 171 ++++++++++++++++++++++++-------------
 refs.h                             |  25 ++++--
 refs/files-backend.c               |  24 +++++-
 revision.c                         | 130 +++++++++++++++++++++++-----
 revision.h                         |   1 +
 submodule.c                        |   2 +
 t/t5304-prune.sh                   |  37 ++++++++
 9 files changed, 305 insertions(+), 94 deletions(-)

-- 
2.11.0.157.gd943d85

