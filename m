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
	by dcvr.yhbt.net (Postfix) with ESMTP id DB26520966
	for <e@80x24.org>; Sun,  2 Apr 2017 20:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbdDBUFN (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 16:05:13 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35187 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbdDBUFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 16:05:11 -0400
Received: by mail-qt0-f193.google.com with SMTP id r5so16591862qtb.2
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 13:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cc9CB7bpn+54MffBjdEqnjToUgLFWIkl4vs0fIAdt4k=;
        b=WUUYVUQWi49NcNiQzgIzlXJNychCXxrW2LRd3+HVVgWLPLy7aZdvJsxO+bYdah3THu
         4kggXkXNPusIdCeFvVpyb4sTXODryxTBJoahAK055RdExZK/uW/nWGxpC49H8E/qOOrO
         tk8HX/ATiH918itGqef/ApF+nT04L8wEpLmFMvzDLg7Hl4eKr3pUFbf9qfNEHOHjsp3A
         Nl/Had11TReVWexra/A7Noi+zwgB9GBTDUqYdrvb7tl1spLhtoiSneAILd7y1cjoLqZm
         VKaL/LCyE8jQDkqX0EqcfrHgr4gUNuvx6VWq+hMMjPvo0YE6mQFvwHpBhvgxv1kMkCjK
         /Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cc9CB7bpn+54MffBjdEqnjToUgLFWIkl4vs0fIAdt4k=;
        b=MOvr3wZL4wVmmbFFAZ2nxnh7iXfn5go7lrp/LQJsDXYql7x9b31SaLB+6n8AZZn1gG
         wWSiDb2iUsLHebBwh3GnTGc6iOaA21zZHOUNguuWShDUrTLJFHh0c69da15P2/1yobnV
         dTldeM5BuxYF1bGL+CnxCiALNt2lhzuoHben8SLB0nHDSRWayiUh42hps2Zxm7EedvSf
         yN3AEwwoO90HS093+Xfl4k304Q8P6YFyb1FcEzzaF947CvFuBLupqYy4hfvxdLjR7aN2
         PypdWtvpCXKSR5bGxOrGmy/ahtLGQpZ6FR3e8KeRwdNxUvczpXMzxFYnfYQd+fw/77KI
         ZGOw==
X-Gm-Message-State: AFeK/H3dH8YXwHB+vD1sI7v7riaib41mHTqIZ1zqqTPF7pd4XS+h6JSoNDjZkmRGYsefBQ==
X-Received: by 10.237.59.198 with SMTP id s6mr14820362qte.161.1491163510761;
        Sun, 02 Apr 2017 13:05:10 -0700 (PDT)
Received: from localhost.localdomain (186-245-85-163.user3g.veloxzone.com.br. [186.245.85.163])
        by smtp.gmail.com with ESMTPSA id 137sm8162258qkd.19.2017.04.02.13.05.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 02 Apr 2017 13:05:09 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v7 0/5] [GSoC] remove_subtree(): reimplement using iterators
Date:   Sun,  2 Apr 2017 17:03:03 -0300
Message-Id: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
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

I screwed up in v6 because I had introduced a bug that in case git tried to open
a directory that did not exist using dir_iterator, the program would segfault. This
was amended and all commits are passing the tests. Sorry for not having tested
my changes properly.

CI build: https://travis-ci.org/theiostream/git

Since the changes in v6 were not reviewed, I'll just copy what was sent
back there.

> Back in v5, Michael had a number of suggestions, all of which were applied
> to this version (including a slightly modified version of his "biggish rewrite"
> project to make dir_iterator's state machine simpler). The only suggestion that
> did not make it into this series was that of not traversing into subdirectories,
> since I believe it would be better off in another series that actually required
> that feature (that is, I do not want a series to implement a feature it will
> not need). The same goes for Junio's thought on a flag to list *only* directories
> and no files on the v4 discussion.

> Junio and Peff's comments about how to write to files in the tests were also
> considered, and the tests were adjusted.

> I chose to squash both the state machine refactor and the addition of the
> new flags in a single commit. I do not know whether you will feel this is
> the right choice but it seemed natural, since most of the state machine's
> new logic would not even make sense without encompassing the new features.
> I am, of course, open for feedback on this decision.

Daniel Ferreira (5):
  dir_iterator: add tests for dir_iterator API
  remove_subtree(): test removing nested directories
  dir_iterator: add helpers to dir_iterator_advance
  dir_iterator: refactor state machine model
  remove_subtree(): reimplement using iterators

 Makefile                        |   1 +
 dir-iterator.c                  | 196 ++++++++++++++++++++++++++--------------
 dir-iterator.h                  |  28 ++++--
 entry.c                         |  38 +++-----
 refs/files-backend.c            |   2 +-
 t/helper/.gitignore             |   1 +
 t/helper/test-dir-iterator.c    |  32 +++++++
 t/t0065-dir-iterator.sh         | 109 ++++++++++++++++++++++
 t/t2000-checkout-cache-clash.sh |  11 +++
 9 files changed, 316 insertions(+), 102 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

--
2.7.4 (Apple Git-66)

