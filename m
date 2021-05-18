Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D5C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE3361285
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351680AbhERS4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 14:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbhERS4r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 14:56:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D431C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:55:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id df21so12486979edb.3
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GwsQahaQ36+BPGDTr+B2UtiRQpFpYBt+73MQuh7oCQM=;
        b=VufDqTZwfFdyReDEvKI9hcf267xMpQT8hNp9qkxBIYTxVdW7UJGB2ql4fFEUgiNPE+
         H3/m/D6ER7fLSAUw4lpi+xiCDfrru2lEBlYgJ3EwMaC7g+f6ynmXxIuodpmIDW/Iyzqn
         J0PhDslDfolSU89cEgAgrmDu+Ywls+m+jC8+z7295xoNsCQi/RRvHqLAaxLZW+S86/kl
         fy+SPLkcD1jIf0BhdfnwvPaXIz7gn3TTZFq+5OPPfg8kmmcdD3pxIIn4lM1oIXEgN2Ev
         Ny6FlTbeRsn8QuahMV4kw5A7U9qhchUjtYT/JUT4tqI32Zcb9HsiNY8QLDJJwwQpOPY5
         sbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GwsQahaQ36+BPGDTr+B2UtiRQpFpYBt+73MQuh7oCQM=;
        b=uoPoWh8dW9R92rTpkH9gotYQd64qqvEDgirKdXCBlmT8JJZrYmFgmHKxZKQqujzIZr
         8YemiTTtWaqljb3OPMlfoYvYUdcGn3wrg1DNGQw1uVfJ0pN8c7+kct8/0T8wNykZ8+Hf
         JxbxzzetWNBd4G/1uWfG8VqnZsKZCaYPIwoRq09ZOR23LGJlMx/AELcRzrpPo0GnZZVo
         DarEECnLTWKr0kxEmPufpeX63jy6IPR4hLWnhWk/JqsYSMXa15JeC3vjUhil6KckO/+X
         dtslTIlOgT2HQu6Ef5sCJHfjPGxYUwJaEpbtbpkUcPvYx0QgkC2Yn/k4eFxCCgvNUNqe
         NCsA==
X-Gm-Message-State: AOAM532HZoAgmfDn8v3MQS+TT1PPWMdrTBEsLMCR6UKXyPAG26XrPBqA
        62V+zUwFQoWYmK3M2r/4RM4=
X-Google-Smtp-Source: ABdhPJxbvv64dO0WGxVwfiIYVRkbMxLLqUWnOixSSNIdAkehukXwZ8mfLgEHKwwRO+BnyZw/kwctUA==
X-Received: by 2002:aa7:cd6b:: with SMTP id ca11mr8797088edb.115.1621364126934;
        Tue, 18 May 2021 11:55:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i19sm2174641eds.65.2021.05.18.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:55:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        karthik nayak <karthik.188@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Options like hash-object --literally and cat-file
 --allow-unknown-type
Date:   Tue, 18 May 2021 20:42:26 +0200
References: <87r1i4qf4h.fsf@evledraar.gmail.com> <xmqqtun0139q.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqtun0139q.fsf@gitster.g>
Message-ID: <87o8d7rhwi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 19 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> So you might expect it to accept an --allow-unknown-type, but it
>> doesn't. I could add support for that, but I think it would be stupid.
>>
>> Why should you need to restart a "cat-file --batch" just because you
>> encounter a bad object? Just .. print it, we can do that safely. I
>> really don't see the point of having --allow-unknown-type at all. Ditto
>> for the --batch-check mode.
>>
>> I mean, having read all the code I think I know why it's there. I think
>> It's because there was no way to ferry the information up from
>> object-file.c before my yet-to-be-submitted patches, so the solution was
>> to pass down a flag saying "please don't die()".
>>
>> But is it something that anyone thinks is a good idea in the abstract? I
>> don't see why I shouldn't just document something like:
>>
>>     Older versions of "cat-file" used to require an --allow-unknown-type
>>     flag to emit information about objects of unknown types. This is no
>>     longer required or the default. If you'd like to die on anything
>>     except known types (e.g. to die instead of bothering with parsing a
>>     "bad" type that possibly has spaces in it in the --batch output)
>>     supply --no-allow-unknown-type.
>>
>> What do you think?
>
> Thanks for thinking things through.
>
> My knee-jerk reaction is
>
>  - As long as "cat-file -t $thing" exits with non-zero status for an
>    invalid thing, which was crafted using hash-object --literally,
>    reporting the typename it read from the object header to its
>    standard output would be fine without "--allow-unknown-type".
>    But scripts would be upset if it suddenly started to return with
>    zero status when asked to check what type of object the $thing
>    is.

That feels even weirder to me. Why conflate the "this is naughty object"
with "we successfully inspected it"? I don't think cat-file should be
exiting non-zero unless it actually has an error inspecting the object.

But in terms of implementation that's trivial, just look if the object
is on the whitelist of types before exiting. It's certainly less hassle
than what it's currently doing.

I was thinking something like an advise() to stderr at most when we
emitted one of these:

>  - For "cat-file --batch[-check]", I am on the fence.  A script may
>    break because it is not prepared to see anything but four
>    existing types (so it might even say "do X if it is a blob, do Y
>    if it is a tree, do Z if it is a tag, and do W for everything
>    else" and expect/assume that W will see only commits), so failing
>    without --allow may still be a prudent thing to do.  We could
>    declare that such a script is already broken, even though it
>    would not change the fact that the user has been successfully
>    using it reliably.

The main reason I even care about this was the fsck case, and it looking
up and down the callstacks from OBJECT_INFO_ALLOW_UNKNOWN_TYPE I think
we're needlessly worrying about this in the cat-file case.

I think even in the case you mentioned a script would be better off with
a default of --allow-unknown-type. Right now if you somehow fed it an
object with such a type it would just hard die, whereas after you could
proceed to feed it other objects.

But realistically (and I may be wrong here) I don't think we need to
worry about backwards compatibility with --allow-unknown-type at
all. I'm fairly certain nobody's dealing with these objects in the wild
except git's own test suite.

No server implementation will accept them, you can't even push/pull them
locally. It's just there for completeness with "hash-object
--literally": https://lore.kernel.org/git/54EDACC9.5080204@gmail.com/

So I think it's fine just to say it was a mistake to require opt-in
options to *inspect* such naughty objects, as opposed to creating them
(where we should have the opt-in --literally option).

> With your new "we can now bubble necessary information up from the
> object-file.c layer without dying" change, it might make it easier
> to arrange so that object-file.c layer would never die and I do not
> think I have any objection against such a plan.  The implementation
> of "--[no-]allow-unknown-type" would have to be migrated to the
> caller at the higher level to decide what to do when it learns that
> the object it asked the object_info() about is of an invalid type.
> And the choice of the default would become easier to change later
> with such a change to the lower layer.

For what it's worth the new API is just passing
OBJECT_INFO_ALLOW_UNKNOWN_TYPE to oid_object_info_extended() along with
the (existing) "typep". You then see if the typep is < 0.

> But I am not sure if that warrants switching of the default.

Hopefully either this thread or a re-roll of that series will convince
you, is this something you'd like to see on list in the next few days or
is it better to hold off until after the RC period?

Another thing I didn't mention as a reason for getting rid of
--allow-unknown-type is that part of the patches I was hacking up made
various read-only commants behave sensibly in the face of these badly
typed objects, where now they'll just die.

E.g. Jeff King's recent --disk-usage for rev-list will just die on it,
since we call "what is the type of this" without
OBJECT_INFO_ALLOW_UNKNOWN_TYPE somewhere.

I think it's a much better approach to just implicitly supply a
OBJECT_INFO_ALLOW_UNKNOWN_TYPE at a high level (you just want the total
disk use, who cares if there's one bad object there), as opposed to
teaching rev-list and others about --allow-unknown-type.

