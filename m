Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE561F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeGIUVP (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:21:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:33639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754528AbeGIUVO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:21:14 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO7im-1fi8xg1dtk-005YXj; Mon, 09
 Jul 2018 22:21:04 +0200
Date:   Mon, 9 Jul 2018 22:21:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: handle empty-set cases consistently
In-Reply-To: <20180709194819.GA7980@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807092220460.75@tvgsbejvaqbjf.bet>
References: <20180709194636.GB9852@sigill.intra.peff.net> <20180709194819.GA7980@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FzRlDNpUDWT+2vwVNz1/ObGZDxdtjManlOxL1zTAw0n0bImtAi1
 yiaqqP7Cp/XCUimMfL+3H8JyBLVrT3Zs2s72O7vJml7TopjuTj4SSMjm4lPg/73n4rQLdOi
 fhVxGmPLbpxa32CHx6foMLHvaey6r/k1lCtojjsNteF9K0okwyzH8P0YA6tZvhSxRnPgmE1
 9XZM9iMJfFn7MXyGF+0hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g1+1lP/7IfA=:Ytx/9PwFhhrOIxr/bv2MJV
 sR961UYjAysN7pKeND6MAAd/M3TW1QqQMTMzHPxq7CVcAmlKLztFiGLsxEGevGV4N5NnzIaUO
 T1PkV0BCSmtQkXhGDLsWc6dXlk9q+nkCuYq7Vwx7CMCBYInyXx8DshIMIxbMQ5mBt/kgqJU3A
 SWc/q7Qtx6GAzdoJykyves/6HHOI38FoYDtZLAjWc8i72tr4fGamXtKGl4m44hsdiCu1XROWW
 azzU6QcNoAsFW9m80aqovN5gdXRTkNVfLunYLgeghg0BYcqgs2AvVBOJhFxW/rFizYUvRzdTw
 WYX3r5y/2JCuROTfF30yF1DV0c5mciMSDtQMihy2diyS72TFFkOvBNrRcIzdnlzuRYXp5glA4
 I4Hl3+2mmjGIVS6RZ5uCr7HAVZ3W+BoiORnaVuubg4MVhmjMc8ODuCi5U+LFEOdbsEgwkQvLE
 CUNBFyb/AZjuwr2YGpLy8aNiXC6MNZVX7uyBFITa6uvVfozEjP8hdNPX5YZ1G48pS7IVRTPOe
 7zcvYReyB6iziI4/srMXFd8xmpRiywIH4ZLb3T2cEwU6KYuazFku8trABlW97j4cqcTkN1LJT
 6NNNAZcqJ78hu3bfy2jQ7IXqPFcuWc8ADIk1EBbhfcbR2lGqyKnamy2VAzVUUPaZqarQVQVaw
 6BprixXH8g5E4qVbDWV5ta0ene1064v2l9jODnxWYR1uZgxOArv8xqSD5Stq51V3/H5VhDLkD
 L8KyPc3PFlFI1vHADjNvG+q+0KZYc1XrFMaRLCeg5ToQb6wvO/FPnsWpWEnjPpuuGwNmn8+Sk
 5C4AeVZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 9 Jul 2018, Jeff King wrote:

> If the user gives us a set that prepare_revision_walk()
> takes to be empty, like:
> 
>   git cherry-pick base..base
> 
> then we report an error. It's nonsense, and there's nothing
> to pick.
> 
> But if they use revision options that later cull the list,
> like:
> 
>   git cherry-pick --author=nobody base~2..base
> 
> then we quietly create an empty todo list and return
> success.
> 
> Arguably either behavior is acceptable, but we should
> definitely be consistent about it. Reporting an error
> seems to match the original intent, which dates all the way
> back to 7e2bfd3f99 (revert: allow cherry-picking more than
> one commit, 2010-06-02). That in turn was trying to match
> the single-commit case that exited before then (and which
> continues to issue an error).
> 
> Signed-off-by: Jeff King <peff@peff.net>

Makes sense to me.

Thanks,
Dscho
