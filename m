Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E4C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF3D20786
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHYPLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:11:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:39942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYPLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 11:11:07 -0400
Received: (qmail 32601 invoked by uid 109); 25 Aug 2020 15:11:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 15:11:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28141 invoked by uid 111); 25 Aug 2020 15:10:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 11:10:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 11:10:53 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] refs: remove lookup cache for reference-transaction
 hook
Message-ID: <20200825151053.GA1409139@coredump.intra.peff.net>
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
 <c1cae6dd19ffe00e4456e4f96ad92277ceeced27.1598349284.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1cae6dd19ffe00e4456e4f96ad92277ceeced27.1598349284.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 12:35:24PM +0200, Patrick Steinhardt wrote:

> The only change compared to v1 is that I've addressed the unportable
> `branch-{1..1000}` syntax in favor of `test_seq`. I had to setup refs as
> part of the setup and change the ordering for "update-ref --stdin" from
> create/update/delete to update/delete/create, but I don't think that's
> too bad. At least timings didn't seem to really change because of that.

Another option instead of changing the order in the other tests is to do
another untimed setup step before the push test. I'm OK either way,
though.

> +test_perf "nonatomic push" '
> +	git push ./target-repo.git $(test_seq 1000) &&
> +	git push --delete ./target-repo.git $(test_seq 1000)
>  '

This works as far as Git is concerned, but "seq 1000" output with NULs
is 3893 bytes. I wonder if some platforms might run into command-line
limits there. I guess we will see when Windows CI runs. :)

-Peff
