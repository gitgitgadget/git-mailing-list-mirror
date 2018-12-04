Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41996211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 06:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLDG7d (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 01:59:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:58246 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725988AbeLDG7d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 01:59:33 -0500
Received: (qmail 28602 invoked by uid 109); 4 Dec 2018 06:59:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Dec 2018 06:59:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17704 invoked by uid 111); 4 Dec 2018 06:59:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Dec 2018 01:59:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2018 01:59:31 -0500
Date:   Tue, 4 Dec 2018 01:59:31 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Git for human beings <git-users@googlegroups.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
Message-ID: <20181204065930.GA11010@sigill.intra.peff.net>
References: <87zhtsx73l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhtsx73l.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 03:59:26PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This is the thing I was wrong about, in retrospect probably because I'd
> been putting PATH_TO_REPO in objects/info/alternates, but we actually
> need PATH_TO_REPO/objects, and "git gc" won't warn about this (or "git
> fsck"). Probably a good idea to patch that at some point, i.e. whine
> about paths in alternates that don't have objects, or at the very least
> those that don't exist. #leftoverbits

We do complain about missing directories; see alt_odb_usable().
Pointing to a real directory that doesn't happen to contain any objects
is harder. If there are no loose objects, there might not be any hashed
object directories. For a "real" object database, there should always be
a "pack/" directory. But technically the object storage directory does
not even need to have that; it can just be a directory full of loose
objects that happens not to have any at this moment.

That said, I suspect if we issued a warning for "woah, it looks like
this doesn't have any objects in it, nor does it even have a pack
directory" that nobody would complain.

-Peff
