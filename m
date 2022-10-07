Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F0C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 10:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJGKtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJGKtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 06:49:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2C120EC5
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 03:49:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nb11so10468366ejc.5
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PL6qsAiZHmDJKZ/PFEDRXlyBdp8x+al/YETu0f9HsnI=;
        b=ZZCCBGEs4jiX9Dq7DmY7W8YqJ4arCpMdgPieg/eevikKRO/YAg3nMh0rSpFP4/nMKa
         p3jQfjDSI4AcKFUZoYMx684+Mj+PxfPg2BlHikhShaBtNa7HIJyiQw3KAAwd4EHyVlUy
         EZtY3vdVS+o7pZrgBHFxCQfVUwH8ozsWV/rM4cKx3Vytykk8zyN+2gDt+ei2cAkwtATC
         xfoM4OiwsNn9tFA8YpIYHtdy9ExEssHr1T9j1K9nrXrrB2iXr+p6aU2nkhAur8y+LxdH
         LphjqovsJYyWiR/Y7dmzwFMX1rhh+Vp1s3+gutNg+1I8Kexo6bJyOr2A14Tz8/KAlSiJ
         RZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PL6qsAiZHmDJKZ/PFEDRXlyBdp8x+al/YETu0f9HsnI=;
        b=SU859kDpn9eEYdi0DQa/jIzh8aSAPiE9xnlJqiv5y31+zUcmuFeoFxy5MCyCzvU4bI
         fhmE19QVNPIjwjHMKRjuDd9v+9n+adCKJehFH3X+3XDDMRSZ8EmFxm9bJ5mXWx7T/uae
         FFklxaVYoofUhYOf6xHnDlxv5Q6DEqZfkk1+BYSSKZQDNbpS55cQCbyh/tVKCrK9qM83
         Y2Lroq2pHGQX6fzMbRm6tk9a7nkawBXs5vy2FAlqVnkXT2XULpqe7KASYmqkUvQ8uxWn
         dRbuSfXNVebQBaAGO8yv42kCz2lZPjRXmC0tjPqollRGKYMU3C+1YseSM+Ox/9AsCcl9
         50iA==
X-Gm-Message-State: ACrzQf3Fcm3nJy9X8siDaZUgHl5dbAOmaldmZeYGJ2LCZYSdrtSVMXAb
        qv83oAKVzwz5brkgs8unitPBPe2q3Trj6g==
X-Google-Smtp-Source: AMsMyM5HJvotvGu0SQ+PA+YoZ/0LRAtwzG0gHg/Bgtk3CsQvLXVTIbRu+f7hNPRUDsKCgik97IIX2A==
X-Received: by 2002:a17:907:b0b:b0:78d:8877:9f9e with SMTP id h11-20020a1709070b0b00b0078d88779f9emr462282ejl.693.1665139738939;
        Fri, 07 Oct 2022 03:48:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b00781e7d364ebsm1018767ejf.144.2022.10.07.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 03:48:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogkuW-003Nhx-1r;
        Fri, 07 Oct 2022 12:48:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [RFC PATCH] trace2 API: don't save a copy of constant
 "thread_name"
Date:   Fri, 07 Oct 2022 12:03:45 +0200
References: <xmqqr0zkipva.fsf@gitster.g>
 <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
 <xmqqo7uoh1q0.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqo7uoh1q0.fsf@gitster.g>
Message-ID: <221007.865ygvrjs7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> A cleaned up version of the test code I had on top of "master", RFC
>> because I may still be missing some context here. E.g. maybe there's a
>> plan to dynamically construct these thread names?
>
> That's nice to learn, indeed.
>
>> +void jw_object_string_thread(struct json_writer *jw, const char *thread=
_name,
>> +			     int thread_id)
>> +{
>> +	object_common(jw, "thread");
>> +	strbuf_addch(&jw->json, '"');
>> +	jw_strbuf_add_thread_name(&jw->json, thread_name, thread_id);
>> +	strbuf_addch(&jw->json, '"');
>> +}
>
> ...
>
>> @@ -107,9 +109,11 @@ static void perf_fmt_prepare(const char *event_name,
>>  	}
>>=20=20
>>  	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
>> -	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
>> -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
>> -		    event_name);
>> +	oldlen =3D buf->len;
>> +	jw_strbuf_add_thread_name(buf, ctx->thread_name, ctx->thread_id);
>> +	padlen =3D TR2_MAX_THREAD_NAME - (buf->len - oldlen);;
>> +	strbuf_addf(buf, "%-*s | %-*s | ", padlen, "",
>> +		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
>
> Having to do strbuf_addf() many times may negatively affect perf_*
> stuff, if this code is invoked in the hot path.  I however tend to
> treat anything that involves an I/O not performance critical, and
> this certainly falls into that category.

Yes, and that function already called strbuf_addf() 5-7 times, this adds
one more, but only if "thread_id" is > 0.

The reason I added jw_object_string_thread() was to avoid the malloc() &
free() of a temporary "struct strbuf", it would have been more
straightforward to call jw_object_string() like that.

I don't think anyone cares about the raw performance of the "perf"
output, but the "JSON" one needs to be fast(er).

But even that output will malloc()/free() for each line it emits, and
often multiple times within one line (e.g. each time we format a
double).

So if we do want to optimize this in terms of memory use the lowest
hanging fruit seems to be to just have a per-thread "scratch" buffer
we'd write to, we could also observe that we're writing to a file and
just directly write to it in most cases (although we'd need to be
careful to write partial-and-still-invalid JSON lines in that case...).
