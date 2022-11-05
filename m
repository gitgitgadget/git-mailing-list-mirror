Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45CFC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 12:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKEMnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEMnD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 08:43:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB218369
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 05:43:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l11so11168886edb.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jPnaoQKANS8x0+G4XzPWjdq12fvqIVYooPqfr6+mQgc=;
        b=ZUevbR/OBJ+9pnRVRN+A7egYc4vdFmFZnBqQOG3xYqMy/+Ovb/A0yWlLptgH1WoaDh
         +sy3MVAbC0fmxpvYYfAZ9cC/4gOUZFDDfOYBWBtGtLHEqpnK28xipZRwu/OLVt2bzSGh
         TnFdkynhwo3GkDAQPqzgZl8W89dNo/daM4CV137XqKHwGAQH6+LCpTT6avkOaoSBuRH1
         SH5+BIzC10A3jZUTCaXA581DzqRH3cmg4lTioTUxQ9mSo1jwNmGn+M1CaZidJzieMAub
         7ip41gaS2NKIkYTvav/pfKCaZ3GUkhQCyC0eIwuEI8zOrq0IcwTkzy2V4nvh6t2bQGsV
         Re1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPnaoQKANS8x0+G4XzPWjdq12fvqIVYooPqfr6+mQgc=;
        b=PZG+SWGHUvwInlkORmBjT0f+ytCl+U+3NOf/kTjnI3Zwh+CdXYkyIvo8mtC9KxmW5g
         4GPzNlFfGUbRogEnAJZgNDCQOFBcs5oYfbTFDmcWSL/UV+daoEzUa6pkqKPd/PxWzTLl
         azPLF6qThxJp92AnV/gU9/FNdEUAdMpsEYtwjF5jxJjcJuciK9mxQmhyrJH7+zQp/x6W
         z+h2u7dcwqhsE5y0E6rN3jSWjw1KH4wekb/3Xu4iu1/XtRO7jbeM8BkMs0xt5ixTLcGj
         seb8LNzD2ufnEZiY1Ghe7/MqUh+ws9tO3il1ygpkvTdsEIPIzU5TfRKQX0UWatN1PXzr
         p39w==
X-Gm-Message-State: ACrzQf3rnnvB0KgCUshwAT3OO96eMUPAiVlHGX9iwvBtiulpUomlNCoH
        08JPUQWsDTom7tNgL/y88Ag=
X-Google-Smtp-Source: AMsMyM7V/ZMrUbrr3yAOkJgnM9x+VKUbXDYKGtJ7Vc/N4SklQonj/AqXfaD7UqpobOQ7Cd/m56qoLg==
X-Received: by 2002:aa7:ccd2:0:b0:462:73bd:3acb with SMTP id y18-20020aa7ccd2000000b0046273bd3acbmr40544470edt.378.1667652180944;
        Sat, 05 Nov 2022 05:43:00 -0700 (PDT)
Received: from gmgdl (31-151-3-230.dynamic.upc.nl. [31.151.3.230])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090631c500b007a03313a78esm883394ejf.20.2022.11.05.05.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 05:43:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1orIVn-000MTt-37;
        Sat, 05 Nov 2022 13:42:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 13/17] rebase: don't leak on "--abort"
Date:   Sat, 05 Nov 2022 13:01:42 +0100
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <patch-13.17-fda9914b558-20221103T164632Z-avarab@gmail.com>
 <f9df4dfc-6024-deb0-5277-bab96c81a875@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <f9df4dfc-6024-deb0-5277-bab96c81a875@dunelm.org.uk>
Message-ID: <221105.86eduhy3l8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Phillip Wood wrote:

> On 03/11/2022 17:06, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix a leak in the recent 6159e7add49 (rebase --abort: improve reflog
>> message, 2022-10-12). Before that commit we'd strbuf_release() the
>> reflog message we were formatting, but when that code was refactored
>> to use "ropts.head_msg" the strbuf_release() was omitted.
>> Ideally the three users of "ropts" in cmd_rebase() should use
>> different "ropts" variables, in practice they're completely separate,
>> as this and the other user in the "switch" statement will "goto
>> cleanup", which won't touch "ropts".
>> The third caller after the "switch" is then unreachable if we take
>> these two branches, so all of them are getting a "{ 0 }" init'd
>> "ropts".
>> So it's OK that we're leaving a stale pointer in "ropts.head_msg",
>> cleaning it up was our responsibility, and it won't be used again.
>> [...]
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1320,6 +1320,7 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>>   		if (reset_head(the_repository, &ropts) < 0)
>>   			die(_("could not move back to %s"),
>>   			    oid_to_hex(&options.orig_head->object.oid));
>> +		strbuf_release(&head_msg);
>>   		remove_branch_state(the_repository, 0);
>>   		ret =3D finish_rebase(&options);
>>   		goto cleanup;
>
> This looks fine. One could argue that the leak is not a "real" leak as
> we're about to exit but the omission of strbuf_release() was=20
> unintentional and fix is nice and simple.

What I've been targeting in this and past leak fix topics is roughly
what valgrind calls[1] "definitely lost" and "indirectly lost", and
which -fsanitize=3Dleak calls "that thing I die on whan I run into it" :)

So, you and I know we're "about to exit" as we're in cmd_rebase() and
about to return to common-main.c etc, but it's harder to convince a
compiler of that.

Maybe I'm just touchy, sorry. It just feels like every time I submit a
leak fix topic there's some rehash of the "why do this at all?" or "why
this one?"  discussion.

To summarize (maybe too much for just this reply, but I hope to link
back to this in the future):

 * Historically we've said "that's just a built-in, let the OS take care
   of it!"

 * I agree with that in principle. It's pretty pointless to free()
   things in cmd_*() in the abstract. We're "about to exit", even if
   valgrind etc. call it "definitely lost"[1].

 * But, it would be nice to have git's APIs not leak, so we could call
   them in loops, replace some of our own sub-process invocations
   etc[2].

 * If we had 100% test coverage for those libraries we could just test
   that, and get those leak-free, and ignore the built-ins.

 * We don't have that, and probably never will. E.g. "git log" and
   friends are *the* things that stress revision.[ch]. So to assert that
   the API is leak-free we really need to assert that its users
   are. Ditto for pretty much any other API we carry.

 * Still, we could just say "if something's alloc'd in cmd_*() don't
   care about it". Both LSAN and valgrind support "suppressions" to
   ignore certain functions, patterns etc.

 * But that doesn't really work either, as e.g. "struct rev_info" would
   seem to come from such a cmd_*() as far as ownership goes...

 * ..."but you could have an even more clever suppressions mechanism,
   and only ignore those things that are malloc'd by cmd_*(). But not
   e.g. a malloc in revision.c in a struct member in a struct that's on
   the stack in a cmd_*()", one might say.

   Yeah, you could do that, e.g. in this case we'll call strbuf_addf()
   which makes a beeline to malloc(). Sufficiently clever
   post-processing of leak stacktraces could probably make the
   distinction.

   But then you run into the problem of e.g. how the the log family and
   others use "mailmap". I.e. in that case (and many others) the cmd_*()
   will malloc(), but "hand it off" to the API, whose job we know it is
   to free() it.

   But we only know because of knowledge about the API, an automated
   system would care, still, it's not unworkable. We could go through
   those, list the exceptions etc. etc.

That's a lot of context, but I think brings us up-to-date on this
one-line change.

So, could we do things differently here? Definitely. And if the codebase
was in a state where e.g. builtin/*.c had ~1500 UNLEAK() already I'd
probably try to extend that, rather than fighting that uphill battle.

But that's not the case, we have around ~30 of them, fewer after this
topic. By far the majority of builtin/* is caring about directly
recahable leaks already.

E.g. just above this context in another "case" arm we're doing the exact
"variable on stack, use it, then release()", just with a "struct
string_list".

So I think this is the right direction to go in, both in this patch & in
general.

1. https://valgrind.org/docs/manual/mc-manual.html#mc-manual.leaks
2. Even the assumption that cmd_*() is a one-off is shaky, e.g. for
   cases where we shell out to "git commit" we're close now to being
   able to just call cmd_commit(), but let's leave that aside for now).

   So, we're pretty close to cmd_*() being a funny API that happens to
   take strvec arguments, which is going to be the shortest path to
   eliminating sub-process invocation in many cases. I.e. as opposed to
   refactoring the cmd_*() into a "real" library, that takes a struct
   with options, doesn't call parse_options() etc.
