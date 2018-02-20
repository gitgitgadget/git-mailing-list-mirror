Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785A81F404
	for <e@80x24.org>; Tue, 20 Feb 2018 21:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeBTVTw (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 16:19:52 -0500
Received: from grym.ekleog.org ([94.23.42.210]:38362 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeBTVTv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 16:19:51 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 391e5ded;
        Tue, 20 Feb 2018 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=Dv384eRpJ4UpvRIMX7bnaIXfx78=; b=4G4gt6R0GFO9MB
        94J7M3/I+dWOLk5+f/8QWx0YV2o4t4MFivwYKsXD9GXmkGZTItN0xI4b1riUpsy2
        22gmiIbyaLNnPPeFfct7uuamedpmtQZ4/knmhUCnUdjdCGK9dDH/jqsfqQzvl858
        rTvOOxzQFDBmTf7fCvukI1zKGRHJE=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 5525b556 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 20 Feb 2018 21:19:49 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
 <20180214013520.GA25188@sigill.intra.peff.net>
 <96dd7fb3-849b-8de6-7c3a-cd6bde9da432@gaspard.io>
 <20180219212347.GA9748@sigill.intra.peff.net>
 <cdef8e46-92ee-2062-385a-999b5b49ae9a@gaspard.io>
 <20180220074201.GA2154@sigill.intra.peff.net>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <51505f97-9d56-a938-7255-ed11fa0de814@gaspard.io>
Date:   Tue, 20 Feb 2018 22:19:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220074201.GA2154@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20/2018 08:42 AM, Jeff King wrote:>> [...]
>>
>> Is there a way for “pre-receive” to individually filter [refs]? I was
>> under the impression that the only way to do that was to use the
>> “update” hook, which was the reason I wanted to model it after “update”
>> rather than “pre-receive” (my use case being a check independent for
>> each pushed ref)
> 
> No, pre-receive is always atomic. However, that may actually be what you
> want, if the point is to keep untrusted data out of the repository. By
> rejecting the whole thing, we could in theory keep the objects from
> entering the repository at all. This is how the push side works via the
> "quarantine" system (which is explained in git-receive-pack(1)).
> Fetching doesn't currently quarantine objects, but it probably wouldn't
> be very hard to make it do so.

Oh, I didn't think about quarantining behavior, indeed!

So I guess, following your answer as well as Jake's, I'll try to
implement a pre-receive-like hook, and will come back to this list when
I'll have a tentative implementation. Thanks for the advice! :)
