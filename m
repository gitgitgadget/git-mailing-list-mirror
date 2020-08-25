Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB20C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84122207BC
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHYQ4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:56:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:40128 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYQ4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 12:56:44 -0400
Received: (qmail 1059 invoked by uid 109); 25 Aug 2020 16:56:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 16:56:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29997 invoked by uid 111); 25 Aug 2020 16:56:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 12:56:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 12:56:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825165642.GB1414394@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <20200825023710.GA98081@syl.lan>
 <e7eb9fb6-f1ea-f932-efaa-7434ad809989@gmail.com>
 <20200825144146.GA7671@syl.lan>
 <6a34d7ee-8c6b-8c6c-93bd-0013dccccafb@gmail.com>
 <20200825154224.GA9116@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825154224.GA9116@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 11:42:24AM -0400, Taylor Blau wrote:

> > test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> > 	git init preserve &&
> > 	test_when_finished "rm -fr preserve" &&
> > 	(
> > 		cd preserve &&
> > 		midx=.git/objects/pack/multi-pack-index &&
> >
> > 		test_commit 1 &&
> > 		HASH1=$(git pack-objects --all .git/objects/pack/pack) &&
> > 		touch .git/objects/pack/pack-$HASH1.keep &&
> >
> > 		cat >pack-input <<-\EOF &&
> 
> Escaping the heredoc shouldn't be necessary, so this can be written
> instead as '<<-EOF'.

We usually go the opposite way: if a here-doc doesn't need
interpolation, then we prefer to mark it as such to avoid surprising
somebody who adds lines later (and might need quoting).

Certainly you can argue that least-surprise would be in the other
direction (i.e., people expect to interpolate by default, and you
surprise anybody adding a variable reference), but for Git's test suite,
the convention usually runs the other way.

-Peff
