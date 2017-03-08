Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9CE5202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbdCHPoH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:44:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:55237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751900AbdCHPn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:43:56 -0500
Received: from virtualbox ([37.201.192.247]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZCUG-1cXPkj0r1w-00L0uq; Wed, 08
 Mar 2017 16:43:29 +0100
Date:   Wed, 8 Mar 2017 16:43:27 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Fix crashes due to real_pathdup() potentially returning
 NULL
Message-ID: <cover.1488987786.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wPHVHJH82msD7Yw7bzfjMvPXneTx8fyROiDMmMeBUOt0ki5L4bu
 m+KR3ktm95Mf5QHYivmWtmF7q3MD0CTKeO0mOyKdRMcfncB/IxiMHAfgkTxvlmfFoLM4eFy
 0Gj+SIGFoBWYnyuYNnf80GgbiHg2ZpV//QC3dYfmmktGmB71MDSjbI9q51elfy1fmVReihy
 PqW+xpOjJQoHUvKbTgFdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sm3kCX2JT7I=:o42GsmacY6/QcYJQ2cPbWJ
 CnP5Cbg3cyf9ZemroqXhwgNjssbgIts67zOedhXjotMVZzVxeOw81kZ1Jf/ChHPM2XAQeccif
 bpgbroTdVC3wqq9Dodungbt85Legbs1cbcN4LbmD90+CBXc/G1vfbswpaTmoaKJaHi0u75owZ
 cM/3kZOvWbHHRbEschGEzmwcQ3dmJVOb6O8SsNSwo7IgON8e7M3r4M7ML71bWQ2RyXFAyDycw
 VrywlEh6GYWhc0QsE9irtjbqVb+9qgk9CIGj8aSXQvGwHNti3EBkWzGAnJ76xXIH0EpCuDqHK
 /JL3j6UDITvdyodjMlgZQ6xj0wsKSOhbEoyiW7fKaIORtiGEZWdK5Ok+cpOMaNYUnAHhUl5ku
 GVBXB+Yo/m5nvKMhRhbB87TjZkh3qD1m2cyM64sToVaOj1w9tHYVePb9C9tF15cyAtPrwirYQ
 3964NBPyavgybCwDC7m8W2Wbl3TR1CTg80b4DIP/37oW6PxL5FuQBVXOPvI3bH6+XhZur3+Bs
 R21kOfumtbonWFUY44prhj4UFwHJiMd+irxZxRcsQIb85Xqwn6xvSLIft+wKQKGmjAEIF8bKO
 sz80pTQ/ZOeUruKfX5Tzy3HrqR2BiDGs83gpSE7+3uS1W876eoZkvCKvt53sEhJIYK+FkknSb
 WP3gqDpbZDOgBVlDw+lSRjL7ytSvt/5r8dXbWQU4qs96UeE+tzDcYYOHrpaoyfKTXmTQeE2gk
 LedXiAAoAMkWKZgZ38qXd9Foom85Tv/oLe7G2Ll/CB8lRudlrMFw0bUiaf0tnZZsaiU/CQVUv
 jteInrP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This problem was identified as the root cause for what seemed to be a
path conversion problem in the MSYS2 runtime at first glance.

Original bug report:
http://public-inbox.org/git/CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com/

We may want to consider fast-tracking this into v2.12.1, and to that
end, I would appreciate code reviews that focus on the correctness of
this patch and that try to consider undesired side effects.


Johannes Schindelin (2):
  Demonstrate NULL pointer access with invalid GIT_WORK_TREE
  Fix callsites of real_pathdup() that wanted it to die on error

 abspath.c            |  4 ++--
 builtin/init-db.c    |  6 +++---
 cache.h              |  2 +-
 dir.c                |  4 ++--
 environment.c        |  2 +-
 setup.c              |  4 ++--
 submodule.c          | 10 +++++-----
 t/t1501-work-tree.sh |  8 ++++++++
 worktree.c           |  2 +-
 9 files changed, 25 insertions(+), 17 deletions(-)


base-commit: e0688e9b28f2c5ff711460ee8b62077be5df2360
Published-As: https://github.com/dscho/git/releases/tag/real_pathdup-callers-v1
Fetch-It-Via: git fetch https://github.com/dscho/git real_pathdup-callers-v1

-- 
2.12.0.windows.1.7.g94dafc3b124

