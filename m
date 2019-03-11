Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6484A202BB
	for <e@80x24.org>; Mon, 11 Mar 2019 18:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfCKSXb (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 14:23:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:46124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726864AbfCKSXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 14:23:31 -0400
Received: (qmail 13909 invoked by uid 109); 11 Mar 2019 18:23:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Mar 2019 18:23:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25572 invoked by uid 111); 11 Mar 2019 18:23:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Mar 2019 14:23:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Mar 2019 14:23:29 -0400
Date:   Mon, 11 Mar 2019 14:23:29 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
Message-ID: <20190311182328.GB16865@sigill.intra.peff.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
 <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 07:15:12PM +0100, Thomas Braun wrote:

> Am 11.03.2019 um 12:58 schrieb Duy Nguyen:
> > On Mon, Mar 11, 2019 at 10:48 AM Jeff King <peff@peff.net> wrote:
> >> And AFAIK there is no good way to
> >> modify the submodule-provided content as part of the build. Why do we
> >> even have the submodule again? ;P
> > 
> > Because of dogfooding of course. This is an interesting use case
> > though. I wonder if people often want to "patch" submodules like this
> > (and what we could do if that's the case)
> 
> I usually do the following:
> 
> - Fork the sub-project
> - Add a branch with my proposed patches
> - Update the URL and the commit of the submodule in the super-project
> 
> This of course requires all users to do
> 
> git submodule sync
> 
> which is a bit incovenient, but works.

The problem to me is not that the steps that a developer has to do, but
rather that we are dependent on the upstream project to make a simple
fix (which they may not agree to do, or may take a long time to do).

Whereas if we import the content into our repo as a subtree, we are free
to hack it up as we see fit, and then occasionally pull from upstream
and reconcile the changes. Changing upstream isn't advisable in the
general case, but I think makes a lot of sense for small changes
(especially if you have the discipline to actually get the same or
similar change pushed upstream).

In this particular case, though, the sha1dc project is pretty
responsive, so I don't think it's going to be a big deal. It just seems
like an anti-pattern in general.

-Peff
