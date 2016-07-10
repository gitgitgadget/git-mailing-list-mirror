Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11EB2018E
	for <e@80x24.org>; Sun, 10 Jul 2016 18:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbcGJSFp (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 14:05:45 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36445 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbcGJSFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 14:05:44 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so38683085ith.1
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 11:05:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/cNG5Ahd/R/HSqTu2skm4XN7yCeDNM+uVWEQMO8i6v0=;
        b=gJFOlaitL2EPJQA7OfF+8BK0QpN2O5UBPIwYjflk09wOdk6ViMPP2Djf2CPl3QXrFn
         mbTRsIOZ95Std2mRfDeZ7Xy2jEtDRmL7BvLbxFHcikzi1AyoIVRR8jcr9Mt2Jtrnvhl4
         TVGzRPBEil/WwCGIrHVsdfzMi5cEWP5AxRbfNRXPVBUIcfX3U/IhZWuKwkpp+n4lgB/k
         2MLfZGcwclbA+uF3LuCCPDxqVOde4twILbH1hANWbjfQcCyILrkpbygPMkblZYyCqjNU
         5Nif54uiGHpVx6N9T6tPruVbZ3QtGWqytaNxXektRcA9dUqztLWSNYUcUktjolA6ThWE
         icJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/cNG5Ahd/R/HSqTu2skm4XN7yCeDNM+uVWEQMO8i6v0=;
        b=F+agu4yBIP8l44mS23U7LjuvLeXG+nILZGZX4OQ3AC50lCMzJtw9SFmiNXione7ljJ
         7/JEr2dAqK75ev7+RelpWxt6z1t7gEaALRgvWp7dPv4fEcHG4nYLVb8tvXo18Qdrb06+
         UBqiqwaygHjQR9qDq+4xkxuk0r8yLOaVQvQWziIKOoBBya/bNBM0Oxod7Cy0K7KbJLAQ
         tZQ1wqBgFatyLlRqJX7nvHDMYHcVG6g26QV2a8rzf8LnPtYUa2yNjKTqtLYPTwCzNvOt
         uO4e5SwoNG5osgJQWlCSohdfkee6CCczZA+F9ap5kSXxEsqHZVFqsHEGvspsD4PEQSL8
         aDDw==
X-Gm-Message-State: ALyK8tK1oXdtQf2lRb1KIP02cqryvor8jxGpYB8xFcstuloKab0MvcvR6K/5R3QlXkHl5gmqUgjJfwYblP7W3vdx
X-Received: by 10.36.29.5 with SMTP id 5mr6012420itj.97.1468173943121; Sun, 10
 Jul 2016 11:05:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Sun, 10 Jul 2016 11:05:42 -0700 (PDT)
In-Reply-To: <CAJo=hJtUyF=-iZeA1qBi42KBCP0pE6KsK4_MDP4JZEOf-K0waQ@mail.gmail.com>
References: <20160709003113.26930-1-sbeller@google.com> <20160709003113.26930-3-sbeller@google.com>
 <CAJo=hJtUyF=-iZeA1qBi42KBCP0pE6KsK4_MDP4JZEOf-K0waQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Sun, 10 Jul 2016 11:05:42 -0700
Message-ID: <CAGZ79kaGJCL-HUNm1Rfgzr5E7curgQ9KLU07fonZF5YmiBW35w@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Shawn Pearce <spearce@spearce.org>
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

On Sun, Jul 10, 2016 at 10:06 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Fri, Jul 8, 2016 at 5:31 PM, Stefan Beller <sbeller@google.com> wrote:
>> +
>> +       /* NEEDSWORK: expose the limitations to be configurable. */
>> +       int max_options = 32;
>> +
>> +       /*
>> +        * NEEDSWORK: expose the limitations to be configurable;
>> +        * Once the limit can be lifted, include a way for payloads
>> +        * larger than one pkt, e.g allow a payload of up to
>> +        * LARGE_PACKET_MAX - 1 only, and reserve the last byte
>> +        * to indicate whether the next pkt continues with this
>> +        * push option.
>> +        */
>> +       int max_size = 1024;
>
> Instead of this, what about a new config variable
> receive.maxCommandBytes[1] that places a limit on the number of bytes
> of pkt-line data the client can supply in both the command list ("old
> new ref"), push signature framing, and option list?

Including the whole command list is pretty smart as it actually tackles the
DoS problem as a whole. We shortly discussed having just one upper bound
limit for the push options alone, but we were distracted by the discussion
on whether to advertise this number or just reject it on the server side
after it filled up so much data.

The design here with two bounds was used to not care about the oversized
push options for now. (I mean we can still just reject larger push
options even when
having a receive.maxCommandBytes setting.)

>
> Memory demands for the server are proportional to the data sent. A
> simple byte limit lets the user make the decision about how this gets
> used. Longer ref names or option values means fewer refs or options
> can be sent. Shorter ref names or option values means more values or
> options can be sent.
>
> I studied a lot of repositories[2] and most use ref names under 200
> bytes in length. A 3 MiB default for receive.maxCommandBytes gives
> users something like 11,115 references in a single git push invocation
> if they used all 200 bytes in every name. Most users don't have ref
> names this long. Unlike a cap on each ref, it allows users to use the
> full 65449 bytes in a reference name available in pkt-line, but you
> can only send 48 such references. Likewise for options. :)

In an earlier discussion Jeff said roughly "either make it work well,
or don't make it work at all, i.e. why are git push options better
than a `git push .. && curl <server>/REST-API` thing?"

And by having this design we could punt on the corner cases with
transmitting arbitrary large push options/binaries for now and claim
it's another next step that needs to be done when adding the config
option for it. By having a single receive.maxCommandBytes setting
we would sweep that problem under the rug and people could wonder
why it fails with the large push option.

As said in an earlier email as a side note, we could think about introducing
a v2 pkt line format which starts with a variable int to indicate the packet
size, such that the payload is not bound up to 64k.

I think 3MiB is a bit much for everyday use though and not enough for
corner cases?

>
>
> [1] I may propose this to JGit.
> [2] More than 3M, but maybe Peff has access to more.
