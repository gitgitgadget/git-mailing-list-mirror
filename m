Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72329C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 13:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiGWNgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWNgn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 09:36:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C30B1DB
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 06:36:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bf9so11601207lfb.13
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DTES3qVFLvEyLAx70IAbfiLzv2xzROhZTzW5OKnGSEY=;
        b=hjuxd1qMhbvJUIuxZAdzf1w7+jlQn6FNtbe5kmILmhhSvQu6ie1qKUfmOc62uvxfgL
         9rGZpNb1TZ5BpOWX3XULZENtIs7pKjSj9Xp+4yA+2Z684XJlJb8/wpi1MoMpqFvSFiEv
         7yO7h/r+M+xVQQeB76vabO5rbPC+p/01iOgcUxMQx1JKL+0XZUte+ByJTRFozkbDfdJY
         wzxgCOej8ba0eCu8tl0N58HgrbrJVa4yQL4MrqF3E28JInh51ixCc0glYj+5b+0KYzfF
         xSVXOjwPIFMbB3oodEI1ne/sX3a6kwCLPV/ODti8SxdOmUhahxiw/N6JhKytx8vXx4HL
         biyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DTES3qVFLvEyLAx70IAbfiLzv2xzROhZTzW5OKnGSEY=;
        b=QQvK5gjEhNyadnO6BQUArYTeVTzRyU0ZEnnXtRrh4brqHqUoJ0fUrCv2avwRXJaJ8o
         6enyo0cP5d1DPLyXITyhPBKxPYLRQCgVzW9UUyQTA5ysxB4yC8t4xKvxF9F+NIFrN0+E
         Wo7YaOdiEBztH62AFPljYUO9QQ7JA9U/z7/v13fGK8r1jnTp3YoNl3fventIilQY87jK
         U4JLy0Trtg0llDKCgW5lkQqyArgaTWTkHqtqOh5Eg1MT/G+YBdkHvWgxJE/JSKIvxFlI
         8IZsnzTL5gv0hQ5TghDJ+fiPrYUiOcleqfvXxK7pDsqcnvLvCN8TlVPSGiuCjK8ipWnn
         QOUA==
X-Gm-Message-State: AJIora/H//hmbH8a4bp3911JfzuzNVrX969+hv++KVE7dHa9J5z7J7zu
        wyD1dWVBzZWDm7ZwC7gciXRgIxIZBCyycCfX0/FQzA==
X-Google-Smtp-Source: AGRyM1t0zEa/GYUUvnUTzhOPia9b10eHkT2T64pTTm1hINunmoHJ2KRJGCG7BBgIizGe+jCUkIXy7e3jg9Hj4JQGEls=
X-Received: by 2002:a05:6512:3503:b0:481:4470:4134 with SMTP id
 h3-20020a056512350300b0048144704134mr1734671lfs.42.1658583397803; Sat, 23 Jul
 2022 06:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658518769.git.matheus.bernardino@usp.br>
 <99823077be77bc621cfa8ccf3303bd612da343ad.1658518769.git.matheus.bernardino@usp.br>
 <220723.86pmhwquie.gmgdl@evledraar.gmail.com>
In-Reply-To: <220723.86pmhwquie.gmgdl@evledraar.gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 23 Jul 2022 10:36:26 -0300
Message-ID: <CAHd-oW4BCXNrUcSHLzKsrK0BTPCpGTi_fo8Buxte=RQDJahipw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t/t0021: convert the rot13-filter.pl script to C
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2022 at 2:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jul 22 2022, Matheus Tavares wrote:
>
> Looking a bit closer...
>
> > however, that we still use the script as a wrapper at
> > this commit, in order to minimize the amount of changes it introduces
> > and help reviewers. At the next commit we will properly remove the
> > script and adjust the affected tests to use test-tool.
>
> I'd prefer if we just squashed this, if you want to avoid some of the
> diff verbosity you could leave the PERL prereq on all the
> test_expect_success and remove it in a 2/2 (we just wouldn't run the
> test until then).
>
> But I think it's all boilerplate, so just doing it in one step would be
> better, reasoning about the in-between steps is harder IMO (e.g. "exec"
> escaping or whatever)

Sure, will do! My split attempt was to try to reduce the mental load
for the reviewers, but if it ended up making it harder instead of
helping, let's squash the two patches.

> > +     remote_caps =3D packet_read_and_check_capabilities(&supported_cap=
s);
> > +     packet_check_and_write_capabilities(remote_caps, &requested_caps)=
;
> > +     fprintf(logfile, "init handshake complete\n");
> > +
> > +     string_list_clear(&supported_caps, 0);
> > +     string_list_clear(remote_caps, 0);
>
> ..and here you're missing a free(), but I wonder why not just declare
> this string_list in this function, and pass it down instead?

Makes sense, will do.

> Not knowing much about the filtering mechanism, I wonder if this code
> here wouldn't be better as a built-in some day. I.e. isn't this all
> shimmy we need to talk to some arbitrary conversion filter, except for
> the rot13 part?
>
> So if we just invoked a "tr" with run_command() to do the actual rot13
> filtering we could do any sort of arbitrary replacement, and present a
> variant of this this command as a "if you can't be bothered with
> packet-line" in gitattributes(5)...

Hmm, maybe so. But I would expect that someone building a long running
process filter (as opposed to a "single-shot" filter, like the "tr"
use case)  would also want to have finer control over the
communication and "queueing" mechanics. And I'm not sure if that would
be feasible via an off-the-shelf solution packed with Git itself.

For example, while some filters may process the received paths
sequentially, Git-LFS will use the delay capability to queue and
download blobs in the background, examining the queue every time Git
asks for the list of currently available blobs.

Anyways, I could see these packet-line routines being exported as a
library for those writing such filters.
