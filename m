Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67D420357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbdGNOef (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:34:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:61494 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754449AbdGNOee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:34:34 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMTZa-1dZrQH234g-008H4a for
 <git@vger.kernel.org>; Fri, 14 Jul 2017 16:34:31 +0200
Date:   Fri, 14 Jul 2017 16:34:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
Subject: Regression in v2.13.3, fixed in master: aliases in worktrees
Message-ID: <alpine.DEB.2.21.1.1707141629400.4193@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xQloN90jQmdNu9YsrgLj0bF6JQ3yxMV+pY1O4I3+uao6fMG1ylu
 2ZxfaGUR5+t8/QrghbE+EmxVdLAJL5KHQeWeivZHYUUr692YB3fRL8uaxbpU+sFg1KNKwq6
 UcNT5f4SfbJq0m5yWi2Ma9mjxmoGUiwRPG+IhejFkmA6nvuYqfJJGmb9mcXxucEJlJERi2Q
 rWV1YYDiUO+yh3fdp4cmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4ZsX6GSSGHM=:jE1fEajOrpmnooPdRduWZB
 9xvjs14l64cmsV2yFZPAcj4WzVEWstqF/S+Ao9FFm1r4bqknNU+qwTd1Mp3m9/LsCcOlGGmTT
 IJaXf8ryYNIIBPla1EQ+7nKsoYoh1LV8c+o3ikg4Zg2bZt37Xf7zGVyLq+YFuhSDFroqfw0tB
 uksnd9pnzSdr3uCsJiUlrP+kKuyjnq/ut3n/2vRndINegCZLFRXiX6BacTvQDrPszkr8Tbvx/
 qnT3cqsHXPmTTFXeYCy+FxSFUV92Apevb305QzfHu7x1CEaXx5NqhOdEyzDV3aTN+Cp+Z+I7b
 BnrV6teEivHeNqjmDjHykUMmxfsyQ/F4qFEJayTFuCu+hLHyvn9sBN98JIoFGUmmWDHHPLVUN
 2xjKWF6p6zbPxAGFi4kxxgD15V0jjfdCDyo8W5imuj+WdfWJX+2y65C8e+UCNVsBoHnvNTsTn
 SN97/rTsIvHuqCDoyOor6yY7b09DytQBHDePbdH823p3GoxihavrcPS0bYRd4V4//LWInMg2U
 oej8uQrKBUyREJEwN2x1E5GwDtVlAzWbW1tC8slD+ZxfXSrMnCFA2APQKcW7HMuLFQpMTwztj
 q1cxh0rKCVqCPe0tcmBB0mHGCXNe0Bgj+760W42zHdVazjaRbIv6glAdNxMZSN3OtHA/TDDhX
 oa3WSpvdqh6DkDkEZYjgo+q506QJO/nbiTyvwy14MlhK2AI0P1S3ppy+1/Pum+Z0eUSFHyTJK
 iEHX/HFK8aupKF84EJ9XlQhbTBcjP9lDb/ixNbiahYwm2++ToxIfr2oGxdRIbvh4BBuHQep5a
 m1frmmfmb84+6dEK8dDZuxFs4QhBe1vpmPbYmQPmUOLaVW49js=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

just to let you know that repository-local aliases stopped working in
v2.13.3. This is due to my "aliases via early config" work that made it
into a maintenance release...

The bug is fixed in master already, and I cherry-picked Brandon's config-h
series that contains the fix into Git for Windows' master branch.

I only had to add one add-on patch that falls back to opts->git_dir when
opts->commondir is NULL (no idea whether that can happen in Git's master,
but it can happen in Git for Windows' master at least).

It *may* be worth it to cherry-pick this to `maint`, too, but then, it
looks as if I am the only really serious user of worktrees anyway (given
that auto-gc still corrupts worktrees' reflogs, and it is a known bug for
2 years and counting).

So I dunno. Maybe not worth bothering about in `maint`. Less work for you,
Junio.

Ciao,
Johannes

