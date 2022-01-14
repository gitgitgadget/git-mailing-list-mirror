Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59C4C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 20:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiANUxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 15:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiANUxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 15:53:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F648C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 12:53:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c71so38336793edf.6
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 12:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6zE4uRXjTQfXQMLv787WNK+b85Co98LZxPlI3psySqM=;
        b=eRQhtox/hs/Z7hgV7/2YsRIQUzU8QAXA+wFXnYLcUb8FBOteM2aA4WZca6ll5rJ3qI
         RlbKzpD1OXB94bJpof8aw0Me7CGXbc6LkU54j78tc4qdFf9Dp97bG4eoGodIdeDyzzUv
         RpaMeJGSlvuf/KOSu1003TgqMIN6OfOHOjhvnWGuWC0kc0QIlofMMQq/PLiChHUxKSzA
         +bm8qqiQlYvqAEla0ikqAWYqhsHJMS6sV6amJOUcfP2aKFJp5kxzt/aQpqtlzyIMN0jX
         kHokIry5pAQawXhEPMQMag4lw1VYCtjsPL9y0byXrFua6FRrcag2HYjwM5/Fj+AUmydU
         FvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6zE4uRXjTQfXQMLv787WNK+b85Co98LZxPlI3psySqM=;
        b=uBwV8XFwU0gZScrzV473oqPlu3s5wUd13GGemaIvGPj/7HswOOdQSOT/6du1JX6gJt
         3yja3X2xm1rV8vMs7W5gtm+iZPT1R6mDBUIoefvNOSBdaDgso2LNaML5NuudiUv2+dBO
         luNiEg+HExjwxu7a1aiMlOvMsBBPD8g+JQz06fK8S3ScN1gSuwbcjpapZexx1nz1UJHx
         wriF0NySgOli84n1xrHBDLy4Yn4g1RrEYU6q15v77PJn9HRxexKsSlNojnhJ4/UG2VKw
         xdQifT/lh8Gl7JQd8bEFm/8tk9rtpFPDUa4frl6VjAqIU2NGkDdMoLXJrgYI974OWVXz
         bDlA==
X-Gm-Message-State: AOAM530XqCHcwdwHpxMb+gv0lRIrP47NKdWbC4NBbC0S7sYu2wf6Vbj1
        VBjHYIUnKAFPRdAM3J9rzHo=
X-Google-Smtp-Source: ABdhPJw+QnMpzq8/dd8gGrXpVugDogYOYtaYEWQDlOQeZaMwmk7aDItd/4cAMCZ2lXQJr4Z5j14YKw==
X-Received: by 2002:a17:907:160d:: with SMTP id hb13mr3831359ejc.726.1642193630637;
        Fri, 14 Jan 2022 12:53:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v8sm2665249edt.10.2022.01.14.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 12:53:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8Ta1-001FAn-BN;
        Fri, 14 Jan 2022 21:53:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
Date:   Fri, 14 Jan 2022 21:41:07 +0100
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g> <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
 <xmqq4k7j68eg.fsf@gitster.g> <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
 <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
 <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
 <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
 <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net> <xmqqilumayfh.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqilumayfh.fsf@gitster.g>
Message-ID: <220114.8635lqrqci.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>>> DEVELOPER=1 will now die because its core libraries use C11-specific
>>> code:
>>>     
>>>     archive.c:337:35: error: '_Generic' is a C11 extension [-Werror,-Wc11-extensions]
>>>                     strbuf_addstr(&path_in_archive, basename(path));
>>>                                                     ^
>>>     /usr/include/libgen.h:61:21: note: expanded from macro 'basename'
>>>     #define basename(x)     __generic(x, const char *, __old_basename, basename)(x)
>>>                             ^
>>>     /usr/include/sys/cdefs.h:325:2: note: expanded from macro '__generic'
>>>             _Generic(expr, t: yes, default: no)
>>>             ^
>
> Wow, that sounds horribly broken.

Yes, but it's also working as designed :) We're erroring because the C
library headers on the OS aren't C99-compliant. That it would apply to
only git.git's sources was only ever wishful thinking.

>> I think we had this discussion about FreeBSD before and that's why I
>> specifically dropped that option from the main makefile.  We can either
>> drop that patch, or we can set it to -std=gnu11 and tell folks setting
>> DEVELOPER to use a system released in the last five years.  I think we
>> can be a little stricter with what we require in the case of DEVELOPER
>> than we might be otherwise.
>
> But that is not being stricter, but looser, no?  I thought that the
> point of -std=gnu99 was to allow us to use C99 features while catching
> use of language features newer than that, and use of -std=gnu11 will
> defeat half the point, wouldn't it?

Indeed. But also as noted in my side-thread reply in
<220114.86a6fytte9.gmgdl@evledraar.gmail.com> I think that being able to
use it like this was always wishful thinking.

I.e. to brian's "tell folks setting DEVELOPER to use a system released
in the last five years". This is the exact opposite of that.

We are implicitly expecting that the OS will forever be using the
20+-year old C99 standard, and not trying out fetures in C11
standardized 10+ years ago. The FreeBSD 13.0 release is less than a year
old[1].

When I went looking I found that the change to use __generic in its
libgen.h just so happens to have been made in FreeBSD sources around 5
years ago: [2].

1. https://www.freebsd.org/releases/13.0R/announce/
2. https://github.com/freebsd/freebsd-src/commit/34168b28e99b0bb328c7bb49cd91cb942181056f
