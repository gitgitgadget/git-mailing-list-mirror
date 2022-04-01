Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E432C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 09:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbiDAJ5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbiDAJ5N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 05:57:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C1EFDE0E
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 02:55:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j15so4686187eje.9
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wn/LLG3xH9dYw4ZbHCczUbhtmxd2s0U4f93Is4JDBeY=;
        b=kHSxzT8DEaCvznKsCLClDdEqv8d/7q5OXAPEn+jQFveE9QZfz8lcdN5HUo3pEpAGwF
         09+qX34WrMF7ZmRbZYkZodxIziFH+36iKQyhyo19OohWqGzoICFdQJbfIghrf4RgZgPR
         sZyEQe+3BOEn+SmUCqaN1UYxQpd/Gy8F7e5zKrYmIf6wr9hpo27J/BvkXFDck2SYzSq3
         p7BBJjJB2UzMcNxqUsbs0rEty4EgOo65LShs/GkfPlTFIfsfbiqApTGihR1u87Ht8anu
         iuaVZbtlb8uz++PY396VPK7qZrK0ikYCA/ukyrmHf+jnaM8H/6z451Qvu0L23M0Wr5KY
         bueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wn/LLG3xH9dYw4ZbHCczUbhtmxd2s0U4f93Is4JDBeY=;
        b=ta7zQJjRc1MebRx7JM9sn+gZFUudi5sApE5MC1jyM+DMT9KdiLLdVQtcTTujkeEZsx
         vgX8XuuS+6FkCvenu3L7KvTijN77nEdseTKXAYj2rgmsquroGsbiW/kp4scuJN9Ff94e
         Nix26c6Ls0E6JXwPAUm+6YV1+DKGv7K8OneoT4CExfin1lBSqiWisLsMFSxGThmarBcX
         j7FxjR1rKhxgPf26mapvBY2s56H5puVDrivYMGQSuodX1HZhYpzPzjm1Zil7jnpC15jz
         vSzZdK2sHHaaNbiSUc9wPOuPX0zvuNa6qHN/lSQ6qWBdpX6FXqPhNeXczVtdAO3typZg
         2e6Q==
X-Gm-Message-State: AOAM530wVrfVyS6w/4HbuXKF4qiAXII8S4gQWr7qYBbiF1crY77fMfBO
        zL+vfxHbteh5KAHU6S+u1xL6BKmK9Ps=
X-Google-Smtp-Source: ABdhPJxot5rFyb+KxhQyJY3XheuwL8D65gU8TNLKKU2jLdL+6p0vzLUJDmwkBAIMbSAXBbQ3+sjwQA==
X-Received: by 2002:a17:906:255b:b0:6e1:6ae:1c76 with SMTP id j27-20020a170906255b00b006e106ae1c76mr8718817ejb.68.1648806922327;
        Fri, 01 Apr 2022 02:55:22 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906038c00b006e4e48969d2sm91295eja.88.2022.04.01.02.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 02:55:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naE00-0010Ag-QJ;
        Fri, 01 Apr 2022 11:55:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: give deadline for "for (int i = 0; ..."
Date:   Fri, 01 Apr 2022 11:29:13 +0200
References: <xmqqy20r3rv7.fsf@gitster.g>
 <220331.86v8vuqv95.gmgdl@evledraar.gmail.com> <xmqqo81l286e.fsf@gitster.g>
 <YkYa2NyA6IwIqZ4C@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YkYa2NyA6IwIqZ4C@camp.crustytoothpaste.net>
Message-ID: <220401.86tubdnn5j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-03-31 at 20:12:09, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>> >> A separate weather balloon for C99 as a whole was raised separately
>> >> in 7bc341e2 (git-compat-util: add a test balloon for C99 support,
>> >> 2021-12-01).  Hopefully, as we find out that all C99 features are OK
>> >> on all platforms we care about, we can stop probing the features we
>> >> want one-by-one like this
>> >
>> > Unfortunately this really isn't the case at all, the norm is for
>> > compilers to advertise that they support verison X of the standard via
>> > these macros when they consider the support "good enough", but while
>> > there's still a long list of unimplemented features before they're at
>> > 100% support (and most never fully get to 100%).
>> >
>> > We also need to worry about the stdlib implementation, and not just the
>> > compiler, see e.g. the %zu format and MinGW in the exchange at
>> > https://lore.kernel.org/git/220318.86bky3cr8j.gmgdl@evledraar.gmail.co=
m/
>> > and
>> > https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail=
.com/;
>> >
>> > But I think we're thoroughly past needing to worry about basic language
>> > features in C99 such as these inline variable declarations.
>>=20
>> Well, that makes it sound like the C99 weather balloon was almost
>> useless, doesn't it?
>
> I think if we were talking about C17, maybe.  But as I said in my commit
> message, C99 is over two decades old and required for the POSIX version
> which came out in 2001.  I'm aware of only two platforms we care about
> that don't support that POSIX version, which are NonStop and Windows.

What I'm referring to upthread is that if you look at
e.g. https://gcc.gnu.org/c99status.html and compare it to
https://gcc.gnu.org/releases.html you can see that GCC (which is usually
really early with these things) was still implementing major C99
features like "inline" (it had its own syntax, but not the C99 one) in
2008.

So, part of this is just unintentional commentary on how old I'm getting
:), I hadn't looked before sending the upthread, but I remembered this
being a bit closer to $(date).

In any case, I think that shows a typical pattern where compiler
implementations are still catching up with standards at least 5-10 years
after they're released.

If you then look at C11 at https://gcc.gnu.org/wiki/C11Status you can
see that _Generic took until April 2014 with GCC 4.9, and
e.g. https://access.redhat.com/solutions/19458 notes that RHEL 7 (still
in wide use) was released with GCC 4.8, and RHEL 6 with 4.4.

(I wouldn't be surprised if RedHat had sneakily backported some
features, so don't take that as gospel about what is and isn't supported
on that platform).

> I think the likelihood of this being a problem is very low.  And I think
> we can justifiably expect that major syntactic functionality is
> available when the define is set accordingly.

Indeed, I only meant to suggest that we might still need to be careful
with some of the more exotic features, and do some research similar to
the above.

E.g. I wouldn't be at all surprised if some of the long-tail compilers
we support (suncc, xlc, msvc) had implemented some parts of C99 much
later.

> I am also willing to simply tell people that a compiler that includes
> the define and doesn't include the requisite features is buggy and ask
> them to use a modern version of GCC or clang.

So we can drop MinGW & I can use %zu? Yay! :)

More seriously, I don't think we should have such a blanket
policy.

Sure, we might decide that's worth it, but when we run into such issues
I think it's good to just weigh the trade-offs for particular
feature. See "We live in the real world" in
Documentation/CodingGuidelines for some nice wisdom.

E.g. (and I didn't recall this when I wrote most of the above) I've got
33665d98e6b (reftable: make assignments portable to AIX xlc v12.01,
2022-03-28) in "next" right now which undoes some small use of C99
syntax because a (buggy) version of xlc isn't too happy about an
edge-case of valid C99 initializer syntax.

Now, we could just say we won't support that compiler, but as argued in
that commit message it's relatively easy to accommodate it, so being a
bit lenient with what subset of the standard we insist on seems prudent.

> But, ultimately, given we're talking about
> C99, this is extremely unlikely to ever be a problem in 2022.

Per the above it was a (small) problem on 2022-03-28 :)
