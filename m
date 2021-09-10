Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90624C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7354A600AA
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhIJUG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJUG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:06:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E124C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:05:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so2735552edn.12
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MsFFLAEbhk0Ve9L5a38MAr00XXot1HNCHVnQW99f0vI=;
        b=bDFMTPMz+IwXyUf9yLvyTXH0Q5Mnb8Nw3Em+B4u0l4e37ybU22p2fCST4zcto6tefH
         0e7R1S6Z8H4ejBxagbsNbn2uVUwUuJDH/J6dBqwU6SIxkpQy+2Fw0uzvxUZ1jZ8HIpg1
         6pAjztXjZi5JLtNNEZ1Gpc6Tlz9qzTA7Rn74jWzfXnBIMamD8fBd2YfhA0gXAUI8eJdn
         +9BeU1iU4vV9xIyMGo+/mcKLdzaRvEMy+UQQQPNEoILtmKv20yJmhNEyf0xzsHUy90lK
         KlCxE9hNr3N6Jh/5AxavUZQMOG+VxVVexXA5oGYjgmjdR7cuMxCAh27t3rd2yg2xp0/y
         pb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MsFFLAEbhk0Ve9L5a38MAr00XXot1HNCHVnQW99f0vI=;
        b=rE8bI3VCaxUOBHdRXcqmImx718TvNDK/LYs29BGPx7F9F5ZMTf60G8ei3lrxEBCaYm
         ct9EhfDVVrZyCj/Y9miY/3QtbZ7pC0W9TZt/4smTtB1D0KUvx0eQHz0onOzkMykHwOFB
         Rf3uByiRbwrsOQXad9QrooISoFtah2n7dCkWyT1HbvDH1hwHqE79PZX6F7p8O0ULTZoJ
         lbALNKYWUmlIMRSqO57pYCMNjCpY/SePnyasnLSHG0R93VtfwPA5F4AoBM/Jl4ed5lVQ
         PvN12zCElgOYDl65K0pm6bRWNMPIrbqd4Jd1+dCx1KXWKTrl4HlPaFEs9/LzGZ2A9r/w
         2KbQ==
X-Gm-Message-State: AOAM531NGb/G6k+4ZusBJo20q9QyAbNobeP79SW0zFgKNZXJZi7fhEzt
        wf8PEr5iEBAEpVUWHluZCHSYYoUETLegWw==
X-Google-Smtp-Source: ABdhPJxsFZw4L1x+akvm2IzsZZjtvuBPOhOIwTXIAWutBRnW3C2olD+EoLI9yunVzeNYDGZtJJQQAA==
X-Received: by 2002:aa7:cb07:: with SMTP id s7mr10869841edt.207.1631304312967;
        Fri, 10 Sep 2021 13:05:12 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e11sm3190838edq.30.2021.09.10.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:05:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Oddidies in the .mailmap parser & future syntax extensions
Date:   Fri, 10 Sep 2021 21:50:28 +0200
References: <20210910130236.40101-1-me@fangyi.io>
 <YTt4RymWg+TOEmUf@tilde.club> <877dfocps2.fsf@evledraar.gmail.com>
 <xmqq1r5wti5a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq1r5wti5a.fsf@gitster.g>
Message-ID: <87h7esb3ig.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> [Changed subject]
>
> [jc: culled CC addresses]
>
>> I'd expect:
>>
>>     Foo <foo@example.com> Bar
>>
>> To be an alias/shorthand for:
>>
>>     Foo <foo@example.com> Bar <foo@example.com>
>
> OK.
>
>> More annoying is that this:
>>
>>     New <foo@example.com> <bar@example.com>
>>     <foo@example.com> <zar@example.com>
>>
>> Doesn't mean the same as:
>> ...
>> I.e. I'd expect the name to map to the empty string, *unless* we saw an
>> earlier address, i.e. just as we do for the first bar -> foo line (we
>> map it to a name of "New", we don't map it to an empty name).
>
> You expect the first one to map (anyname, <bar@example.com>) to
> ("New", <foo@example.com>) and you describe the second one does not
> map the human-readable part to "New", but it is unclear what the
> code does, or why you expect it to map to "" (or what your
> expectation is, for that matter, exactly---do you want an empty
> string, or do you want "New", or something else???).
>
> FWIW, if we were designing it from scratch, I'd expect the second
> one to map (anyname, <zar@example.com>) to ($1, <foo@example.com>),
> keeping the human-readable part as-is and only map the e-mail part.

Yes, that's what it does now. I.e. we'll create two mappings from those
lines, namely (in line-by-line regex-like pseudosyntax):

    [[(.*), bar@example.com>] =3D> [New, foo@example.com]]
    [[(.*), zar@example.com>] =3D> [$1, foo@example.com]]

I.e. for the second one we'll retain whatever name we found there.

> Or do you expect that when these two entries appear together, the
> first entry with "New" is carried over to the second entry?

Yes, I'd expect it to be stateful and implicitly do:

    [[(.*), bar@example.com>] =3D> [New, foo@example.com]]
    [[(.*), zar@example.com>] =3D> [find_last_name_for_address_in_mailmap(f=
ind_last_explicit_) || $1, foo@example.com]]

I.e. we'd map the entries for you in git.git like:
=20=20=20=20
    diff --git a/.mailmap b/.mailmap
    index 9c6a446bdfb..2a884981e9d 100644
    --- a/.mailmap
    +++ b/.mailmap
    @@ -127,8 +127,8 @@ Julian Phillips <julian@quantumfyre.co.uk> <jp3@qua=
ntumfyre.co.uk>
     Junio C Hamano <gitster@pobox.com> <gitster@pobox.com>
    -Junio C Hamano <gitster@pobox.com> <junio@hera.kernel.org>
    -Junio C Hamano <gitster@pobox.com> <junio@kernel.org>
    -Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
    -Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
    -Junio C Hamano <gitster@pobox.com> <junkio@cox.net>
    -Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
    +<gitster@pobox.com> <junio@hera.kernel.org>
    +<gitster@pobox.com> <junio@kernel.org>
    +<gitster@pobox.com> <junio@pobox.com>
    +<gitster@pobox.com> <junio@twinsun.com>
    +<gitster@pobox.com> <junkio@cox.net>
    +<gitster@pobox.com> <junkio@twinsun.com>

Which are currently mostly redundant, except for one old commit under
junio@twinsun.com where the " C " wasn't present in your name field.

One might say that's a feature, and you'd like to be explicit about when
to map addresses and when to map names, i.e. if we were trying to
minimize the size of the .mailmap then this would be the most minimal
thing we can get away with currently:
=20=20=20=20
    diff --git a/.mailmap b/.mailmap
    index 9c6a446bdfb..4668f9b32f2 100644
    --- a/.mailmap
    +++ b/.mailmap
    @@ -127,8 +127,8 @@ Julian Phillips <julian@quantumfyre.co.uk> <jp3@qua=
ntumfyre.co.uk>
     Junio C Hamano <gitster@pobox.com> <gitster@pobox.com>
    -Junio C Hamano <gitster@pobox.com> <junio@hera.kernel.org>
    -Junio C Hamano <gitster@pobox.com> <junio@kernel.org>
    -Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
    +<gitster@pobox.com> <junio@hera.kernel.org>
    +<gitster@pobox.com> <junio@kernel.org>
    +<gitster@pobox.com> <junio@pobox.com>
     Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
    -Junio C Hamano <gitster@pobox.com> <junkio@cox.net>
    -Junio C Hamano <gitster@pobox.com> <junkio@twinsun.com>
    +<gitster@pobox.com> <junkio@cox.net>
    +<gitster@pobox.com> <junkio@twinsun.com>

But I just can't imagine cases where the proposed shorthand isn't useful
for everyone.

Who wants to use mailmap, *and* map one e-mail address to another, *and*
has an entry explicitly mapping the name, but *would* mind having git be
auto-smart and follow the chain of that explicit name mapping if there's
an entry after that with an an e-mail -> that-earlier-email mapping?

I think the answer is "nobody" and it would be unambiguously helpful,
but maybe I'm wrong.
=20=20=20=20
>> Doing that would be strictly backwards compatible, i.e. now we'll
>> entirely ignore the 3rd E-Mail address. It does mean we also
>> accidentally support things like:
>>
>>     New <foo@example.com> <bar@example.com> # A comment, because we igno=
re everything after the 2nd address
>>
>> But don't tell anyone I told you that :) But that is something that
>> might technically have inadvertently closed the door to future syntax
>> extensions, but we could probably do them anyway, or at worst have some
>> heuristic.
>
> I vaguely recall that it was not an accident but a deliberate
> feature to allow comments, but don't tell anyone I told you that.

Which works, right until someone has an old name entry that looks like a
comment :)
