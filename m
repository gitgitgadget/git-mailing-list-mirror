Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C89EECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 03:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiJ1DYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 23:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiJ1DYT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 23:24:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4FFC90EA
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 20:24:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z97so6047566ede.8
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 20:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BwM9IHQq8iKChrQAdJt4MT9gJBQKMold0dw1GhVnoW0=;
        b=hCU89t6RXlJnIiKTjXzyLjC9GbV2INtG9YI7T26K5Ic/A2yfFw7A773eLs4joimHoI
         2dlH0jtrOT6XWDpDKHoZ221KJtvudPsUbLHpULMFZQTQUvxib/S4RicZd7GzkYJt29s9
         0UOC41/RnmVnC+CFvcYDfMXuj+IDiXzYmjc0+IHPNVzRAy2Nk7BZqGHHLxdi2bZzOC9s
         u1HhZQEJo5IaKAWaLjjQiTzJR97CrNedpJRukXLfQjsD4mA/pPKaL3lJkYvXaXk7K2ip
         3j/fnTfZqZX7eJD8V1fCLXhhXJ6g2AuCALNMOsvoHz/bw73UcIjWrlP5fBf1wicjtgar
         iXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwM9IHQq8iKChrQAdJt4MT9gJBQKMold0dw1GhVnoW0=;
        b=7muTbRiniGmwgqvTKkrmMJZT4l264ll8uZ8UjzpKI4zzUEj+271reS7HajX2mBGMYc
         6NHBCqkrwaZrDoxryWW3/ukP9V+EL2ENoNMt7KtItT4jRbgVfIJE3GEEONm7mm4QbASh
         cCuzfUwNrTTqMKeodX6e0cUVHMgKja9lc4FTqCxo0qZmntE3NpVEoYFRt0oOqomgQewy
         C82emsNtzkJO8kYni1Q+nCmMI+eT/RfuIZBMaR91ZLZfZCqOj0hfPt35POAsgx106BNx
         W64krBX8x5c9icHK3tTR/DbtC9JhjSYJMJuJuTm53DI5tC36V5+vJQh3Hvh5IQNfDjTh
         hv2A==
X-Gm-Message-State: ACrzQf3L6NGkqVP1RALCXkDSow3KeKRIMWr8lDvPtpiazxf5Yik1QMmp
        7YN9js5oa/zSAqAKg/7yGSlz1681OZhs/w==
X-Google-Smtp-Source: AMsMyM7MkEWSDcMyQz2R+s8yGR1MB+gyGHZ8iSNMGJM92/Oqc2DOAPttlCb+cuSJa282H1CpfsKe/g==
X-Received: by 2002:a05:6402:1f06:b0:457:149d:beaa with SMTP id b6-20020a0564021f0600b00457149dbeaamr48022075edb.238.1666927456476;
        Thu, 27 Oct 2022 20:24:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906314b00b0072af4af2f46sm1608206eje.74.2022.10.27.20.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 20:24:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooFyh-009lhF-0h;
        Fri, 28 Oct 2022 05:24:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Date:   Fri, 28 Oct 2022 05:11:07 +0200
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
 <221026.8635badbz5.gmgdl@evledraar.gmail.com>
 <08A5BC44-24D9-4C8F-A61A-41983A13553A@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <08A5BC44-24D9-4C8F-A61A-41983A13553A@gmail.com>
Message-ID: <221028.86k04k8wbk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, John Cai wrote:

> Hi =C3=86var,
>
> On 26 Oct 2022, at 7:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Oct 26 2022, Jeff King wrote:
>>
>>> On Wed, Oct 26, 2022 at 04:43:32AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>>
>>>>
>>>> On Tue, Oct 25 2022, Junio C Hamano wrote:
>>>>
>>>>> During the initial development of the fsck-msgids.txt feature, it
>>>>> has become apparent that it is very much error prone to make sure
>>>>> the description in the documentation file are sorted and correctly
>>>>> match what is in the fsck.h header file.
>>>>
>>>> I have local fixes for the same issues in the list of advice in our
>>>> docs, some of it's missing, wrong, out of date etc.
>>>>
>>>> I tried to quickly adapt the generation script I had for that, which
>>>> works nicely, and by line count much shorter than the lint :)
>>>
>>> Yeah, my instinct here was to generate rather than lint. If you make a
>>> mistake and the linter hits you over the head, that is better than
>>> quietly letting your mistake go. But better still is making it
>>> impossible to make in the first place.
>>>
>>> The downside is added complexity to the build, but it doesn't seem too
>>> bad in this case.
>>
>> Yeah, it's not, I have local patches to generate advice-{type,config}.h,
>> and builtin.h. This is a quick POC to do it for fsck-msgids.h.
>>
>> I see I forgot the .gitignore entry, so it's a rough POC :)
>>
>>> (I had a similar thought after getting hit on the head by the recent
>>> t0450-txt-doc-vs-help.sh).
>>
>> Sorry about that. FWIW I've wanted to assert that for a while, and to do
>> it by e.g. having the doc *.txt blurbs generated from running "$buildin
>> -h" during the build.
>
> If we wanted to go this route of generating the docs from the code (which=
 sounds
> like a better long term solution), how would this work? Would we print ou=
t the
> list of message ids in builtin/fsck.c and write it to
> Documentation/fsck-msgids.txt ?

First, for the purposes of this thread I think Jeff and I are far off
into the weeds here :)

I think nothing needs to change in how this topic's doing things, we're
just takling about the longer term.

But if we go for that: I think in this case & most I can think of
generating the code from the docs is better (as that rough POC I had
showed), because:

 - You just need a shellscript to scrape the docs to make a *.c or *.h,
   whereas you'd need a C compiler to make the docs if it's the other
   way around. But more importantly:

 - The docs are way easier to scrape with some sed/awk/grep/whatever
   few-liner than to scrape C code for generating docs. E.g. see
   config-list.h.

 - Scraping the C code sucks so much that we'd probably make some
   dedicated interface for it, e.g. what we have for "git <cmd>
   --git-completion-helper".

   In that case it's worth it, but for other things we'n need to make
   the interface & maintain it (even if it's some test helper just for
   the build).

But mainly it helps to have a use-case, replacing the linter script with
e.g. the *.sh I demo'd might be a marginal improvement. But e.g. "git
help -c" uses one of those generated files (config-list.h), and actually
does something useful ...

Is there a good use-case for the fsck data like that? I'd think that
we'd want to make sure the docs are in sync with the code, as in we're
not adding new warnings/errors etc. without documenting them. But beyond
that maybe not much, and people would just run "git help fsck" to get
the list of variables..
