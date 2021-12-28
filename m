Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A2C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 23:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhL1Xxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 18:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhL1Xxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 18:53:34 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D9C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:53:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z29so79573383edl.7
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QXGb0UugxQOz1yU+J1BEOqVdOWY14Z+IqOffjc4NWjQ=;
        b=pnnlcESDfWW+T2it+l8RGXotgb9ej7hDFG/n2upNtHJy1Y30drW9v4kexPROEqrtP9
         JHWgK4as6Rj3yNxdLv3X4WyDh6TU/FQ9/sb43CKfKJYa34Fyg0ApacqxoUVLyHId+5To
         cZdCsA8d15IT/RLdFPfNHmJlnu0DkN3k02bqkIULlEl2ctN2Ka52/cvdHvbiI5oAbIYD
         RXfZPGk7ilam2r+4XdZbcB3hL3MQmQ2eoWGIm15+kmW1z1vhWKfxlmPyqI7pxtfjaTDn
         QULKEjsDJQ6xzlMqB6Ukif6+91ql6dpnmCIDUiONUXJi2PzKOrrBIGzU9JVaDv8Gbn9j
         eX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QXGb0UugxQOz1yU+J1BEOqVdOWY14Z+IqOffjc4NWjQ=;
        b=AQStZxU9YkVfybvsjmAmgD2BTjOdsYSi05VLCppSZx3gZcd9E5C+Vu8egOI6M4Nft2
         DtV/VhfPEd4/cDPs8hxdlFCLZX4A4bkNkZGo7QsQiff6s6Ioh5mPIsNqxNt2N/r0s62h
         8r6cikQpk2v89eenrAbMChvlUO2Ym230gmlrxNeOPFE4KYVnqesBEh7TEp9L1bF2QoVb
         T89rL8+s0PwpY9l3PkjXHLEADvLjCw72ANHdViBT2EqSycVbgCpL5iTOzVyCiM4fc6d+
         MK3H0EkA6VD9bMvTnTCqH1eiTYk8/4rmzqeAmq6Q3iFXOUS8ZZL8TfTJoVm/DtVYZbcS
         Rs1w==
X-Gm-Message-State: AOAM532Q9qEJtVKh/OTyeJ86kWi7UuD8lJj2q8EIcyHNFvM5zD7n/jaA
        3VOqJJ84sYpAoksx83VaW1+fWshcgD5CxtYK
X-Google-Smtp-Source: ABdhPJzEb2dZkYMUe7PyHkygROYpu6UrUkDkkXP9q9KzHW3B9eJIXJsUvX7kYdcVpQVGx84Je9yFng==
X-Received: by 2002:a17:907:d8f:: with SMTP id go15mr20374387ejc.501.1640735612318;
        Tue, 28 Dec 2021 15:53:32 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id hc14sm6389633ejc.42.2021.12.28.15.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 15:53:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2MHa-000G02-6h;
        Wed, 29 Dec 2021 00:53:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 19/21] usage API: use C99 macros for
 {usage,usagef,die,error,warning,die}*()
Date:   Wed, 29 Dec 2021 00:48:48 +0100
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
        <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
        <66b25f23-7349-1540-76b8-c9f0a64660ac@jeffhostetler.com>
        <211228.861r1xk40d.gmgdl@evledraar.gmail.com>
        <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com>
        <CABPp-BHxVTjLFZkM5MBCwymFTzBbyNaoj=hOPYJVV4hBv49eXA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHxVTjLFZkM5MBCwymFTzBbyNaoj=hOPYJVV4hBv49eXA@mail.gmail.com>
Message-ID: <211229.864k6si8w5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 28 2021, Elijah Newren wrote:

> On Tue, Dec 28, 2021 at 8:32 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>> >      If you'd like a semi-stable grouping across similar git versions the
>> >      "file/func" pair should be Good Enough for most purposes. Some functions
>> >      might emit multiple errors, but you'd probably want to group them as
>> >      similar enough anyway.
>
> Why would we want to group different errors?  Isn't the point to
> figure out which error is being triggered the most (or which errors)?
> This sounds like it'd leave us with more investigation work to do.

Ideally you wouldn't, i.e. the goal here is to get some approximation of
a unique ID for an error across versions.

But unless we're going to assign something like MySQL's error ID's
manually any automatic method we pick is only going to be an
approximation.

So the question is whether we can have something that's good enough. The
current "fmt" feature is fragmented by i18n. That's fixable (at the cost
of quite a lot of lines changed), but would something even more succinct
be good enough?

Which is why I suggested file/function, i.e. it'll have some
duplication, but for an error dashboard using trace2 data I'd think it's
probably good enough.

But maybe not. I just wanted to ask about it as a quick question...

>> > But I realize that those things don't give you exactly the same things
>> > that "fmt" does, but maybe they're good enough (or even better?), or
>> > not.
>
> I think "fmt" is strictly better, personally.

