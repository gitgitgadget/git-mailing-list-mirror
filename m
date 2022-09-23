Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10364ECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 08:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIWIf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiIWIfX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 04:35:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C7071BC4
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:35:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nb11so1708100ejc.5
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=QrF7/z5blNbpQ3s9KZVWt2DrTbKcUrtw4JJLdrfwtbc=;
        b=ZZO6/TyQqz/VqqYZdhgUBeMvlH+MB4q989O5ceqJ7Rka+bg5knTPV7HD3KisvHYPqD
         6C9IA1RUEcdUWYXpzMfNlh8QX34wCE4gFQbbkt80p0+pzIKvt6ts3s/DQGChTCovPMgW
         RkRzSieT/A5T5OjTVAzAB4ou7leagScQo2cyIahaod42sX09OPlAT5KNW9PgtBdqdHGR
         bt7QYCB9lBja3obOA4C2DiTLxFunbZ8AwLQRjQ0Y+c8L6og5NuitPYida/dNxcksdEbM
         y9VmsjLXDbpWWeBBbUsEo8Tr9CX6D+2+RXCRo1QM1IKUNnmImzyDMahGGQIsdeX3KsuA
         3w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=QrF7/z5blNbpQ3s9KZVWt2DrTbKcUrtw4JJLdrfwtbc=;
        b=jLAXF5ZsnGoHSU9rWxt3R//wcWOkZ6t7YKZmJGZG5UIK/WNHoY4Yrjp5chsgJVeKzG
         q3kcwRXkT3tj7bnf52krhD3hsU2fGUFE6zgDc0OZBXPnTWTO5gWgOhUGBfKYHqnMcvo8
         2zWWSry7I5O/KnlKVRpMPWst2pIFfdAO+Imw0AfxMph02NTU9JSXRW/tUEjrlSPkmvKU
         91igO/KHGk6T8xQt6Isi1EhhrSEVWC8oXXevFSv7P6Y2aTsB7HdW9XCgqFZjrEhOL14P
         +ocfKO31VsCtSC2wdGCo1GQoFrOejLNnLuiPzdxqE7vMJI4Qioz9WDjLkMw7meVGISy7
         6P6w==
X-Gm-Message-State: ACrzQf3PCvqixGFtfwnN5rRgiADkdXEBeEXxAiKOg39eKjmc7/tLUglI
        W2Lh/C5mHXjByjunpu6paWinQqrQPLU=
X-Google-Smtp-Source: AMsMyM7RNRuFawdrNwbdaXWuFw4ctb6CjzuE9lLfHJiwM5SLOiCMp/YAey6RUpgN8RFq6r1ISMmYkQ==
X-Received: by 2002:a17:907:9725:b0:782:3669:89b5 with SMTP id jg37-20020a170907972500b00782366989b5mr6076447ejc.717.1663922120162;
        Fri, 23 Sep 2022 01:35:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lh7-20020a170906f8c700b0073d6d6e698bsm3666506ejb.187.2022.09.23.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:35:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1obe9W-003Gni-14;
        Fri, 23 Sep 2022 10:35:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: opt "git --config-env" test out of SANITIZE=leak
Date:   Fri, 23 Sep 2022 10:28:29 +0200
References: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
 <patch-1.1-fb2f0a660c0-20220908T153252Z-avarab@gmail.com>
 <Yxo3HIXYDxutU0wF@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yxo3HIXYDxutU0wF@coredump.intra.peff.net>
Message-ID: <220923.86k05u4hfd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 08 2022, Jeff King wrote:

> On Thu, Sep 08, 2022 at 05:42:54PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This is arguably not a compiler issue or bug, as the very notion of a
>> variable being "in scope" as far as the leak checker is concerned is
>> fuzzy at best in the face of compiler optimizations.
>>=20
>> A similar issue came up before related to the config.c code in
>> [2]. There the consensus seemed to be to avoid hacks in the C code to
>> work around these compiler edge cases. In this case however skipping
>> one test is easy enough. We can deal with these "!SANITIZE_LEAK"
>> issues later, when we have fewer overall leaks.
>
> IMHO this is the wrong approach. It is playing whack-a-mole with
> individual false positives, when we know the root cause is compiler
> optimizations. We should be invoking the compiler in a way that gives us
> the most reliable result.
>
> In the long run, when all leaks are plugged, we'd want to ditch the
> whole SANITIZE_LEAK system anyway. So we are better off preventing false
> positives than trying to gloss over them.

In the long run when all leaks are plugged I'd prefer to be able to
compile a git with CFLAGS=3D-O3 and -fsanitize=3Dleak, and have it run "git
config" without erroring out about a leak.

So I'd really prefer to keep this patch as-is. I'd agree with you if the
"whack-a-mole" was painful, but in this case it's really not. I think
it's just this one edge-case in the whole codebase (out of the things
marked leak-free).

That's inching us closer to what I think should be the end goal,
i.e. this SANITIZE=3Dleak is just a transition mechanism, so having it
enforce -O0 would mean that we can't have -fsanitize=3Dleak Just Work in
the future (both for the tests & when manually compiled).

>> I don't know if we (or the compiler implementors) can call it the
>> "wrong" result. Just as some warnings only pop up depending on
>> optimization levels, this behavior also depends on it.
>
> I think it's different than the case of warnings. In those cases the
> optimizations let the compiler see more of what's going on in the code,
> which lets them find a warn-able offense that they wouldn't otherwise
> see (e.g., inlining a function lets the compiler see an invariant).
> Those are real problems in the code that -O0 simply doesn't catch.
>
> But this is different: there is no problem in the code. It is just that
> the optimization of removing the variable does not work well with how
> the leak-checker works. There is nothing we can do in the code to fix
> it; the C conceptual model of variable scoping is all we have to work
> with, and according to that, there is no leak. C's "as if" rule means
> that the compiler can change the program as long as the behavior is the
> same. And it is, from the perspective of the rest of the program. The
> issue is that the leak-checker is itself a sort of undefined behavior;
> it expects to poke at random parts of the stack at any moment and find a
> consistent state, which is not something a normal C program can do.

This is just from vague recollection, and I couldn't find an example now
with some light digging (which was just seeing if any of the tests with
a "!SANITIZE_LEAK" prereq passed on -O0, but not -O3 with clang), but I
think I've run into cases where higher optimization levels have also
spotted genuine leaks that I've fixed.

