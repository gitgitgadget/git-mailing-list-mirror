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
	by dcvr.yhbt.net (Postfix) with ESMTP id A92BB1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763517AbdDSNOw (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:14:52 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33018 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763315AbdDSNOv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:14:51 -0400
Received: by mail-qt0-f193.google.com with SMTP id c45so3102336qtb.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vxAqKFMrNLCd28nrpWYixzq311DO9g3eAU4gwyyeHMk=;
        b=AA8iJkayQhjTGlat04Qw64r16o8UPf9Xe8A50aKR/amWrlOMViJ35ccKTGuoSlkLK9
         cVckskvAuntfRTNqLuoiQRDuPWY3w5BzNYFbVrHu7BMtkGAChuS38hf4lHhv1qIU5/ob
         QACQKDaGNPLb5kIf94b8Y7Frr997CAtRVwLSRXlKcLDxRhV0t3v2hd+OWhzlIsbE1US4
         KcGfIxx20w7GUWMJcGnq6IXRQKAV4BDsXDTk5W1Tch6nuaBANsRoDLRFWjkr4i55+mEs
         uM7ZLnJ7YwJiEKqHLnBXjs1tZDP2UYN6ot4tDqYyPrQuK9j4fcLJycilheqbx6gNK6AC
         razQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vxAqKFMrNLCd28nrpWYixzq311DO9g3eAU4gwyyeHMk=;
        b=jO1dbAoDO2aifGNgsTZZWuaNx1MqpopLNfsRNWukupwkyWthpfKqtkhKznjTjUm5W2
         YeepvnPewtIQDViHTj2cM5BpgCUBFZAmGBNfvQVZ3PfTdX8ak5+HxooMFsLmTHnVSk5Y
         iJEpA6B6BY73bn5mZkhio0vR4dK0xc4WqLkELgFekqiUgZ0lSdW7qvl0/iV4W1wI9xUk
         g/d8wPjLtB4YLt8UBffYS+hlZBOcliNr2mrA/JlmqLGpIgUKM8y/gg8Rtgiq/6TISAIg
         VmkmjCvfzhLp9Q2eWQqXWjMfTChm9t1Lau5eLofxlWILET+cf08wa68YAktYJcajd7Xa
         rJCA==
X-Gm-Message-State: AN3rC/5vSzxlj2DP3dhiFEfYg8Dl5txCasoIvoOAZf7afYDrRqziKROa
        XFFD5ELty6W3lw==
X-Received: by 10.237.36.211 with SMTP id u19mr2295241qtc.187.1492607690012;
        Wed, 19 Apr 2017 06:14:50 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id k133sm1835587qke.25.2017.04.19.06.14.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 06:14:48 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v10 0/5] [GSoC] remove_subtree(): reimplement using iterators
Date:   Wed, 19 Apr 2017 10:14:07 -0300
Message-Id: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the tenth version of a patch series that implements the GSoC
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
v9: https://public-inbox.org/git/CAGZ79kaBRS0SFAvrV4mN7-mVk+8QmPKPJMD55zPQ+A14ZzYFYA@mail.gmail.com/T/#me8988b7dd4adbc4ea24946ccb24fc1cf7baf44e3

Travis CI build: https://travis-ci.org/theiostream/git/builds/223542902

I do not know if "queuing" meant I did not have to change this series
any further (specially after Stefan's "ok"), but anyway, this series
applies Junio's corrections back from v9, that were mostly regarding
commit messages or style. I hope I got them right.

The only point I was in doubt was about Michael's signoff. Actually, he
gave it not regarding the snippet for the new dir_iterator_advance()
logic, but to a small piece of actual code he wrote on the new dir
iterator test helper[1]. Thus I don't know whether this would require his
signoff to come before or after mine. Regardless, proper credit has
been given in the commit message, as suggested. In the end, I kept
his before mine, but I suppose that can be adjusted by Junio if
necessary.

I also didn't get whether I myself should have renamed t0065 to t0066
given the other queued patch. I kept it as t0065 since I figured it
would be weird for this patch as a unit to "skip" a number.

Once again, thanks for all the time invested in the reviews for this
patch.

[1]: https://public-inbox.org/git/1491163388-41255-1-git-send-email-bnmvco@gmail.com/T/#m187b9e681e3369862ccc6083bbf6596cd2e19cd4

Daniel Ferreira (5):
  dir_iterator: add tests for dir_iterator API
  remove_subtree(): test removing nested directories
  dir_iterator: refactor dir_iterator_advance
  dir_iterator: rewrite state machine model
  remove_subtree(): reimplement using iterators

 Makefile                        |   1 +
 dir-iterator.c                  | 252 +++++++++++++++++++++++++++++-----------
 dir-iterator.h                  |  35 ++++--
 entry.c                         |  42 +++----
 refs/files-backend.c            |  51 +++++---
 t/helper/.gitignore             |   1 +
 t/helper/test-dir-iterator.c    |  53 +++++++++
 t/t0065-dir-iterator.sh         | 111 ++++++++++++++++++
 t/t2000-checkout-cache-clash.sh |  11 ++
 9 files changed, 433 insertions(+), 124 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

--
2.7.4 (Apple Git-66)

