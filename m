Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08EE1F406
	for <e@80x24.org>; Thu, 17 May 2018 03:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeEQDbP (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 23:31:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:44200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751478AbeEQDbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 23:31:14 -0400
Received: (qmail 9944 invoked by uid 109); 17 May 2018 03:31:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 May 2018 03:31:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31462 invoked by uid 111); 17 May 2018 03:31:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 16 May 2018 23:31:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2018 20:31:11 -0700
Date:   Wed, 16 May 2018 20:31:11 -0700
From:   Jeff King <peff@peff.net>
To:     Sitaram Chamarty <sitaramc@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Martin Fick <mfick@codeaurora.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180517033110.GA13235@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <20180516192343.GB3417@sigill.intra.peff.net>
 <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
 <20180516193744.GA4036@sigill.intra.peff.net>
 <5156717b-6fc9-b792-dfa4-1ba48ac50333@linuxfoundation.org>
 <20180517004355.GA9431@sita-lt.atc.tcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180517004355.GA9431@sita-lt.atc.tcs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 17, 2018 at 06:13:55AM +0530, Sitaram Chamarty wrote:

> I may have missed a few of the earlier messages, but in the last
> 20 or so in this thread, I did not see namespaces mentioned by
> anyone. (I.e., apologies if it was addressed and discarded
> earlier!)
> 
> I was under the impression that, as long as "read" access need
> not be controlled (Konstantin's situation, at least, and maybe
> Peff's too, for public repos), namespaces are a good way to
> create and manage that "mother repo".
> 
> Is that not true anymore?  Mind, I have not actually used them
> in anger anywhere, so I could be missing some really big point
> here.

The biggest problem with namespaces as they are currently implemented is
that they do not apply universally to all commands. If you only access
the repo via push/fetch, they may be fine. But as soon as you start
doing other operations (e.g., showing the history of a branch in a web
interface), you don't get to use the namespaced names anymore.

I think a different implementation of namespaces could do this better.
E.g., by controlling the view of the refs at the refs.c layer (or
perhaps as a filtering backend).

-Peff
