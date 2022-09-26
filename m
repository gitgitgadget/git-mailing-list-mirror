Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60886C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 09:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiIZJIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiIZJIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 05:08:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C6D1084
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:08:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so12564375ejb.13
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=U+6uU9hOA8lF/6mikL0tJ7GIJM8uGBuifLxZVZHJZ08=;
        b=MKoBiU6gvoCECDEbV3UCHM6LMzdV2fxA1KgJNQcO1C0LD0q2Sise3QmqVqRDXP9b/9
         PkDCE0sSMQEOJREzlMwFIhN6rctCsE0GXBWqTGJp9wNB7kYwi+alFzF3T3yBLIklGonB
         qvuux089tY7tFhpnY+nwxSZpb7WbPC2EIq7SuPa8kkNQA8FpftM7ozCCDZDRJqiMzMfN
         owC54gVAsPS4l12la2Agwt5zQkmzpJBeBrIa82+BsUo+kK4n/EiUX9/4U0MKGoQtquCW
         bQ9lgZtzIoHgwc2pljLJ/ohyXoLDznDuifjm8PWCPKOD3E1n+0AZEaW7gsJqIFQm7AIh
         zOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=U+6uU9hOA8lF/6mikL0tJ7GIJM8uGBuifLxZVZHJZ08=;
        b=xXoPOqsNoVn2ctbApdpP+Fq6BPIW7v4JaLYRdF+WAYsM0XikamBwmzPy4HeSQCx4Ip
         BTeomPx+kjhq0Oq5gYbT372mW5Ku1ZJeWkh8NkqZNI88GOif01fZhxXwPKMR2YIKotE0
         MMYbQmcvw0zWPgjrzaEZKJarKuSr0N5Nb6yNg3DeisW7GKeW6j6L3NsxGCioFbdACku2
         ixxlFQWsE0KNvijXuIMqA+B1FQDTnNKGFTGFysJiLyemrARU3Hc4xBfbcwd4bCkvmvv/
         SMekEJUAqI+WGGE6k3eydXKgzcyWHbt9glDC7y2hoynWXdVzPhoOTHjCBF+2s4Xtk9g+
         9mUg==
X-Gm-Message-State: ACrzQf36haARVWDecaese1frqE2GWy8491/64JR7S/Gy+gEgu+6LkRg3
        T5fi8SF2gexFQWJmEdxx5pGkI9AsLkw=
X-Google-Smtp-Source: AMsMyM6RPjZ0DSIYjy8KSnQqLdDLcXoed6iQ2e+MmiiHpaeLv894CLSwMNqC+nuE4f82/C1aY8Hvuw==
X-Received: by 2002:a17:907:162a:b0:783:d11a:a553 with SMTP id hb42-20020a170907162a00b00783d11aa553mr174517ejc.482.1664183287238;
        Mon, 26 Sep 2022 02:08:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906c28b00b0073d9630cbafsm7849106ejz.126.2022.09.26.02.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:08:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ock5t-003nj8-38;
        Mon, 26 Sep 2022 11:08:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: opt "git --config-env" test out of SANITIZE=leak
Date:   Mon, 26 Sep 2022 10:56:45 +0200
References: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
 <patch-1.1-fb2f0a660c0-20220908T153252Z-avarab@gmail.com>
 <Yxo3HIXYDxutU0wF@coredump.intra.peff.net>
 <220923.86k05u4hfd.gmgdl@evledraar.gmail.com>
 <Yy4eo6500C0ijhk+@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yy4eo6500C0ijhk+@coredump.intra.peff.net>
Message-ID: <220926.86tu4u33m2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 23 2022, Jeff King wrote:

> On Fri, Sep 23, 2022 at 10:28:29AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > In the long run, when all leaks are plugged, we'd want to ditch the
>> > whole SANITIZE_LEAK system anyway. So we are better off preventing fal=
se
>> > positives than trying to gloss over them.
>>=20
>> In the long run when all leaks are plugged I'd prefer to be able to
>> compile a git with CFLAGS=3D-O3 and -fsanitize=3Dleak, and have it run "=
git
>> config" without erroring out about a leak.
>
> Why? Do you want to run a leak-checking copy of Git all the time?=20

Not all the time, yes, and I've been getting closer to compiling my
daily driver with it..

> If so,
> I have bad news for you performance-wise. Running the tests marked as
> leak-passing with -O2 (but not -fsanitize=3Dleak) takes ~101s of CPU.
> Running with -O0 takes ~111s. Running with -fsanitize=3Dleak takes ~241s.
> So the improvement from compiler optimizations is not a big win there,
> relatively speaking.

Yeah, I know it sucks, but I use it for interactive use, "git push" and
the like, so I usually don't care if it's ~2x slower. I even run with
SANITIZE=3Daddress sometimes.

Wanting to have non-O0 there is less about thinking the higher -On
helps, and more to avoid it being a special snowflake, i.e. if I run
with -O2 -g usually I'd like to just add -fsanitize=3Dleak to that, and
not have to also change the optimization level.

> Or are you thinking that -O3 reveals new information we would not find
> under other optimization levels? I don't think this is the case. While
> that does sometimes find new opportunities for static analysis (via
> inlining code, etc), I don't think it helps with run-time analysis. And
> as we've seen here, it actively makes things _worse_ by introducing
> false positives.

I think this (and to your "conter-example" below) is correct on your
part. I.e. I don't see a good reason for why this would happen.

I have been able to reliably reproduce some leaks as being flaky (and
have avoided adding them to the tests). I wonder if that explains it,
i.e. there was another underlying issue, and the optimization level
happened to trigger some race (or whatever was going on there, I haven't
looked in any depth into those either...).

>> So I'd really prefer to keep this patch as-is. I'd agree with you if the
>> "whack-a-mole" was painful, but in this case it's really not. I think
>> it's just this one edge-case in the whole codebase (out of the things
>> marked leak-free).
>
> Is it just this one spot? This is already the second one we've discussed
> on the list, and I think you indicated there were more spots where you
> intentionally held back on setting TEST_PASSES_SANITIZE_LEAK when you
> saw hits under higher optimization levels.

Probably not the only spot, but the only spot under the
TEST_PASSES_SANITIZE_LEAK umbrella.

> It really is a potential problem anywhere we'd call a NORETURN function,
> because the compiler (rightly) realizes there is no point in making sure
> we can call a later free() that we'll never reach.

FWIW I'm not sure it's NORETURN, and haven't had time to dig...
