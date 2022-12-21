Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C076C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 23:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLUXOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 18:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLUXOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 18:14:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E00523BEC
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 15:14:17 -0800 (PST)
Received: (qmail 3652 invoked by uid 109); 21 Dec 2022 23:14:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Dec 2022 23:14:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5421 invoked by uid 111); 21 Dec 2022 23:14:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Dec 2022 18:14:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Dec 2022 18:14:15 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta <edecosta@mathworks.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #03; Mon, 10)
Message-ID: <Y6OTR2iwcORPsTxz@coredump.intra.peff.net>
References: <xmqqlepnz1vu.fsf@gitster.g>
 <Y0S7/jA5tNeoQ2Hm@coredump.intra.peff.net>
 <xmqqczazx7dn.fsf@gitster.g>
 <Y0Vq3iGifYeBxPbn@coredump.intra.peff.net>
 <92cc457a-d267-d20f-b516-295646b989ca@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92cc457a-d267-d20f-b516-295646b989ca@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2022 at 12:11:54AM +0100, Johannes Schindelin wrote:

> > > Is there anybody else who is reading Coverity reports, I wonder.
> > > This one is a clear positive.
> >
> > I doubt it.
> 
> As I mentioned to you previously (e.g. in
> https://lore.kernel.org/git/3896n74p-0r16-866o-r668-70q6pos078n9@tzk.qr/),
> I do have a look at them, usually a closer look during the -rc phases.

Thanks for the reminder. I had a vague recollection that you were pretty
negative on Coverity's quality, but you do say pretty clearly there that
you'll continue with builds.

That said, I stand by the sentiment that hardly anybody is looking at
them. It sounds like it's mostly just you and me.

> > My personal fork still has the coverity github-action which I showed
> > last year[1]. We could merge that, but giving access to the project is a
> > minor pain. And of course the full list is full of false positives. One
> > nice thing about coverity is that it marks each defect by date, and
> > tells you how many new ones there are. So when I push up my
> > next+personal branches build, I usually just skim over any new ones it
> > reports. I'd say about 10% of them are actionable.
> 
> That 10% number does not match up with my experience.
> 
> In the v2.39.0-rc period, I looked through over a hundred new issues.
> Pretty much all of them were strvec/strbuf false positives, and even the
> remaining ones were not actionable. (I typically glance over leaks such as
> the one you reported, in favor of focusing on bugs that may cause crashes
> or other serious problems.)

My counting method may be a bit more generous to Coverity. I build
'next' (plus my local topics) every day or three, and get an email from
Coverity if there's anything new. If so, I look at it. So I'm counting
"times I got an email and looked" as the denominator, and the numerator
is "there was at least one useful warning". So that skips some useless
ones that appear along side useful ones.

I'm not sure how you saw a hundred new issues, though. My dashboard has
10 unresolved issues total since the beginning of September, which is
before 2.38 was released, and I think I sent 2 fixes since then (which
are not counted, since they're now resolved, so 2/12).

I do think it would be less noisy if we could somehow convince Coverity
that yes, strbuf really does NUL-terminate the result. But I haven't
wanted to sink time into figuring out how to annotate it.

-Peff
