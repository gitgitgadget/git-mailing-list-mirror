Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFEA1F42D
	for <e@80x24.org>; Thu, 10 May 2018 11:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757225AbeEJL42 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 07:56:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:34628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757141AbeEJL40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 07:56:26 -0400
Received: (qmail 32656 invoked by uid 109); 10 May 2018 11:56:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 11:56:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23004 invoked by uid 111); 10 May 2018 11:56:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 07:56:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 07:56:23 -0400
Date:   Thu, 10 May 2018 07:56:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] replace-object.c: remove the_repository from
 prepare_replace_object
Message-ID: <20180510115623.GA20632@sigill.intra.peff.net>
References: <20180509234059.52156-1-sbeller@google.com>
 <20180509234059.52156-2-sbeller@google.com>
 <xmqqtvrfizce.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvrfizce.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 07:23:13PM +0900, Junio C Hamano wrote:

> This one was doing
> 
> 	ptr = xmalloc(sizeof(*another_ptr))
> 
> and it was OK because ptr and another_ptr happened to be of the same
> type.  I wonder if we are making it safer, or making it more obscure
> to seasoned C programmers, if we introduced a pair of helper macros,
> perhaps like these:
> 
> 	#define ALLOCATE(ptr) (ptr) = xmalloc(sizeof(*(ptr)))
> 	#define CALLOCATE(ptr,cnt) (ptr) = xcalloc((cnt), sizeof(*(ptr)))

I've often wondered that, too. It's the natural endgame of the
ALLOC_ARRAY() road we've been going down.

-Peff
