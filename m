Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD08AC433E9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EC664EC2
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhBATyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhBATwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:52:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891DC061351
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:52:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s3so6598391edi.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Axxvp8pRlyK4p1MtC33SQ8UaRSXtOMK7CUGh6glSRig=;
        b=nQhMxhLyXCz0NFfkQ90YRBnuk5gjVywwFBrj4cx4rTaKcJou1bUamrEjSuj7tbYc1F
         QIZAD2Ua7Xqsc/8Nex+ExpzJ4XIaCg6+V18pGS5MGTpO6xRedf+fQ7YC2l017ZEKklad
         BneYuaGWhZ4BxlC+LJljYIivKyX3XUiC+6ykbieqr0RfqCMNvdfIE7dkbIRuJo1BfeOh
         tef53CkXtNdJMGsMSoVTipHTJVbIMgdhGR4bxipUuzN4rA605O3Tnrw+EP1kSc8tA720
         0tjz7ht8O2C6Kraj29/EMsEfdLnWoMEaxFHgGRamTCGYWVtt8D3Is755u/j5RMO4CmPO
         A9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Axxvp8pRlyK4p1MtC33SQ8UaRSXtOMK7CUGh6glSRig=;
        b=SeBRcJr7Oy14dLkbaavt3PRhaus+AQ1zqjquVubId0rtXFll6KfCS4qozUQdRGxdnZ
         JSLp2kOj07Y/6IN6lwhaM84MlGdvi4lDGGlVJaxUzPmAGxIQqtL8kU2hM0WOyb1BiUpE
         s9u89/t9XnkCMkctYBju13QHyCg90x07A+Y5Z9b3FLJPuG5c9RQU76pm4r2JB7OBQ9gQ
         Bv2ir30eTnGIhdSotomBACZ+Hy2VXOw4OhmTfYdx4qFHX2KB4RNLxCuZETtXli/SUxPC
         NYz9ELgAK+bUOB7ldALTQpsLkIm3+Z8Os9rBT5DC9zsfDVWYfYquPWHBpt/nkXwVxtGd
         7i7g==
X-Gm-Message-State: AOAM531aDTAlWBr5opouKcurpxd+4z/zonIfvfOIfTQTCnQZdkfpnNL0
        hdycWv60+EMgfZi5We/F0Rw=
X-Google-Smtp-Source: ABdhPJyUjGvmb4LAu4qWc4x5g3R8VJWCJYs/pzZPsC6uEF7606esuKBiNhBNf9zvx6h46QuRouAoug==
X-Received: by 2002:a50:d4d9:: with SMTP id e25mr8667935edj.183.1612209125964;
        Mon, 01 Feb 2021 11:52:05 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id re19sm8470415ejb.111.2021.02.01.11.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:52:05 -0800 (PST)
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
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
Date:   Mon, 01 Feb 2021 20:52:04 +0100
Message-ID: <87wnvrefbv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> diff --git a/pager.c b/pager.c
>>> index ee435de675..5922d99dc8 100644
>>> --- a/pager.c
>>> +++ b/pager.c
>>> @@ -34,6 +34,8 @@ static void wait_for_pager_atexit(void)
>>>  static void wait_for_pager_signal(int signo)
>>>  {
>>>  	wait_for_pager(1);
>>> +	if (signo =3D=3D SIGPIPE)
>>> +		exit(0);
>>
>> As shown in
>> https://lore.kernel.org/git/20210201144921.8664-1-avarab@gmail.com/ this
>> leaves us without guard rails where the pager dies/segfaults or
>> whatever.
>>
>> That's an existing bug, but by not carrying the SIGPIPE forward it
>> changes from "most of the time we'd exit with SIGPIPE anyway" to "we'll
>> never notice".
>
> Would it be the matter of propagating the exit status of the pager
> noticed by wait_or_white() down thru finish_command_in_signal() and
> wait_for_pager(1) to here, so
>
>  - If we know pager exited with non-zero status, we would report,
>    perhaps with warning(_("..."));
>
>  - If we notice we got a SIGPIPE, we ignore it---it is nothing of
>    interest to the end-user;
>
>  - Otherwise we do not do anything differently.
>
> would be sufficient?  Implementors of "git -p" may know that "git"
> happens to implement its paging by piping its output to an external
> pager, but the end-users do not care.  Implementors may say they are
> giving 'q' to their pager "less", but to the end-users, who report
> "I ran 'git log' and after reading a pageful, I told it to 'q'uit",
> the distinction does not have any importance.
>
> Or are there more to it, in that the exit status we get from the
> pager, combined with the kind of signal we are getting, is not
> sufficient for us to tell what is going on?

It is, I just wonder if ignoring the exit code is a practical issue as
long as we're not clobbering SIGPIPE, particularly with my trace2
logging patch in this thread.

But yeah, we could patch git to handle this in the general case. I think
it's probably a bit of a PITA to do, since for the general case we need
to munge the exit code in an atexit() handler.

Which means calling _exit() (if that's even portable), and presumably
changing from the atexit() API to our own registry of how many times we
called atexit(), which would introduce logic bugs if we ever use a
library that wants to have atexit(). I.e. if we _exit() before its
atexit() handler runs because we wanted to munge the exit code.

