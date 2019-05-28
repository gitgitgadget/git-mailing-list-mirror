Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB621F462
	for <e@80x24.org>; Tue, 28 May 2019 06:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfE1GaJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 02:30:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:39460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726305AbfE1GaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 02:30:09 -0400
Received: (qmail 27493 invoked by uid 109); 28 May 2019 06:30:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 06:30:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10451 invoked by uid 111); 28 May 2019 06:30:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 02:30:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 02:30:07 -0400
Date:   Tue, 28 May 2019 02:30:07 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] list-objects-filter: disable 'sparse:path' filters
Message-ID: <20190528063006.GF7946@sigill.intra.peff.net>
References: <20190525142834.6168-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190525142834.6168-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 25, 2019 at 04:28:34PM +0200, Christian Couder wrote:

> If someone wants to use as a filter a sparse file that is in the
> repository, something like "--filter=sparse:oid=<ref>:<path>"
> already works.
> 
> So 'sparse:path' is only interesting if the sparse file is not in
> the repository. In this case though the current implementation has
> a big security issue, as it makes it possible to ask the server to
> read any file, like for example /etc/password, and to explore the
> filesystem, as well as individual lines of files.
> 
> If someone is interested in using a sparse file that is not in the
> repository as a filter, then at the minimum a config option, such
> as "uploadpack.sparsePathFilter", should be implemented first to
> restrict the directory from which the files specified by
> 'sparse:path' can be read.
> 
> For now though, let's just disable 'sparse:path' filters.

Thanks for picking this up. The patch looks fine to me (versus just
disabling it for remote invocations) assuming we are OK with the
possible regression. I suppose cooking this in 'next' for a while is one
way we might find out if anybody yells loudly.

-Peff
