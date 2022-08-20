Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A6C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 08:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbiHTI4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbiHTI4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 04:56:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76F659F5
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 01:56:16 -0700 (PDT)
Received: (qmail 21880 invoked by uid 109); 20 Aug 2022 08:56:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 08:56:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9968 invoked by uid 111); 20 Aug 2022 08:56:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 04:56:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 04:56:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: do not translate reflog messages
Message-ID: <YwChr17RntWnoNok@coredump.intra.peff.net>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
 <cover.1660828108.git.git@grubix.eu>
 <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
 <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
 <6oqr69o7-qsps-sr86-o4r9-16r7no9n5424@tzk.qr>
 <220819.86o7wg6zci.gmgdl@evledraar.gmail.com>
 <xmqq8rnkklon.fsf@gitster.g>
 <220819.864jy853qc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220819.864jy853qc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 11:13:21PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Fri, Aug 19 2022, Junio C Hamano wrote:
> 
> > Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >
> >> Doesn't that also mean that the relevant functionality is now also (and
> >> still?) broken on any repository where these translations ended up
> >> on-disk?
> >
> > It may, but the first response to that problem is not to make the
> > breakage in repositires worse by keep adding unparseable data to
> > them.
> 
> *nod*, but where is that breakage specifically? I don't see where we're
> parsing this message out again. I tried to test it out with the below
> (making the message as un-helpful as possible). All our tests pass, but
> of course our coverage may just be lacking...

I'm not sure if you mean "where are we parsing this sequencer message
specifically", or if you're just asking where we parse reflog messages
at all. If the latter, try interpret_nth_prior_checkout() and its helper
grab_nth_branch_switch().

As far as I know, that's the only one we parse, so the answer for
_these_ messages is: nowhere.

I'm not sure if you're proposing to leave the "checkout" message
untranslated, but translate everything else. If so, I'm not sure how I
feel about that. On the one hand, it could help people who want the
translation. On the other hand, it sounds like a maintainability
nightmare. ;)

-Peff
