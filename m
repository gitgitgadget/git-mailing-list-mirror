Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0951DC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76C364ED5
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBBCGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhBBCGT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:06:19 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA41C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:05:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so21196951edd.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yBboROif7AuR/5hQ8IrzQcHKJ4jO6e9+D2ukIQabfVM=;
        b=Wb2nM4a7f58mGp0Qt6l0MhtepvaO6uMlRcFg4uvCc8jfZ+8sCA8INimTFOdoMmOZY/
         kKDtacB9hcnjlMf+cke/9vGDYyi2j91ipaQBG0QQcLbFQobWsbIzsM0jd+PbjUFaRYxd
         4Q1T57SjtjfNw5fYrLNxRPLDQWpJIhbY/PYBLFPL1q7JVcjsjR8yBOlPbVBZRJMoYWqM
         ChZG+BEpoBDxJSVuHFcmEs4xr57bkyf3rKT1+Ydzbu7Y9+9AJUvpU9uzY03E1f3jUaRq
         T54CFylW/gIPnYqIozK4E+T+bNvj1wJi4O2R13jDNZpzzmCWxNPku+xs8kgJCWZCepXb
         HIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yBboROif7AuR/5hQ8IrzQcHKJ4jO6e9+D2ukIQabfVM=;
        b=k98XWh+0XkdVmxybmglle6YoZdAI5rh/8IMHbt2ujDPOgVkqLFChNbv4bOwyjxiEY5
         KYvZ3iHxk7h2m+eAg9Q5YJXQW4ph4CP1mBgmS7c4LHgPdlp6gJ0KBeXAET+0I8O6RVSI
         gcZzKMu54+SSyk1yDssmCgYT8IFkHl777SNzbU9fKICAltsNwBr7dChC0eHRde1U4tmY
         qEwyb7TEXwM3cs/60KfMY2gseaPPDGkzor81qepR0JHLO0NP65kFjsmwU40qpJ6lgKFq
         8EhLVSSyZeWrHFrZuuSsBiyW1bP3+A5OEcPnUC5GcrrSnchvWB2TySw+39NbK1hh8C8o
         FLyA==
X-Gm-Message-State: AOAM533mYfcH02N69dJdeBv7XkycPXbqRBum5OIbqAm7+8A5ruUbEhCN
        HzPw+8FqyAz3WXMO4J0+T5c=
X-Google-Smtp-Source: ABdhPJznt6aMSbyYZZAzjmd+p1j5H4kDghSJRENY6SZoxwrq6+efi9wzDSUG8tCm3BxGXwk7sJn1TA==
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr21412481edd.378.1612231537401;
        Mon, 01 Feb 2021 18:05:37 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id zk6sm3742230ejb.119.2021.02.01.18.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:05:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
 <87czxjomn8.fsf@evledraar.gmail.com>
 <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
 <87wnvrefbv.fsf@evledraar.gmail.com>
 <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
Date:   Tue, 02 Feb 2021 03:05:36 +0100
Message-ID: <87tuqvdy1b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Would it be the matter of propagating the exit status of the pager
>>> noticed by wait_or_white() down thru finish_command_in_signal() and
>>> wait_for_pager(1) to here, so
>>>
>>>  - If we know pager exited with non-zero status, we would report,
>>>    perhaps with warning(_("..."));
>>>
>>>  - If we notice we got a SIGPIPE, we ignore it---it is nothing of
>>>    interest to the end-user;
>>>
>>>  - Otherwise we do not do anything differently.
>>>
>>> would be sufficient?  Implementors of "git -p" may know that "git"
>>> happens to implement its paging by piping its output to an external
>>> pager, but the end-users do not care.  Implementors may say they are
>>> giving 'q' to their pager "less", but to the end-users, who report
>>> "I ran 'git log' and after reading a pageful, I told it to 'q'uit",
>>> the distinction does not have any importance.
>>>
>>> Or are there more to it, in that the exit status we get from the
>>> pager, combined with the kind of signal we are getting, is not
>>> sufficient for us to tell what is going on?
>>
>> It is, I just wonder if ignoring the exit code is a practical issue as
>> long as we're not clobbering SIGPIPE, particularly with my trace2
>> logging patch in this thread.
>>
>> But yeah, we could patch git to handle this in the general case....
>
> Sorry, but now you lost me.
>
> I was merely wondering if Denton's patch can become a small update
> on top of these, if we just made sure that the exit code of the
> pager noticed by wait_or_whine() is reported to the code where
> Denton makes the decision to say "let's not re-raise but simply exit
> with 0 return as what we got is SIGPIPE".  I guess we could even
> make git exit with the pager's return code in that case, as the
> end-user observable result would be similar to "git log | less"
> where 'less' may be segfaulting or exiting cleanly.
>
> IOW, something like this on top of your three-patch series?
>
>  pager.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git c/pager.c w/pager.c
> index 3d37dd7ada..73bc5fc0e4 100644
> --- c/pager.c
> +++ w/pager.c
> @@ -28,8 +28,14 @@ static void wait_for_pager_atexit(void)
>=20=20
>  static void wait_for_pager_signal(int signo)
>  {
> +	int status;
> +
>  	close_pager_fds();
> -	finish_command_in_signal(&pager_process);
> +	status =3D finish_command_in_signal(&pager_process);
> +
> +	if (signo =3D=3D SIGPIPE)
> +		exit(status);
> +
>  	sigchain_pop(signo);
>  	raise(signo);
>  }

I sent a WIP start at something like this at the end of my v2, please
discard it when picking up the rest:
https://lore.kernel.org/git/20210202020001.31601-6-avarab@gmail.com/

As noted there it's going to be a lot more complex than this.
