Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A0C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 15:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbhK3PVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbhK3PSg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 10:18:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878FEC061A20
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 07:12:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so88260787edd.9
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZHMG563O3B0j09ZKHjtphBnMys4VPAHNlsEOO+9DFZI=;
        b=dsz7Ef57qXtdwNfxfbHrzkfPom+zNvPEDpZXVNAQf5fTRJivC3rO64OA4W7F9Eum44
         m3yalOmAnGxuV5dYZ1wkqY04J383Y5002t6SYxSCT0eBExCbUKh0s7XfSDCA3+A69Asg
         fMKSyZRr/TYbKXTpb5exSy1idEwG5pC5YPRRQcg/7oi5wcR3vrbqgSfpkIEcbMqLx6Jl
         F2X5SfXee0htxvEUGHstW+S1yzvk89Jl74mGHuK+C+aYJykwJAx79oYsBTd/LZ7jgk5z
         xqeej8K35HvxKg7Pkditp8TZVeg3su29ycT3FALqZ0HL+jVNzXnox/AKK2i0BssQoRZM
         TWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZHMG563O3B0j09ZKHjtphBnMys4VPAHNlsEOO+9DFZI=;
        b=RXduf95zyZst6XyFj8Ajc30Sc5CJnou5FJKvL3kAAnhNvZvMZTi59yP/nbxMdad0Up
         NGUaAaxSQO+pu4K/sto3kk+GoIszSHqEQmfs+Z2caBj+cOS7YyE0udiyKqvz0MGk5GpF
         LlsiXm1tUOCkwKaTBpPaGpnbxnSYitlK9szYBLhTWOCgLz5hBGYoTcAe7grazazUQi3A
         gGYzAmgFN1w0utxagELM2kiRkhwjMXxZWqdTSwDKuBMdFagM0E8tqYt0jeWQ4OKz8+2f
         rYOzmWj1bu1W9qGa6vKhL3Ob5vZCiwVpIjV/jYX9VJODoP3B630r4+sn/DNv8JK6JIw8
         u3rg==
X-Gm-Message-State: AOAM532OIQ6sIYu4UyLbsNUj93Z4NyJd9mh2bg53gpfM6arCLMDhdVhE
        6ySOXDzV+JXWTmWkq/neRV0=
X-Google-Smtp-Source: ABdhPJwBSjuvgLTz82RQWp9QxxXY2LVqAShbFBCQ1kKFfyJKLhBeeK96vCeiHlAAzrwdIvVrYewIjw==
X-Received: by 2002:a50:9510:: with SMTP id u16mr84140899eda.134.1638285136991;
        Tue, 30 Nov 2021 07:12:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cs12sm9334239ejc.15.2021.11.30.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:12:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ms4nn-0012YF-V8;
        Tue, 30 Nov 2021 16:12:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
Date:   Tue, 30 Nov 2021 16:10:37 +0100
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <xmqqtufu2pll.fsf@gitster.g> <YaXPUe9Sz3JBlzYL@coredump.intra.peff.net>
 <YaXRd2YBQR+ifNTE@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YaXRd2YBQR+ifNTE@coredump.intra.peff.net>
Message-ID: <211130.86sfvdd6eo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Jeff King wrote:

> On Tue, Nov 30, 2021 at 02:14:25AM -0500, Jeff King wrote:
>
>>   - flushing causes us to block. This implies our stdout is connected to
>>     a pipe or socket, and the other side is not expecting to read. A
>>     plausible case here is a client sending us a big input which we find
>>     to be bogus (maybe index-pack checking an incoming pack). We call
>>     die() to complain about the input, but the client is still writing.
>>     In the current code, we'd write out our error and then exit; the
>>     client would get SIGPIPE or a write() error and abort. But with a
>>     flush here, we could block writing back to the client, and now we're
>>     in a deadlock; they are trying to write to us but we are no longer
>>     reading, and we are blocked trying to get out a little bit of
>>     irrelevant stdout data.
>> 
>>     I _think_ we're probably OK here. The scenario above means that the
>>     caller is already doing asynchronous I/O via stdio and is subject to
>>     deadlock. Because the segment of buffer we try to flush here _could_
>>     have been flushed already under the hood, which would have caused
>>     the same blocking. A careful caller might be using select() or
>>     similar to decide when it is OK to write, but I find it highly
>>     unlikely they'd be using stdio in that case.
>> 
>> Of the two, the deadlock case worries me more, just because it would be
>> quiet subtle and racy. As I said, I think we may be OK, but my reasoning
>> there is pretty hand-wavy.
>
> Thinking on this a bit more: I guess as soon as we exit libc would call
> the equivalent of fflush(NULL) anyway, and try that same flush. So in a
> sense this is just ordering a bit differently, and not introducing any
> new problems. (Unless libc is clever enough to avoid blocking, but that
> doesn't seem like something we could or should rely on in general).

I think this change is probably OK too, but let's not forget about
warning() and error(). I.e. we are not always on a path to a fatal error
with vreportf(), that's just with die(), usage() and BUG().

So e.g. the warning you added recently (and we ejected before v2.34.0)
about encodings in "git log" would behave differently with this
change.

I think probably for the better, but we should also consider those
cases.
