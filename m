Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCB41FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 16:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754016AbcKYQgX (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 11:36:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:61674 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754878AbcKYQgW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 11:36:22 -0500
Received: from virtualbox ([95.208.59.208]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHso5-1c9U8j1itJ-003bFW; Fri, 25
 Nov 2016 17:36:16 +0100
Date:   Fri, 25 Nov 2016 17:36:13 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: [PATCH 0/2] Fix segmentation fault with cherry-pick
Message-ID: <cover.1480091758.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BzQ0QUO7CAtO1x+9wGDHqEDGeWeGXboTqjqwYTg1SQcR4ykGje2
 WmpZo/cWNUyqni/tLpIX85OMIylclvfDPRp1EuA4fHZcyPZ5rmKOnpqy36w5ruYPtFBorVj
 ZOquMNyKTYqr5qpUtPWnZixkn47qYhR7RD8gqHzTZfS8qqXSJGhhAD/W1tpqUVXiIKDr7u1
 3QEbI5GiBrrpQdptlCdLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:liap3uveJoA=:+hbZ04UfrCVSibhw2szhOk
 3lHDuxSicVWzG5NnZWPqS6Gj2tLV62VDci3z01sZEkvssHZmDe6Kvm4KKC1+L5AzbupyT4maJ
 dSU5RmB3pV9FMEaTz15mN1s8QRuu9K0SPmmGnlUCRR/JuICLxQo47ewS0zhEU1tUJG6GRe9P1
 LBaVuLpDUqNtJjjlnSTMeVfG0aGKzITH8Uci77M7XSg4OvR6DXOtZdjz4rzekOmAyZD5CZ5/8
 +KFm4rBUCFa8IweLbroaclt21vqE5qcP1iWpWLywRBTr58KnrH59kPWNlfkR3X/cXVFx8QrXq
 e8Aj1v23adPn+SAwEqDfB8YtZOMrmtay/6UkvDV9Av5ihhLaKVsSb/G3IcOU3Yd9kwMfwuiWI
 t6Umhru9nR2/Tak2v5j8a3NMzcDBCKlIcK21G/B1/QTiVa9VSRpNnU6f65MGID+qxoW4qjtuY
 wR21kr8h/9Cr48K4pcQS+SWsIwTWJWWlHBxGTtsVx0mTaHDa/CxLIm1llMRMSGKdr8I69Q1U+
 zsBIUYt/CHGaj/hVICB5MxkH7aw+Fd7qk5G+nGb7jNX1xFK9BYPFWd8tFnf0uxQ+1m2l+aN3r
 1BEYFvh9vQ6qnuD/d0qWmbbDos4l645xqsBgbjvCQuBLJkUmSXZ2GMq2Se1yZw4pMlNRmquK8
 AZaBmR/wtg8ZyCalnP+G0qGpJpDmuv9ANdsagwKT5d22tgZmo0OxmPrf49sW0nkQWI+EKKgno
 VFbrtHV9r9CUL8SDAGemQo2HUqt9sp38IjXxWHx4POyj6faoY0eOVPA0VUtMtE7JVkY/asNrS
 HEJwlXM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The culprit is actually not cherry-pick, but a special code path that
expects refresh_cache_entry() not to return NULL. And the fix is to
teach it to handle NULL there.

This bug was brought to my attention by Markus Klein via
https://github.com/git-for-windows/git/issues/952.


Johannes Schindelin (2):
  cherry-pick: demonstrate a segmentation fault
  Avoid a segmentation fault with renaming merges

 merge-recursive.c             |  2 ++
 t/t3501-revert-cherry-pick.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+)


base-commit: e2b2d6a172b76d44cb7b1ddb12ea5bfac9613a44
Published-As: https://github.com/dscho/git/releases/tag/cherry-pick-segfault-v1
Fetch-It-Via: git fetch https://github.com/dscho/git cherry-pick-segfault-v1

-- 
2.11.0.rc3.windows.1

