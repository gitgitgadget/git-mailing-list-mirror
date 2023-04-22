Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999FCC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 11:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDVLXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLXf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 07:23:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06381BF1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 04:23:34 -0700 (PDT)
Received: (qmail 10948 invoked by uid 109); 22 Apr 2023 11:23:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 11:23:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27729 invoked by uid 111); 22 Apr 2023 11:23:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 07:23:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 07:23:33 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] t/t6501-freshen-objects.sh: prepare for `gc
 --cruft` by default
Message-ID: <20230422112333.GF2969939@coredump.intra.peff.net>
References: <cover.1681764848.git.me@ttaylorr.com>
 <4ccc525c39dd23db1136681bc0ffd572db0ed2f2.1681764848.git.me@ttaylorr.com>
 <20230418105622.GA516715@coredump.intra.peff.net>
 <ZD70iXDdAqeDIeXX@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZD70iXDdAqeDIeXX@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 03:50:33PM -0400, Taylor Blau wrote:

> > > @@ -151,7 +151,7 @@ test_expect_success 'do not complain about existing broken links (commit)' '
> > >  	some message
> > >  	EOF
> > >  	commit=$(git hash-object -t commit -w broken-commit) &&
> > > -	git gc -q 2>stderr &&
> > > +	git gc --no-cruft -q 2>stderr &&
> > >  	verbose git cat-file -e $commit &&
> > >  	test_must_be_empty stderr
> > >  '
> >
> > The idea is that we don't complain when repacking unreachable-but-broken
> > segments of history. Which could perhaps behave differently for objects
> > that are going into a cruft pack versus being turned loose. So maybe
> > it's worth covering for the --cruft case, too. I dunno.
> 
> I think we already have coverage of those cases in t5329, specifically
> in the tests:
> 
>   - cruft packs tolerate missing trees (expire $expire)
>   - cruft packs tolerate missing blobs (expire $expire)
> 
> which are tested for both the pruning and non-pruning implementations
> (by setting $expire to "2.weeks.ago", and "never", respectively).

Ah, perfect. I only gave a quick look over t5329, and didn't see those.
So yeah, I think it is fine to just have this whole script run in
no-cruft mode.

-Peff
