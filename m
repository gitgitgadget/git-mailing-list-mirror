Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9EB20966
	for <e@80x24.org>; Thu,  6 Apr 2017 01:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756549AbdDFBji (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 21:39:38 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36198 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756280AbdDFBjg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 21:39:36 -0400
Received: by mail-qk0-f195.google.com with SMTP id v75so4069771qkb.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=trsncQwnHs03c6CCWN14NaKwnQYjDe8wW7HlPQbDidI=;
        b=blQUvh+3PiKKHMhiamavFuAGVHYyGOIWaDWg2pIFKo3Vjf7EsPG3A6PZtsmRYT/6XV
         Bdti6C1pkmIhjig0IdP6w2+HZnuAC6lx6ImQ4SsnZrymYh7YSMSbzQG0IZgnA1GGzKro
         726T6g8tY4jPkjkhiAx1T/Z5xoZZohZ+lh6qS1uHyCRqemD0bCyQphIW+XYqUT4HpZeE
         mr8xC1JCvNHxN1jfy2omqdd720A+M252Z/LWLJeR7itqM4mlLuG9PXRZXWg5dehdLc7o
         8QwExCRsCM+Z/F9nwSZnX9rhJE0fwHHTwGs4/Ed1lBdgFF4D+9Bf3A9onbAr00uT0P3R
         6cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=trsncQwnHs03c6CCWN14NaKwnQYjDe8wW7HlPQbDidI=;
        b=W5IpE3imiReuPRt0hzDyIJvgSCImKyVNMP9Ghbjj5OPxDOWax6e9fY6VnCFOf9HR1L
         WYYhoUJwOVbptQ29t086iTIr2jNpQgMLwBSMr5SYIIQ0guixm1Ta4TEaeAg4QFrquT3S
         YvkJY9kGUOAMsXy5KDtEdtdzYSlS2BsBnkdTExeVGyXj/GbSiDsGEE5z7bnoiHNbsa7z
         fqGqmkw5qQ5bMZJPjO1UTNd0PruZx3FCQfazRJcLRZQfIwr64eU/hnjlEAgiAKP4Adeh
         lMV/ub+JGqWx/TN0DJsofxVw+tSYFpub1eUV3wnUOPx1RF+KYG8O8O2z4N5v+5jbgFwy
         Ukpg==
X-Gm-Message-State: AFeK/H1/BHo239dPidHESTv//3qCwuSuRZVAWJEh2zcZTmbSZqBtSFieyBwv5RQhvfE8WQ==
X-Received: by 10.55.187.132 with SMTP id l126mr28879485qkf.236.1491442775697;
        Wed, 05 Apr 2017 18:39:35 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id b78sm58718qkc.50.2017.04.05.18.39.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 18:39:34 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v8 0/5] [GSoC] remove_subtree(): reimplement using iterators
Date:   Wed,  5 Apr 2017 22:39:22 -0300
Message-Id: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the seventh version of a patch series that implements the GSoC
microproject of converting a recursive call to readdir() to use dir_iterator.

v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t
v4: https://public-inbox.org/git/1490747533-89143-1-git-send-email-bnmvco@gmail.com/T/#e437a63e0c22c00c69b5d92977c9b438ed2b9fd3a
v5: https://public-inbox.org/git/1490844730-47634-1-git-send-email-bnmvco@gmail.com/T/#m2323f15e45de699f2e09364f40a62e17047cf453
v6: https://public-inbox.org/git/1491107726-21504-1-git-send-email-bnmvco@gmail.com/T/#t
v7: https://public-inbox.org/git/1491163388-41255-1-git-send-email-bnmvco@gmail.com/T/#t

Travis CI build: https://travis-ci.org/theiostream/git/jobs/219111182

In this version, I applied pretty much all suggestions Michael and Stefan had
for the patch.

Michael, regarding the patch you sent for parsing the arguments on the
test-dir-iterator helper, I did not squash because it'd generate too many
merge conflicts. I just preferred add your code manually. Let me know how I
can properly credit you for it.

The only "controversial" part of this code is how I ended up caching the result
of lstat() on the dir_iterator_level struct. Having to handle the case of the
root directory ended up making set_iterator_data() way more complicated (having
to handle the case of level->stat not being set by push_dir_level()), as well
as required the introduction of st_is_set member in the level struct. This issue
would be solved if we could lstat() the root dir on dir_iterator_begin() and
possibly return an error there. Regardless, I appreciate other suggestions to
make this less complex.

Daniel Ferreira (5):
  dir_iterator: add tests for dir_iterator API
  remove_subtree(): test removing nested directories
  dir_iterator: add helpers to dir_iterator_advance
  dir_iterator: refactor state machine model
  remove_subtree(): reimplement using iterators

 Makefile                        |   1 +
 dir-iterator.c                  | 247 +++++++++++++++++++++++++++++-----------
 dir-iterator.h                  |  35 ++++--
 entry.c                         |  39 +++----
 refs/files-backend.c            |   2 +-
 t/helper/.gitignore             |   1 +
 t/helper/test-dir-iterator.c    |  48 ++++++++
 t/t0065-dir-iterator.sh         |  93 +++++++++++++++
 t/t2000-checkout-cache-clash.sh |  11 ++
 9 files changed, 373 insertions(+), 104 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

--
2.7.4 (Apple Git-66)

