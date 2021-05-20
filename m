Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5329C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 01:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B5860FE3
	for <git@archiver.kernel.org>; Thu, 20 May 2021 01:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhETB4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 21:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETB4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 21:56:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310D1C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 18:55:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 69so8111018plc.5
        for <git@vger.kernel.org>; Wed, 19 May 2021 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cJNDrY7I6mrRTP7uFiASB1Czx4huM0F7W9NakTrQJqw=;
        b=sbhu9hlMYimwoUzw3WB1rK7jsegqwujQTW4G/UE2TEqa/wtdTPv3LP+VXRas16CAai
         JGVArdFSd3Bd0/q+iiruLi7RGhRfgTlztObW1mQI5otebIw5glW5Klx7vHYXeQz0AHqi
         UJtgmZ0YWH8Wd4J51U3IB8uVSU+GXf90p2fc3Njg5tVoBDDzLmERUPHMjZkx5po0CkXi
         g0D0/Cs3BHaLQekQAxsxXSTo5+9Z5kU0aKzlkzc/lHV25urwoHX6OkZ2evhR6yRJbMlb
         jYdDFsKl0RPWVTnnR55A0TybN2fGxlwYo9RHm67mAy/QJE7xn7zUI5Ypu1BEBlwioQPf
         Tvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cJNDrY7I6mrRTP7uFiASB1Czx4huM0F7W9NakTrQJqw=;
        b=SwB8Lz2EugmDZxfKW3KDmh8UZjZzyUC+BnWa7SAuDgQxTBuLMiBMBWg5Wb6CRcpwE+
         XRcDRkt7QWXFAGKjBUcNJK4x3lsyVJWEvy9BFWWX1N9mlf+yiKRQBkeWQF/heriqoPNB
         nc8PZlPuwGcpW3EB+4ZriYRrPDFdfCd5s3oN8HnM1YWu9HTY3pK0/suchVO5paMZvjHO
         hfoqHd8tFAXTCWT4xic2NpZDV6rUrTQzRCuzyC12UK2Ts3o89DR8A0LXXV4Fu3RxZoKe
         Y4QP97VC1sFzOdPJJzlSHcsnaZyR4IrYn6K8x3y35KW6u4xob/6igdY8+nFQl45cg9YY
         xJRQ==
X-Gm-Message-State: AOAM532/gWmoHzz+Vyq2GJP/OUtVvPNtU83R2b0UQrDtU1NSHLtREpTI
        fjrU05q1wlR7JrZeMRSqM84=
X-Google-Smtp-Source: ABdhPJzyGfdXAJI1F2yvUkcm8LeBmL/Ab3p36hD59biHnCpuvmnShWUzffGl8EVZNncbAOUge3ogAA==
X-Received: by 2002:a17:902:f704:b029:f4:228d:4dca with SMTP id h4-20020a170902f704b02900f4228d4dcamr3001125plo.26.1621475719499;
        Wed, 19 May 2021 18:55:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id e6sm2203574pjt.1.2021.05.19.18.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 18:55:18 -0700 (PDT)
Date:   Wed, 19 May 2021 18:55:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
Message-ID: <YKXBhDbWMyB6A7z4@google.com>
References: <YKWggLGDhTOY+lcy@google.com>
 <xmqqeee2w7ov.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeee2w7ov.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> In order to do this, I would like to annotate "exit" events with a
>> classification of the error.
>
> We already have BUG() for e. and die() for everything else, and
> "everything else" may be overly broad for your purpose.
>
> I am sympathetic to the cause and I agree that introducing a
> finer-grained classification might be a solution.  I however am not
> sure how we can enforce developers to apply such a manually assigned
> "error code" cosistently.

I think two things you're hinting at are "what about maintainability?"
and "what is the migration path?"

I suspect that a number of error paths will remain unclassified for a
long time, possibly indefinitely.  The way I've seen this treated in
other tools is that it's okay for something to show up as an INTERNAL
error if it doesn't happen frequently: sure, that can cause us a bit
of unnecessary worry when it starts occuring more often, but at that
point we're in a good place to replace it with something more
appropriate.

That means that we would still want to keep die() or some equivalent.
That in turn might suggest that the API I suggested is overly verbose;
it might make sense to have a different die()-style helper for each
type of error, matching what we do with die() and BUG().

Side note: you might wonder why keeping die() would even be a
question.  For example, there are all the outstanding patches that
still use die(); changing such a fundamental API would seem to be a
nonstarter.  Fortunately, though, the tools in
contrib/coccinelle/README allow changing an API in three steps:

 1. Introduce the new API.  Keep the old API around for backward
    compatibility.

 2. Add a "pending" coccinelle semantic patch to automatically
    update callers to the new API.  Update existing callers using
    'make coccicheck-pending'.

 3. Remove the old API and mark the semantic patch as no longer
    pending.  Patches using the old API can be fixed using 'make
    coccicheck'

So we can make this decision based on whether the resulting API is one
we like more; in this example, I suspect that keeping die() is
preferable _even though_ it would be possible to remove by staying in
step 2 for a while without too much fuss.

> Just to throw in a totally different alternative to see if it works
> better, I wonder if you can teach die() to report to the trace2
> stream where in the code it was called from and which vintage of Git
> it is running.
>
> The stat collection side that cares about certain class of failures
> can have function that maps "die() at <filename>:<lineno>@<version>"
> to "what kind of die() it is".
>
> E.g.  blame.c:50@v2.32.0-rc0-184-gbbde7e6616" may be BUG(), while
> blame.c:2740@v2.32.0-rc0-184-gbbde7e6616 may be an user-error.

For ad hoc queries, this is a rather nice tool.  Traces already record
filename, version, and line number, though I believe in the die() case
it currently just points to the implementation of die(). ;-)

However, for analysis in aggregate (for example, to define an SLO[1])
that would require us to maintain a database that maps
<filename>:<lineno> to error code.  That database would be essentially
the same as patches to record the error codes, so what it would really
amount to is having these deployments using a permanent fork of Git.
It would also get rid of the chance to discuss and improve common
error paths on-list.

If we expect the error codes to not be useful to anyone else, then
that is the right choice to make (or rather, we'd have to use other
heuristics, such as having the traces record a collection of offsets
in the binary and a build-id so we can key off of stack trace
signatures).  Part of the reason I started this thread is to get a
sense of whether these can be useful to others.

Thanks,
Jonathan

[1] https://sre.google/sre-book/service-level-objectives/
