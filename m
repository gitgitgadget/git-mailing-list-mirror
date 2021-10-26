Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A30C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE9260F6F
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhJZNCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 09:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhJZNCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 09:02:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5821C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:59:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d10so15008162wrb.1
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=l2ITzVNjWzHEjtZLqQ3FW1m4Ni3BEY7FXsgGhASJsqg=;
        b=iR5JMbGIot7m900UDfaLp2UOb/l12krL61b8ufoZRtcBXW9VVlugNSqyC16IedZ2+L
         eLPkmnB93VLG849tx7o/t+VfJNKpP8qC2EAdrk5KVXcLak9QkbE16TBWuik9zdzdxfR0
         kXt0EAsjYRVFw579k23jpdGHlrps7q1CW5EporYLGFDNQnc5ArVo+FSuzpn2U3oUQNwO
         Zu6pMYJd2rhcyi+8qWJS4kFkclZxA3l+p0Nn3+aQHxuPXtW22MPTo9N6lx335gPdCPuQ
         o2LHkHWVGweMYbiRh/u7mB4nJ9TzsnfLFmjdQhb3TfrEr2oGriza6h0c0fDm7eEKPlMd
         DKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=l2ITzVNjWzHEjtZLqQ3FW1m4Ni3BEY7FXsgGhASJsqg=;
        b=o1rrv3ZQS1kU7iBr/wv08XYBgqVrFe4/0juzFj3Y/V3tNkVzytyYOsT6Ef6waV0c8l
         LwnsAIqosAOC13VcAwArv78NwLKVfnEec8sTkeo87FcQ9abYaz88G9cdFOdO+E423CrR
         equt8LAr6sbhYcXoZ8M64P4/CbeD5j3hhY3bUlKsqDDHp0vE4s0VV9GomeBVAuYrMMCQ
         tNa6aE6xG21dh7OlJVToDNv9Bv71W+W67I4ajdLkgS7vnKnsvM9fB7HHLS1qZ92wVwWj
         nV/MORMHtoC9qD0ZUkrF065OPPwDEhuO/c82uNs4BAcO0YmDD59KNEW1HcoBrkE8rzZK
         I1Vg==
X-Gm-Message-State: AOAM53302WXVx3cn9Mq3Vvr4T/83/nxy0OWJJLKuebRDyAiDpS8ipueg
        7qt/IEcmBzS+JA5/moUQXUQ=
X-Google-Smtp-Source: ABdhPJyENpPyZCs+h3282cKXUXbnGVEkgFnEh7ycABd/MVE+sI2kdz2JmOzEbf4dLnMatFTQHF39Iw==
X-Received: by 2002:a05:6000:1205:: with SMTP id e5mr10167629wrx.437.1635253182315;
        Tue, 26 Oct 2021 05:59:42 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c17sm12421611wrv.22.2021.10.26.05.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 05:59:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfM3J-001ot5-Cc;
        Tue, 26 Oct 2021 14:59:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Oct 2021, #05;
 Mon, 18)
Date:   Tue, 26 Oct 2021 14:20:55 +0200
References: <xmqq1r4hv7bv.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2110191436250.56@tvgsbejvaqbjf.bet>
        <211020.86zgr3n698.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2110210947590.56@tvgsbejvaqbjf.bet>
        <211022.868rylkuw7.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2110221734530.62@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <nycvar.QRO.7.76.6.2110221734530.62@tvgsbejvaqbjf.bet>
Message-ID: <211026.86lf2gym9u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 22 Oct 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Thu, Oct 21 2021, Johannes Schindelin wrote:
>>
>> > tl;dr it isn't worth your nor my time for you to focus on the build
>> > process in contrib/scalar/ at this moment.
>
> I still stand by these words, and I think you completely glanced over this
> problem. Your focus seems to lie exclusively on those "dependency
> problems". But apart from you, who cares if `libgit.a` is not rebuilt in
> obscure and rare circumstances _when building something in `contrib/`_?[.=
..]

You glanced over and didn't reply to the "This invariant that something
must be[...]" part of the E-Mail you're replying to, which I think gets
to the crux of the issue.

I.e. you haven't answered why you actively prefer a broken build system
integration when a non-broken and less complex one is available, other
than some vague and unclear references to the effect that "it's a
contrib thing", without really explaining what that means, or why it
necessitates a broken and more complex build system.

It's not that libgit.a isn't rebuilt, that part isn't broken, it's built
by the top-level Makefile. It's that if you:

    make -C contrib/scalar

And then change anything it depends on, short of the top-level
rebuilding libgit.a it won't be re-built, so for anyone hacking on it
that Makefile is rather useless. It *does* work to do:

    make contrib/scalar/scalar

Because that uses the top-level Makefile, will inspect
contrib/scalar/.depends etc. So your patches already mostly make
contrib/scalar/Makefile redundant anyway, hence my question about (and
patches) why we can't just drop it entirely.

As an aside your commit message instructs users to run:

     make -C contrib/scalar/Makefile

But that command can't work (you either meant -f <path>, or -C <dir>).

You keep narrowly focusing on the bit where your *.o dependencies are
broken, but I've pointed out a bunch of other things that are broken,
including but not limited to: "make TAGS coccicheck check-docs install
install-doc" etc.

> [...]The code in `contrib/scalar/` is transitional.[...]

OK. But it's being proposed for merge to "master", I don't see how "we
don't expect this to stay for long" translates into "it's OK that it's
broken while it's here".
=20
> Just forget about Scalar's build process. Forget about getting its CI to
> work. I have all that figured out already. It is all working as well as
> needed.

You're proposing to integrate this into git.git, so it really does
matter that it's useful to others and plays well with existing
components.

When a release of this is available we'd expect third-party packagers to
consider installing it alongside git. If that's not at all the intent
then at the very least the commit messages & documentation are sorely
lacking.

And it's not OK that some in-tree *.c code that uses various bits of
libgit.a and will break if changes to that code don't take it into
account doesn't have meaningful testing CI/integration.

E.g. I was hacking on something the other day, and since I build (my
version of) your scalar patches had a breakage due (my local changes to)
an API where scalar was the one remaining in-tree user of an API
function. Luckily I ran its tests by default, and didn't need to go out
of my way to do so.

All of the above is in the context that I've offered you patches to fix
all these issues.

I haven't sent anything but an inline WIP demo of that to the list
because we're still having this discussion where you're categorically
refusing to even consider fixes to things in your series that are
demonstrably broken.

>> > Having said that, I do appreciate your interest in this patch series, =
and
>> > I have suggestions at the end of this mail how we could collaborate on=
 it
>> > in a more fruitful manner.
>
> I would still like to invite you to think along more productive lines.
> It's not about where Scalar's build mechanics are right now. It's where we
> can take _Git_ to do what Scalar already does.

That's also interesting, but right now we're not discussing that
subsequent set of patches, but your integration of scalar in-tree. Let's
fix those issues first.
