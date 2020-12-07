Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A47C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 08:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66B1225A9
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 08:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgLGIyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 03:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLGIyF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 03:54:05 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40DC0613D2
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 00:53:25 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q16so12811779edv.10
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 00:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rOqGagRjFPuRZbSuTOdh5ZSNoEZhXOBRC9QFp+66K4U=;
        b=RWAb4jB/0dtMoSJBae8JYK1anaCIXVAu1ut/R+AESvFySVHo7qrR+dmToRZORQ5kcA
         Qnh3/pIIozUT8bNvGk9Ah6zJUmKvOACdlnZCgysdlBvKlFW/iMjoGfICpmqMoRpSeX3Q
         muN+N4G70ezxipni+/XOhrdVvv9QwbUVI2CCcKy7rZp+VXdHZ9oJqb6UKbor9F0S7f8i
         NKi2fAYGjMwvTJhPPbOqgOaB71K3T+CGSJB2rgiRSr5pRSkf0GwhoMXg4h8BsOOCXTwb
         zn0uevsurfzeNEHVlakGPFqfGMbu5CdMgbT92vQaQBQ8wuk8V4ZNO8LOZNlsSQU/gCx7
         tqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rOqGagRjFPuRZbSuTOdh5ZSNoEZhXOBRC9QFp+66K4U=;
        b=B/CbYMtMleN50tggc+Zy/tzlEjdZxL1STFkHABg4YfowppAuCPm9HwbZsbs5f2+N5/
         CGOkr4PQ13OVmo8h+/ziG79zhm4qpzZHrXJ/p29V5suYZe/pwvmcF3V/Fe0fwQ6z7KWk
         LzRXszPLqwNogtRCSaRzm2eYDM5It6ndhjRTYJZoakgXfzNhp4I/zMpW0Hp1KhroC4MY
         HrQBXTWPet2R33SUYDd3btKQL/hXwIjoBhZ3rZHby3FOs0HLm/4VxtxMiRwtYk1i/RvE
         oKHKFqkG1ewE4gIqClLvIBoVQC8F3zlcXyRUSaFfYCn0X8U7NpMpq1YGmDIKsnbiSV9Q
         B+VA==
X-Gm-Message-State: AOAM530Jp0xXCLkEipkSns3igC3nfdxL3fL/Z/uwnfJmFiDZ2oHPqkgf
        MngUy6cCPjqkRHNlutBfKsE=
X-Google-Smtp-Source: ABdhPJwvZjDGaejBWssBchBuje6+0WughY3eWSF18viUEHR8KGKI3D8YaKHPcxhKL3w126c/6RLxZA==
X-Received: by 2002:a50:fe0e:: with SMTP id f14mr19358690edt.159.1607331203802;
        Mon, 07 Dec 2020 00:53:23 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id f8sm12184428eds.19.2020.12.07.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 00:53:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        christian.couder@gmail.com, peff@peff.net, jonathantanmy@google.com
Subject: Re: [PATCH 0/5] pretty format %(trailers): improve machine readability
References: <20201025212652.3003036-1-anders@0x63.nu>
 <20201205013918.18981-1-avarab@gmail.com> <87wnxwp15o.fsf@0x63.nu>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <87wnxwp15o.fsf@0x63.nu>
Date:   Mon, 07 Dec 2020 09:53:22 +0100
Message-ID: <87h7oyxail.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 05 2020, Anders Waldenborg wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason writes:
>
>> I started writing this on top of "master", but then saw the
>> outstanding series of other miscellaneous fixes to this
>> facility[1]. This is on top of that topic & rebased on master.
>>
>> Anders, any plans to re-roll yours? Otherwise the conflicts I'd have
>> on mine are easy to fix, so I can also submit it as a stand-alone.
>
> Yes, I have plans to do that. But have yet to carve out the required
> time from my copious spare time to actually do it.
>
> So please don't hold your breath waiting for me to do that.

Thanks. I sent a v2 of mine yesterday as
https://lore.kernel.org/git/20201206002449.31452-1-avarab@gmail.com/

As noted there the merge conflict with yours is trivial, so hopefully it
won't cause you much hassle if you re-roll while it's outstanding.

>> This series comes out of a discussion at work today (well, yesterday
>> at this point) where someone wanted to parse %(trailers) output. As
>> noted in 3/5 doing this is rather tedious now if you're trying to
>> unambiguously grap trailers as a stream of key-value pairs.
>>
>> So this series adds a "key_value_separator" and "keyonly" parameters,
>> and fixes a few bugs I saw along the way.
>
> Interesting. When adding "valueonly" I never consider it being used
> without "key". The trick you are doing with separate keyonly and
> valueonly is quite clever.
>
> I've only been doing machine parsing for explicit keys, things like:
> "%cn%x00%x00%an%x00%x00%(trailers:key=3DReviewed-By,valueonly,unfold,sepa=
rator=3D%x00)%x00%x00%(trailers:key=3DBackport-Reviewed-By,valueonly,unfold=
,separator=3D%x00)"
> (double-NUL to separate field, single-NUL to separate values within field=
).
>
> But I can't help wonder that if the goal just is to have a nice machine
> parsable format maybe it would be easier (both for user and
> implementation) to have a separate placeholder for "machine readable
> trailers" which by default emits in a format suitable for machine
> parsing. Something like a new "%(ztrailers)" (but with a better name)
> which simply emits a sequence of "<KEY> NUL <VAL> NUL" for each trailer

I think it's a bit tricky to make something general in the middle of all
the custom format printf-likes in the pretty format. E.g. some users
might want to use \0 as a delimiter for key-values, others \0\0
etc. because they used \0, or the other way around.

Maybe if there's a reason to extend the optimization it could be smarter
about detecting that you only wanted some fixed-string separator and
nothing else custom?

B.t.w. I tried just deleting the optimization for testing and it slowed
down by around 8% on linux.git according to an extended
p4205-log-pretty-formats.sh.

Looking at the code I wonder if there aren't other lower hanging
optimizations, e.g. it seems we call find_separator() on multiple passes
instead of saving it away, e.g. in the format_trailers_from_commit()
entry point if there's any custom options such as "unfold".

I also wonder if memory allocation is a bottleneck in the "git log"
path, but didn't have time to refactor & test it. For each commit the
walking machinery eventually calls the trailer.c code, which allocates &
free()'s internal structures that could be re-used for parsing the next
commit.
