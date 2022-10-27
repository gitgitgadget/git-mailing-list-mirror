Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC29FA373D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 23:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiJ0XiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 19:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiJ0XiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 19:38:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37084D241
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 16:38:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sc25so9075134ejc.12
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aFPcTzbqz/A57wEJ4RrslLYiHKz8hMSlxbjW87Osa9w=;
        b=eNR8O768KVMAU+CVJAsCNt95O5e+Dd+zVVPcsMTOxDBswAX6thN+LmgDnEwexdlqpy
         6UMPlSBYA/7DPzJa/QEGoKRXrp2Ift9YM7J7E1z8bvT+i+IAODkCsDFcWgpeF2dC//FN
         YLM5syiUVHmAAm8kIcRakCr/cDWbAxCmY2PaOnpMkChROq65CULxRW+Fy6BA0ixg09Lx
         ng/NJpwaTrzRtKqh3zXEEm6ObT4t/gHYeAfU1vkQUeJt1KOjq1OR4NvvAAFYkM41MHx5
         7FMo59OxfeYzwfnGoh0JHdK6iSUJ9dbu6r5uN14UQTPnJeqxIE2spXYs5GsJEeqfCQME
         0gUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFPcTzbqz/A57wEJ4RrslLYiHKz8hMSlxbjW87Osa9w=;
        b=u3EHIWpO8QplAbWihXgWJPAYhVmrIQ5WejscJCQkB+LTSFQTIyky7F3Cg5St87iRoa
         D5GOhXF20Nv2sKSrRjepK97ZJKOyL7tldA55CTTOe1ab/XSUDfic4Lm29citcCS505Jy
         TiuqN/aLdGZSWap+Bp67GoeLt1hAmb/m4Sfzz7Mg0AbXk+FicUgVs7mR9PgT1gAxQ+ni
         nSJIBGydqHk+aW1nyA7XT6GwJpy26yhnORfg6FCdECHVC6iPpl6yiRAwxQWjbplyjRQD
         4+2QyUsJ2AxAXWPcWUKPlTW7wVpKxMkwisg9tnnWhZZHWowNNyjyW6JS9kElAtlRnqYh
         mbMg==
X-Gm-Message-State: ACrzQf0NAGlPbb//ggay+gXJliM5uEGfcCSKsGGy5HtMBGbCLoHL27qt
        2aRKDJj5IvyIAI9FEQzQigA6OtmCBPwhCw==
X-Google-Smtp-Source: AMsMyM4RjuOE6yYMAIdBtuVjbv72N1dK+FpVI+KcfNUY2alQjFghjRWY4J2CtAwimpgG9G6ktCTe4g==
X-Received: by 2002:a17:906:ee81:b0:77e:829a:76e9 with SMTP id wt1-20020a170906ee8100b0077e829a76e9mr46052395ejb.207.1666913899362;
        Thu, 27 Oct 2022 16:38:19 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906329600b0073c8d4c9f38sm1424643ejw.177.2022.10.27.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:38:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooCS1-009fNs-3A;
        Fri, 28 Oct 2022 01:38:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 06/10] builtin/gc.c: use
 "unsorted_string_list_has_string()" where appropriate
Date:   Fri, 28 Oct 2022 01:25:53 +0200
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
 <patch-06.10-9c36f17481b-20221026T151328Z-avarab@gmail.com>
 <xmqqh6zpkqgo.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqh6zpkqgo.fsf@gitster.g>
Message-ID: <221028.865yg4alcm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Refactor a "do I have an element like this?" pattern added in [1] and
>> [2] to use unsorted_string_list_has_string() instead of a
>> for_each_string_list_item() loop.
>
> In the longer term, I am not sure if we want to keep such code that
> uses string-list as a "database to be looked up with the string as
> the key".  I am not sure it is worth our review bandwidth to change
> a for-each-string-list that terminates early to its shorthand
> unsorted_string_list_has_string().  Surely each such conversation
> would allow us to lose 4 to 5 lines, but longer term we should be
> discuraging the use of unsorted_string_list_has_string() in the
> first place.

I haven't benchmarked, but I'd think on modern computers O(n) for such
short lists would be more performance due to cache locality, i.e. not
worth pre-sorting it, or making it a hash table.

But for such small amounts of data I'd think it would be fine either
way.

As to the change, I'm fine with leaving this out.

The reason it's in here is because this series came out as a reply to
Stolee's earlier RFC.

I think it's a fair summary to say that the reason we started talking
about this at all is because the topic at hand was how to make this
exact code in builtin/gc.c safer and more idiomatic. I.e. see:

	https://lore.kernel.org/git/e06cb4df081bc2222731f9185a22ed7ad67e3814.16642=
87711.git.gitgitgadget@gmail.com/

And my earlier summary of that, the very beginning showing the API forms
under discussion:

	https://lore.kernel.org/git/220928.868rm3w9d4.gmgdl@evledraar.gmail.com/

So Re this & your "it might be good, but why does it have to be done
here now?" reply to the CL: Yeah I can eject some of this, but having a
series (and a predecessor RFC) whose main reason for existing is making
this API safer & nicer seems incomplete unless we're also converting
callers to use those supposedly nicer patterns.

In general I think this sort of change is exactly the sort of thing
you'd want in such a series. A test of a good API isn't just that it
looks or acts nicely in isolation, but that it's easily combined with
other things you might expect to use with it.

Hence this 04-06/10. I.e. the original contention in the RFC was that we
had to return a dummy string list to make these sort of patterns
safer/nicer/idiomatic. I think these patches serve as a convincing
counter-argument to that.
