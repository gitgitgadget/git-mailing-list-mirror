Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA3FC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 23:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhL1XsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 18:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhL1XsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 18:48:05 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302BC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:48:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l5so44874539edj.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ls43tiJprKQQHBaPbyyJ2/O6+ovi7b63SvoggqIGVlE=;
        b=PstFl4D0B2UDU5JT1uyAOhJF07kM+Xvfs7JjyYVQsrpY4M6qZrWGpokLsgfeVgJcu/
         nFcyXN/Y2ou/hatTqs87E6sGZZ5XIi7LoG8tnFngIZflutw8Ufv1R6FSRT2072SOPKyI
         mJ/s9JydPYjLx7ENPyChIunketQUVueaXzU2bJJlKgGuBsMPHTJnEoJ3er09JV5QlDUF
         /hazML6+An9V8ATNVzs2IK6SKbsiYHTG0MKTbCyZXetdzhTIyYyMxtZoLGEVy3kyVzkO
         jnicZsMuEUqxaA8Hy6dFttsdqqoLDjhB/WITDFCQnGbDaGM0gPRyzIs1SSujh0M6Dz/G
         KN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ls43tiJprKQQHBaPbyyJ2/O6+ovi7b63SvoggqIGVlE=;
        b=govzWjdOlSJ3MRQXIA7mjaQrVRQS/7MTd8zcN0vuBrUqy62SQWZA9rK9KpD+QviMhd
         cc74l7zLjq15gkCmONoAoshFEvFy5pJ1y1CEKuvxil3N9RhGhMdJ8msdUvF3rHVOdCCp
         it5aqg8UooGRYr6udcbolWUOM1jl/zrB0IDtV3oA8DKQRHOaTGd/pP7+lYTHx/BhXIB2
         i8q1DagJLiIxSozIFQnaKp/b3Jj3EqlRHETDwKRUam/sGJGlloeCHTBf3fqprVwAvEu+
         h+Ee9K0GGRsOIihgjAj5vzdjJTZhpGUaf9l3abppoTMpuANsYwT+b1s6BJa6r0a9vVJe
         3nNA==
X-Gm-Message-State: AOAM532RjkWe9f6YN0VSTKNczZLYUzyPYN21VU8AZAyjY5+EVl7kYH0j
        xI3LtS31hnRhtSQDSKfLSuI=
X-Google-Smtp-Source: ABdhPJzTPCCz4xV8WzWRTT9MmaQDbtszUXY2wvDQW51SqHdZD36CjMUp+6A5SugrYUGnsvaN4BaPQg==
X-Received: by 2002:a17:906:b003:: with SMTP id v3mr19190303ejy.770.1640735283457;
        Tue, 28 Dec 2021 15:48:03 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id m6sm7959444edc.36.2021.12.28.15.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 15:48:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2MCH-000Fu9-6q;
        Wed, 29 Dec 2021 00:48:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 19/21] usage API: use C99 macros for
 {usage,usagef,die,error,warning,die}*()
Date:   Wed, 29 Dec 2021 00:42:48 +0100
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
 <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
 <66b25f23-7349-1540-76b8-c9f0a64660ac@jeffhostetler.com>
 <211228.861r1xk40d.gmgdl@evledraar.gmail.com>
 <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com>
Message-ID: <211229.868rw4i95a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 28 2021, Jeff Hostetler wrote:

> On 12/27/21 6:01 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Dec 27 2021, Jeff Hostetler wrote:
>>=20
>>> On 11/15/21 5:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> [...]
>>>> It might be a good change to remove the "fmt" key from the "error"
>>>> events as a follow-up change. As these few examples from running the
>>>> test suite show it's sometimes redundant (same as the "msg"), rather
>>>> useless (just a "%s"), or something we could now mostly aggregate by
>>>> file/line instead of the normalized printf format:
>>>>         1 file":"builtin/gc.c","line":1391,"msg":"'bogus' is not a
>>>> valid task","fmt":"'%s' is not a valid task"}
>>>>         1 file":"builtin/for-each-ref.c","line":89,"msg":"format: %(th=
en) atom used more than once","fmt":"%s"}
>>>>         1 file":"builtin/fast-import.c","line":411,"msg":"Garbage afte=
r mark: N :202 :302x","fmt":"Garbage after mark: %s"}
>>>> "Mostly" here assumes that it would be OK if the aggregation changed
>>>> between git versions, which may be what all users of trace2 want. The
>>>> change that introduced the "fmt" code was ee4512ed481 (trace2: create
>>>> new combined trace facility, 2019-02-22), and the documentation change
>>>> was e544221d97a (trace2: Documentation/technical/api-trace2.txt,
>>>> 2019-02-22).
>>>> Both are rather vague on what problem "fmt" solved exactly, aside
>>>> from
>>>> the obvious one of it being impossible to do meaningful aggregations
>>>> due to the "file" and "line" being the same everywhere, which isn't
>>>> the case now.
>>>> In any case, let's leave "fmt" be for now, the above summary was
>>>> given
>>>> in case it's interesting to remove it in the future, e.g. to save
>>>> space in trace2 payloads.
>>>
>>> I added the "fmt" field so that we could do aggregations
>>> of error messages across multiple users without regard
>>> to what branch or filename or percentage or whatever was
>>> formatted into the actual "msg" written to stderr.
>>>
>>> The actual file:line wasn't useful (primarily because it
>>> was probably something in usage.c), but even if we fix that
>>> it might not be useful if we have users running 10 different
>>> versions of Git (because some people don't upgrade immediately).
>>>
>>> So I'd rather not kill it right now.
>> Thanks. I'm not trying to kill it, but just poking at what it was
>> for
>> exactly.
>> Depending on the answer to that perhaps we didn't need it anymore,
>> but
>> the explanation you provide (mostly) makes sense.
>> The "mostly" being because I'm assuming that you only need to deal
>> with
>> LC_ALL=3DC users?
>> I.e. the documented promise that you can group things by "fmt"
>> doesn't
>> hold if you're processing even streams from users who are using a
>> translated git, because we'll get the translated format string, not the
>> original.
>
> I just did a query on the data we've collected over the last
> few weeks and there are only English error messages in the
> database, so yes LC_ALL=3DC seems to be the norm.

Ah, that explains it.

>> For that we'd need to change the API from/to to:
>>      - error(_("some format %s"), ...)
>>      + error(N_("some format %s"), ...)
>
> So no, I don't think it is worth the complexity to change
> this.  Besides, wouldn't you need to more machinery under
> the hood -- to emit the untranslated string to trace2 and
> the translated string to stderr?  (As in, move the translation
> down a layer??)

Yes, hence N_(), it marks the string for translation, but doesn't
translate it. So the underlying function would call _() for what we emit
to stderr, but not for the "fmt" field.

> My "fmt" field is not worth that effort.

Probably not to you because you're deploying git into a monolingual
environment, but for anyone who is they'd need to maintain manual
groupings of messages by scraping our po/*.po files.

> And besides, my goal was only to get the "top 10 or 20 errors"
> across a large set of users.  I guess I'm thinking of it as a
> sample rather than an exhaustive list, so it is OK if we don't
> capture the translated strings.

I suppose with enough users it wouldn't matter either way, but you'd get
quite a bit of fragmentation. You'd also have errors that don't differ
between translations (e.g. those "%s" cases) amplified in count, as they
won't fragment due to i18n.

> Something else to consider is the GDPR.  The "fmt" string is
> generic (e.g. "path '%s' exists on disk, but not in the index")
> but doesn't leak an PII or otherwise sensitive data.  Whereas
> the corresponding "msg" field does include the pathname in this
> example.  So if someone is post-processing the data and aggregating,
> they may want to relay only the "fmt" field and not the "msg" field
> to their database.

Indeed.

> (Granted, there are lots of PII and GDPR problematic fields in
> the data stream that a post-processor would need to be aware of,
> but all of that is outside of the scope of the Trace2 logging.
> I only mention it here because the "fmt" field may be useful for
> reasons not previously discussed.)

I do think it would be a good thing to work on, i.e. to make the logging
less verbose, which as a side-effect would make it GDPR compliant.
