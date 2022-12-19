Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC26C4167B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 09:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiLSJKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 04:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiLSJKD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 04:10:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB7CE3F
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 01:09:57 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kw15so19831663ejc.10
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 01:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5zOkpisBy9TtMOcoonbahLqWP59dc6s/eTLE+TlbFY=;
        b=ULOgGnsIEoEPkoTBDypyPpp54JE5Mi+D/O7FxASSvJyoSgz1oVMbXFpxapJyEwi+mX
         A91tx3C6Exn/a0iO5xT9Y0IH7Qzuv+9lrq2GhY15Bme5lzNwdWM3eQMNuYniGyKMjqGr
         mezgGHPExZRcqClVwNvfuzk51rCRcg8Aw6vpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5zOkpisBy9TtMOcoonbahLqWP59dc6s/eTLE+TlbFY=;
        b=Eb1/1L+0qwnrQM6sdN3M8JpA+P6G0yjh3uyyO3yX9Vo0X5UbM/wjuyky+HI1CLmTvB
         Zwqd794MpmYqT9DKL/Ehnq7lYEHmRJh96T5MEtX5Qs4nxhhH/w+6zr9EekTBwDBVKyuR
         9z7muWqB8KAE35MQtBr1zhQM/wwFszpKttE1RV5y8nPhMCuyBlhydlqWclwgkv192pzf
         KIFbjS1ujyzgpL/rb+ss+X3VSOiFsNRfEsMllZfEQziggkI6cMbWgaI08lWeeHFLAkri
         6ChtOX/FdvbtzJPONGriBN6bLlui68G0pXjBn73cAkZtsTAujXoFaxyg+rLDPLghA/9M
         lUXQ==
X-Gm-Message-State: AFqh2koEoFu8Qv39BOtauVbWE/v0HK9RV86MBknDUnOQ4mLvMRAQ3QMl
        hnrJBd6Yp6h1+XdjXUBFAbEp9nxKZLD64RUbdiClzg==
X-Google-Smtp-Source: AMrXdXuIpSPYe6eOdL8omwvpJmYx01nitiqdQHLV5ZY4eYTKlK47zNPhEWP6I3cAvBBgqyHRECdFNpiMCZpKTOEF7Sg=
X-Received: by 2002:a17:906:8249:b0:7de:e71d:b07f with SMTP id
 f9-20020a170906824900b007dee71db07fmr735332ejx.479.1671440996203; Mon, 19 Dec
 2022 01:09:56 -0800 (PST)
MIME-Version: 1.0
References: <CAKu1iLWvd+PVOK405Q+SNDyyYnhbi=LtovZvWw55y6eQqoRpaA@mail.gmail.com>
 <CAPMMpoi=6x5VbSh=Lkbi7WJKudGpQS2U_GnJk8GJi+ArJNp2EA@mail.gmail.com> <xmqq1qp1wph5.fsf@gitster.g>
In-Reply-To: <xmqq1qp1wph5.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 19 Dec 2022 10:09:44 +0100
Message-ID: <CAPMMpoiLYhjjK73Le1u71e-nzU1cf_dA=i7zYYz3t8+AujgbCA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: preserve utf8 BOM when importing from p4 to git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Git List <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2022 at 12:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > Again, I'm not attempting to defend the breakage - just outlining why
> > I don't see how "using the Perforce variable P4CHARSET" would solve
> > anything.
> >
> >> This new behavior has made it impossible for
> >> me to submit changes to files of type "utf8"!  Any attempt fails with
> >> "patch does not apply" and the erroneously added BOM is the cause.
> >
> > I will try to understand the "unicode enabled server" behavior today
> > or tomorrow and see what options might make sense.
> >
> >> I propose rolling back the patch that introduced this behavior,
> >
> > Junio is the expert here and has noted it's a little late for that. I
> > obviously defer to his expertise as to git's release and backout
> > strategy.
> >
>
> It sounds like, if your conjecture turns out to be correct in that
> those P4 users who interact unicode enabled servers would have
> P4CHARSET and others don't, we may not need an extra configuration
> but pay attention to the P4CHARSET variable (or lack of it) and
> switch the behaviour.

Yes, I suspect some sort of detection will be required. There appears
to be no way to query the server for this "unicode mode" directly, but
you can force the client to try connecting in the "wrong" mode for the
server, and catch the corresponding error. Ugly, but effective.

(the reason it's hard to just test for "P4CHARSET" is that there are
several ways to set it, not just the environment, and there are
multiple versions of the setting, per-connection or global; setting
the global override and testing for failure is likely to be safer than
attempting to understand/evaluate the hierarchy of settings)

> > I would like to have a go at understanding what the options are (how
> > we can get correct and functional behavior for all users), before
> > proposing a specific course of action.

I have finally managed to start testing with the "unicode enabled
server" behavior.

So far I've learned that:
 * Some of our tests around file content encoding handling do fail
with the server in this mode (not necessarily because we're doing the
wrong thing, but because the server's behavior doesn't match our
expectations) these failures may correspond to bugs to be fixed, or
tests to be adjusted to match appropriate expectations in this
"unicode enabled mode"
 * Our tests around "git p4 submit" *don't* seem to fail, even on
utf-8-bom files - so I have not yet reproduced Tzadik's issue

(I keep placing "unicode enabled server" in quotes because I don't
want to give the impression that perforce in "normal" mode doesn't
handle unicode content - it absolutely does, but... differently.)

I definitely need to keep testing around this to understand what the
right thing to do for Tzadik (and others like him of course) might be.

Tzadik, could you provide any more detail about the failing situation?
One piece of info that might be particularly helpful is *what is the
exact/full p4 FileType of the problem file?*

Thanks,
Tao
