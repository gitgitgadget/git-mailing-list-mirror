Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C209720248
	for <e@80x24.org>; Thu,  4 Apr 2019 12:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfDDM1Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 08:27:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:46660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728870AbfDDM1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 08:27:24 -0400
Received: (qmail 27078 invoked by uid 109); 4 Apr 2019 12:27:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 12:27:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16489 invoked by uid 111); 4 Apr 2019 12:27:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 08:27:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 08:27:22 -0400
Date:   Thu, 4 Apr 2019 08:27:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
Message-ID: <20190404122722.GA23024@sigill.intra.peff.net>
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l>
 <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
 <20190403213318.GA14137@dev-l>
 <20190404020226.GG4409@sigill.intra.peff.net>
 <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 06:31:25PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do still think it is likely to be a mistake. I think Junio's point,
> > though is: who cares if the mistake was made? For the most part you can
> > continue to use the tag as if the mistake had never been made, because
> > Git peels through multiple layers as necessary.
> 
> Nicely said.
> 
> If we forget to peel, that is a bigger problem, but I do not think
> it makes any sense to single out tag-of-tag as "curious" and forbid
> it, when we silently allow tag-of-blob or tag-of-tree happily.

IMHO the difference between those cases is that it is very easy to type
something natural to get a tag of tag, like:

  git tag -m foo mytag
  # oops, try again
  git tag -m bar -f mytag mytag

but you have to take pretty specific steps to get a tag of a blob or
tree, like:

  git tag mytag HEAD:path

or

  git tag mytag HEAD^{tree}

Unless you have a ref pointing to a blob or tree in the first place, of
course. But then it is a chicken-and-egg question. Didn't you have to do
something specific to get that tag in the first place?

-Peff
