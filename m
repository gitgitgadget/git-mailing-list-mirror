Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6474EEE4996
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 01:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjHVBaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 21:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjHVBaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 21:30:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C8110
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 18:30:20 -0700 (PDT)
Received: (qmail 19578 invoked by uid 109); 22 Aug 2023 01:30:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Aug 2023 01:30:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24726 invoked by uid 111); 22 Aug 2023 01:30:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 21:30:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 21:30:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] diff: the -w option breaks --exit-code for --raw
 and other output modes
Message-ID: <20230822013016.GA1815572@coredump.intra.peff.net>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
 <20230818235932.3253552-6-gitster@pobox.com>
 <20230821210058.GD1800481@coredump.intra.peff.net>
 <xmqqcyzgniaq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyzgniaq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 03:26:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> ...
> >> about it is that it is not like we recompute the hash of the blob
> >> after removing all whitespaces to show "git diff --raw -w" output).
> >> 
> >> But that is not an excuse for "git diff --exit-code --raw" to fail
> >> to report differences with its exit status, when used with options
> >> like "-w".  Make sure the command exits with 1 when these options
> >> report paths that are different.
> >
> > I think s/with options like/without options like/ in the final
> > paragraph?
> 
> Sorry, I am confused.  "diff --raw --exit-code" without "-w" reports
> with its exit status that it found differences just fine.  When "-w"
> is given, without this patch, it always reports 0.

I think I just got confused by the multiple negatives "not an excuse to
fail to...".

> What I wanted to convey was ...
> 
>     "--raw" and friends deliberately ignore "-w" and other "look at
>     contents" options.
> 
>     The fact they do ignore the "look at contents" options is not a
>     good excuse for "diff --raw -w --exit-code" to also ignore the
>     request to report the differences with its exit status.  "diff
>     --raw --exit-code" does report the differences as requested, and
>     we should do the same when given "-w".

Yes, that conveys it more clearly (to me, anyway).

-Peff
