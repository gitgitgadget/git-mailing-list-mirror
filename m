Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BBDC43460
	for <git@archiver.kernel.org>; Tue, 11 May 2021 01:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60AB616ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 01:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhEKBg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 21:36:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:49950 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhEKBg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 21:36:27 -0400
Received: (qmail 20459 invoked by uid 109); 11 May 2021 01:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 01:35:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17597 invoked by uid 111); 11 May 2021 01:35:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 May 2021 21:35:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 May 2021 21:35:19 -0400
From:   Jeff King <peff@peff.net>
To:     Will Chandler <wfc@wfchandler.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
Message-ID: <YJnfV7op4yhyLqdg@coredump.intra.peff.net>
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
 <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
 <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
 <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
 <YJYTQYk5q8g6HaIm@mini.wfchandler.org>
 <YJYa+7yUyt2YD16r@mini.wfchandler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJYa+7yUyt2YD16r@mini.wfchandler.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 08, 2021 at 01:00:43AM -0400, Will Chandler wrote:

> Subject: [PATCH v2] refs: cleanup directories when deleting packed ref
> 
> When deleting a packed ref via 'update-ref -d', a lockfile is made in
> the directory that would contain the loose copy of that ref, creating
> any directories in the ref's path that do not exist. When the
> transaction completes, the lockfile is deleted, but any empty parent
> directories made when creating the lockfile are left in place.  These
> empty directories are not removed by 'pack-refs' or other housekeeping
> tasks and will accumulate over time.
> 
> When deleting a loose ref, we remove all empty parent directories at the
> end of the transaction.
> 
> This commit applies the parent directory cleanup logic used when
> deleting loose refs to packed refs as well.

This thread got off on a tangent about threads, but to get back to the
main idea: this v2 patch looks good to me. Thank you very much for
finding and fixing it.

Regarding threads, I agree with everything Junio already said. My only
suggestion would be to make sure the "Subject" above becomes the actual
email subject, rather than an in-body header (that may be what confused
the b4 tool, but more importantly, threaded readers like mutt will show
the changed subject in the thread index, making it very clear at a
glance that there is a v2 and not just more discussion).

-Peff
