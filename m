Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3007EC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383848AbiDUMXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243488AbiDUMXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:23:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D320BC9F
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:20:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t11so9604097eju.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kj6r3h4cUETqpF/EDRN3rmqw/jJQtf8dH2qz3h5itFs=;
        b=mVDdMfHEveuAv2qp+Vx0LkItDHkMfG7AfhGGPt/wl2DeOl+wAq9vNqI5JdwB+aMhbA
         WkEAMZ4wJGK8AMawvawINsHSEHPrggYkcxvEOXwaxiyH7Cc906QUXCflalco/knemSfA
         cYXFNGhr+xccJyd4iQtTySGzbwsgBvEgHrBA2lbs8ZJmrEjecsJDpI691iqEuQ638BPs
         zwAAwa5BwLzZglmaUNh4eU220Ctd8hC/TYlreU3z6QYvV3A3QVAjrSvXFOcVLbBiJpTW
         IzaxBWeyyNHof+bASv4cRPxJohVYgsnMLVGCW+LtUeY+zXLTdZl+GafFZCgVgWCAe02Y
         sgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kj6r3h4cUETqpF/EDRN3rmqw/jJQtf8dH2qz3h5itFs=;
        b=KJTdlkPo6lsQpE5NqhvW0UsVEBzoEkjpV3r765NP9Gzja0DMEYNXSM6LxdkSLI9NjN
         YyKlkDiQBnPcFnfrIYO8ZEt9usBanIbm8xSLjzfGFz408Ewrrjer3iGwRF/FNC3vYnoO
         9MhXudwA/q8Q7cbIQNEchpinUGwmHOwdtSzUn3hutQkicucp430FXTGrijwnoDSfESxN
         PJ9kyYfYSHR2Rto6JE7s3i9P00wOrBipggPm1Ty94y24GzKlk8EvGdG2CsYJMZdd4GfN
         s5aZZxcoP8IdlTUDuAUIsZPQmOxeq3ge8yZqhKfBlq/JrCJiydHC0NFCa7mUz6Gm3eWA
         O5RQ==
X-Gm-Message-State: AOAM531rHREQaDj2DosPLYNmi5l0PmF1fJOBX7SuS0nA5hEuLuquznZl
        sW7O4fX3gkNWCRCnnMJX2kY=
X-Google-Smtp-Source: ABdhPJyI9cJoyX6O6t8XpBOac7LnH+6GH1UA2pfWdSdilwu9kimPGTl9a3+kwATvTbi/FHKh0pM+Dw==
X-Received: by 2002:a17:907:c25:b0:6e8:9e29:2322 with SMTP id ga37-20020a1709070c2500b006e89e292322mr22133781ejc.66.1650543650228;
        Thu, 21 Apr 2022 05:20:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nd31-20020a170907629f00b006dff863d41asm7767922ejc.156.2022.04.21.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:20:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhVnk-007ugS-Uf;
        Thu, 21 Apr 2022 14:20:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
Date:   Thu, 21 Apr 2022 14:03:12 +0200
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <Yl9Hn0C0TwalASC0@google.com>
        <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
        <xmqqr15rr9k6.fsf@gitster.g>
        <CAJoAoZm7p32Hn=TLQeWUqp_nMjo_TQ2whR4F=cXk4c6PV1M5bA@mail.gmail.com>
        <xmqqilr3r7ki.fsf@gitster.g>
        <CAJoAoZnw6cNBwWpa5w-rhQ4p_zw6w6Q-NHzNeRKrrqPpDCjY2A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAJoAoZnw6cNBwWpa5w-rhQ4p_zw6w6Q-NHzNeRKrrqPpDCjY2A@mail.gmail.com>
Message-ID: <220421.86sfq67hlr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 20 2022, Emily Shaffer wrote:

[I'll reply to most of this & other questions in the form of patches,
just on some of this]

> On Wed, Apr 20, 2022 at 10:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Emily Shaffer <emilyshaffer@google.com> writes:
>>
>> >> In the longer term, there are multiple possible action items.
>> >> ...
>> >>
>> >>  * We should teach hooks API to make it _optional_ to use the
>> >>    parallel subprocess API.  If we are not spawning hooks in
>> >>    parallel today, there is no reason to incur this regression by
>> >>    using the parallel subprocess API---this was a needress bug, and
>> >>    I am angry.
>> >
>> > To counter, I think that having hooks invoked via two different
>> > mechanisms depending on how many are provided or whether they are
>> > parallelized is a mess to debug and maintain. I still stand by the
>> > decision to use the parallel subprocess API, which I think was
>> > reasonable to expect to do the same thing when jobs=3D1, and I think we
>> > should continue to do so. It simplifies the hook code significantly.
>>
>> A simple code that does not behave as it should and causes end-user
>> regression is not a code worth defending.  Admitting it was a bad
>> move we made in the past is the first step to make it better.
>
> I am also sorry that this use case was broken. However, I don't see
> that it's documented in 'git help githooks' or elsewhere that we
> guarantee isatty() (or similar) of hooks matches that of the parent
> process. I think it is an accident that this worked before, and not
> something that was guaranteed by Git documentation - for example, we
> also do not have regression tests ensuring that behavior for hooks
> today, either, or else we would not be having this conversation. (If I
> simply missed the documentation promising that behavior, then I am
> sorry, and please point me to it.)

You're correct that it wasn't documented, and as regressions go that
makes it *slightly* better. I.e. at least it's not a publicly documented
promise.

Anyone using this part of the interface would have discovered it by
experimentation, or (reasonably) assumed that git was invoking the hook
without any special redirection or buffering.

And you're also right that we didn't have any test coverage for this,
actually before the t/t1800-hook.sh we didn't have any test coverage at
all on stdout_to_stderr for hooks (at least those converted to the API
so far), which is pretty fundimental.

But none of that (except perhaps the doc omission) makes this any less
of a regression. We don't have 100% test coverage, and can't assume that
just because something isn't documented or tested for that it's not
being relied on in the wild. It is, as this upthread report indicates.

In this case "100% test coverage" in the "make coverage" sense wouldn't
help, this is part of 200% test coverage. I.e. it's in how an external
user expects to use and interact with the command. So it can remain
uncovered even if our own tests touch 100% of our own code.

> [...]
>> > Hm. I was going to mention that =C3=86var and I discussed the possibil=
ity
>> > of setting an environment variable for hook child processes, telling
>>
>> That...
>>
>> > them which hook they are being run as - e.g.
>> > "GIT_HOOK=3Dprepare-commit-msg" - but I suppose that relying on that
>> > alone doesn't tell us anything about whether the parent is being run
>> > in tty. I agree it could be very useful to simply pass
>> > GIT_PARENT_ISATTY to hooks (and I suppose other child processes).
>> > Could we simply do that from start_command() or something else deep in
>> > run-command.h machinery? Then Anthony's use case becomes
>> >
>> > if [-t 1|| GIT_PARENT_ISATTY]
>> >  ...
>> >
>> > and no need to examine Git version.

Just to clarify this a bit, we discussed passing down GIT_HOOK so that
you could e.g. symlink all your hooks and dispatch to some "hook
router".

Which right now you can do with the file-based hooks, because you'll
need to symlink them to such a router, but couldn't with future
config-based hooks.

IOW it's entirely separate conceptually from a "how does this hook
expect to behave" vis-a-vis calling isatty() or whatever. It would just
be working around or own implementation details, i.e. whether we invoke
a path or a configured command.

>> But DO NOT call it ISATTY.  "Are we showing the output to human
>> end-users" is the question it is answering to, and isatty() happens
>> to be an implementation detail on POSIXy system.
>>
>> "This" and "That" above make it smell like discussion was done, but
>> everybody got tired of discussing and the topic was shipped without
>> necessary polishment?  That sounds like a process failure, which we
>> may want to address in the new development cycle, not limited to this
>> particular topic.
>
> I think, rather, during discussion we said "without knowing how real
> users want to use hooks, it's not possible for us to make a good
> design for individual hooks to state whether they need to be
> parallelized or not." Perhaps that means this body of work should have
> stayed in 'next' longer, rather than making it to a release?
>
> For what it's worth, Google internally has been using multiple hooks
> via config for something like a year, with this design, from a
> combination of 'next' and pending hooks patches. But we haven't
> imagined the need to color hook output for users and check isatty() or
> similar. I think there are not many other consumers of 'next' besides
> the Google internal release. So I'm not sure that longer time in
> 'next' would have allowed us to see this issue, either.

We're both thoroughly "on inside" of this particular process failure, so
we're both bound to have biases here.

But having said that I agree with you here. I.e. as a mechanism for
mitigating mistakes and catching obscure edge cases just being more
careful or having things sit in 'next' for longer has, I think, proved
itself to not be an effective method (not just in this case, but a few
similar cases).

I'm not sure what the solution is exactly, but I'm pretty sure it
involves more controlled exposure to the wild (e.g. shipping certain
things as feature flags first), not deferring that exposure for long
periods, which is what having things sit it "next" for longer amounts
to.
