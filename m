Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B1C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiCGMHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbiCGMHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:07:17 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8683E76653
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:06:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dr20so31360541ejc.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pIDOYCsl/xuE7I48ro6Qo7gl8vPdnNjJ6fBQGmX/ekA=;
        b=YBVoivZY1bvMNcQa1b1uqKFkbxGAmSd27hR0dcHedWCAfF4u40uKrjqpFZgWN2QAJf
         Vyby0f8+8wHenRU569K3WbV2i1JEyZeQY77BwtGJ9S3o0qU/nJAYm2qgiBYM17kJRxSD
         ddHfRoT7ptn3/mS7v7kQNS+9Xxw0qvehs/2w5gScNvO3e8rkPnzEcQfHOtHRL564AJxv
         2C5DSWJ9U0N4DqFH334A4h+KppBwWfA4AzATs+nIvAwPXj8xKKpWOAyUOyTAJhYmyVSJ
         6Zptvzi/U0+UQeIxwpEgx42ffnhu0kTfFzRyxJ21/oaBxbpgHgBAhUuhkEiCd0/f0qh+
         u0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pIDOYCsl/xuE7I48ro6Qo7gl8vPdnNjJ6fBQGmX/ekA=;
        b=jS7WUBwgG3cZKuA3LAAoAQVW+zYP+XJhzwB8uux78IhuqL5PB/GbKNAO+3j6ydl8hk
         JCWOlw29oauJn2XsdjipKTCAvVCbxjeJ0g427LSX5IiRRJ4cUJQgwAj3XXkINvqL1t5x
         Oqo2H6lg6b71ZvvGyEafn0TuWk5JJskLCSaGW/GDB4Zhd+GeIf/UH8yyxCRqccbWCcMC
         Gjgid+qNhegHNQ/zJ6KxUUSEDEEYxklW56aZV4nGSQH/P/fl8fSuqQIbfNxAije7KWou
         N1z7vBIU1diWhdr/dtmAPucXEanjd1n84ALxuC/pNyVwC5fMhT14c+Ks3tdtM9ivFBXV
         x7Yg==
X-Gm-Message-State: AOAM5301zEfsofS6r3ZQt737P0lplWFllbOFAxqu/6yZ8NacxguqMy8t
        LkPxxiPB8vprhFBaNKzyzCo=
X-Google-Smtp-Source: ABdhPJwJHP6mAIJesFEGG8MH/6Zjc25n7ewfvjSf+qpPA4L+yfrbROMnaEldPeYu6BNbLG+AuqU7kQ==
X-Received: by 2002:a17:906:49d4:b0:6d6:e5ec:9a23 with SMTP id w20-20020a17090649d400b006d6e5ec9a23mr8820983ejv.79.1646654769844;
        Mon, 07 Mar 2022 04:06:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b006da975173bfsm4387373ejg.170.2022.03.07.04.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:06:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRC7s-001TDg-Jq;
        Mon, 07 Mar 2022 13:06:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] terminal: restore settings on SIGTSTP
Date:   Mon, 07 Mar 2022 12:49:37 +0100
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-5-phillip.wood123@gmail.com>
 <220305.86bkyk4hwc.gmgdl@evledraar.gmail.com>
 <8aa11144-c9ce-46aa-2edd-15e8fa1298dc@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <8aa11144-c9ce-46aa-2edd-15e8fa1298dc@gmail.com>
Message-ID: <220307.86ilsq0xxr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 05/03/2022 13:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [...]=20
>>>   int save_term(unsigned flags)
>>>   {
>>> +	struct sigaction sa;
>>> +
>>>   	if (term_fd < 0)
>>>   		term_fd =3D (flags & SAVE_TERM_STDIN) ? 0
>>>   						    : open("/dev/tty", O_RDWR);
>>> @@ -44,6 +136,26 @@ int save_term(unsigned flags)
>>>   	if (tcgetattr(term_fd, &old_term) < 0)
>>>   		return -1;
>>>   	sigchain_push_common(restore_term_on_signal);
>>> +	/*
>>> +	 * If job control is disabled then the shell will have set the
>>> +	 * disposition of SIGTSTP to SIG_IGN.
>>> +	 */
>>> +	sigaction(SIGTSTP, NULL, &sa);
>>> +	if (sa.sa_handler =3D=3D SIG_IGN)
>>> +		return 0;
>>> +
>>> +	/* avoid calling gettext() from signal handler */
>>> +	background_resume_msg =3D xstrdup(_("error: cannot resume in the back=
ground"));
>>> +	restore_error_msg =3D xstrdup(_("error: cannot restore terminal setti=
ngs"));
>> You don't need to xstrdup() the return values of gettext() (here
>> _()),
>> you'll get a pointer to static storage that's safe to hold on to for the
>> duration of the program.
>
> I had a look at the documentation and could not see anything about the
> lifetime of the returned string, all it says is "don't alter it"

I think this is overed in "11.2.7 Optimization of the *gettext
functions", a pedantic reading might suggest not, but what's meant with
the combination of that API documentation & the description of how MO
files work is that you're just getting pointers into the already-loaded
translation catalog, so it's safe to hold onto the pointer and re-use it
later.

In any case, if we're going to be paranoid about gettext() it would make
sense to propose that as some general change to how we use it, we rely
on this assumption holding in a lot of our use of the API:

    git grep '=3D _\('

Rather than sneak that partcular new assumption in here in this already
tricky code...

>> In this case I think it would make sense to skip "error: " from the
>> message itself.
>> Eventually we'll get to making usage.c have that prefix translated,
>> and
>> can have some utility function exposed there (I have WIP patches for
>> this already since a while ago).
>> To translators it'll look like the same thing, and avoid churn when
>> we
>> make the "error: " prefix translatable.
>
> Unless we add a function that returns a string rather than printing
> the message I don't see how it avoids churn in the future. Having the
> whole string with the "error: " prefix translated here does not add
> any extra burden to translators - it is still the same number of
> strings to translate.

Because translators translate "we failed" for most errors, not "error:
we failed".

If and when we convert it from "error: we failed" to "we failed" they'll
need to translate it again (although to be fair, the translation cache
will help).

And even then it'll be one of very few exceptions where the "error: "
currently that *is* translated.

>> Aside: If you do keep the xstrdup() (perhaps an xstrfmt() with the above
>> advice...) doesn't it make sense to add the "\n" here, so you'll have
>> one write_in_full() above?
>
> I decided to keep the translated string simpler by omitting the
> newline, calling write_in_full() twice isn't a bit deal (I don't think
> the output can be split by a write from another thread or signal
> handler in between).

Makes sense.

FWIW I meant if you're going to xstrdup() or xstrfmt() it anyway you
could do:

    xstrfmt("error: %s\n", _("the error"))

And then do one call to write_in_full().

But I think just:

    msg =3D _("the error");

And then:

	const char *const =3D pfx =3D "error: ";
        const size_t len =3D strlen(pfx);

	write_in_full(2, pfx, len);
        write_in_full(2, msg, strlen(msg));
	write_in_full(2, "\n", 1);

Makes more sense :)
