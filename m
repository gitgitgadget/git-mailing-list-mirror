Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03ADC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C557D61056
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 15:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJNP5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhJNP5e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 11:57:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928FEC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 08:55:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g25so20877418wrb.2
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kEFRD0Ke+Y7D/emVZvtnSq3qIELHZ3jHXZLRwgvFWZA=;
        b=VTyMrdFGY7JGHWYEI2xLDAQAquCyM/svM1KrwRKca0DZuUQgNAladWDHHkHk2XnhqN
         Ezoil1a+NGEoDdPvRLa3JGPZpZbEXFkvBAQzr4Vlp6nGvo1EcjsoYDoiL/kqSuM6+Iyh
         VbPfEmrOf3HvChmWiegUb+ppctgFKPRSed4X1NqtVQSZu5hAvFucGk9yKrgBlLHobaEA
         XsBg2SNyp/lKLDc0ATTGfcPfjOD9XFpYeh/JJYFLkqnQ5pa3cm4TkLB+h5cJ/DCzRjxp
         SZ7VFR6pWvfAYTOXvB0PWzob/ZYiymQPqbHMNbqO8dK+7aHkyKatTL1YSD+0c4HXdo7b
         URxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kEFRD0Ke+Y7D/emVZvtnSq3qIELHZ3jHXZLRwgvFWZA=;
        b=LYcsAGNTX2w7qf5OIwqoTlAVkjMMFvIE4hfqiTleiWGkeF5G0o16f34f+yJlRK24Qj
         0ap4AzPnOf5AL/ecUec8RguN6sgKuWoU24Bzsx98wHKxhHu6L+wmI4n8UyEUMdP5O7MN
         k3ntSQfRHLTiKifmrInoSZ5hvQ3XbgvSZjxXl8IpeP6WSVDKNLONEeOg3tNki9yDxEIx
         GUYpPfbjKXhLdOeM5fQJm1MONIUVIrzzC3ZVOaMIYWgiKaFNFJW8JX8vMOzWWtACtDJ1
         4K5/nkjH0SOt6EzrSfWUcJHo1X8HHKTBfMrEsZZrXG7UsHJ9xyG/RHMWyvm2wnoQqFJA
         4o0A==
X-Gm-Message-State: AOAM532aA2Cw8hh6IoxZbQwCQLltFcn1Wr81jxapYwhEJuRBSLzCjJqv
        97zrrxdWB0gQe8ML3QG9zXg=
X-Google-Smtp-Source: ABdhPJzdzRD067WagEkS65v2hEnjjbhZpuYT2iI0alc0KzlsMTwMb7+mGeSzekPedU+DxIUmDyFagw==
X-Received: by 2002:adf:aa88:: with SMTP id h8mr7731974wrc.360.1634226927913;
        Thu, 14 Oct 2021 08:55:27 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j15sm2755293wrr.8.2021.10.14.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:55:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
Date:   Thu, 14 Oct 2021 17:53:22 +0200
References: <20211005001931.13932-1-chooglen@google.com>
 <20211012174208.95161-1-chooglen@google.com>
 <87wnmihswp.fsf@evledraar.gmail.com>
 <kl6l1r4p3mi3.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <kl6l1r4p3mi3.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <874k9jha8h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> ...how isn't disabling those t3800-mktag.sh tests just plasting over
>> corruption that we're noticing because of your changes to (rightly) fix
>> the bug where "fsck" wasn't checking the graph at all?
>>
>> IOW haven't we just found exactly the sort of bug that
>> "GIT_TEST_COMMIT_GRAPH" is put in place to find for us, but now instead
>> of fixing it we're hiding it?
>>
>> If I comment yout your addition of GIT_TEST_COMMIT_GRAPH=3D0 in that file
>> I see that we fail N number of tests, but all of them are actually
>> fallout of just this test:
>>
>>         git replace $head_parent $head &&=20
>>         git replace -f $tree $blob=20
>>
>> I.e. we've created a replacement object replacing a tree with a blob, as
>> part of tests I added to test how mktag handles those sorts of weird
>> edge cases.
>>
>> This then causes the graph verify code to throw a hissy fit with:
>>
>>     root tree OID for commit 0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 in
>>     commit-graph is da5497437fd67ca928333aab79c4b4b55036ea66 !=3D
>>     0fbca9850869684085d654f9e1380c9780802570
>>
>> I.e. when we wrote the graph we somehow didn't notice that the root tree
>> node we wrote is to an object that's not actually a tree? Isn't this a
>> bug where some part of the commit graph writing should be doing its own
>> extended OID lookup that's replacement-object aware, it didn't, and we
>> wrote a corrupt graph as a result?
>>
>> If there is a legitimate reason why we're not just hiding a bug we've
>> turned up with these fixes let's disable that one test, not the entire
>> test file.
>>
>> If you don't run the one test that fails (which is split up into 3
>> individual pieces) there's still 143 other tests that are run, all of
>> those presumably benefit from finding future bugs with
>> GIT_TEST_COMMIT_GRAPH=3Dtrue, particularly since the test file seems to
>> just have turned up one just now...
>
> I think this falls on my shoulders. I assumed that the failures were
> expected behavior, not bugs. You are right that we shouldn't be
> plastering over bugs.
>
> I'll have to ask for help here because I don't know enough about mktag
> to distinguish between 'expected' and 'unexpected' failures. The best I
> can do is to add GIT_TEST_COMMIT_GRAPH=3D0 + NEEDSWORK for the failing
> tests. But if that's good enough for now, I'll just do that :)

I don't think your series needs to be tasked with fixing a generic issue
in the commit-graph you stumbled across.

So for your series I'd think the only required fix would be to narrowlry
skip *just* the broken tests, not the entire test file.

But in this case (see
http://lore.kernel.org/git/87pms8hq4s.fsf@evledraar.gmail.com) the fix
seems rather trivial to me.

I.e. just adding one line to builtin/commit-graph.c, so perhaps you can
see if that works for you and such a "this bug was missed because this
mode didn't work" fix could be part of a re-roll of yours?

