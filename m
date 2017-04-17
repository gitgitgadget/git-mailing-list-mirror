Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E96420A04
	for <e@80x24.org>; Mon, 17 Apr 2017 20:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932185AbdDQUvs (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 16:51:48 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34217 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbdDQUvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 16:51:46 -0400
Received: by mail-qk0-f196.google.com with SMTP id p68so21104841qke.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jy6wT7Ug2OEC5lapAKIgl2lcb14eFttAEtL0LiFzhZY=;
        b=mDq5wodtwbER0KSsjBnjk8nPlWIZHIiXz2tYlqGTfDYLhG/vnUC2KlOsN0WTKhB+2s
         MNUo1dxl8eqfAi+UujAyF86m11mGb/Jl3f6No4qfIYkQxycf2yT0tGrqRJR6NcNXkrv0
         mcv2Puu8ndCGSVe9RT1J2PzaM9lrbn8sVw5mF1dALHAb5mSEtU4yF4nb1qiFRAtAVlXj
         rpEblhfJtdtDZZ6lwVcEzTLu6d+MBacPR9uYhMT4PQGF41qco56EhLWzl0IMHtAGT+ud
         HsdMlZSNAMqz28f4VZga4Pw/ig1jN5syB3LUr7Tw2Oh6DZC65pKkVrUdvsB7T8jeNHvG
         2XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jy6wT7Ug2OEC5lapAKIgl2lcb14eFttAEtL0LiFzhZY=;
        b=f+D715jlOOvaRt6UUwHQZHyFdH69RCK8sLx07Pt0ecMgyB1VOcuEoLLKCSS1Y5GLLZ
         Ey9e333T0JR0gujgFcK4MOWSQQky1O3vR+7EsDxif/MsYMIEzBvqXxuXu2n/GhSEzChj
         tPyJmzyv6yHfk/BydUv0ClldxbL9RIm57YZ0lYC4CEOdE8pR3tNdsNlwYgn8LllgmoBp
         B0hNlxxcYSGSOkbajoEyXcfnhIBEGBFjIpLdN7wxWPVTSKGrM1Y6FvA3J8LHD2tNFxxn
         m2mqmLqK67Ge84sZSUnDkGzde8ByOml53kqGyyFBsA6qT0zx2wYsLAO6ANe8G0jGQdIG
         uFjw==
X-Gm-Message-State: AN3rC/6vdWzpvMdBPrX+C6ti9pW3WZss175AFh/luxKCEswr6OaO15vM
        NlomQR4vQU++xg==
X-Received: by 10.55.103.212 with SMTP id b203mr9963931qkc.264.1492462305624;
        Mon, 17 Apr 2017 13:51:45 -0700 (PDT)
Received: from localhost.localdomain ([179.222.191.2])
        by smtp.gmail.com with ESMTPSA id f203sm8093848qka.11.2017.04.17.13.51.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 13:51:44 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v9 0/5] [GSoC] remove_subtree(): reimplement using iterators
Date:   Mon, 17 Apr 2017 17:51:31 -0300
Message-Id: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the ninth version of a patch series that implements the GSoC
microproject of converting a recursive call to readdir() to use
dir_iterator.

v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t
v4: https://public-inbox.org/git/1490747533-89143-1-git-send-email-bnmvco@gmail.com/T/#e437a63e0c22c00c69b5d92977c9b438ed2b9fd3a
v5: https://public-inbox.org/git/1490844730-47634-1-git-send-email-bnmvco@gmail.com/T/#m2323f15e45de699f2e09364f40a62e17047cf453
v6: https://public-inbox.org/git/1491107726-21504-1-git-send-email-bnmvco@gmail.com/T/#t
v7: https://public-inbox.org/git/1491163388-41255-1-git-send-email-bnmvco@gmail.com/T/#t
v8: https://public-inbox.org/git/a60b2ed6-2b99-b134-05af-7c8492a6949c@alum.mit.edu/T/#t

Travis CI build: https://travis-ci.org/theiostream/git/builds/222919383

I think this is the closest to a final version we've ever gotten. I
followed all of Michael and Stefan's suggestions on top of v8, and with
Michael's endorsement made dir_iterator_begin() return NULL and set
errno appropriately in case of an error.

On second thought, maybe the extra code complexity required from
dir_iterator_begin()'s callers might be actually an advantage as
dir_iterator grows to tackle more complex dir traversing challenges on
Git. After all, we might want some special behavior depending on what
the given `path` is instead of always considering it valid and later
behaving as if it was an empty directory.

Thanks again for the reviews.

Daniel Ferreira (5):
  dir_iterator: add tests for dir_iterator API
  remove_subtree(): test removing nested directories
  dir_iterator: add helpers to dir_iterator_advance
  dir_iterator: refactor state machine model
  remove_subtree(): reimplement using iterators

 Makefile                        |   1 +
 dir-iterator.c                  | 252 +++++++++++++++++++++++++++++-----------
 dir-iterator.h                  |  35 ++++--
 entry.c                         |  42 +++----
 refs/files-backend.c            |  51 +++++---
 t/helper/.gitignore             |   1 +
 t/helper/test-dir-iterator.c    |  53 +++++++++
 t/t0065-dir-iterator.sh         | 113 ++++++++++++++++++
 t/t2000-checkout-cache-clash.sh |  11 ++
 9 files changed, 435 insertions(+), 124 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

--
2.7.4 (Apple Git-66)

