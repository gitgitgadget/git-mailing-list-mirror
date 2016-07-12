Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C461F744
	for <e@80x24.org>; Tue, 12 Jul 2016 04:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbcGLEyC (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 00:54:02 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34795 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcGLEyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 00:54:00 -0400
Received: by mail-vk0-f44.google.com with SMTP id o63so6400320vkg.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 21:54:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U+PzA6eEOm31RB8XT/xIaeeksElswRERhe7utJ34Va0=;
        b=fKwqOqBOeQBqlfGMTUtrcBwoIy2lY019GuaB4RXX7SvjsPTb9Zbfk9qeK3iXYoUWnh
         WrgJafAlkkyOIhCkxN4gLc39m9gjIkzRC6E0hE5dyp4XaD4GYEKkMk5vkSMpxoQyUoVS
         1oXWE67q/uXsw5DLZmlyEiInDFeUod+CTNOo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U+PzA6eEOm31RB8XT/xIaeeksElswRERhe7utJ34Va0=;
        b=TnUB/DFatTQQX67AZhcr466qpEy7KlbPo256hR+seKufRTanktqZ33NV4xZtzwo7y9
         tjiILmElSY0YvxM82unFsONIzNvoQqxnLl35Uay9ztRVUWvJgbp9pOvteZ7BxaPytnbs
         TrwuH2bcGi3s4q4UaB8cELWmNNTLKzXGUJsZpIh+gFZ+IEvY0Pb7a9VKriJS43EruhYY
         XgitJKcRC/NKlUvfbigdhkwQZTCkvMkrPSO/AQg3Di7O6KYBSvxBCOoUk/aozcPoRE9l
         Dx/H6uNwu6ItTP+7aaTvAkEaHLjoFJD8sKdDpMqsHP7Djy4lgQShwGJ++8OjYhluZb51
         N2qg==
X-Gm-Message-State: ALyK8tJ7ZFp4OWv3nXWLEN5nUs+ql5KC8xdEAbDSjBrWznq9Xv7xpRmSs5QgPMEVv5gs56/5V++m4ieEWKymkA==
X-Received: by 10.31.62.66 with SMTP id l63mr113861vka.87.1468299239730; Mon,
 11 Jul 2016 21:53:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.41.197 with HTTP; Mon, 11 Jul 2016 21:53:40 -0700 (PDT)
In-Reply-To: <CAGZ79kaGJCL-HUNm1Rfgzr5E7curgQ9KLU07fonZF5YmiBW35w@mail.gmail.com>
References: <20160709003113.26930-1-sbeller@google.com> <20160709003113.26930-3-sbeller@google.com>
 <CAJo=hJtUyF=-iZeA1qBi42KBCP0pE6KsK4_MDP4JZEOf-K0waQ@mail.gmail.com> <CAGZ79kaGJCL-HUNm1Rfgzr5E7curgQ9KLU07fonZF5YmiBW35w@mail.gmail.com>
From:	Shawn Pearce <spearce@spearce.org>
Date:	Mon, 11 Jul 2016 21:53:40 -0700
Message-ID: <CAJo=hJvFLonqiHtUfSdDOS53TFK_i847dMY1jPuKVinwEFh2Dw@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 11:05 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jul 10, 2016 at 10:06 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Fri, Jul 8, 2016 at 5:31 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +
>>> +       /* NEEDSWORK: expose the limitations to be configurable. */
>>> +       int max_options = 32;
>>> +
>>> +       /*
>>> +        * NEEDSWORK: expose the limitations to be configurable;
>>> +        * Once the limit can be lifted, include a way for payloads
>>> +        * larger than one pkt, e.g allow a payload of up to
>>> +        * LARGE_PACKET_MAX - 1 only, and reserve the last byte
>>> +        * to indicate whether the next pkt continues with this
>>> +        * push option.
>>> +        */
>>> +       int max_size = 1024;
>>
>> Instead of this, what about a new config variable
>> receive.maxCommandBytes[1] that places a limit on the number of bytes
>> of pkt-line data the client can supply in both the command list ("old
>> new ref"), push signature framing, and option list?

FYI https://git.eclipse.org/r/77108 is my proposal in JGit.

> The design here with two bounds was used to not care about the oversized
> push options for now. (I mean we can still just reject larger push
> options even when
> having a receive.maxCommandBytes setting.)

I don't really see a problem with a single option being nearly 64 KiB
in size. The pack file is going to (probably) need a lot more memory
than that to be unpacked and have SHA-1s generated. The
maxCommandBytes setting at 3 MiB neatly allows a few options to be up
to the pkt-line 64 KiB size, which is 1/10th of what anyone would ever
need. :)

> In an earlier discussion Jeff said roughly "either make it work well,
> or don't make it work at all, i.e. why are git push options better
> than a `git push .. && curl <server>/REST-API` thing?"

One reason this is less optimal is you need to setup authentication
twice. git push might be working over SSH, or over a custom
git-remote-NNN transport. But curl might not speak the same
authentication. Even if git and curl are both using .netrc or an HTTP
cookie file you need to pass the right options to make sure both use
the same auth.

Another is we can do validation of the incoming Git data in context of
what options you specified to us and refuse it while discarding the
pack if we don't like what was asked. With `git push && curl` we have
to save the data without necessarily knowing exactly what we should do
with it, just in case the user comes back with a corresponding REST
API call on another connection.
