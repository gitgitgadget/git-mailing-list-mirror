Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A17BC636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7598060E09
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhGQVrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 17:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGQVrr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 17:47:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2731C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 14:44:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dp20so19066681ejc.7
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Kth3wGT/28pKydxrWpVHcfs7M8QY6Wv0irJzVzKKfrU=;
        b=VceXkh0OG9la6WCdiw5NyUfR8q0RWveahktP+fiGY72l1Bs+9ixQXw8tMQx9idfDxs
         UqOYUWdtDOHPttKDkt03r6wBsshs/cf6VXp19Xyl+ZsYBbSfXAA3d/rFJlrKPnVTDXpP
         emcm7vZFfi6LPx5OJMvCyjP9p7ue1XF0F1zHzt/SeHBC1ojLANzTuFcjKLhfoaRCxJe3
         rnzw2fQ0T9BZz3Vo2Gq9Gw9zF/vLDKPvxj45KBJNinB3cfZyPUqgeS4asB6zF5tAQNbL
         gzVQ/e5dPiyBeeIhfONuwZhbNtpoZ+msQ6fTC3lugyROSzdkibSNoHA0p+vUKHfaO4Xv
         JTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Kth3wGT/28pKydxrWpVHcfs7M8QY6Wv0irJzVzKKfrU=;
        b=CuFi5bPVsaDW7fDl2XhZnaqQOnJQet4rLs7PB75Eyo9aoCewpKw/+kejnhxJC1yuNw
         shRXwva873tk7GW9HeMqIjBK6/ZKbo+ZVcePq2ZDLbfHHqM+E+BfVoq1Y5pbFC8tBTLc
         5qm+HHSGLTDZQoqgjdQtsOU6djOzxMvHEUC9BPvVVYdq+B7SlHJyK/g+Sb96xl+jnIzR
         J3Xsnr3EIYACGxQQ1mPZN3SAlc9TjnMAZUR2RkswUQJfpUKoMA/8RPTumiXcDxhgLU4Q
         T1N6fq1Y6Mt+7fb5VOn7JyOYcDcBpwC+Uz+GZL0clyK1i42Elxod6Jk7onx8XuomSEWD
         wA3Q==
X-Gm-Message-State: AOAM533vHRTbb2TpxvNq4p2XJzERc0h8Xfms2S0bNbA/4fgzKVGBuhOs
        Kc53z+DQKHj2uob46tTOdZU=
X-Google-Smtp-Source: ABdhPJyYNIRlNyeziV/Oag/P6zK8G5D5+EwZ9I0MjSRSiKQ9qhIcKMDtbe67hnoH5uI6ljQH2HAlMQ==
X-Received: by 2002:a17:906:69cc:: with SMTP id g12mr19360502ejs.550.1626558288174;
        Sat, 17 Jul 2021 14:44:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h17sm4230057ejl.37.2021.07.17.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 14:44:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
Date:   Sat, 17 Jul 2021 23:43:00 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
 <87v95tbqgh.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161747010.59@tvgsbejvaqbjf.bet>
 <87y2a6w61l.fsf@evledraar.gmail.com> <xmqqa6mlplo7.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqa6mlplo7.fsf@gitster.g>
Message-ID: <87k0lowr6u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> > +ifdef FSMONITOR_DAEMON_BACKEND
>>>> > +	COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
>>>> > +	COMPAT_OBJS +=3D compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR_=
DAEMON_BACKEND).o
>>>> > +endif
>>>> > +
>>>> >  ifeq ($(TCLTK_PATH),)
>>>> >  NO_TCLTK =3D NoThanks
>>>> >  endif
>>>> ...
>>>>
>>>> Why put this in an ifdef?
>>>
>>> Why not? What benefit does this question bring to improving this patch
>>> series?
>>
>> I think that when adding code to the Makefile it makes sense to follow
>> the prevailing pattern, unless there's a good reason to do otherwise,
>> e.g. on my build:
>>=20=09
>> 	$ grep "''" GIT-BUILD-OPTIONS=20
>> 	NO_CURL=3D''
>> 	NO_EXPAT=3D''
>> 	NO_PERL=3D''
>> 	NO_PTHREADS=3D''
>> 	NO_PYTHON=3D''
>> 	NO_UNIX_SOCKETS=3D''
>> 	X=3D''
>>
>> Why does the FSMONITOR_DAEMON_BACKEND option require a nonexistent line
>> as opposed to an empty one?
>
> I do not quite get the question.
>
> #!/bin/sh
> cat >make.file <<\EOF
> all::
> ifeq ($(FSMONITOR_DAEMON_BACKEND),)
> 	echo it is empty
> endif
> ifdef FSMONITOR_DAEMON_BACKEND
> 	echo it is undefined
> endif
> EOF
>
> echo "unset???"
> make -f make.file
>
> echo "set to empty???"
> make -f make.file FSMONITOR_DAEMON_BACKEND=3D
>
> These two make invocations will give us the same result, showing
> that "is it set to empty" and "is it unset" are the same.

Indeed, which is why I'm pointing out that wrapping it in an ifdef is
pointless, which is why we don't do it for the other ones.

We do have a bunch of ifdef'd things there for perf etc., I'm not sure
if it matters or not for those.
