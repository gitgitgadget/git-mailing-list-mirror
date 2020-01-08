Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F82DC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E359820720
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgAHNtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:49:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:60270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727158AbgAHNtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 08:49:46 -0500
Received: (qmail 22381 invoked by uid 109); 8 Jan 2020 13:49:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 13:49:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10083 invoked by uid 111); 8 Jan 2020 13:55:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 08:55:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 08:49:45 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] graph: fix collapse of multiple edges
Message-ID: <20200108134945.GA3390419@coredump.intra.peff.net>
References: <pull.518.git.1578457675.gitgitgadget@gmail.com>
 <12abb32531ed7125293986dc139a7ffed3839065.1578457675.git.gitgitgadget@gmail.com>
 <20200108072541.GC1675456@coredump.intra.peff.net>
 <7a0e4637-85de-589f-df31-915b4603e45a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a0e4637-85de-589f-df31-915b4603e45a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 08:40:26AM -0500, Derrick Stolee wrote:

> > Hmm. Your description and your diagrams make sense to me. But one
> > curious thing is that the earlier test you added for 6_* does not need
> > modified. Because it continues to show:
> > 
> >           | | | | * 6_F
> >           | |_|_|/|
> >           |/| | |/
> >           | | |/|
> >           | |/| |
> >           | * | | 6_D
> > 
> > rather than adding a horizontal component to the second-parent line.
> > That seems inconsistent.
> 
> The issue here is that there is not enough room for a second horizontal
> line. The horizontal line can only start after the previous has completely
> terminated, that is
> 
>            | | | | * 6_F
>            | |_|_|/|
>            |/| | |/
> 
> at this point, the first horizontal line has terminated.

Ahhh, OK, that makes perfect sense. I didn't quite realize how the rules
for "going horizontal" worked.

> If there was one more row to the example, then we would have:
> 
>            | | | | | * 6_F
>            | |_|_|_|/|
>            |/| | | |/
>            | | |_|/|
>            | |/| | |
>            | * | | | 6_D

Right, that makes sense. Thanks for explaining. And the patch otherwise
looked good to me; your explanation convinced me that this is the right
thing to do.

-Peff
