Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B87C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A727E2072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgCSRJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:09:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:44122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727235AbgCSRJz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:09:55 -0400
Received: (qmail 26298 invoked by uid 109); 19 Mar 2020 17:09:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 17:09:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29108 invoked by uid 111); 19 Mar 2020 17:19:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 13:19:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 13:09:54 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        james@jramsay.com.au
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200319170954.GB4075823@coredump.intra.peff.net>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <20200318101825.GB1227946@coredump.intra.peff.net>
 <20200318212818.GE31397@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200318212818.GE31397@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 03:28:18PM -0600, Taylor Blau wrote:

> I wonder. A multi-valued 'uploadpack.filter.allow' *might* solve some
> problems, but the more I turn it over in my head, the more that I think
> that it's creating more headaches for us than it's removing.

IMHO we should avoid multi-valued keys when there's not a compelling
reason. There are a lot of corner cases they introduce (e.g., there's no
standard way to override them rather than adding to the list).

> Another thing we could do is just simply use a different character. It
> may be a little odd, but it keeps the filter-related variables in their
> own sub-section, allowing us to add more configuration sub-variables in
> the future. I guess that calling it something like:
> 
>   $ git config uploadpack.filter@blob:none.allow <true|false>
> 
> is a little strange (i.e., why '@' over '#'? There's certainly no
> precedent here that I can think of...), but maybe it is slightly
> less-weird than a pseudo-four-level key.

I guess it's subjective, but the "@" just feels odd because it's
associated with so many other meanings. Likewise "#".

-Peff
