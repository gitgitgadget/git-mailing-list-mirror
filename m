Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6480B1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeGSWcc (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:32:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:53352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727523AbeGSWcc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:32:32 -0400
Received: (qmail 11566 invoked by uid 109); 19 Jul 2018 21:47:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 21:47:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17231 invoked by uid 111); 19 Jul 2018 21:47:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 17:47:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 17:47:30 -0400
Date:   Thu, 19 Jul 2018 17:47:30 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, primetheus@github.com
Subject: Re: Find commit that referenced a blob first
Message-ID: <20180719214729.GA14323@sigill.intra.peff.net>
References: <C00CED1F-D685-40E5-A5CC-4040BFD82886@gmail.com>
 <CAGZ79kbJnyRbeH8yMa=QaqNofA_Ek_SwmH5qRaCaq4cyQ26Kqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbJnyRbeH8yMa=QaqNofA_Ek_SwmH5qRaCaq4cyQ26Kqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 02:19:34PM -0700, Stefan Beller wrote:

> > I have a blob hash and I would like to know what commit referenced
> > this blob first in a given Git repo.
> 
> git describe <blob>
> 
> If the given object refers to a blob, it will be described as
> <commit-ish>:<path>,
> such that the blob can be found at <path> in the <commit-ish>, which itself
> describes the first commit in which this blob occurs in a reverse
> revision walk from HEAD.
> 
> Since
> 644eb60bd01 (builtin/describe.c: describe a blob, 2017-11-15)
> (included first in 2.16.0

Hmm.

  $ git describe cfbc47ee2d
  fatal: No tags can describe '83adac3c57ad8cd2c8d44b525414b949950e316d'.
  Try --always, or create some tags.

  $ git describe --always cfbc47ee2d
  83adac3c57:checkout-cache.c

That first output confused me for a moment. We can't produce a nice
descriptive name for the commit in question, so we punt on the whole
thing.

Anyway. I have found your diff --find-object to be more useful in
practice. I.e.:

  git log --find-object=cfbc47ee2d

because I usually care less about a succinct name, and more about
digging into the history (so adding "-p", etc).

-Peff
