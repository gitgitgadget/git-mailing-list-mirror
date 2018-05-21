Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DA81F51C
	for <e@80x24.org>; Mon, 21 May 2018 21:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932087AbeEUVyv (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 17:54:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:48478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754347AbeEUVyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 17:54:45 -0400
Received: (qmail 373 invoked by uid 109); 21 May 2018 21:54:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 May 2018 21:54:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32145 invoked by uid 111); 21 May 2018 21:54:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 21 May 2018 17:54:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2018 17:54:43 -0400
Date:   Mon, 21 May 2018 17:54:43 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
Message-ID: <20180521215443.GC16623@sigill.intra.peff.net>
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 02:10:54PM -0400, Derrick Stolee wrote:

> In the Discussion section of the `git merge-base` docs [1], we have the
> following:
> 
>     When the history involves criss-cross merges, there can be more than one
> best common ancestor for two commits. For example, with this topology:
> 
>     ---1---o---A
>         \ /
>          X
>         / \
>     ---2---o---o---B
> 
>     both 1 and 2 are merge-bases of A and B. Neither one is better than the
> other (both are best merge bases). When the --all option is not given,    
> it is unspecified which best one is output.
> 
> This means our official documentation mentions that we do not have a
> concrete way to differentiate between these choices. This makes me think
> that this change in behavior is not a bug, but it _is_ a change in behavior.
> It's worth mentioning, but I don't think there is any value in making sure
> `git merge-base` returns the same output.
> 
> Does anyone disagree? Is this something we should solidify so we always have
> a "definitive" merge-base?

Heh, I should have read your whole original message before responding,
not just the part that Elijah quoted.

Yes, I think this is clearly a case where all of the single merge-bases
we could show are equally good. And I don't think we should promise to
show a particular one, but I _do_ think it's friendly for us to have
deterministic tie-breakers (we certainly don't now).

-Peff
