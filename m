Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E077C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 17:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiBCRyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353403AbiBCRxr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 12:53:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B0C061751
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 09:53:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id s5so11168181ejx.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9PSKlxxyD9qqP2y1yDVel87PGA/9QGqrj5c2Py8d9wg=;
        b=eodV945I47T5C0dxc7Pj2VDoCpckrTU4N424cvid+B9kUjCUwMvNq1PMBGw9+W6nUn
         7KCyQk1RGBh8+RjJa1eXGxZcnr8M7E3B3bL/KGDy8/crxZhQUJJjt0t5R8buaLWBQFJG
         jZIC86AF/4z+p3pZz245G4ocfqTS7KTJD7zrHONq8r0cpegwOASNdJpw+4/DyDUQPT66
         KUfFENz8SB4LzIAF844zAVtCOtkCO9NC0hKfuraKOMya25NPm4Nq9FZ2I0n+GEEOWSSW
         1PC2HDvYNdzV18xOk0cFnHHC3cSLTVSANXOCi31a7HGCyevzMip3kVV3sDDYKr5AR6mZ
         Ptjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9PSKlxxyD9qqP2y1yDVel87PGA/9QGqrj5c2Py8d9wg=;
        b=N3Z+cp7NhKSv36dowusAvZrrK8TLHT98eVrxiAmMME5TuOvXQyBU68RiF8lIAgPDGM
         vfCT1Pd2Auc2VVLL4dLPdYEO93aL1sGdX5Fvjhif74kv5sNYCJhGy1Vn6LzQshimNnfP
         dcM83Gxe4W/SDaqugq0hgP17c1KWpxhDtUMn1BiCzTi76Wjv+2upRkpCObDJlBr33mLc
         u83opJLFg+wDB7H3Eaq/LNt3whMlvOy3iGtdoiOVyQM3SgeLa3P+dKUdcexmOUViaxwl
         vOyExwuczh2+feu9qGTFJcE1b3I+MC5MbmYLpabI8CIGchx4e08bddZ84M6csRcaE26S
         czHQ==
X-Gm-Message-State: AOAM5307y00WAhXeUBog7ixW5sUAMinwY+YYUGsI+eytv6qAFf+881Fu
        BHemD8ngaR2C7oLIG+t3b+M=
X-Google-Smtp-Source: ABdhPJx5fZb6KdkMsi235J+4hjEGI1hW7UlAk51t0JO9svvuiR5QIVQXd7Axbn4Nz0sZEeRdEVQgTg==
X-Received: by 2002:a17:906:7f0a:: with SMTP id d10mr29631306ejr.397.1643910784332;
        Thu, 03 Feb 2022 09:53:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s8sm2913959ejb.59.2022.02.03.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:53:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFgI3-0057E2-0i;
        Thu, 03 Feb 2022 18:53:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
Date:   Thu, 03 Feb 2022 18:39:29 +0100
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
        <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
        <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
        <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
        <xmqqa6facn9i.fsf@gitster.g>
        <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
        <xmqqsft2b5jl.fsf@gitster.g>
        <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
Message-ID: <220203.867dab6dmp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Han-Wen Nienhuys wrote:

> On Tue, Feb 1, 2022 at 11:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > We could surely add magic record types, but how would such a dance be
>> > performed while keeping compatibility with existing JGit clients?
>>
>> Yes.  It is exactly the point of the question I asked.  If it is
>> simple and easy to add such a new type that is ignored/skipped by
>> existing clients, then we can go that route.  If it is simple and
>> easy to add a new bit per ref that existing clients would not barf,
>> we can use that as an alternative implementation strategy.
>
> I'm not sure that there are any JGit clients: I committed reftable
> support at the end of 2019. Before that time, we were running it
> internally at Google, but only ref storage, and without the posix
> part. Reflogs were never stored in refable, and I actually found a
> couple of bugs in Shawn's Java code.
>
> Gerrit has increasingly started using Git as a database, and the
> packed/loose system is just not a very good database, so that
> motivates the work reftable in general. But the folks who run Gerrit
> on a POSIX filesystem want to be sure that isn't a fringe feature, so
> they only want to start using it once Git itself supports it. So there
> is a chicken & egg problem.
>
> It's sad that we have to introduce an existence bit to make things
> work, but overall it is probably easier for me to do than trying to
> make sense of sequencer.c and how it uses refs/stash@{0}.
>
> Technically, the only obstacle I see is that we'd need to treat an
> existence entry especially for the purpose of compaction/gc: we can
> discard older entries, but we shouldn't discard the existence bit, no
> matter how old it is.

Ah, that's very informative. I had been assuming (or misremembered) that
reftable was already seeing production use at Google. Perhaps I
remembering the now-dead Google Code (or whatever it was called). Maybe
not.

In any case, not being locked into the format as specified is very
nice. So is it basically seeing no (production) use anywhere as far as
you know? Whether that's in production at Google, or some third parties
via JGit-something (maybe as editor libraries?).

Taking a bit of a step back.

I do think that generally speaking parts of this series are putting the
cart before the horse in seemingly trying to get the test suite clean
before we have the integration in-tree.

Not everything you have here, but some of it.

I know I'm the one who started encouraging you to work towards getting
the test mode passing, but I think that while it's good to mark some
obviously file-only tests beforehand, anything where we have different
behavior under reftable should really come after.

Because then we can positively assert what we do differently, not just
skip an existing test.

And yes, for many tests that will require rewriting their setup, because
they conflate things that are backend-independent, such as the general
question of "can we ask about reflog existence?" with the implementation
detail of the test setup, which oftentimes is file-backend specific.

Of course that will mean we'll have some interim period where our test
suite is a dumpster fire under GIT_TEST_REFTABLE=3Dtrue, and I think
that's fine, as long as we work towards getting it passing, and as long
as the non-stability of the nascent backend is very prominently
advertised in the interim.

I.e. I think *the* issue with the original series you had in this regard
was that git-init.txt (or whatever it was) basically just discussed
enabling reftable matter-of-factly, when we were still failing
tens/hundreds of tests, which is just setting up a big bear trap for
users to step into.

But if we just changed those docs a bit to note "!!WARNING WARNING!!
EXPERIMENTAL AND UNSTABLE !!WARNING WARNING!!" or whatever we could
merge the API integration parts sooner than later, even with a lot of
known-broken tests.

We could then whitelist the broken parts, and work on narrowing that set
down. Similar what the SANITIZE=3Dleak mode is currently doing for memory
leaks.

I think that would make things a lot easier when reviewing submissions
like these, in that we have reftable/* in-tree already, but with the
"real" integration we could check how files/reftable backends behave,
add the diverging behavior to tests etc.

What do you think?
