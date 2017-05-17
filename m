Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C664201A7
	for <e@80x24.org>; Wed, 17 May 2017 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbdEQNML (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:12:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:53604 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbdEQNMK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:12:10 -0400
Received: (qmail 4543 invoked by uid 109); 17 May 2017 13:12:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 13:12:07 +0000
Received: (qmail 9328 invoked by uid 111); 17 May 2017 13:12:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 09:12:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 09:12:04 -0400
Date:   Wed, 17 May 2017 09:12:04 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 07/23] ref_store: take `logmsg` parameter when deleting
 references
Message-ID: <20170517131204.m564xy7i3ywietsl@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <b26ccc03a7e72dfa30467db81e9210dd621516e2.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b26ccc03a7e72dfa30467db81e9210dd621516e2.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:30PM +0200, Michael Haggerty wrote:

> Just because the files backend can't retain reflogs for deleted
> references is no reason that they shouldn't be supported by the
> virtual method interface. Let's add them now before the interface
> becomes truly polymorphic and increases the work.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/fetch.c                |  2 +-
>  builtin/remote.c               |  4 ++--
>  refs.c                         | 11 ++++++-----
>  refs.h                         | 12 +++++++-----
>  refs/files-backend.c           |  4 ++--
>  refs/refs-internal.h           |  2 +-
>  t/helper/test-ref-store.c      |  3 ++-
>  t/t1405-main-ref-store.sh      |  2 +-
>  t/t1406-submodule-ref-store.sh |  2 +-
>  9 files changed, 23 insertions(+), 19 deletions(-)

Having carried a similar patch in GitHub's fork for many years (because
we maintain an audit log of all ref updates), I expected this to be
bigger. But I forgot that we did 755b49ae9 (delete_ref: accept a reflog
message argument, 2017-02-20) a few months ago, which already hit most
of the ref-deleting callers. This is just making the plural
delete_refs() interface match.

I think your reasoning above is sound by itself, but that gives an added
interface: we are making the delete_ref() and delete_refs() interfaces
consistent.

-Peff
