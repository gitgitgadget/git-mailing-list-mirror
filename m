Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAC8C433E7
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 09:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66632071B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 09:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgH1JO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:14:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:43442 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgH1JOz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 05:14:55 -0400
Received: (qmail 24335 invoked by uid 109); 28 Aug 2020 09:14:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 09:14:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4763 invoked by uid 111); 28 Aug 2020 09:14:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 05:14:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 05:14:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] pack-redundant: gauge the usage before proposing its
 removal
Message-ID: <20200828091454.GA2140991@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
 <20200825172214.GC1414394@coredump.intra.peff.net>
 <xmqqh7sq1u0a.fsf@gitster.c.googlers.com>
 <20200825182745.GA1417288@coredump.intra.peff.net>
 <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 03:45:52PM -0700, Junio C Hamano wrote:

> The subcommand is unusably slow and the reason why nobody reports it
> as a performance bug is suspected to be the absense of users.  Let's
> show a big message that asks the user to tell us that they still
> care about the command when an attempt is made to run the command,
> with an escape hatch to override it with a command line option.

I was looking at the history here and noticed this topic, which I
somehow missed when it happened:

  $ git show -s cf0879f7e98d2213503622f780d2ab0dd3f93477
  commit cf0879f7e98d2213503622f780d2ab0dd3f93477
  Merge: 3710f60a80 0e37abd2e8
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Thu Mar 7 09:59:54 2019 +0900
  
      Merge branch 'sc/pack-redundant'
      
      Update the implementation of pack-redundant for performance in a
      repository with many packfiles.
      
      * sc/pack-redundant:
        pack-redundant: consistent sort method
        pack-redundant: rename pack_list.all_objects
        pack-redundant: new algorithm to find min packs
        pack-redundant: delete redundant code
        pack-redundant: delay creation of unique_objects
        t5323: test cases for git-pack-redundant

So it sounds like:

  - somebody does care enough to use it

  - it may not be horrifically slow anymore

So it may not be worth trying to follow through on the deprecation
(though the fact that neither of us realized this makes me worried for
the general state of maintenance of this code).

-Peff
