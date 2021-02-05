Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EB3C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134B964EE4
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhBETPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 14:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhBETOD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 14:14:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99997C061756
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 12:48:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t5so10394948eds.12
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=flgLNC36vx0KZgqEiYQjMVcBwzN0HXjnkVPeAnmSr/I=;
        b=GATZG0y6hhRb5xiWXU/PATQxlwMNTgnuSjWhCQ9XIT0nuowReYha8DguT/lzYNOooV
         gouBPMA2LEX3b3q+BPtsxo6KFWXTgRzMkeBVrhsA4bPP1UYdrPazmZA9DU9iJZ7lHdJv
         TBs4XMPLDS7cZfkHO6GxM7A5UhU1BxVM7BTIu6sCwqOzmKdJPGWrByWrT7ERjSKi0+Vu
         JxvMAMEE20CP9N301FNzRyKalI0/dZxnN4kXFRvAIZIeeH5UyJRnbezGVKIb12MAEvfS
         8KGGdH6+OkahR8HSBNxHk61Fbj+cHsIbs2DjbJkdZZCLoHQ2+6IC0YNWZhiLysU5dE1S
         7Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=flgLNC36vx0KZgqEiYQjMVcBwzN0HXjnkVPeAnmSr/I=;
        b=jvxewtN/GWeyUB1euCTfcCDVz1nH3eiX9H2Zbhh3Vc5io27stqiI+sfvl0MIHzX2IN
         8jluIJ9QtbEFlsu47Q0KvFzMyNE9LXD4EFbOcZ7I9dhjHDC+mK8OyfuVngFaTjBE4SpX
         kAtG+koLbtevsGU54hFhRB4JiLE4GCTq8edayfJBvHctuu8BjoCACxYe/+vmiImKN1KS
         +xn/XMwnR87/hNnTAUunFWXPZnayE1ZSNa7njRy4V55C4C9wZg9OriWXdLDySnkfjNcJ
         OUpS1EWEMo167THKyY8Sq4qrQiW85Q7qbfh38sk0OP1JZC2iRFI9wqav549SRN1iaTk3
         7iUw==
X-Gm-Message-State: AOAM530qhdjBPdjAAOQebJJ6HsMokeZowxXRqleddJ2Ht4pfhJ83RjBg
        6VkNjtfcsD7U2vq11I2kn7M=
X-Google-Smtp-Source: ABdhPJwR8C4ihqD3KEctsld/GHdqiN7vRYtU59oggnTzXffc1K44txtJSUhiTyFravjXicuLNRqGKQ==
X-Received: by 2002:a05:6402:186:: with SMTP id r6mr5646567edv.234.1612558126205;
        Fri, 05 Feb 2021 12:48:46 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id c18sm4463661edu.20.2021.02.05.12.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:48:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH v3 5/6] doc hash-function-transition: move rationale
 upwards
References: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
 <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
 <ee0fa2ec1d0fb4875c6a10af26686d2d5b3cb489.1612549349.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <ee0fa2ec1d0fb4875c6a10af26686d2d5b3cb489.1612549349.git.gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 21:48:44 +0100
Message-ID: <87h7mqckb7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 05 2021, Thomas Ackermann via GitGitGadget wrote:

> diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
> index 5ff9ee027cff..0c4cb98cd4e9 100644
> --- a/Documentation/technical/hash-function-transition.txt
> +++ b/Documentation/technical/hash-function-transition.txt
> @@ -33,16 +33,9 @@ researchers. On 23 February 2017 the SHAttered attack
>  
>  Git v2.13.0 and later subsequently moved to a hardened SHA-1
>  implementation by default, which isn't vulnerable to the SHAttered
> -attack.
> +attack, but SHA-1 is still weak.
>  
> -Thus Git has in effect already migrated to a new hash that isn't SHA-1
> -and doesn't share its vulnerabilities, its new hash function just
> -happens to produce exactly the same output for all known inputs,
> -except two PDFs published by the SHAttered researchers, and the new
> -implementation (written by those researchers) claims to detect future
> -cryptanalytic collision attacks.
> -
> -Regardless, it's considered prudent to move past any variant of SHA-1
> +Thus it's considered prudent to move past any variant of SHA-1
>  to a new hash. There's no guarantee that future attacks on SHA-1 won't
>  be published in the future, and those attacks may not have viable
>  mitigations.
> @@ -57,6 +50,38 @@ SHA-1 still possesses the other properties such as fast object lookup
>  and safe error checking, but other hash functions are equally suitable
>  that are believed to be cryptographically secure.

I missed version 2 of this. I don't think it's an improvement to
completely remove the description of us using sha1collisiondetection by
default, i.e. effectively revert 5988eb631a3 (doc
hash-function-transition: clarify what SHAttered means, 2018-03-26)

I can see how my comment on v1 could have been read like that. FWIW I
didn't mean remove the whole thing, but that I don't think it adds much
value to our description of how we use SHA-1 to go into the level of
detail of mentioning several researchers by name, there's Wikipedia for
that.

I think what we should instead do is have some brief summary of the
vulnerabilities and how they're impacting git.

Maybe I'm barking up the wrong tree here, and what I'm describing should
be in a "man 5 gitsecurity" or something.

But anyway, I think it adds a lot of value to somewhere have not just
what amounts to "sha-1 sucks, see research papers", but to have some
brief human-readable summary of what the practical impact is on users.

In 2018 it was true that sha1collisiondetection was mitigating the known
attack in practice, and that's also true about this new attack[1] (maybe
there's others I missed ...).

Then there's the fact that we don't *just* rely on SHA-1, but e.g. the
"don't re-write objects we have already". So as a practical attack on
someone using git ...

Oh, and the attacks currently all seem to require file formats like JPEG
or PDF for anything practical, i.e. being able to spew in lots of
arbitrary data into some data segment, as opposed to e.g. creating a
program that compiles.

None of this is meant as some overall defense of SHA-1, just that most
of our users aren't security researchers, and will be helped by a
summary of how this system they're using using SHA-1, and having read
that it's "broken" or "believed to be weak" translates to a threat to
them in practice.

1. https://eprint.iacr.org/2020/014.pdf
