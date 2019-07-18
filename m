Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54A21F461
	for <e@80x24.org>; Thu, 18 Jul 2019 20:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391404AbfGRUVm (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 16:21:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:39682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728054AbfGRUVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 16:21:42 -0400
Received: (qmail 30115 invoked by uid 109); 18 Jul 2019 20:21:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Jul 2019 20:21:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20427 invoked by uid 111); 18 Jul 2019 20:22:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Jul 2019 16:22:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jul 2019 16:21:40 -0400
Date:   Thu, 18 Jul 2019 16:21:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thurston via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Adding git-ignore command, tests, and documentation.
Message-ID: <20190718202140.GB22038@sigill.intra.peff.net>
References: <pull.264.git.gitgitgadget@gmail.com>
 <xmqqmuhc1uw9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmuhc1uw9.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 17, 2019 at 09:35:34AM -0700, Junio C Hamano wrote:

> "Thurston via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Instead of managing paths and relative paths such as echo
> > "path/to/the/file.txt" >../../../../../../.gitignore git ignore
> > path/to/the/file.txt No matter what directory that is in, the correct
> > relative path will be added to the gitignore.
> 
> Hmph, do you mean you type something like this?
> 
> 	$ cd path/to/the
> 	... work in that deep directory ...
> 	... realize that file.txt in that directory needs ignoring ...
> 	$ echo path/to/the/file.txt >../../../../../../.gitignore
> 
> Wouldn't this simpler to type and less error prone, as you do not
> have to count ../?
> 
> 	$ cd path/to/the
> 	... work in that deep directory ...
> 	... realize that file.txt in that directory needs ignoring ...
> 	$ echo file.txt >.gitignore

It's also much more efficient, at least with our current implementation,
as we do not have to worry about matching this entry when we are dealing
with /some/other/path. See [1] for a pathological case.

I see "with our current implementation" because I could imagine a world
in which we have a more trie-like structure for non-wildcard patterns.
But I don't think anybody is working on such a thing.

-Peff

[1] https://public-inbox.org/git/20120329211136.GA1112@sigill.intra.peff.net/
