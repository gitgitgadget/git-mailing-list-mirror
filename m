Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94091F428
	for <e@80x24.org>; Thu, 16 Aug 2018 08:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbeHPLdj (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 07:33:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:42723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbeHPLdj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 07:33:39 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCxfb-1fhevn3iIl-009ku9; Thu, 16
 Aug 2018 10:36:37 +0200
Date:   Thu, 16 Aug 2018 10:36:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: fix SIGSEGV when 'merge <branch>' fails
In-Reply-To: <20180815093935.10222-3-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1808161036200.71@tvgsbejvaqbjf.bet>
References: <20180815093935.10222-1-phillip.wood@talktalk.net> <20180815093935.10222-3-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BREnqT/VCeU2cP6rnwM2tZVMMHIcI6no+7E5pXyH7WjLNWAupeo
 kS9MwOVrCJSiCKOqO4HpddMhGddDZW8Z1m6x85VIE6k0aRsrtnEVo1yV+tZKB2MZUYG8Ta7
 +KUX5Gq3YoSTFNlljstQxDoQHbP1VjLLt8qOBt6VyJkhFcwEVeZmv/56gbboS+SCVqd6wrV
 x8IkdQkWjRUKUW5FDoQjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YnhFAsqtejE=:V9WQFy7ygxCSIu1mgsFSP8
 n8n0Jh7D0wCPXGwjFGy5MAP/3knbvWGd9evDeoP8+goqt1wiW6el71vVkPJf3qTn/4EYQcefs
 6iz1ksskYcsv7vpvQ+9VCxLla53UgpjCo1gQ7bPrbaiqDdMuenzt14Rbp0L9JjRUhm2F+hc2I
 wh7aKDBrBlrpuOPqxnMAEhv6zonNShW1C+UUg/VCLkrw1Es3CAQznX+vOpoTuJs4MzQgZrESS
 /E8rVJJ8KgkHPG2nbwjg646Oo9ZY5s4ccoAwJEsnpE2NHYyZhJaaTX7QtOPJtPSWbbgAkbkaD
 oWMR0MlfxJI/b5gJlxqqhC0DC3qSwRFbzsnQDu11EPEyJxxXP/R1/E/QVmO/tEhzfkEXMLaJ1
 Ro6QCb4HfJEn/WsvTyKAqVH3sypIstmvrsnHyLiyb1Gg0l6c8cC9gkNIgfoLzcyuJbYXENVDU
 pXRsg325aPTStjugFzKLSkwnRhe3Q2m15Jia1R/z+5R1r0X8LK8thkwKZw6hj3RUhOorUfu9W
 ovm/ASBDm2Ba9GIUnKbE3aBuOixK+g8uXxgdgLcQq3dNLM+rvRBAtVAz/g9WR2TGeX+l5WtGH
 07hmLaTORNp7X/XbAeIzjl3+H9YvofRInDkrT16dV0xDj3XBZYPRSgd9+jR9+OtxDPly60STu
 78vNH7yaNiKuqcHKj6hESJmTW+hAYZDj6UAnDfZtdXjPj6HWgx3TtCKQUgFVoEjt239Lb4+SS
 1OYd5UOnWNr+UECKOi6udKdZXj/fv7/OI0ZRRY3Ib031HWIa7/3VQQrTv+6dqLMrm93byr4kc
 AwsMePN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 15 Aug 2018, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> If a merge command in the todo list specifies just a branch to merge
> with no -C/-c argument then item->commit is NULL. This means that if
> there are merge conflicts error_with_patch() is passed a NULL commit
> which causes a segmentation fault when make_patch() tries to look it up.
> 
> This commit implements a minimal fix which fixes the crash and allows
> the user to successfully commit a conflict resolution with 'git rebase
> --continue'. It does not write .git/rebase-merge/patch,
> .git/rebase-merge/stopped-sha or update REBASE_HEAD. To sensibly get the
> hashes of the merge parents would require refactoring do_merge() to
> extract the code that parses the merge parents into a separate function
> which error_with_patch() could then use to write the parents into the
> stopped-sha file. To create meaningful output make_patch() and 'git
> rebase --show-current-patch' would also need to be modified to diff the
> merge parent and merge base in this case.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

ACK!

Thanks,
Dscho
