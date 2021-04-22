Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9274C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 08:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E33D6144E
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 08:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhDVIzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 04:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhDVIzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 04:55:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A046C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 01:54:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u17so67651131ejk.2
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ieJfwDSmVbxnzMq2qwgkykTnm1emK8iYRuuFpKj544k=;
        b=mu1l/lK8cDQpuMA5G3kwUeG2BG+oB4Gih2L47Ql5ECejBZzoiXQ/3uCQZHP5zzdp4J
         yaSeSMt2SpV2RbAzsgIiNKziGyvZxgezVEQVEqIvVMJch0SJvkAFKSsjvbe+ILLOlHYN
         H6NAdxVw7CwnPJMLf5fKv1O9lx2LQLpJs+K4Qib4uy5qP5wNM2tS3/3D9a5oFuUTG89S
         VhdL8+ClGd+vpjXESL7LdTYYnsKRBpxCDbNYuIvLHEIWwbYrh4YHQSwgoze/RPLZrAj3
         bIZu3Pz1rvVWSMlDPY0IQHN606yU/ki9qQbIlK1NEdfzinzBTEMGM7tW9RlJv/S0AQqs
         SX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ieJfwDSmVbxnzMq2qwgkykTnm1emK8iYRuuFpKj544k=;
        b=OnqXD4crLSZSAOMJWtdSxW2TZmuLbrobw/fvNKwCV2rv97JBZq+OPXaDFc53nuvb7l
         MdJGrNF437HDiRjS0oD5exnBVO32vfthPHeIl8YwTLlGAxM2YeejBqofwfNyOvSDqJvh
         mF3AwDeBWbDjxzGx0zXZOtwbpxaYYMVPe60EqbY0M/Y8KREYAsyPWeJ7bPrj8SB9nbPR
         LDwLkHjklcJREKh/hb/WDTBWV3U9/nb5w/RBgb0O6IxFCuk/iWTmq0BYBcUkMXLKW5nw
         JsouUZXhtmM1FNniACXKx+MEvx9VWUDLSPwuukb+jhv2A7X22GwBX23Ijy0L5jTaqzOw
         mMnQ==
X-Gm-Message-State: AOAM5304JkdUplw16yD9BSNMs6GN57Hry84U2S0c/XKseWTig3PhCQQ5
        2ZzsHybN5M+FMm2S5DGaPzqHE/CoG1KXMw==
X-Google-Smtp-Source: ABdhPJxzF5FMjnDOu3o57pf6anFqQZAFnvnVx/2GRaTdaEHAWtrn8g95g36VPFL47BsuwB6bYjpDrw==
X-Received: by 2002:a17:907:16a9:: with SMTP id hc41mr2297166ejc.84.1619081664761;
        Thu, 22 Apr 2021 01:54:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w6sm1383061eje.107.2021.04.22.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 01:54:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
References: <20210420190552.822138-1-lukeshu@lukeshu.com>
 <xmqqa6ps4otm.fsf@gitster.g>
 <CABPp-BF-rHnxvz0sAFAujXkiNwSjtpRQA4uvxT=a3z8v_sYbAA@mail.gmail.com>
 <xmqqy2dbxybn.fsf@gitster.g>
 <CABPp-BF373j2BbyTgTJbKzDP9Y5R2jZVNqWeOqLtypdz6VZRMQ@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CABPp-BF373j2BbyTgTJbKzDP9Y5R2jZVNqWeOqLtypdz6VZRMQ@mail.gmail.com>
Date:   Thu, 22 Apr 2021 10:54:23 +0200
Message-ID: <871rb23dj4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, Elijah Newren wrote:

> On Wed, Apr 21, 2021 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Tue, Apr 20, 2021 at 2:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >> ...
>> >> +The `<refname>` is prefixed with `refs/tags/` when stored
>> >>  in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
>> >> -use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will write the
>> >> +use just `RELENG-1_0-FINAL` for `<refname>`, and fast-import will write the
>> >>  corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
>> >
>> > Going on a slight tangent since you didn't introduce this, but since
>> > you're modifying this exact documentation...
>> >
>> > I hate the assumed "refs/tags/" prefix.  Especially since ...
>> > ... The special casing reminds me of the ref-updated hook in
>> > gerrit
>>
>> Gerrit and fast-import?  What is common is Shawn, perhaps ;-)?
>
> :-)  To be fair, though, given the number of things he created for us,
> it's inevitable there'd be a few small things causing problems and
> these are small potatoes in the big scheme of things.  ref-updated was
> fixed years ago, and it sounds like Luke is about to fix the tag
> prefix assumption for us.
>
>> > broken given the fact that the name inside the tag didn't match the
>> > name of the actual ref.  (To be honest, though, I was never sure why
>> > the name of the tag was recorded inside the tag itself.)
>>
>> The name of the tag and the name of the object has to be together
>> for a signature over it to have any meaning, no?
>
> Oh, I guess if you treat the signature as affirming that not only do
> you like the object but that it has a particular nickname, then yes
> you'd need both.  I had always viewed a signed tag as an affirmation
> that the object was good/tested/verified/whatever, and viewed the
> nickname of that good object as ancillary.  I have to admit to not
> using signed tags much, though.

The current behavior leaves the door open to an attack where say git has
a security point-release v2.31.2, and you have my hostile repo as a
remote, and I've sneakily replaced v2.31.2 in that repo with the object
pointed-to by v2.31.1.

You "update" (but not really), verify v2.31.2 with Junio's GPG key,
which is all correctly signed content. But the tag name isn't what you
expected, and thus you don't get the security fix, I use this
information to attack you.

This already unplausible but hypothetical attack was sort-of-maybe
plausible before my 0bc8d71b99e (fetch: stop clobbering existing tags
without --force, 2018-08-31).

That was released with v2.20.0, before that I could more easily sneak
such a tag into your repo knowing that you were doing a "git fetch
--all" and had my evil git.git clone[1] on github.com evil remote. Now
that's unlikely to happen, in practice the "fetch --all" happens in
order, you'll have your "origin" remote first in the file (it's the way
git config adds them), and will get the good tag first.

Hrm, I suppose with --jobs and a race condition that might not always be
true. Aside from this mostly imaginary issue maybe having --jobs be
deterministic (i.e. "fetch content in parallel, apply ref updates in
sequence") might be a good idea..

Anyway, getting back on point since no release of git has cared about
the "tag" field I'd be inclined to say that we should explicitly
document that we don't care, and perhaps document this caveat.

1. Disclosure: I know of no actual evilness except a bunch of crappy WIP
   code in my git.git fork on github.
