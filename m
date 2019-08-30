Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F331F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 19:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfH3TnJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:43:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55926 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfH3TnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:43:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BB1CC1F461;
        Fri, 30 Aug 2019 19:43:08 +0000 (UTC)
Date:   Fri, 30 Aug 2019 19:43:08 +0000
From:   Eric Wong <e@80x24.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 10/11] introduce container_of macro
Message-ID: <20190830194308.skgeqzj7goh6y6nm@dcvr>
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-11-e@80x24.org>
 <381dd52f-f7d4-3e6c-24b8-22c8a0710f25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <381dd52f-f7d4-3e6c-24b8-22c8a0710f25@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> wrote:
> On 8/25/2019 10:43 PM, Eric Wong wrote:
> > + * container_of - Get the address of an object containing a field.
> > + *
> > + * @ptr: pointer to the field.
> > + * @type: type of the object.
> > + * @member: name of the field within the object.
> > + */
> > +#define container_of(ptr, type, member) \
> > +	((type *) ((char *)(ptr) - offsetof(type, member)))
> > +
> >  #endif
> 
> I think it would be good to include at least one use of this
> macro in this patch. As it stands, I need to look at the next
> patch to make sense of what this is doing.

Yeah, I considered making list_entry an alias of this.
But I wasn't sure about including git-compat-util.h in
list.h...

> It took me a little while to parse what is happening here.
> 'ptr' is a pointer to the generic struct (in our case,
> 'struct hashmap_entry *'), while 'type' is the parent type,
> and 'member' is the name of the member in 'type' that is
> of type typeof(*ptr).
> 
> Perhaps this is easier to grok for others than it was for me.

*shrug*  I only dabble in C, but I've been using it for a good
while.  I'm probably drawn to it because I'm not a great C
programmer like having it to prevent mistakes.  I also find
open-coded linked lists (even singly-linked ones!)
hard-to-follow, so I always reach for something like urcu/list.h
or ccan/list.h.
