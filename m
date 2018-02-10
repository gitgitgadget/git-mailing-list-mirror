Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33B21F404
	for <e@80x24.org>; Sat, 10 Feb 2018 18:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbeBJSDh (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 13:03:37 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55852 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBJSDh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 13:03:37 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 7f60d9c3;
        Sat, 10 Feb 2018 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:from:to:cc:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=/MrI6tcWGUs/dx8Epuu4eJcT7K4=; b=C7tXu0SuEHqkVI
        e35EsS+ew2JvBhygPCYWzsQ3Vj3dbXVrKrJe2t0DgU+8yqPv9tkeEeIvTHzgFcce
        RRsdJv4FkU6oWHN4hkNqEBulW0jGsSZCUiRutwD+XCCFyZdfxyy41O1hjsaiRydU
        wjR6Yt12LLvDwlun4T/Pf59ErSUHk=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 56fc30d0 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 10 Feb 2018 18:03:35 +0000 (UTC)
Subject: Re: Fetch-hooks
From:   Leo Gaspard <leo@gaspard.io>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <xmqqvaf5tzw6.fsf@gitster-ct.c.googlers.com>
 <9ab95c53-61e5-06a3-535e-a8916b3e5ec1@gaspard.io>
Message-ID: <92130c51-9e5d-39e9-3129-046295ecb353@gaspard.io>
Date:   Sat, 10 Feb 2018 19:03:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9ab95c53-61e5-06a3-535e-a8916b3e5ec1@gaspard.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2018 02:33 AM, Leo Gaspard wrote:> I guess the very early part
of the discussion you're speaking of is what
> I was assuming after reading
>     https://marc.info/?l=git&m=132478296309094&w=2
> 
> [...]
> 
> So the reason for a post-fetch in my opinion is the same as for a
> pre-push / pre-commit: not changing the user's workflow, while providing
> additional features.
Well, re-reading my email, it looks aggressive to me now... sorry about
that!

What I meant was basically, that in my mind pre-push or pre-commit are
also local-only things, and they are really useful in that they allow to
block the push or the commit if some conditions are not met (eg. block
commit with trailing whitespace, or block push of unsigned commits).

In pretty much the same way, what I'm really looking for is a way to
“block the fetch” (from a user-visible standpoint) -- like pre-push but
in the opposite direction. I hope such a goal is not an anti-pattern for
hook design?

In order to do this, I first tried updating this tweak-fetch hook patch
from late 2011, and then learned that it would cause too high a load on
servers. Then, while brainstorming another solution, this idea of a
notification-only post-fetch hook arose. But, as I noticed while writing
my previous answer, this suffers the same
the-hook-writer-must-correctly-update-FETCH_HEAD-concurrently-with-remote-branch
issue that you pointed out just after the “*HOWEVER*” in [1]. So that
solution is likely a bad solution too. I guess we'll continue the search
for a good solution in the side-thread with Peff, hoping to figure one out.

That being said about what I meant in my last email, obviously you're
the one who has the say on what goes in or not! And if it's an
anti-feature I'd much rather know it now than after spending a few
nights coding :)

So, what do you think about this use case I'm thinking of? (ie.
“blocking the fetch” like pre-push “blocks the push” and pre-commit
“blocks the commit”?)


[1] https://marc.info/?l=git&m=132478296309094&w=2
