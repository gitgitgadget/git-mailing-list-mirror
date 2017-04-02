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
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F2920964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbdDBEfq (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:35:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34054 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdDBEfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:35:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id x35so15089993qtc.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 21:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xSyWB+q5ZvcyNO+80kB+o+gpAEGeT8bbgJUgAqde2KM=;
        b=gzaWFCs8NbTzC2HkTvN8WlKHNEAbvfAjqxNxvc6lqL6fky38CIFBVd2ABBDMMjn02T
         TxANxc9+TqRyBY6hcpp6KDPB7T1dV9QlMisNoVlObzHgaiyOCYHDhLBukfVZ6F2qiWnR
         es7PJhLu1gCvwKBotq0kyCEr4AxC97+DdKHcLDOIX7muibtoqSIEwqBDiUFs6BXcnMob
         4Mxso5AslvQ4UcPJPSE5xG4pkXd+AowQmjnKXAFoPe9f4Xj0CgLL5TPthzrcoOxQDu6T
         sjPisq3c7SrK7U81W6ihNh/cz99VlG3xTnv5tofbwBBCHkwBB8sGMWVTI0iOxPjnrFwz
         /kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xSyWB+q5ZvcyNO+80kB+o+gpAEGeT8bbgJUgAqde2KM=;
        b=Ry7c1kwJlP8u+h8+5eBHADKzRVtFw4gHQCIxyV1fYCspZyJVxtuhV4IzTwgNmEf7iY
         33ru1UX6secLuIZqFt8kzP+gSauv+ZWjyFG1I78+5oZamLYTxRhZGYrZ6+k8vDc1Cl9V
         scWbkbT4q6EF9RDioFgyN7OMOgXMr/wNvZAHpgE7J7npzmh3mfXckhXalZYnUiwDaJ4I
         RS870ncOQbZZ4ccA7uEhcM5tYf+sGXAi9RauNsrUMUaqOU/V3afRPYJ/bQvoYYynk/H/
         kVS3lpEuyjv49QhIrzvMD1A2EqyKFqCu3QuFf96l8dJ4M+Rj9hZyIHoxygSV36c1yHH3
         v39w==
X-Gm-Message-State: AFeK/H20NhiQ8PQuN8TXMjpPKFwuxereYHu3qsmVvXMEqfu6CRROHVFPJpVuG3X/8uir0w==
X-Received: by 10.237.43.68 with SMTP id p62mr10345378qtd.207.1491107744775;
        Sat, 01 Apr 2017 21:35:44 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id t23sm6907383qka.37.2017.04.01.21.35.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Apr 2017 21:35:43 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, peff@peff.net,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v6 0/5] [GSoC] remove_subtree(): reimplement using iterators
Date:   Sun,  2 Apr 2017 01:35:21 -0300
Message-Id: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the sixth version of a patch series that implements the GSoC
microproject of converting a recursive call to readdir() to use dir_iterator.

v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t
v4: https://public-inbox.org/git/1490747533-89143-1-git-send-email-bnmvco@gmail.com/T/#e437a63e0c22c00c69b5d92977c9b438ed2b9fd3a
v5: https://public-inbox.org/git/1490844730-47634-1-git-send-email-bnmvco@gmail.com/T/#m2323f15e45de699f2e09364f40a62e17047cf453

Back in v5, Michael had a number of suggestions, all of which were applied
to this version (including a slightly modified version of his "biggish rewrite"
project to make dir_iterator's state machine simpler). The only suggestion that
did not make it into this series was that of not traversing into subdirectories,
since I believe it would be better off in another series that actually required
that feature (that is, I do not want a series to implement a feature it will
not need). The same goes for Junio's thought on a flag to list *only* directories
and no files on the v4 discussion.

Junio and Peff's comments about how to write to files in the tests were also
considered, and the tests were adjusted.

I chose to squash both the state machine refactor and the addition of the
new flags in a single commit. I do not know whether you will feel this is
the right choice but it seemed natural, since most of the state machine's
new logic would not even make sense without encompassing the new features.
I am, of course, open for feedback on this decision.

To Michael and Duy, thanks -- really -- for the encouraging comments! :)
I never regarded this microproject purely as a means to fulfill a GSoC
requirement, but as a way to get to learn more about Git, so I'm surely
not giving it up.

Once again, thanks for all the previous reviews,
Daniel.

Daniel Ferreira (5):
  dir_iterator: add tests for dir_iterator API
  remove_subtree(): test removing nested directories
  dir_iterator: add helpers to dir_iterator_advance
  dir_iterator: refactor state machine model
  remove_subtree(): reimplement using iterators

 Makefile                        |   1 +
 dir-iterator.c                  | 190 ++++++++++++++++++++++++++--------------
 dir-iterator.h                  |  28 ++++--
 entry.c                         |  38 +++-----
 refs/files-backend.c            |   2 +-
 t/helper/.gitignore             |   1 +
 t/helper/test-dir-iterator.c    |  32 +++++++
 t/t0065-dir-iterator.sh         | 109 +++++++++++++++++++++++
 t/t2000-checkout-cache-clash.sh |  11 +++
 9 files changed, 312 insertions(+), 100 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

--
2.7.4 (Apple Git-66)

