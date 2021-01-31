Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75157C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C3664E11
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhAaUue (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhAaUuc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:50:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E178C061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:49:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p20so1810640ejb.6
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0GhiaHHfuG32iNs8P9DvMktwV3os3rTMcOaXLcQz+Qs=;
        b=MDUqhg6lIgkq4QG7wdX96vkNd2EkonxkKTDPbsZQYODLuKyrbRU9j4z2nt33JqBwM9
         kKi+xITkqg6wfBVfTfjOgUVGAbVz19fXyhW/b0pq73ZzS3vHEOYFJTcDmFCOfRu2BZTQ
         JXlTw58UKCk1RHZtsMm5VyHGz04XcjPb3OwS5NyEIu1VWui8doa0jG/ubl1TyAti87pg
         9BjAdMSLC9rv5M2NhYHwj3r1EpRRo1WGBsd3n8aEls2gvpcMwJMJ4LQiJuxZJPB66UTr
         ZtFr7BP98xw98J1887cLhLTObJVz3ViD/Sr/72CQyazQ6O+EV+urRUhtA8h2OinzQyH9
         PGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0GhiaHHfuG32iNs8P9DvMktwV3os3rTMcOaXLcQz+Qs=;
        b=ch5VgL27ZsYfrUoDNjhZsAmGT/npUv40+F+zCypO4yv8aLETIwoQ0qdNPO4dHduAOh
         Zr9cdhXIsKwmVl+5yc6thzXQE+SyBMjY5dXVWVFwZRk1FDDF9h1MNcpTb5inf8XA1sxR
         TtnqnT2/sw3SkXYaprMpciwkPwVJZe4ptv2mJ5Rk2N7wZmziESjp9Exas2khLn8B7zQD
         LkPgPRo9znza6Xc/bCHMzmIFczJa1u0Zc3S54WdqIl88XjOog4n20jXjPCsip38XGDcQ
         PyFZTfq8aejvnDffnGWRUVhWIH+FvHKza5JJh4uAGRe4wul3ynK4Q3QA/VNH7LX54mQP
         DIYQ==
X-Gm-Message-State: AOAM530fwHF8HDz/1IV/SikUQdqlYxh7CPhptEGHbd59/bJLngUhF1z7
        Rp42+Qs0AjRdgigOhNXf6jTUxigEBQc=
X-Google-Smtp-Source: ABdhPJwiKNO6HmZ7sHRgPAkuefTQdi+wxRYLRnBhJngXV53iTW09eSmSf+/2BVP6KSHsE+pJhZDz6Q==
X-Received: by 2002:a17:906:94ce:: with SMTP id d14mr14480611ejy.121.1612126190811;
        Sun, 31 Jan 2021 12:49:50 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id v23sm3846397eja.11.2021.01.31.12.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 12:49:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     git@vger.kernel.org
Subject: Re: git fails with a broken pipe when one quits the pager
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210131033652.GK623063@zira.vinc17.org>
Date:   Sun, 31 Jan 2021 21:49:49 +0100
Message-ID: <87o8h4omqa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 31 2021, Vincent Lefevre wrote:

> On 2021-01-31 02:47:59 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrot=
e:
>> On Fri, Jan 15 2021, Vincent Lefevre wrote:
>> > I had reported the following bug at
>> >   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D914896
>> >
>> > It still occurs with Git 2.30.0.
>> >
>> > Some git commands with a lot of output fail with a broken pipe when
>> > one quits the pager (without going to the end of the output).
>> >
>> > For instance, in zsh:
>> >
>> > cventin% setopt PRINT_EXIT_VALUE
>> > cventin% git log
>> > zsh: broken pipe  git log
>> > cventin% echo $?
>> > 141
>> > cventin%=20
>> >
>> > This is annoying[...]
>>=20
>> Yes it's annoying, but the annoying output is from zsh, not
>> git. Consider a smarter implementation like:
>>=20
>>     case $__exit_status in
>>         0) __exit_emoji=3D=F0=9F=98=80;;
>>         1) __exit_emoji=3D=E2=98=B9=EF=B8=8F ;;
>>         141) __exit_emoji=3D=F0=9F=A4=95 ;;
>>         [...]
>>=20
>> Then put the $__exit_emoji in your $PS1 prompt, now when you 'q' in a
>> pager you know the difference between having quit at the full output
>> being emitted or not.
>
> FYI, I already have the exit status already in my prompt (the above
> commands were just for the example). Still, the git behavior is
> disturbing.
>
> Moreover, this doesn't solve the issue when doing something like
>
>   git log && some_other_command

What issue? That we're returning an exit code per getting a SIGHUP here
is a feature. Consider:

    git -c core.pager=3D/bin/false log && echo showed you the output

Before the patch from Denton Liu we'd correctly not say that worked, now
we'll just ignore that we couldn't give the output to the pager.

>> > And of course, I don't want to hide error messages by default, because
>> > this would hide *real* errors.
>>=20
>> Isn't the solution to this that your shell stops reporting failures due
>> to SIGPIPE in such a prominent way then?
>
> No! I want to be warned about real SIGPIPEs.

Not being able to write "git log" output is a real SIGPIPE.

I'm genuinely not trying to be difficult here, I just really don't see
what the conceptual difference is that would cause you to say that's not
a "real" SIGPIPE.

Is it because in your mind it's got something to do with the "|" shell
piping construct? The SIGPIPE is sent by the kernel, so it's no less
expected in cases like:

    git log && echo foo

Than:

    git log | cat

If something were to fail or the write() to the pager/pipe.

>> > The broken pipe is internally expected, thus should not be reported
>> > by git.
>> >
>> > Just to be clear: this broken pipe should be discarded only when git
>> > uses its builtin pager feature, not with a general pipe, where the
>> > error may be important.
>> >
>> > For instance,
>> >
>> > $ { git log ; echo "Exit status: $?" >&2 ; } | true
>> >
>> > should still output
>> >
>> > Exit status: 141
>>=20
>> I don't get it, how is it less meaningful when git itself invokes the
>> pager?
>
> I don't understand your question. If I invoke the pager myself,
> I don't get a SIGPIPE:
>
> cventin:~/software/gcc-trunk> git log
> cventin:~/software/gcc-trunk[PIPE]> git log|m
> cventin:~/software/gcc-trunk>

Do you mean if you invoke "less <file>" yourself, as opposed to "git
log" doing it for you? I.e.:

    git log >log.txt
    less log.txt
    <type 'q' to early exit>
   # returns 0

v.s.:

    git log # using less
    <type 'q' to early exit>
    # returns 141

Yes, because e.g. under less aborting before you view the whole output
isn't an error, the SIGPIPE is sent to the writer trying to
unsuccessfully spew output to the pager.

To git the pager should be a black box. We don't know if the reason we
couldn't write output to it is because it's what the user wanted, or the
pager died on our input or whatever (as shown by setting it to
/bin/false above).

Anyway, I'm not saying that there's no place for this as an optional
feature or whatever.

Maybe we have users who'd like to work around zsh's "setopt
PRINT_EXIT_VALUE" mode (would you want this patch if you could make zsh
ignore 141?). But I think it should at least be hidden behind some
core.pagerErrorIgnore=3D141 or something. Some of us like standard *nix
semantics.
