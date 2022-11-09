Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D4C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 15:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiKIPpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKIPpM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 10:45:12 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98BD2F8
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 07:45:11 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id f5so47787106ejc.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 07:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VqtB+H2qbLuHgumTWDRXUlnGTcMh7nuvZ0ralRVNab0=;
        b=ikv0UzGNKjkYt4bPejJK/efqiJbLldlp7xs9sjChNOfjX0wBw+nark0aWHPB/H3QvX
         wZJKrmwwDa4M8ep+S8zBteEjBLxrLLuARW5K0ydMCAVYz8neyDukbGZqQR1FZOG5vSjy
         75oTMW/5MBmIdDWiq3RlHE44IpngQI37mWhls72p3idiEqQsK/SXaYfdlJlz1JlCpWJk
         DEz9Rc2zh5M5hrtYCW0oStT85wusaJ3iea4864SBHl0pY2JIWewLls0/fzF6qq9MFFFC
         0Ec9H9GPsVBOA7h91ZmvrpI1jiRatE83eNEWMjO3kvbf4WThq6we0cIP5zPaUXESyrn2
         PlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqtB+H2qbLuHgumTWDRXUlnGTcMh7nuvZ0ralRVNab0=;
        b=o0mK1bE++NeYmAbqTo6y7mfkFGUmOovRsJAoNHl9+jrSSdEvYrpaf7kfjRHgY2rsi+
         E2vIoW5MULiBMk3zVEJqnddUxe9ZXCUMP/Y9s4Tndbv6mdIyYBNpXHJFodRaMSxIpXpr
         5tzXXSXV0XHmOs7+rFT6jSqHZeZ2nJAnSgTWjtA3zBVH9G25awdi5xWHDrBlf+QuIQes
         moyucccLjYNwYgSM0Kn3nrjcezr5iigzqZTr1uQqo3eGAQU1enryyw2S+Ff7mxKegquB
         behoRYolFx1SsiP0oBeYBlqplDBeaqgtuLj6um123wa4zJKTQpu8X2Kz3gPfXNofoQmK
         nVtA==
X-Gm-Message-State: ANoB5pkecQYUmIPxUb5uQgKDniQEMgS2I+R2ZfEkcDCKbB6/FkslCvOQ
        TeJjjdvSYknEP7v4mIRhvL8=
X-Google-Smtp-Source: AA0mqf6ZpYw+cu7cUEecVRBRe9AowLknxltSS6LpT/0y/iH8kkuZw2Cq40NG1PjaOadWKlNcGxmedQ==
X-Received: by 2002:a17:907:7ea3:b0:7ae:5033:d991 with SMTP id qb35-20020a1709077ea300b007ae5033d991mr19029687ejc.217.1668008709629;
        Wed, 09 Nov 2022 07:45:09 -0800 (PST)
Received: from gmgdl ([109.38.150.4])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b0079e552fd860sm6070409ejc.152.2022.11.09.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:45:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osnGF-000zZy-2p;
        Wed, 09 Nov 2022 16:45:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 10/13] Makefile: copy contrib/coccinelle/*.cocci to
 build/
Date:   Wed, 09 Nov 2022 16:42:33 +0100
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
 <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
 <patch-v5-10.13-56ca8f5720a-20221101T222616Z-avarab@gmail.com>
 <20221109150556.GE1731@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221109150556.GE1731@szeder.dev>
Message-ID: <221109.86tu38p1x8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, SZEDER G=C3=A1bor wrote:

> On Tue, Nov 01, 2022 at 11:35:52PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Change the "coccinelle" rule so that we first copy the *.cocci source
>> in e.g. "contrib/coccinelle/strbuf.cocci" to
>> ".build/contrib/coccinelle/strbuf.cocci" before operating on it.
>
> After this patch the output of 'make coccicheck' looks like this:
>
>     CP contrib/coccinelle/hashmap.cocci .build/contrib/coccinelle/hashmap=
.cocci
>     MKDIR -p .build/.build/contrib/coccinelle/hashmap.cocci.patch
>     SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/upload-pa=
ck.c
>     SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/merge-ort=
-wrappers.c
>     SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/unpack-tr=
ees.c
>     SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/gpg-inter=
face.c
>     SPATCH .build/.build/contrib/coccinelle/hashmap.cocci.patch/linear-as=
signment.c
>
> Notice how there is not one but two leading '.build' path components.
> Surely one would be enough :)

Oops, well spotted, I'll submit a patch on top soon to fix that...

> This also breaks 'make cocciclean':
>
>   $ make cocciclean
>   rm -f GIT-SPATCH-DEFINES
>   rm -f -r .build/contrib/coccinelle
>   rm -f contrib/coccinelle/*.cocci.patch
>   $ find .build/
>   .build/
>   .build/contrib
>   .build/.build
>   .build/.build/contrib
>   .build/.build/contrib/coccinelle
>   .build/.build/contrib/coccinelle/hashmap.cocci.patch
>   .build/.build/contrib/coccinelle/hashmap.cocci.patch/upload-pack.c
>   .build/.build/contrib/coccinelle/hashmap.cocci.patch/merge-ort-wrappers=
.c
>   .build/.build/contrib/coccinelle/hashmap.cocci.patch/unpack-trees.c
>   .build/.build/contrib/coccinelle/hashmap.cocci.patch/gpg-interface.c
>   .build/.build/contrib/coccinelle/hashmap.cocci.patch/linear-assignment.c

...and that, i.e. the nested .build is clearly unintended...

Aside: Now that "coccicheck" is a well-behaved (well, mostly, sans the
above) target that knows its deps etc. I wonder if it makes sense to
have it clean this at all, and just leave it for "make clean". I.e. it
should clean the worktree litter, but we could just leave the
".build/contrib/coccinelle".

Anyway, that's just a thought, and something to leave for some later
"what should we clean in .build" topic, if any. I'll make sure it rm
-rf's the right .build/ dir, and that we put stuff in it...
