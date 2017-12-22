Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3EB71F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756906AbdLVXzk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:55:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:61814 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756902AbdLVXzj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:55:39 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyA2L-1f4hxw42rt-015Y02; Sat, 23
 Dec 2017 00:55:34 +0100
Date:   Sat, 23 Dec 2017 00:55:33 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 0/5] A couple of sequencer cleanups
Message-ID: <cover.1513986836.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qt8yG6rg3JDSZlbBE0/nn+Okz5nySqfchRiQzSpI/G2bRvEy2gl
 Uz+fh8OfHUn1VfFaKNZoIQ/swthCbcU3eMAGvIPOcyDp4YjuoI5jz3SSo5fbbU8Dd+ufyin
 NhmooTUfeDOW25NC3z98qSsF9WOvEunRx8fpsJxv4wDleGWOusay23X3l/vxf9EcqpQ2aav
 yFnRUt50p5iGhYe1ZPv6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M0DLS5awT1s=:kr5i+BG+DNYTpliyv1zMyL
 14yFe0f1Da9KEHl848wJ2lAFTNeaPOxTF07GTyLYABwspYtsPbkmLkmQ0I010MPDTN971hLzI
 Rvd8fN8T+ut2NwsS+fChB6b2yHJ4RnrG+ffnHRzMFMf8DlHx5DOUxPHWeXrgzEXcPBSuzIKZQ
 ab7xNqRC5UkSXr7BwyzWU3EeWAu4Uz/WIzUkR4SbiNYZg9XIlIIhLDusqALZdY84yAjtTaCrI
 PmxixldNV7potx77+0ItSZAmh9er6/lDxkQC/53qht6k+5wjLNcK4unqwNeVeMg/zOkq3jmeA
 eqyQj5ANH9/XHsS075K6PwS7/tjmzdC1e0XokrW0NXM/zaXIgOw2URkTSeqHpCk94Vza6Xpi0
 gtMw6auxeWKuZ8Wr594ac56B+GJuBQFt8LLmv10Njg+0qVryJWGo0FNRUvA/nPm3odXptA1Cm
 ku1wlQcjDwmUDjg2Wml/6Qg4XlFG7SyJnv8E9pZLNwjpbw5bIWht0IA6ShOPXlxADZvrinVOR
 FB+DaZQnmTwjqT5Aaa9WhM6x8UFnrrNobbFIuKSZefPrKp0ZC0+nTc/ZbxgR3T6nAvGjxhzqm
 lhLOnUs6SKD03h/b4CyCwlDMEGD02NGcq58KpK5dy6pu/bxdzNqG0R5IHzhpPIGmI4i0f7Eu8
 evVQxbuE9K2YU6Lt9qeKmktOgWaFeLaADgGQjKMUbqwpcIIc5DJEIlU7vVktmh2MyaEsW2FBX
 Wph+9HmEpuIhzYBuEZzj1o6WAMSsf02bQrUW2bhP7jrF5XeagyApN1a+Mysws+qZduUIQI0LF
 JKeY4UshLiVBGKYZUchfpV4yVJ/ixEGBH0lZfrOB5Sk2j6rE98=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on patches to teach `git rebase -i` to recreate branch topology
properly, i.e. replace the design of `--preserve-merges` by something much
better, I stumbled across a couple of issues that I thought I should fix on the
way.

The patches are based on lb/rebase-i-short-command-names, mainly because the
new `--recreate-merges` patches benefit from the patch "rebase -i: update
functions to use a flags parameter", and I was too lazy to resolve the merge
conflicts while rebasing the patch "sequencer: do not invent whitespace when
transforming OIDs" to the current `master` branch.

Oh, and by the way, the `--recreate-merges` feature already works. I used it
to develop the patches themselves. I do not have time to pass one last time
over them, so they'll have to wait for next year to see the Git mailing list.
If anyone wants to have a look over them, play with them, or even wants to
review the patches:

	https://github.com/git/git/compare/master...dscho:sequencer-shears


Johannes Schindelin (5):
  rebase: do not continue when the todo list generation failed
  sequencer: strip bogus LF at end of error messages
  sequencer: remove superfluous conditional
  sequencer: report when noop has an argument
  sequencer: do not invent whitespace when transforming OIDs

 git-rebase--interactive.sh |  3 ++-
 sequencer.c                | 30 ++++++++++++++++++------------
 2 files changed, 20 insertions(+), 13 deletions(-)


base-commit: 1795993488bef1b48e4224db096e9d12df075db2
Based-On: lb/rebase-i-short-command-names at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git lb/rebase-i-short-command-names
Published-As: https://github.com/dscho/git/releases/tag/sequencer-cleanups-v1
Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-cleanups-v1
-- 
2.15.1.windows.2

