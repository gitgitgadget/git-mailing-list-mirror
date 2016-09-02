Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5BE1F859
	for <e@80x24.org>; Fri,  2 Sep 2016 08:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbcIBIfn (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 04:35:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:51524 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbcIBIfk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 04:35:40 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LtaDM-1az1DL0iDE-010xk3; Fri, 02 Sep 2016 10:34:27
 +0200
Date:   Fri, 2 Sep 2016 10:34:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Let the sequencer handle the grunt work of rebase -i
Message-ID: <cover.1472805251.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kr/gpf7oZXpO2xq9njGrwugmO5PFzH+m0+qL8nq6f8R5zMiGg0M
 zBWdk4Z8u9+Q6yULYLuZxH3un9hZw8MFBmdwaxifwRCWjHiuxoIwCIUsXj9k0MCPWKbtHY1
 7ssZY+PveMUcO/QvD/tSwuqlpEnijWCp2vtDeR1TlThXuVb9R47y/cWdXEaklYxJ8ARCYQy
 Lg9QxQ71GnWzD2QLUMg7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eybdAjhrfvs=:GBl9d+IoKxAti4PEkSPDDP
 BvWBJYmqssa+RRn8vH1WAf945W71OZsRtqTbj6qnEItht7VN68XHgNBuZ7bWqpmVEeyMNusz6
 g3LdZRingekPLApvGhyLLQ4Bg8IODrQ4/wTtLDP+NZk0Bco4CevmyNZY2SflAN69hoDrhq3vv
 qVAkJoLzYQtfbdUUeDWAC5qdGJyzHSVwea4SepvZO+olWrNPBUU16W/7BHDmqBKKgrxYxXs8A
 vsf9nCYtnffmoKwGcqEN1gIAAlaMeRu8Y1Iu+8rV6gf1x+ZWdIjsZTd1btEihTFgikhEnBSZh
 T/wtzIIMSf2AhYiawWvYD0qlmOTXiPoL7eMycvhA4x3OFes+gBof/FNf2eSSTbfWBB4gu4YGj
 Rqwzn2H90e9Bgv1iDZBxHIUC4sYUPdewQn8WuH3H+TjQ4YHYRutrveZUN4mE+ooP41E7KC1VY
 Ky6Cmm+EG1/InA1pvzo1541xlTtBD0kvB4anWaQVfTgJnX68UW2KWA9IpmidmdoT/Drv45pYF
 216mgcSk7wjPjaDywczhawy82A0wxFFXi0auqhsPmC/boeH5mXE8gxT303Zn8ERZhcfq18X0Z
 OaqeMtEw7QP+mi0EeiCUkHSUhXT2+tMaLt0pJlgG/PP+jubggV8oV+omzSU4FerBYHEcVWnC6
 UI0PMf3Znd4tasI7Z5EZ6/cKwJMDJtZhCRhm/mFX/Q/dkASrpevUg+KxN4AtL4JujhC55P2EH
 hgB+aUiGBg8i0MCK4da6FyVUdVbwgRn7Mpz5N6I8Y3EzTucDwMLl5ElSNYb8/ouwrDwLca0Us
 AxUlGjz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After all of these patch series y'all had to review, this is finally the
one that switches things over.

Please note that it does not (yet) handle the `git rebase -i --root`
invocation; I tried to focus on the common case, and I rarely use --root
myself.

Please note also that --preserve-merges is *not* handled.

The way I designed --preserve-merges is totally stupid and idiotic and I
do not want to spend any further time on it. You cannot "pick" merges
and hope to be able to reorder commits, for example.

And please finally note that this pair of patches does not yet yield the
full speed improvement that I promised earlier. After these patches, the
time is dominated by pre- and post-processing the todo script, at least
on Windows, so there is another patch series that ports those bits and
pieces into the rebase--helper, too.


Johannes Schindelin (2):
  Add a builtin helper for interactive rebases
  rebase -i: use the rebase--helper builtin

 .gitignore                 |  1 +
 Makefile                   |  1 +
 builtin.h                  |  1 +
 builtin/rebase--helper.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 git-rebase--interactive.sh | 13 +++++++++++++
 git.c                      |  1 +
 6 files changed, 57 insertions(+)
 create mode 100644 builtin/rebase--helper.c

Based-On: sequencer-i at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git sequencer-i
Published-As: https://github.com/dscho/git/releases/tag/rebase--helper-v1
Fetch-It-Via: git fetch https://github.com/dscho/git rebase--helper-v1

-- 
2.9.3.windows.3

base-commit: bbec81903b5e46c481fdc0cfe6f10166423526f1
