Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC457202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 02:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756446AbdJQCmI (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 22:42:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:54910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756356AbdJQCmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 22:42:06 -0400
Received: (qmail 26596 invoked by uid 109); 17 Oct 2017 02:42:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 02:42:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19662 invoked by uid 111); 17 Oct 2017 02:42:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 22:42:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 22:42:03 -0400
Date:   Mon, 16 Oct 2017 22:42:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
 <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 10:22:31AM +0900, Junio C Hamano wrote:

> > I like the state this puts us in, but there's one catch: we're
> > completely changing the meaning of "check-ref-format --branch", aren't
> > we?
> >
> > It is going from "this is how you resolve @{-1}" to "this is how you
> > check the validity of a potential branch name". Do we need to pick a
> > different name, and/or have a deprecation period?
> 
> That was not my intention.  When used in a repository, it behaves
> exactly the same as before, including @{-1} resolution part.  And by
> using strbuf_check_branch_ref(), it has always been checking the
> validity of a potential branch name, even though it wasn't
> advertised as such.  The documentation needs to be updated, I would
> think.
> 
> When used outside a repository, @{-1} would not have worked anyway,
> and @{-1} continues not to work, but the part that checks the
> validity should continue to work.
> 
> At least that is what I wanted to happen in the patch.

Ah, OK, I did not read carefully enough then. I think that would be OK,
and probably close to what Jonathan was asking for.

It leaves unresolved the fact that the resolving feature does not belong
in check-ref-format in the first place, but we can just accept that as a
historical wart.

I don't think there is any need to prepare it upon my 4d03f955, though.
I'd think it could simply replace it.

-Peff
