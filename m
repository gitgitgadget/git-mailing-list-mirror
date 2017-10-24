Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B291F1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 19:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdJXT1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 15:27:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:34604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751323AbdJXT1B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 15:27:01 -0400
Received: (qmail 29229 invoked by uid 109); 24 Oct 2017 19:27:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 19:27:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14786 invoked by uid 111); 24 Oct 2017 19:27:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 15:27:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Oct 2017 12:26:59 -0700
Date:   Tue, 24 Oct 2017 12:26:59 -0700
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Andrey Okoshkin <a.okoshkin@samsung.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <dturner@twopensource.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] path: use xmalloc in add_to_trie
Message-ID: <20171024192658.4rvxvb34y64lt2tc@sigill.intra.peff.net>
References: <CGME20171024151508epcas2p4d9455e93e2e19bfb118b485d4ce14922@epcas2p4.samsung.com>
 <e63c2208-900e-138a-a13c-fecf9403e0b8@samsung.com>
 <CAGZ79kZM_hVi8BeTmL5u_QK5+=1g3gcPsccEe1AJVpDLUWz_9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZM_hVi8BeTmL5u_QK5+=1g3gcPsccEe1AJVpDLUWz_9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 09:13:28AM -0700, Stefan Beller wrote:

> On Tue, Oct 24, 2017 at 8:15 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
> > Add usage of xmalloc() instead of malloc() in add_to_trie() as xmalloc wraps
> > and checks memory allocation result.
> >
> > Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
> > ---
> > Hello,
> > I'm not sure but it looks like there is a missing check of the malloc result.
> > memcpy() may crash with SIGSEGV due to the memory allocation failure.
> > make_trie_node() uses xmalloc() and xcalloc() - so I believe add_to_trie()
> > also should use it.
> 
> Good catch! Thanks for spotting.
> 
> Trying to find similar occurrences via git grep "= malloc" did not
> yield other places that need the same fix.

Don't forget realloc and calloc (though I don't think there are any
cases that need touching there; just a hint for anybody doing auditing).

-Peff
