Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16300C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiGRPMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiGRPMt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:12:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B41F62A
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:12:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e15so15750902edj.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dmS35tI0NeoN1/6WSeShqsiAOPiAdILlPjuKVyNKA2I=;
        b=GKygVMlPiC1+jKb+8VIN3DNWYzN1GRwc3ZKmEhWhX08B7OzgR4Mad0O7dvxzeW1UAq
         oIpP/jlC3Lqbu1gSnmtNivNoOr1NqmvyjY2rAJyBbTZVd8aRkOjRcerNq7B5+G8iectX
         OVI9KUXuN+ToEXKqwtul83VHEwVhMcmyrbQYjq2DhxXTse5marnCUcDbKBBj8dV5hrVV
         p7R15OBsgJPoVkSUjQjlXLk+/GxYKm9EolJjV5u7/CXSDhBveIXdoo37P01pqdQZLJ33
         6CKFos3lhjJmycBYlIF5pCjbgzgRL9WhMXx+znqLqPK14n9MYqKfJ1QmnDOdRnYbqySl
         uqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dmS35tI0NeoN1/6WSeShqsiAOPiAdILlPjuKVyNKA2I=;
        b=4ASB66ZQ+WEnMbtD72cJ4RldqQVwMblC6bQVybd/n/uWGr9VwfeNQF/zBY3DK7arH2
         TPt5yNTL3sb4RDjsiehQOlNXsJEFMZsGVut/gywpEql+vHBc6SmF5rj52W0ZeEoWHer/
         DyJDPMbOCY9/HGM8lEErBjjb+2sKt3OFaTHGZrv6DjzsVJvdm2CVkz4mOSDEtibadLym
         PvYcKyawkVk2yeQ+BAHo/144rQQXW3R+6GBcSayVnv4uU3OKM8bdPdazCiCHpwDd/zuy
         S1olCiudAshVz+cbdD1OvYpUIf4h/D58dwAfF1ChOzfYF7Idxr3O6m5QvlsU6oG7/RoW
         Rgig==
X-Gm-Message-State: AJIora83PbQb9HU39W5lF0LHehLqPi8ls3UdtrhanL9qqTossRH4pv/g
        PyMeK77b5oHLICWjKPYgpJc=
X-Google-Smtp-Source: AGRyM1s5njQTAR1mOeiQANBXC48mdJqMy9Lj2Yxb2Eoh3N9UmjMO6jkN/zzaDFT6aAyyTxBu9QIrmg==
X-Received: by 2002:aa7:cb01:0:b0:437:8a8a:dbb3 with SMTP id s1-20020aa7cb01000000b004378a8adbb3mr37367939edt.74.1658157166388;
        Mon, 18 Jul 2022 08:12:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090653d400b0072eec799e52sm4869699ejo.145.2022.07.18.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:12:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDSQP-003CXN-7Z;
        Mon, 18 Jul 2022 17:12:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] log: fix common "rev.pending" memory leak in "git
 show"
Date:   Mon, 18 Jul 2022 17:08:08 +0200
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-4.6-9bff7b10197-20220713T130511Z-avarab@gmail.com>
 <YtV0xB9d6g/XwkLk@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YtV0xB9d6g/XwkLk@coredump.intra.peff.net>
Message-ID: <220718.864jzexxn6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Jeff King wrote:

> On Wed, Jul 13, 2022 at 03:10:33PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index e0f40798d45..77ec256a8ae 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -747,6 +747,8 @@ int cmd_show(int argc, const char **argv, const char=
 *prefix)
>>  			memcpy(&rev.pending, &blank, sizeof(rev.pending));
>>  			add_object_array(o, name, &rev.pending);
>>  			ret =3D cmd_log_walk_no_free(&rev);
>> +			object_array_clear(&rev.pending);
>> +			memcpy(&rev.pending, &cp, sizeof(rev.pending));
>>  			break;
>
> OK, so we clear the fake one-entry pending array we just created. That
> make sense.
>
> And then we have to restore rev.pending, because we don't otherwise
> clean up cp. That makes sense in the context of your previous patch, but
> if you take my suggestion there to separate "cp" from rev.pending
> entirely, and clean it up explicitly, then this second memcpy() goes
> away. IMHO that leaves the resulting code much easier to follow, as the
> lifetimes are clearly distinct.

Thanks, I'll mull that over, and didn't have time to do it now. FWIW I
was aiming to end up with the least bit of invasiveness into the private
bits of revision.[ch], i.e. we know we can fiddle with rev.pending
independently of other members, but it's rather nasty to assume that. So
restoring the previous state and having release_revisions() handle it is
a bit less nasty.

Of course we assume things about its internals here anyway, but this way
it's only for the narrow scope of when we're clobbering it for "show".

> Two alternatives I briefly considered that don't work:
>
>   - you can't just leave the one-item rev.pending in place to get
>     cleaned up by release_revisions(), because we may show multiple
>     commits. We have to clean each one as we go.
>
>   - you can't just object_array_clear(&rev.pending) _before_ clearing
>     it, because in the initial state it's still a copy of "cp", and thus
>     would hose the array we're iterating over.
>
> This whole "reuse rev, but tweak its pending array" feels a bit sketchy
> to me in general. But it has been this way since 2006, and anyway is
> completely out of scope for your series, so let's hold our nose and
> continue. ;)

*nod*

>> diff --git a/t/t7007-show.sh b/t/t7007-show.sh
>> index d6cc69e0f2c..f908a4d1abc 100755
>> --- a/t/t7007-show.sh
>> +++ b/t/t7007-show.sh
>> @@ -2,6 +2,7 @@
>>=20=20
>>  test_description=3D'git show'
>>=20=20
>> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>>  . ./test-lib.sh
>
> Lots of stuff now passes, which is good, but....
>
>> diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
>> index 527ba3d2932..0fc289ae0f0 100755
>> --- a/t/t9122-git-svn-author.sh
>> +++ b/t/t9122-git-svn-author.sh
>> @@ -2,7 +2,6 @@
>>=20=20
>>  test_description=3D'git svn authorship'
>>=20=20
>> -TEST_FAILS_SANITIZE_LEAK=3Dtrue
>>  . ./lib-git-svn.sh
>
> ...this one (and t9162) don't anymore? Are these hunks a mistake? If
> not, this feels like something that needs to go into the commit message.

I can add an explanation for this, this too passes, note that it's
"TEST_FAILS..." not "TEST_PASSES...".

I..e. in an earlier series I whitelisted all of lib-git-svn.sh, unless
that variable was specificed, which was less churn than adding
"TEST_PASSES_SANITIZE_LEAK=3Dtrue" to all of them (as more than 1/2 of
them passed already).

So there's no new leaks here, and only new passing tests.
