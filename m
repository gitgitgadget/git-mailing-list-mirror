Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E670CDB46E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjJKX3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJKX3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:29:45 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB2AA4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:29:43 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697066982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkgyXmz7UYRgmZVlRQyvrBFNyeNIFAXCq9FskRLKxek=;
        b=IHCFoczx08mtwZTplvQbPPNfhOrymclsAAUMECGa3p2ErpvA7/uG8zAJhggsKZD3UrAtq7
        BYGZhueBVpVYD/qLm+SJtAdjJpkw6zd0qVzU4b94TMonoYKyW66fNW9GVWfcBiww0gBCsy
        7QL2OZbJrQobrxOniY2dnb7fFxpDhaiKgNWzi6+n4v8y02dQeK564YeAd+AOSxRf1aJfoc
        4kvsHNYfvOHmzix1bFoy0pEN3tW91iVZ4WiS4yc6HHboSLFKQupwXoxdulVn3sPgOO3HrY
        bhM7koy6B33Mu7WMnZcrHWQMYxAuwEu6EcGOPvZzTCIMwQEptF/dhHFw+HXl5w==
Date:   Thu, 12 Oct 2023 01:29:41 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
 <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
 <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
Message-ID: <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-12 01:16, Christoph Anton Mitterer wrote:
> On Thu, 2023-10-12 at 00:51 +0200, Dragan Simic wrote:
>> In general, not clearing the screen (i.e. "-X") is there so the
>> displayed contents is still visible in the terminal after exiting the
>> pager.  That wouldn't be the case if the screen was cleared, making
>> it
>> less usable for most users.
> 
> Well, I personally, also prefer it that way... but I'd also say that
> just like in the case of `S`, this is not really needed from the git
> side, but rather simply a user choice.

It's about providing a set of sane defaults for less(1), which other 
utilities also do, including dmesg, for example.  Of course, everyone 
can set $PAGER or $GIT_PAGER to fit their own prereferences.

> And since, if the output did not fit one one screen, the non-cleared
> remains may likely be chopped off,... one could argue that some users
> would actually prefer to have it cleared.

I'm not sure what do you mean by the non-cleared remains being chopped 
off...  Could you clarify that a bit, please?

As I already mentioned above, everyone is free to configure the pager 
behavior in any way they like.

>> Exiting if less contents than one full screen was displayed (i.e. "-
>> F")
>> is there to save people from the frustration of quitting a pager that
>> actually wasn't needed to be executed.
> 
> Same actually here, at least strictly speaking, ... though I (and
> probably everybody else?) would really hate it, if that was removed. ^^

I'm afraid that I don't understand very well are you complaining about 
the presence of "-F" or not?

> Anyway... that's no request from my side to change the default. I just
> wanted to know whether that don't-clear-the-screen part was the
> motivation for the `X`.

AFAIK, there should be no motivation other than not clearing the screen. 
  Other utilities that invoke the pager internally configure the default 
pager options in a very similar way.

> In case someone cares, I've asked less upstream whether there's a way
> to have VTE scrolling work with -X:
> https://github.com/gwsw/less/issues/445

Quite frankly, I can't stand scrolling in less(1) using the mouse wheel, 
but I do understand why some people like it.
