Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DCEC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhK2Wvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhK2WuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:50:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368ECC0E5F4D
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 13:02:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r25so12186562edq.7
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 13:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QmaFCsS8lfQyol3ueeVMZoQG3Oii6ZXDC4R7ZvCPfpY=;
        b=BypE0D6/klI6UfNhkbfA95UCxiMvciy0FIPnK/hUnPVApXhJ+CulUjHefWuKuwOlQu
         cFXA665BtPa3PYhWj5TnaTkUKVyX3UAEb6WXkc6z9ADQjjlwGVTl02ykCbLRAqJW4VSc
         5X2BcLwFK3M4QXo3srrdJf+kbEdL2JslO+1+FWHgZqam0ISDRz6budcE28uFkYAVDtcY
         MMcrJyu93n3gSx5NFU85qNUjfhBv55xPp1E2jA4EFcMDDsphCPKLgJfSyIvUyBMzvdpX
         4DwHAzCN9VYG4Fv5z/7sAHP33tYCsFr3yAVtmaqdYnqqK0JwlqpZWmuyt7/QuaA22EOY
         pdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QmaFCsS8lfQyol3ueeVMZoQG3Oii6ZXDC4R7ZvCPfpY=;
        b=jc7irffclBPtS82/OHLVSKJ21tr3YQa0Gx9ijzIQ+IJrkAiLdmlQdxnm4UNme39YeJ
         WKNVfyoRt0OXKlBBn+fRnhKP8VAL7hYHg0DK/bvZaxH+OLa7BcsYTQa1SvdIgMa+JBUy
         EP59Gec6Q9JiD/qbTRMxI3hmpSRDgmHakV7W3Wzpx8h4Cbn7uHKSXHEd/UzwJlcmC6Vf
         Q2wMS0bgYxgTNX4go2ts99SjNxG4WG0laoJZ2GCOCdUwPLk6Oep2jmP+B4wVQi2FRm4m
         plsDR8Gd5tsiV2a/GxCz5mtxgSu070EgFXTsny76MutitbSUHD7wT7eo7aEhQDuWMmVU
         5eqg==
X-Gm-Message-State: AOAM530hW5l6csIoCECEQUw1WLaArFxIrK/f892ybC5Mw4Fb0MiXFu9i
        o1YsSJwYVv3fV0D3gWYvk08=
X-Google-Smtp-Source: ABdhPJx1b7Zu/pq6RxXkhTWGIA3GgWCPRnjngCvUrKh6WCxDDwOyDOi/DUWca0Qrz1RkdhimDezSFQ==
X-Received: by 2002:a05:6402:2210:: with SMTP id cq16mr78206597edb.32.1638219768765;
        Mon, 29 Nov 2021 13:02:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id og14sm7920510ejc.107.2021.11.29.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:02:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrnnT-000rvk-5S;
        Mon, 29 Nov 2021 22:02:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] refs/debug: trim trailing LF from reflog message
Date:   Mon, 29 Nov 2021 21:59:52 +0100
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
 <0288e743eb2e96e2effd6b0b90c6f885009bf337.1637855872.git.gitgitgadget@gmail.com>
 <xmqqilwf72nf.fsf@gitster.g>
 <CAFQ2z_N20ESyzkPLdGbS9q8HEHGB7_gmaX8FUBR=jGqXLGcL1Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAFQ2z_N20ESyzkPLdGbS9q8HEHGB7_gmaX8FUBR=jGqXLGcL1Q@mail.gmail.com>
Message-ID: <211129.86v90aekug.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Han-Wen Nienhuys wrote:

> On Fri, Nov 26, 2021 at 9:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The API promises to have only LF, not CRLF, at the end, so
>> strbuf_trim_trailing_newline() is a bit overkill (and if payload
>> happened to end with CR, we would lose it).
>
> it would be best if there was a way to escape characters (ie. "\n" =>
> "\\n"). Do we have a function for that?
>
>> > +     trace_printf_key(&trace_refs,
>> > +                      "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
>> > +                      dbg->refname, ret, o, n, committer,
>> > +                      (long int)timestamp, trimmed.buf);
>> > +     strbuf_release(&trimmed);
>> >       return ret;
>> >  }
>>
>> Can we use counted bytes in trace_printf()?  If we can, it would be
>> simpler to just scan "msg" for LF and then show only the span
>> between the beginning of the string and the found LF using "%.*s",
>> perhaps like this?
>
> I beg to differ - despite this being fewer lines of code, I think
> pointer arithmetic is best avoided if possible.

We usually do this with pointer arithmetic, but the %.*s format doesn't
require that, just code like:

    const char *str = "foobar";
    size_t len = strlen(str);
    len -= 1; /* give me less! */
    printf("%.*s", (int)len, str);

So you can also feed it (len - 1) or whatever if you know it to end with
a character you don't want.

It's (more simply done as) pointer arithmetic if you're finding that end
marker with strstr() or whatever, but you can also bend over backwards
and get a "len" instead through other means, and in either case I think
it beats reallocating the whole thing (more for readability than any
optimization reasons).
