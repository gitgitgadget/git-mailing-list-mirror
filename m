Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65EBC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 16:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355726AbiDOQJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355719AbiDOQJi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 12:09:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E4F8C7C4
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 09:07:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so16077400ejb.6
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tgKG8L4TV38RfDD1K7bHkpbJ36RQg3y3jZDqAlHQVkw=;
        b=fjfdISOsugxbJW0YKNeV1yGha/+AX0WFeleoNgHRrjmEDzf/FRnSgHTrHrDz/RXilj
         uv5dZ+Uo7mZ9fcRxADvlJ4qEmGvkmW8jeU/W506Ee/vO45azYEOEQONN8chRjAr2TDUG
         +ZMJYKVnQds1uEPwWiYBSA7YnZ7TC5g7tNuDsxnKt+rOunTTh3TGjy92EEtFTd7xn4qV
         kbbUcKJqSfvJg0An6QLAE6woYhzqVzlJiPuCw21MQ++6sICdTF3KvrfCmcf+BzWZBMD5
         xiOyO/POuRPV8xp/eWnJyF4XC+zjhBh4DW3U5p7Hj/SRoC2F/QPocNliYLP0K3mYheH0
         kpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tgKG8L4TV38RfDD1K7bHkpbJ36RQg3y3jZDqAlHQVkw=;
        b=8FdjYDILYywt0kgdJGLDaROwzRDwEe0bOfKj0luF+bXmm8/7DKp7o5xl9BZJ5KkFf2
         Mpj7Uq/+hEeUEaZcW3g7JVfDu+DHoTyOMNIzz7ERpng8b+8ijW2Z5mThRGQ4PjBgwmYh
         3yMCQwD3BmzGlgdWB3feRWKQub7CJw09Ns0O/cxWi1UrKz/M6B0u2vw1Gm1pjrg5bC16
         nybwPI7jBByuCXUHi1WnL8STLIyspv6GzWcD6TtAtYkLEpMWFQO38dVSt1wswGRnbP59
         kPjHzBvUZQ078nRsrWCtT6+pdHf/d7ODYKt4N1m7LNg9GI8lCg/39LUocW0/9q7A5GD4
         8pFQ==
X-Gm-Message-State: AOAM533WMmSthL9kyNbcf6kdkjNNPELJiWaRpTz29WSwHPGHcSY7Mcna
        Wcy7rd8VIV1vv55BXD8xCF2n0FGeAQxJew==
X-Google-Smtp-Source: ABdhPJxIUwhaGc6xCGNU9ofB2VeeTlSHA5LOMdKJjHf5gR8OZpCHccsvxA+W4VTidVQz9LDABF6HCw==
X-Received: by 2002:a17:906:408c:b0:6e8:d649:5e41 with SMTP id u12-20020a170906408c00b006e8d6495e41mr6889137ejj.519.1650038827726;
        Fri, 15 Apr 2022 09:07:07 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906bc4400b006e893908c4csm1813016ejv.60.2022.04.15.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:07:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfOTS-005j9N-H1;
        Fri, 15 Apr 2022 18:07:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] xdiff: provide indirection to git functions
Date:   Fri, 15 Apr 2022 17:55:07 +0200
References: <20220209012951.GA7@abe733c6e288>
 <20220209013354.GB7@abe733c6e288>
 <220216.86wnhvvgeh.gmgdl@evledraar.gmail.com>
 <7e6385f8-f25d-69f5-edae-6f5d6f785046@gmail.com>
 <220216.86leybszht.gmgdl@evledraar.gmail.com>
 <20220217012847.GA8@e5e602f6ad40>
 <220217.86ee41izpq.gmgdl@evledraar.gmail.com>
 <20220217225804.GC7@edef91d97c94>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220217225804.GC7@edef91d97c94>
Message-ID: <220415.867d7qbaad.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 17 2022, Edward Thomson wrote:

> On Thu, Feb 17, 2022 at 10:29:23AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> [I'm assuming that dropping the list from CC was a mistake, re-CC-ing]
>
> It was; many apologies, I don't use mutt very often any more.  Thanks!

No worries. Also, late reply but I remembered & referenced this thread
in
https://lore.kernel.org/git/220415.86bkx2bb0p.gmgdl@evledraar.gmail.com/,
and saw that I'd left this hanging...

>> As for the "new person to our codebase..." I don't think you're wrong
>> there, but that's an asthetic preference, not something that's required
>> for the stated aims of this series of dropping in compatibility shims.
>
> Sure, but avoiding a prefix is also not a technical decision but an
> aesthetic and ergonomic one.

Yes, I see that, but this code is maintained in git.git, not
libgit2.git, and having to remember to use custom malloc()/free()
per-namespace is very much negative asthetics & ergonomics in that
context.

So if the linker solution works...

> Is using a prefix here great?  No, it's not great, it's shit.  But it's
> shit that's easy to reason about.

I really don't see that, as noted in the linked newer reply above we
have bugs due to this sort of pattern where someone uses
mycustom_malloc(), forgets that, and then calls free() instead of
mycustom_free().

Which is a bug and potential segfault that's entirely preventable by not
using such wrappers at the per-file level (some one-off "this is where
we provide a custom malloc" file might of course have such complexity).

> If somebody sees a call to `xdl_free` in some code, they say "wtf is
> this `xdl_free` nonsense?"  And they grep around and figure it out and
> understand the way that this project handles heap allocations.  It's
> very transparent.
>
> If somebody sees a call to `free` in their code, they say "great,
> `free`".  But it merely *appears* very transparent; in fact, there's
> some magic behind the scenes that turns a `free` into a `git__free`
> without you knowing it.  You've not learned the way that this project
> handles heap allocations, but you also don't know that there's anything
> that you needed to learn.  These are the sorts of things that you think
> you understand but only discover when you _need_ to discover it because
> something's gone very wrong.

Because the reader assumed that when they saw malloc/free that it was
The Canonical Libc version, as opposed to whatever custom malloc the
library linked to?

> In my experience, calling a function what it _isn't_ is the sort of thing
> that a developer discovers the hard way, and that often leads to them
> not trusting the codebase because it doesn't do what it says it does.

But they aren't anything until you link to something that provides them.

Anyway, I think I see your point, you'd like names to always reflect
their different-ness, no linker shenanigans.

Anyway, since per [1] it seemed Junio was also more partial to sticking
with malloc/free *and* we're talking about a thing that gets
one-off-imported into libgit2 (not as a submodule, presumably) I don't
think there's any reason to really argue about this.

I.e. instead of importing the sources as-is why not just search-replace
malloc to mymalloc and free to myfree?

Which can be either a dumb "sed" script, or even better the same (and
guaranteed to understand C syntax) thing with coccinelle/spatch.

Which wouldn't require libgit2 to have a dependency on that, just
whatever dev runs that one-off import occasionally. The semantic patch
is just:
=09
	@@
	expression E;
	@@
	- free(E);
	+ myfree(E);
=09
	@@
	expression E;
	@@
	- malloc(E);
	+ mymalloc(E);

etc.

Wouldn't that also give you exactly what you want? Or was the plan to
have libgit2 have some option to build this *directly* from git.git
sources?

1. https://lore.kernel.org/git/xmqqfsohbdre.fsf@gitster.g/
