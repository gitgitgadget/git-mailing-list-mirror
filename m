Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D19C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 11:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiK1LDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiK1LDH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 06:03:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54151839A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:03:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id fy37so24746092ejc.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Af8u4qxZRm8Mt1HpxTsOpN+ibT5xnIHRHtKF/D2ztS4=;
        b=ClcO1IVkTR+UScfRzk2kZh0/HOCL9ipuY5JX6AAS/KPC+tL14lAXWU5IZbBL++BeN2
         jFKyVT1yNwpyiohYFF2snd8NYFRvgMxkR0DcXe3iX3DiTXOlDcz3lrgUTKBDXE/9UJS/
         7YvZdGBOVq9UbQyHRRrk6SeomxPH7DHfW6Am6RO2sGSvJEPJ8Q9DYohXWL0Tfe/QPtc3
         gm6sz3k9H/nLO2XnoCx543qTOtQKKn/85BNRgjUmJmIsguwTcI38fLsrtw3DdPhSLzhY
         I0dzGV3rmbV5WVLeNqbRBzMKVnizRmESaHhumrgyJwix5ipE2Qe6kS/x9zU99zdPcdL1
         nIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Af8u4qxZRm8Mt1HpxTsOpN+ibT5xnIHRHtKF/D2ztS4=;
        b=NNe9X6A/ZyzU++IIK7eaiUoHFzAAC4zDU6V2wZ/RM6WZOdODQJT1Fy3rvWdyj+HeNn
         UwbEenVJfyZk4LO0EuTATZQsGegpXalKb65vIEgOwgX0MHeopUyKZrpS7EApKf0ncnoz
         0iT1pIMpi5RuadGgyQEraAli9Yk2NVQCZdJ1GN3XtKKbmx5a/mPYQ5SR1whPXX0zbaLD
         JRcQUj3jSKweLRamxFP29OxicVZoNE5Op7iwzZy2q+sR6kK1QHiD4mnAVkcynSO9r1LH
         D1yTLUPwRV5lyhDhyrPYLUYcQdZPWrsLyHVe9kqyTvrGfvSiqZGxDT+3qpX9IbgZHGRH
         KymQ==
X-Gm-Message-State: ANoB5pl+GfjIXicclzCf4G2hW58i9kPPPhNCMEXOFkVKuxhpC1YjSOsv
        M71V3a6feGbNEIWim1nxdu9pm0RUt8I=
X-Google-Smtp-Source: AA0mqf7m/FxsTnFOXpO1C62L+cVOlsGzh539N9uxtJgdIvBiD221ENyzpAfe6aO8C5hKA8ko1lpCgg==
X-Received: by 2002:a17:906:ce2d:b0:7ba:b9a:5e7e with SMTP id sd13-20020a170906ce2d00b007ba0b9a5e7emr20530992ejb.735.1669633385127;
        Mon, 28 Nov 2022 03:03:05 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b0078cf8a743d6sm4806141ejc.100.2022.11.28.03.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:03:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozbui-000zIK-0T;
        Mon, 28 Nov 2022 12:03:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Yoichi Nakayama <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v7 3/3] git-jump: invoke emacs/emacsclient
Date:   Mon, 28 Nov 2022 11:54:20 +0100
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
 <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
 <221125.8635a7o123.gmgdl@evledraar.gmail.com>
 <CAF5D8-uxZOFi8p0bUMaqJCLFxipXCB9fo_Kx=QE6s=DW8Jspgg@mail.gmail.com>
 <221126.86h6ymmvyc.gmgdl@evledraar.gmail.com>
 <Y4RC3NZsiy5gXPoJ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y4RC3NZsiy5gXPoJ@coredump.intra.peff.net>
Message-ID: <221128.86cz97mjdj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Jeff King wrote:

> On Sat, Nov 26, 2022 at 12:52:50AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Second, there is a difficulty passing arbitrary arguments properly to
>> > Emacs Lisp properly.
>> > For example, your version will cause error with
>> >         git jump grep "hello world"
>> > My early patch was doing something similar. But the second problem was
>> > hard to deal with,
>> > so I switched to using a temporary file.
>>=20
>> To the extent that that's painful couldn't we write the grep expression
>> / arguments to the tempfile, then feed the tempfile to the ad-hoc elisp
>> code?
>>=20
>> It would then read it, get the argument to grep for, and we'd call (grep
>> that-argument).
>
> You'd still need to quote the arguments, since you'll be reading
> potentially multiple arguments out of the bytestream of the file[1].
>
> If you're not going to quote, the simplest thing is to generate the
> line-oriented output and read that.
>
> If you are going to quote, then you don't need the tempfile at all. You
> can shove the command into the eval, as if git-jump were run from emacs
> directly (but you want to use the --stdout mode introduced in this
> series, and not the git commands directly, because of course they're
> non-trivial).
>
> I showed how to do the quoting earlier in the thread. But it is ugly,
> and this tempfile hack should work (modulo the gross wait loop
> afterwards).

Thanks, I'd missed
https://lore.kernel.org/git/Y30a0ulfxyE7dnYi@coredump.intra.peff.net/

I think the case where the temporary directory itself has spaces in it
isn't worth worrying about.

So, all we'd need to worry about is getting the arguments to be grep'd
to emacs.

That should be simpler & bug-free with some equivalent of

     echo "args" >$tmpfile

then in Emacs, given some "<tmpfile>" variable:

  (with-temp-buffer
    (insert-file-contents <tempfile>)
    (buffer-string)))

We'd then invoke M-x grep with that.

I think getting rid of the tempfile isn't worth it, or worth worrying
about, what I was pointing out is that the implementation as it stands
works notably differently than if you invoked M-x grep itself.

I.e. it doesn't do highlighting, and (I didn't note this before) if it
takes a while we'll "hang", if we had emacs itself invoke the "git grep"
we'd stream out grep results as they came in.
