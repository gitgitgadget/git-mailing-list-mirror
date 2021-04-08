Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C2EC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E1D61103
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhDHOdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:33:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:44564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231574AbhDHOc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 10:32:59 -0400
Received: (qmail 23084 invoked by uid 109); 8 Apr 2021 14:32:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Apr 2021 14:32:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32345 invoked by uid 111); 8 Apr 2021 14:32:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Apr 2021 10:32:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Apr 2021 10:32:47 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
Message-ID: <YG8UD7c4lChOQM5a@coredump.intra.peff.net>
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com>
 <YG4jxKQ3z1R+8Jfz@coredump.intra.peff.net>
 <CAOLTT8QvdLeWz=cDOoVFV8Lrk2QL2wf_jwDc6oK5j+6gup+Png@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8QvdLeWz=cDOoVFV8Lrk2QL2wf_jwDc6oK5j+6gup+Png@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 08:18:59PM +0800, ZheNing Hu wrote:

> > I think this is a reasonable direction to take the solution: wrapping
> > the loop so that the reuse of the buffers can be included there.
> >
> > But I do wonder if we should go the opposite direction, and get rid of
> > show_ref_array_item() entirely. It only has two callers, both of which
> > could just write the loop themselves. That is more code, but perhaps it
> > would make it more clear what is going on in those callers, and to give
> > them more flexibility.
> >
> 
> Indeed. I think `pretty_print_ref()` is proof that we may need to keep
> `show_ref_array_item()` because If it modified to `show_ref_array_items(...,1);`
> it will look very strange.

What I meant was that we should get rid of show_ref_array_items(), as
well, and just use format_ref_array_item() everywhere. This whole
wrapper is only saving us a few lines, and it makes it harder to see
what the function is doing. Likewise for pretty-print ref. But I dunno.
Maybe that is all going too far.

-Peff
