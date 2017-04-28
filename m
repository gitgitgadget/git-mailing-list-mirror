Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6C71FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 10:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422876AbdD1Kve (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 06:51:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:61694 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035442AbdD1Kvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 06:51:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lw1vh-1eBHrr3wg1-017mmI; Fri, 28
 Apr 2017 12:51:23 +0200
Date:   Fri, 28 Apr 2017 12:51:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/26] checkout: fix memory leak
In-Reply-To: <xmqqk266mjzv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281247540.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <be7ff5f9b303bb42f0d2a6c8f144bcc8342450cc.1493237937.git.johannes.schindelin@gmx.de> <xmqqk266mjzv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HW6ubL3CrWmAam+avmaOKASr2i9fVKEZOOl/qheAxSU0GkRaLbq
 rbKD6bTyQx/ZaQ8rlJeJQZe1Am3CNPqTmebU/TUPoWvVW1HJ1cNl/np3MIfiS8Kh72WYVia
 HAUribRkf64I4ZbIi7kPNpRtMTx8o2b5S1LjQx22ukVnPLNAY8kaiUHaXiMG71ie5X3/zqc
 /V+5iLqSKVgrfM4xfMJpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mfFFODYQR6U=:ky1r9eUtUsjDLKZH2XiHcp
 61sIJTsW90dKe+os0/RF189PePFZZ4lhlOyM9qzXj1S5a2Pqp6RJOCT15KhP2GdU21yWc4cO+
 bjdNE/HqUNam4TvOYwDjpupm3La07H+QPOtzCNtaXLcmBPtQpM1S/lW58V0JAhdCMMRzkacrk
 1W1D/bGVV90LbcJ5athjllFYhExGJW0c+wocBGzeM1QlPqAbJx0BbA+Jd6tWhvXLxV4wl+a1W
 XbL151CDnbaRS/OQRbYLM1mEloKt3W0uPqGZUIVVISaP3DJQv9DWaCSruu9pmF8Zmv78/mkwf
 aomh2Uu37YU/iv/EETW+NLKQGn5kRtRmWC2J796Bh75Gun7XR/rqfPTLpZp+uleJGc6vsrJD6
 C1vbB8QBYgCZwu8+R75k9l84W0nzCD3fg+syDj7yqudk93ybHo/2qK/j2NcObc3wEiNzdU1Wn
 Y7Xt8pcG8cIrLxL2AouCxJwkx/xy8x2fXxMJriszXLRqfc8rSuwUSeKiYU+IgF4kzcFO9WcEM
 p+TIU0meJCcLuIVZ/dcP67HW5kBjRrM/w3MVH/jyH2ZD+jE0rWtM7fOKAUgGzTGXQyddWwXU8
 PaAZBMPYBHXlPAzTBFVA8+usL76F0a0Ec/4WGx5/d5CVYfPT5jcaFPRUP96CyS/j/kafse4b1
 bWYnaPDi1lEnOxt1vkDx9kEpQPHvXeP850koY47KQbMuA6LslbhaCxGjysbBHwF3BseoXpEHA
 bKMsT752vO/dpvZDVCybphCfcrEDdCsLHHPuQNyiDM0UT5rkJwaZRVVK2z+3OJS1tvdKTm2pn
 /SHdar6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Discovered via Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/checkout.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index bfa5419f335..98f98256608 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct checkout *state)
> >  	if (!ce)
> >  		die(_("make_cache_entry failed for path '%s'"), path);
> >  	status = checkout_entry(ce, state, NULL);
> > +	free(ce);
> >  	return status;
> >  }
> 
> Thanks for spotting this one and fixing it.  
> 
> In case anybody is wondering what the "only to leak" comment before
> this part of the code is about (which by the way may need to be
> updated, as the bulk of its reasoning still applies but at least we
> are no longer leaking with this patch), back when this code was
> written in 2008 or so it wasn't kosher to free cache_entry under
> certain conditions, but it has been a long time since it became OK
> to free any cache entries in later 2011---we should have done this a
> long time ago.

Thanks for the background. The next iteration will change that comment,
too (simply removing "just to leak" and rewrapping to 74 columns/line.

Ciao,
Dscho
