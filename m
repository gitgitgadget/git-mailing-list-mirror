Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A621FDEA
	for <e@80x24.org>; Mon,  8 May 2017 09:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdEHJlq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 05:41:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:50751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbdEHJlp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 05:41:45 -0400
Received: from virtualbox ([95.208.59.245]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LslCb-1e9teK3MRV-012IhO; Mon, 08
 May 2017 11:41:38 +0200
Date:   Mon, 8 May 2017 11:41:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
Subject: [PATCH 0/1] Preserve the untracked cache across checkout, reset
 --hard, etc
Message-ID: <cover.1494236457.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:maz+v0fefoh9aiYs4baG0Jgai/bexM71AwOpWuqRM7x9lL+5dk6
 jjPffpYsjwfLkiqu/N9hn/0L9rEjvPg7goN1g3A9Cq/2xTqOofufdemXPGa9boBu3G9as27
 oI+XwLfT+jKBX3LW1k5zy0inH+qz7zejsOh4l2Qxhyk5vHAyLfa5tVsmMzOE2zw7hud5Wkf
 fDMd3tfXMX/yJA0wR0EzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UNrGhCewdkA=:DcUnZmYEb8EhfIw3OvG9v4
 WmrGac2y4kkF2Qd5Tqu8/5tw1a09vaS4s2y3WKqFIace/yczeMq3yTt2x21mGh/D3p5DDGbec
 HA0EJCyUDXlF1U9tcNzUnt4MbgRnRMoMmk3IU6pLmtwCKC1Tk9O910CKY6VxbGL/vFkEnzEtu
 9wImPwfzFT2ls9ODG6As5j+AsBF2GmArrtbll8WzyAu7Jnf/yVPYgFjdp1TcqGBQ1LyS/O7aE
 STdbdYxS+omVctxegaDF1wzePyh0Pfs+rXR5TD47eu8pIvAuItZtGGEYncriEPa5JuwaO1iX/
 xGrYucAPZp1l5k5xjuR7khm1c1RZ+8CdB+k62WF2DmbPVm33eRHqsMegz5v0xVQ0gqdCMJi4P
 y9I6SHHF1jT0DCbGkPUUbV4v00AcbO8y0pKTiErdVHgAm4BvDIMRazZIrYbtiT22+ZTf7EmHu
 GtAVdoYjM934WgaE3cIAP3QqaGXpWEmICMebI6kltNzjYhUIj7fmWEc3A+81Pm0fIcl5E/wyy
 5U64MB6qAYiyGVtFbPY6dIrCt/H0dRxFocZz2BULjNTzekSIoqTHQcGJitiApF4lCa4P7pXZ+
 b3ljxQusfUlGYZyB0u2/KbekRG8XnZZ2ME8PL2VpMHyECwAHKyz0cKdnPu9t3mUF2nBVorFbb
 EOkriG1wT5Qpm57Q7gBgKeKcMyIycSiBHYF4OEuWMWHxaRzOu8sYnL4UxuT/UjFzKZgqc9Qxj
 kk0yQ3IfIGWWFrn6tVN0xMt+NDAESl50QUGp8Nt/MhzagjFjKN9DBTZB5LVn64hfnuMzKMreY
 KQqJuH1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently sent out a request for assistance, after noticing that the
untracked cache is simply thrown away after operations such as
`git checkout` or `git reset --hard`:

http://public-inbox.org/git/alpine.DEB.2.20.1705031202470.3480@virtualbox/

Duy responded with some high-level reasoning that it should be possible
to simply reuse the untracked cache data structure in the new index, as
he had a gut feeling that "we do invalidation right".

I did not have time to back that up by a thorough analysis of the code,
but it turns out that it is unnecessary: Ben Peart pointed me to a patch
of Dave Turner's that was submitted as part of the watchman series,
addressing the very issue about which I was concerned.

And I trust Dave to have validated the idea that the untracked cache
invalidation "is done right" even when we simply move the pointer to a
different index_state struct than originally.

Seeing as the untracked cache being dropped unceremoniously when it
should not be dropped, in a surprising number of operations, I think it
is a sensible change, and important, too, and independent enough from
the watchman patches to merit being separated out and applied pretty
soon.

So what I did was simply to drop the two lines from this patch that
referred to index_state fields added by Dave's watchman patch series.

Please do not mistake this for a sign that I am disinterested in
watchman support, far from it... stay tuned ;-)

Oh, and I adjusted Dave's email address. Dave, is that okay?

As we are in a feature freeze phase, I was debating whether to send out
this patch now or later.

Having thought about it for quite a bit, I am now convinced that this
patch fixes a bug in the untracked cache feature that is so critical as
to render it useless: if you

- have to switch between branches frequently, or
- rebase frequently (which calls `git reset --hard`), or
- stash frequently (which calls `git reset --hard`),

it is as if you had not enabled the untracked cache at all. Even worse,
Git will do a ton of work to recreate the untracked cache and to store
it as an index extension, *just* to throw the untracked away in the end.


David Turner (1):
  unpack-trees: preserve index extensions

 cache.h                           |  1 +
 read-cache.c                      |  6 ++++++
 t/t7063-status-untracked-cache.sh | 22 ++++++++++++++++++++++
 unpack-trees.c                    |  1 +
 4 files changed, 30 insertions(+)


base-commit: 4fa66c85f11bc5a541462ca5ae3246aa0ce02e74
Published-As: https://github.com/dscho/git/releases/tag/preserve-untracked-cache-v1
Fetch-It-Via: git fetch https://github.com/dscho/git preserve-untracked-cache-v1

-- 
2.12.2.windows.2.800.gede8f145e06

