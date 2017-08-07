Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28E52047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbdHGTjU (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:39:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:52271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdHGTjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:39:19 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MH07e-1dsbdi3WNu-00DnCI; Mon, 07
 Aug 2017 21:39:12 +0200
Date:   Mon, 7 Aug 2017 21:39:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
In-Reply-To: <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1708072136290.4271@virtualbox>
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause> <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:brkrsFj/fZ/4x2pRT8b0kuyGHJEFoTG82Bpyd8G5C/RvcefSSbS
 Hs0aNSKHgH4Rv2cUMV8DGDnN+VSgzheRmXjhnBWJNz0gBsShmNwVipn7rmp6IKrmjTT7nRR
 v7znwS6NtrckmXd8DkvdDDfgF1suJmmFAwTwW1yS/RhBWnMLSDqZgrvCqxnweq6/AkOrj6T
 +m41cE0J0bzuawlsnYXLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HByyhOHnU40=:y033x3+mvE0boJ0Hqkekau
 9oAf74wiyjhxIKol4GiYuebsQftsLi5NO/PjTbNO0rLih7pKH0fN0UkOfqYGVeSbxOiBXtSQF
 nOdDvQDYuQk6dt2EX+vIlLfnHQ+/kSj7H2gUdkehp5YqfuXdFGdyX++NG7uRyFd2Li63aDqSl
 wl0rIdaF/21BeXEFIFBebKpHEpJwkb92jkx+aRCuKzQjVrtXN0wx/0uAQaOes7G72tLW9sP/Y
 T/dnTKYd0Hnu01H5A/ivuIXpYmpWSmY7Qu9teZHaOiW8BJRcw5Y45P3Iskz8a3bUfLrlpRwCJ
 /X6OU9JRG5lq4hRMCmEXycg8BC9986hcYz48umnX8NpnEuJDnwVOyQR9yGePw6skkb3kgvEsA
 NV54LqTWRQYQyEGlslEftipFzMaI31AbHz0P5juVC3yLVBjE7OCWIuLL1F7shAeF5OqogsI61
 pHASH6+j0RubakCcnsLamhUO3hC65Oxzdp3WoBgcbdqYlFexvi313Gv3fQCE7by/FT7RP7SMi
 cfCw9dGo8QE5VBvTfm4h4FcJFc3Lxfx/XuxjKb8SurvuA0h2jcui2b7dZzxGtBlII5quiOFud
 sA6ZmPPuThlPSMT9ZF0/Kb35f6PbJDA7Q1DqWhz7c9mtkZlzyZxCfH1N03reeUTp5Pq3uy41K
 7zQiNCnfMPKD6KhLt27RWtON01SmDuOKufKMso/ictNLdl9d2EdG/bt3ABeoYpHJKp2cAnNIq
 EmfP0al07yfHWMvZgjFchsJpv2hzYSars8Yy3M5E1wBGFh4MQ10ihBk+fkofmybc1SPCD2+VR
 qm3KKUVbEnyGnArPJAWd1cuR1+5LS2wDc1aXk2ZbnnG8BlFS40=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 7 Aug 2017, Junio C Hamano wrote:

> Martin Koegler <martin.koegler@chello.at> writes:
> 
> > From: Martin Koegler <martin.koegler@chello.at>
> >
> > The current delta code produces incorrect pack objects for files > 4GB.
> >
> > Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> > ---
> >  diff-delta.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > Just pass any file > 4 GB to the delta-compression [by increasing the delta limits].
> > As file size, a truncated 32bit value will be encoded, leading to broken pack files.
> 
> The patch obviously makes the code better and self consistent in
> that "struct delta_index" has src_size as ulong, and this function
> takes trg_size as ulong, and it was plain wrong for the code to
> assume that "i", which is uint, can receive it safely.
> 
> In the longer term we might want to move to size_t or even
> uintmax_t, as the ulong on a platform may not be long enough in
> order to express the largest file size the platform can have, but
> this patch (1) is good even without such a change, and (2) gives a
> good foundation to build on if we want such a change on top.
> 
> Thanks.  Will queue.

This is sad. There is no "may not be long enough". We already know a
platform where unsigned long is not long enough, don't we? Why leave this
patch in this intermediate state?

If you want to work on data in memory, then size_t is the appropriate data
type. We already use it elsewhere. Let's use it here, too, without the
intermediate bump from the incorrect `int` to the equally incorrect
`long`.

Ciao,
Johannes
