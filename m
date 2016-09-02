Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D46220193
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbcIBQXO (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:62313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754240AbcIBQXL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MYsEZ-1bbmU61uRH-00Vf6H; Fri, 02 Sep 2016 18:22:57
 +0200
Date:   Fri, 2 Sep 2016 18:22:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] The final building block for a faster rebase -i
Message-ID: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:55TjWxdtC1/8KqW23tKFHcww4dsPFn3jqDQGnkFQb2SUfd98tWE
 UKLBRMitOKoQptMkuwqlkGtSb7BBqzwRK5NO9KFtTnrW8sjys1ah36oyK7EVBoKird7z1kB
 VHrBo54YVBybC02oDhRmC98vYzlMP8s9Jycb+u9rmmRNc9RKrCQxtXyXp2xM/z/klde5iSL
 5YhTsV1DNZx8z64/6oQMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Udnr8M3hh80=:RF19zzNTgmeN1ObFOxhvzZ
 NbrR/s2tKWcYEBijuV/JkzYEGUi0AjisVnJ6oR+oWQyTZUnuG8VW/8jQa1f6Q2Y+nzsnNb/IJ
 739gMD/V4aWBFlhRVTXBfmZGrJ2U6MwBbmMcdvAMGW5i8+chJKcbehAtT7inxagqjTVQrM9xg
 Wc/7kKofUHNA1xqGNyRN3vz4ZGCtYWENrz4D06wuOYebELugKUE2mou49sQBt7Vjymxe/G5AZ
 B4QjQR3/2thskzwTuZc1Dwjj8lFOgXD9FKF5x5aQQ1sJQGdX8LlNE5CU7wQbwughg3PMxrXQk
 VMV6pTW3vM9PFNhQtupQT8kwLO04LWyO/cMs4j2F4ppvvpB+0yMzXWW7yu6WvPv+YCDRXu+QK
 pIwkagONm1ziwqt0kCD0tysUcQsnpEqe5K2eUR0xrQ6/FdCMBu/7L0Ba5xM4DaYa5W4NCJvYH
 PALDZcW+Sx/2xgqZ/Zp60Lljf52+Af2dJUf7soNweVG0qp/BzZJzBfG3VBPnilvSNqe3v8Wt+
 wYykIglpjzsQp4ZZqzF/A0CMiE+62jsfiBpz0Qmpvky5azjf923F9uWfjBhbx3Dn+sJr59vn2
 DshNDvQYCSjIkd2/gDsm/GwhyIFxVBJ0UyXK1YjQMxuduV8lQ4FzmSUu278nsT85llfHQwxWZ
 aNLTDDtpaaRIgxU1MsG1j6Wus6uio2pjlo/v90lm81OJjBccl85hLbE/bhavRqBEYGcvjahXz
 HlfbUMEQXBg4Y0UCnxPMfZK6Pb7fK+71hOoS7LRDRqzf5Zae4OnM7Lg6+2GxYGwsTu1eVuKnb
 F0PyAU9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series reimplements the expensive pre- and post-processing of
the todo script in C.

And it concludes the work I did to accelerate rebase -i.


Johannes Schindelin (9):
  rebase -i: generate the script via rebase--helper
  rebase -i: remove useless indentation
  rebase -i: do not invent onelines when expanding/collapsing SHA-1s
  rebase -i: also expand/collapse the SHA-1s via the rebase--helper
  t3404: relax rebase.missingCommitsCheck tests
  rebase -i: check for missing commits in the rebase--helper
  rebase -i: skip unnecessary picks using the rebase--helper
  t3415: test fixup with wrapped oneline
  rebase -i: rearrange fixup/squash lines using the rebase--helper

 builtin/rebase--helper.c      |  29 ++-
 git-rebase--interactive.sh    | 362 ++++-------------------------
 sequencer.c                   | 514 ++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                   |   7 +
 t/t3404-rebase-interactive.sh |  22 +-
 t/t3415-rebase-autosquash.sh  |  16 +-
 6 files changed, 614 insertions(+), 336 deletions(-)

Based-On: rebase--helper at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git rebase--helper
Published-As: https://github.com/dscho/git/releases/tag/rebase-i-extra-v1
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-extra-v1

-- 
2.9.3.windows.3

base-commit: 4c39918f42eb8228ea4241073f86f2ac851f4636
