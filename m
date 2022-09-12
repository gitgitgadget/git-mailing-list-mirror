Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770DFECAAD3
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 00:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiILAlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 20:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiILAlW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 20:41:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2AE27B27
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 17:41:20 -0700 (PDT)
Received: (qmail 24548 invoked by uid 109); 12 Sep 2022 00:41:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Sep 2022 00:41:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10486 invoked by uid 111); 12 Sep 2022 00:41:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 20:41:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 20:41:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2022, #02; Fri, 9)
Message-ID: <Yx6AKkWKa5sCUJzM@coredump.intra.peff.net>
References: <xmqq5yhwi1vw.fsf@gitster.g>
 <Yx1tnBRXJdkFQYEX@coredump.intra.peff.net>
 <xmqqo7vlh1pc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7vlh1pc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2022 at 05:32:31PM -0700, Junio C Hamano wrote:

> > I just want to double-check that the plan is to merge this to master as
> > noted above. I had thought you would revert jk/unused-annotation and
> > that I'd just re-roll it. I'm perfectly happy with either, but just
> > didn't want to add more confusion by posting that re-roll. ;)
> 
> Sorry for making a confusing move.  The thing is, the first patch in
> this two-patch series builds on top of your "UNUSED(var)" thing.
> Its patch text depends on "UNUSED(var)" being there, and it explains
> why we ended up using the "var UNUSED" syntax over "UNUSED(var)".
> It of course is the right thing to do because "UNUSED(var)" was
> already in 'next' when it was written.
> 
> We could rewrite it to pretend as if "UNUSED(var)" never happened;
> we prefer to keep experiments that turned out to be dead end and we
> are unlikely to revisit out of our history.  But I think it makes
> sense in this case to leave a record in our history that we consider
> that "UNUSED(var)" is a superiour implementation that we would have
> used and the only reason why we do not use it for now is Coccinelle.
> 
> So, 'next' has the merge of 'jk/unused-annotation' reverted, but when
> 'ab/unused-annotation' was merged, the revert was reverted ;-).
> When it graduates to 'master', it will pull 'jk/unused-annotation'
> along with it and keeps "UNUSED(var)" in our history, but at its
> tip, what we end up using will be "var UNUSED".

OK, I am happy with that. When I rewrote the initial commit to go to
"var UNUSED" instead of "UNUSED(var)", I was going to explain the
alternatives in the commit message. But doing it this way is less work
for me. ;)

I've converted my further annotation patches to "var UNUSED" already, so
those will appear that way from the get-go. If we ever go back to
UNUSED(var), the initial ones are just a "git revert" away, but the new
ones will have to be converted manually. It's not too bad to do it with
a clever use of sed/perl, though.

-Peff
