Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EA3C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 15:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355656AbiDOPxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 11:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355402AbiDOPxt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 11:53:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F0986FE
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 08:51:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so15938313ejf.11
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aTDSaSBzWnLUaNGQaW26tsp57qOOuOMQ9R/v1ab4BeA=;
        b=Oh7h7SxM6gOQalDJvEIO+bk8dSOAWBveaCFImP4jI7DIv1tQqwitrYWXVC5o561YzE
         Dh9V3KvQJm3IQzsVMgG7mjodJuJggA2WCb3YZIT2PTgVUDcxPFe4Y/TUAKK9T77dyd6X
         xEeOU8vw6qmjdOLC3ykkawhtW03JQIpvDcHOlttxbS6XlZpt0iU89sHPEatmxjc8IAYN
         5X+TPT89xHpQmdWB1sykdvAS1j8VUnEwS0lpCoWBy7h0gAOBOhFd/LOgrioxM6WT0dWc
         5kQcIIOsnmbaMZDvxikX45glK9jHccMy5fQQ5kiurzjdrsBLIBucI8nch/+TV7U+AQZv
         +KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aTDSaSBzWnLUaNGQaW26tsp57qOOuOMQ9R/v1ab4BeA=;
        b=uvKS1GeClY6DFV194UUbfKk6r0rTaZyihTBOUPjtJ2EKOs9S+9CWA2SMrTn/A/JRGZ
         TqKPV+QVv2OhHPXg98HF/EDpalBPODidL17D2+w3GMRX6y4q1jFYllqYpZzHrIdO1ir7
         d51p9ZdS3hEz+dddl/e7fr05iS+/rC/udu+LErxfz/3NEPoKpW472ZigFA+k+EVKJc5G
         uAf2V2hA7smE6wdKnqjFAQTswGTXLwmtyazODDUacy08uvM1A9vaF+HJqrpuw0irYuI8
         kZMZ1u0wJGUmaX1n0Edn2VFkqpJeJ5kVCazCbYxQ/OkVC7R9tkw/dzUmNyfiYyVw6ziE
         Y0Iw==
X-Gm-Message-State: AOAM530OrLirexNAXOBrNP2M481N9F4lpB54osiZwPQzSGv65LCFjAka
        Lza5H3qGITy4m1ROvVTkPI4=
X-Google-Smtp-Source: ABdhPJyTN2Q8FmkPQf/aJuEOgWZOOjAqA2yuWhWc/DFq7owxxu3qXKLIpKCnRiZ91j85G5tXxe2reA==
X-Received: by 2002:a17:906:99c1:b0:6db:f0cf:e38c with SMTP id s1-20020a17090699c100b006dbf0cfe38cmr6622891ejn.692.1650037879320;
        Fri, 15 Apr 2022 08:51:19 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906270800b006bbd3efa6b8sm1766234ejc.80.2022.04.15.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:51:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfOEA-005ii5-84;
        Fri, 15 Apr 2022 17:51:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 2/2] reftable: don't memset() a NULL from failed
 malloc()
Date:   Fri, 15 Apr 2022 17:20:53 +0200
References: <20220415083058.29495-1-carenas@gmail.com>
 <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
 <RFC-patch-2.2-364d1194a95-20220415T101740Z-avarab@gmail.com>
 <4321a9dd-bb82-e2fe-5449-395f998378c5@web.de>
 <220415.86fsmebgds.gmgdl@evledraar.gmail.com>
 <23138e2b-436a-0990-cefc-0662674373c3@talktalk.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <23138e2b-436a-0990-cefc-0662674373c3@talktalk.net>
Message-ID: <220415.86bkx2bb0p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Phillip Wood wrote:

> Hi =C3=86var and Ren=C3=A9
>
> On 15/04/2022 14:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Apr 15 2022, Ren=C3=A9 Scharfe wrote:
>>=20
>>> Am 15.04.22 um 12:21 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> Return NULL instead of possibly feeding a NULL to memset() in
>>>> reftable_calloc(). This issue was noted by GCC 12's -fanalyzer:
>>>>
>>>> 	reftable/publicbasics.c: In function =E2=80=98reftable_calloc=E2=80=
=99:
>>>> 	reftable/publicbasics.c:43:9: error: use of possibly-NULL =E2=80=98p=
=E2=80=99 where non-null expected [CWE-690] [-Werror=3Danalyzer-possible-nu=
ll-argument]
>>>> 	   43 |         memset(p, 0, sz);
>>>> 	      |         ^~~~~~~~~~~~~~~~
>>>> 	[...]
>>>>
>>>> This bug has been with us ever since this code was added in
>>>> ef8a6c62687 (reftable: utility functions, 2021-10-07).
>>>
>>> Not sure it's a bug, or limited to this specific location.  AFAICS it's
>>> more a general lack of handling of allocation failures in the reftable
>>> code.  Perhaps it was a conscious decision to let the system deal with
>>> them via segfaults?
>> I think it's just buggy, it tries to deal with malloc returning NULL
>> in
>> other contexts.
>
> Does it? I just quickly scanned the output of
>
> git grep -e 'reftable_[mc]alloc' -e 'reftable_realloc' -A2 origin/master
>
> and I didn't see a single NULL check

I think you're right, I retrieved that information from wetware. Looking
again I think I was confusing it with the if (x) free(x) fixes in
34230514b83 (Merge branch 'hn/reftable-coverity-fixes', 2022-02-16).

>>> When the code is used by Git eventually it should use xmalloc and
>>> xrealloc instead of calling malloc(3) and realloc(3) directly, to
>>> handle allocation failures explicitly, and to support GIT_ALLOC_LIMIT.
>>> This will calm down the analyzer and extend the safety to the rest of
>>> the reftable code, not just this memset call.
>> Yeah, its whole custom malloc handling should go away.
>
> Isn't it there so the same code can be used by libgit2 and other
> things that let the caller specify a custom allocator?

I don't think so, but I may be wrong. I think it's a case of
over-generalization where we'd be better off with something simpler,
i.e. just using our normal allocation functions.

That still allows for taking this code and plugging it into any custom
allocator. If you simply want to compile some code such as this to use
another allocator you can easily do that via the linker, as
e.g. git.git's build process allows you to do with nedmalloc.

So presumably if libgit2 would want to use this they'd just do that via
their build process.

I.e. they'd have "malloc" point to a symbol that would resolve to a
shimmy layer that would dispatch to functions using this:
https://github.com/libgit2/libgit2/blob/main/src/util/alloc.c

The reason you'd use these sorts of pluggable malloc functions is, I
think, a few:

 1. You are a library like libgit2, as opposed to libreftable itself, so
    you want to provide this sort of "set the alloc pointers to this"
    now. But in this case we either always want malloc/free (git.git) or
    the "parent" can provide these wrappers (libgit2).

 2. You want to support switching dynamically (or not-globally), or have
    N instances with different malloc, as e.g. the PCREv2 API does:
    cbe81e653fa (grep/pcre2: move back to thread-only PCREv2 structures,
    2021-02-18).

    For this code I think that's thoroughly in YAGNI territory.

 3. Your distribution model can't assume the user can adjust this via
    linking, e.g. C source that's intended to be #included as-is
    (although there you could use defines...) etc.

But maybe I'm missing something.

But a really good reason not to do this and just rely on the link-time
overriding is:

 A. Things look the same, and benefit from more general fixes (although
    to be fair the x*alloc() wrappers would work either way..)

 B. You don't get subtle bugs where you forget some_custom_malloc() and
    then use a generic free(). Having looked just now reftable/ has at
    least one such submarine-segfault waiting to happen.

 C. If you don't actually need the hyper-customize pluggable model of
    say PCREv2 where the library is trying to support having two
    patterns in memory managed by different allocators, or other such
    advanced use-cases it's just extra complexity.

Some of this was discussed for xdiff/* in this thread:
https://lore.kernel.org/git/220216.86leybszht.gmgdl@evledraar.gmail.com/
