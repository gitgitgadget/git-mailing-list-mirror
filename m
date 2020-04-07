Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC9C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064932074B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDGUbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:31:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:36370 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726277AbgDGUbM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 16:31:12 -0400
Received: (qmail 4045 invoked by uid 109); 7 Apr 2020 20:31:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Apr 2020 20:31:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1343 invoked by uid 111); 7 Apr 2020 20:41:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2020 16:41:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Apr 2020 16:31:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emma Brooks <me@pluvano.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
Message-ID: <20200407203111.GA1936475@coredump.intra.peff.net>
References: <20200405231109.8249-1-me@pluvano.com>
 <xmqqd08lwatm.fsf@gitster.c.googlers.com>
 <20200407034622.GA42812@pluvano.com>
 <xmqq8sj7t7d0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sj7t7d0.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 12:37:31PM -0700, Junio C Hamano wrote:

> Emma Brooks <me@pluvano.com> writes:
> 
> > It's also too vague and it's not entirely clear from the option itself
> > what sort of encoding it refers to. I will change it to
> > --[no-]q-encode-headers and format.qEncodeHeaders in v2 unless there are
> > other suggestions.
> 
> I actually did not mean to push you into that direction.  We can,
> and do want to, keep the most generic "--[no-]encode-headers" if we
> do not anticipate us wanting to special case the Q encoding.  A
> sample question to ask is "would it make sense to disable q-encoding
> but still perform other parts of 'encode headers'?"  I haven't
> thought deeply about such questions, but as a proposer of this
> topic, you would certainly have, and I was hoping that you'd say
> things like "Q-encoding is the only thing that we do to munge
> headers, so there aren't any 'other parts of encoding headers' we
> need to worry about", "there are things like X, Y and Z that we do
> to the headers when we enable Q-encoding, but they all are what we
> do not want when we do not want the Q-encoding", which would be a
> very good sign that assures us that "--[no-]encode-headers" is a
> good name.

I thought we might b-encode some headers, but couldn't find any code to
do so (after about 5 minutes of looking).

However, this new option isn't just for format-patch. It is available
for all revision walkers (as it should be; I can say "log
--format=email" and I might want to use it there). And there "headers"
is less clear that we are talking about email headers, and not other
object headers (e.g., that you might see with --format=raw).

Saying "--no-rfc2047-encoding" would be more descriptive to _me_, but I
wonder if people not so familiar with the standards would find it a bit
obscure. Another option is to invert it to "--8bit-email-headers" or
something.

-Peff
