Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F3A1F437
	for <e@80x24.org>; Tue, 31 Jan 2017 18:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdAaSVn (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 13:21:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:47407 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdAaSVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 13:21:40 -0500
Received: (qmail 18051 invoked by uid 109); 31 Jan 2017 18:21:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Jan 2017 18:21:15 +0000
Received: (qmail 3793 invoked by uid 111); 31 Jan 2017 18:21:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Jan 2017 13:21:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2017 19:21:11 +0100
Date:   Tue, 31 Jan 2017 19:21:11 +0100
From:   Jeff King <peff@peff.net>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
Message-ID: <20170131182110.mothq33nhswlizsa@sigill.intra.peff.net>
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
 <20170127100948.29408-1-cornelius.weig@tngtech.com>
 <20170127100948.29408-2-cornelius.weig@tngtech.com>
 <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
 <20170130233702.o6naszpz32juf5gt@sigill.intra.peff.net>
 <1e341485-6fb6-243a-0b27-4035789a6f2a@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e341485-6fb6-243a-0b27-4035789a6f2a@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 03:00:33PM +0100, Cornelius Weig wrote:

> Concerning branches, I fully agree. For git-branch, the
> "--no-create-reflog" option does not make sense at all and should
> produce an error.
> 
> On the other hand, for tags it may make sense to override
> logAllRefUpdates=always. As tag updates come exclusively from
> force-creating the same tag on another revision, a reflog will actually
> not be created by accident.

Hmm. I think you could also see tag creation and update via "git fetch",
though only with explicit refspecs, I think, not tag-following.

So I think ultimately you'd need to use "git -c logallrefupdates=false"
if you want to override reflog options for all commands. A saner
interface would probably be put teaching the ref code to respect a
configured list of exceptions ("I do want reflogs for refs/tags/, but
not for refs/foo/"). But I don't think it's sensible for anybody to go
to the work of doing that, given that I haven't heard a single useful
reason for --no-create-reflog in the first place.

Personally, I'd be fine with leaving it in its current state as a known
bug that somebody may fix later, if they actually care. But if it is not
too hard to fix while we are all thinking about it, we can do that.

-Peff
