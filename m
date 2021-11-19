Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C747BC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9501261B2B
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhKSVEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhKSVEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 16:04:48 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB3C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 13:01:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l25so31254652eda.11
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 13:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OQTMHpYdUYp+Xt4o0tyXQKR2Qv7mbRrSjd+QnvFatUQ=;
        b=XaHhMBx3XMN+zgu9UfekY8CJnEd1mglvnr3/XFp6O9A/aWF9xO95NYVHANyLDO5DMd
         vtl2WUWPIC6NTYkGOD/R8YDACx2hbAtPe+keOG+QmggssUM6sDZv56IeMvmx1e+DydUv
         IEpIvLDY4aml0v5itBigTl5NW5+tn4RgNOp0A/sJPy1zgc8WRCSrJPhl0yWQaXIXzDtR
         O2tzog3hZZXTDD+gxXJ5xR5NzfQ9Wamj8u6N1mJeV5qpSul+g+PufuacYIrYUIEcFjz6
         Fiy3Yktoi6EONIGq3ARTpyywn2/4HnE2sEALQl3pV3mPbLukMJ9uXAZ6uzsmsVNCXZjn
         mnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OQTMHpYdUYp+Xt4o0tyXQKR2Qv7mbRrSjd+QnvFatUQ=;
        b=RyCBjE1k+ckz0Zn6J2F/pRbku5TtvX+hGFVviPoyxUzaYiJm4eL1+SCqzY+mfT/JpW
         1uJRGSC7dtHrF5G0gDyt6ebjLMLuZmpvX0/+pHMpZS6d9k6WkQPsJv4jGazY/vQ7Zn9z
         0PLJbah4mmo6eFKxRpGvOjUTQAJde5ltM5ANpXDvMm+ap7/MDC3mLl1G7MHi8bY/c/H2
         7lq8Bcvt76hX9hiUwaWa6aNIZ4B5sJYggC/OzIEN1yR3iSvZlmlbY1xPjh8Ptkv3HRyd
         XGn7U1HvCeiZX+Wje5hpWMDLA425wzvZG+ujawKKV6Xw7u18WkOlGMn+uh2fR1VukFOA
         44Uw==
X-Gm-Message-State: AOAM530f3Z5YUJXnM0+IE1AdXujsUjtKx9+0Xr8ezkgW5cRp+RYZgfcJ
        hK6nd3YYJVfZTE7p6ju/VS03wikla2L5Ww==
X-Google-Smtp-Source: ABdhPJynMeBMod4ffvdGtGBl7BjrSdFwju88O4UNpRTUp5CEESWY2sdRL5O2lCGk1ra8xqggqk2AXA==
X-Received: by 2002:a17:906:5811:: with SMTP id m17mr11612169ejq.289.1637355704444;
        Fri, 19 Nov 2021 13:01:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm406639edk.41.2021.11.19.13.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 13:01:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1moB0x-000oQm-FA;
        Fri, 19 Nov 2021 22:01:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Danial Alihosseini <danial.alihosseini@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
Date:   Fri, 19 Nov 2021 21:57:25 +0100
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
        <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
        <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
        <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
        <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
        <190a1fea-124d-2e85-38ea-9dab87f3e377@kdbg.org>
        <429375f7-ec3e-596f-5f79-c724570c8397@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <429375f7-ec3e-596f-5f79-c724570c8397@gmail.com>
Message-ID: <211119.86zgpz272g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Derrick Stolee wrote:

> On 11/19/2021 3:05 PM, Johannes Sixt wrote:
>> Am 19.11.21 um 15:51 schrieb Derrick Stolee:
>>> What is unclear to me is what exactly "match a directory" means.
>>> If we ignore a directory, then we ignore everything inside it (until
>>> another pattern says we should care about it), but the converse
>>> should also hold: if we have a pattern like "!data/**/", then that
>>> should mean "include everything inside data/<A>/ where <A> is any
>>> directory name".
>>>
>>> My inability to form a mental model where the existing behavior
>>> matches the documented specification is an indicator that this was
>>> changed erroneously. A revert patch is included at the end of this
>>> message.
>>>
>>> If anyone could help clarify my understanding here, then maybe
>>> there is room for improving the documentation.
>> 
>> You form a wrong mental model when you start with the grand picture of a
>> working tree. That is, when you say
>> 
>> - here I have theeeeeese many files and directories,
>> - and I want to ignore some: foo/**/,
>> - but I don't want to ignore others: !bar/**/.
>> 
>> This forms the wrong mental model because that is not how Git sees the
>> working tree: it never has a grand picture of all of its contents.
>> 
>> Git only ever sees the contents of one directory. When Git determines
>> that a sub-directory is ignored, then that one's contents are never
>> inspected, and there is no opportunity to un-ignore some of the
>> sub-directory's contents.
>
> So the problem is this: I want to know "I have a file named <X>, and
> a certain pattern set, does <X> match the patterns or not?" but in
> fact it's not just "check <X> against the patterns in order" but
> actually "check every parent directory of <X> in order to see if
> any directory is unmatched, which would preclude any later matches
> to other parents of <X>"
>
> So really, to check a path, we really want to first iterate on the
> parent directories. If we get a match on a positive pattern on level
> i, then we check level (i+1) for a match on a negative pattern. If
> we find that negative pattern match, then continue. If we do not see
> a negative match, then we terminate by matching the entire path <X>.
>
> I'm still not seeing a clear way of describing the matching procedure
> here for a single path, and that's fine. Me understanding is not a
> necessary condition for fixing this bug.

Just watching this thread on the sidelines I think it would help if it
can be distilled down to a wildatch() test that doesn't have to do with
the pathspec matching code.

I.e. can you stick the "should this match?" into t3070 and it does the
same thing, or is this to do with the pathspec-specific sugar on top,
either that it splits paths and then matches them, that there's some
information about the path type in there added on top, or that it's to
do with the specifics of the exclude/include gitignore matching?

FWIW I have some old WIP patches somewhere where I made this match
behavior much faster by compiling the (using a mode PCREv2 has) glob
syntax into PCRE's, which are then JIT'ed, and matched.

To do that I had to unpeel this whole truncation of the pattern thing,
and IIRC it didn't matter for speed (or maybe it did just with the
wildmatch code?).

Maybe all of this is irrelevant, sorry. I haven't looked into this issue
at all, just skimmed this growing thread over the past day, maybe some
of the above helps, or not...
