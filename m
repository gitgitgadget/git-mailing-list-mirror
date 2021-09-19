Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0A2C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 12:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E126127B
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 12:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhISMVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhISMVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 08:21:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38675C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 05:20:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c21so49050268edj.0
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SLvZW5dwFntWTenaqJW3RgxswtKxjYygQzNDuXzITAs=;
        b=BJ9RuWILVIMofVGlLAqsDsk1dnMVcbIEOgJLWHltAWd+0g4wmx2ZCZSMniklUhMeNQ
         aAVL9wQ+iZWG84xbpoWMWDDyFdDs8nSIRqeWm67kdvYwTREJe00y+qfLCdHsyj2lNcrG
         OGV/AoToDh4hga7Y7TJJ03rFT78ITrkC7sBo/I0IGhdX8H+lqCcrmwhggQmnW+Xdj9Pp
         xMvEdWt0pKVBflE/QzjqZidFnk2Qk8u4nQZGF+4a59PONxY4U0VsPheKcpMl5z53yw0T
         75ohyVPXqAUKPJuTWPge4KEkwsV8K792fdDUOY4bUkiQaYeqLheR7Qcm58OC2a4o1W91
         56mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SLvZW5dwFntWTenaqJW3RgxswtKxjYygQzNDuXzITAs=;
        b=uaeJuDKu9paeuZlx7XNs900f4xhZWUmcvttsMc2vQx0pkmGxhb055xttqEcf5sKOyS
         6VmPEZdVrXPgZrYJJzC3mTzL2+f/xWvIRnkFPvpcIRNBBYvEkfIMPyTdsW/siWy80oRq
         bJPfdGPDex06Q+Z47mGseH/bOnCHcl8//AJA3ccuppaJwDHKH7YCsQdYMQvti4t86mMB
         cB1PNHJ0fIf5yn4lZYwpCvKCP9/kiyDJ4vDBLWypSwGu2GTpDK7ZBTEJ5ZhzdXHw2Qih
         Vu1IlbFSmo4N21XOV+gkYmnrTwQKjEgkHzFLsAOqGHRftLPAUeCWaCGrlVN32ZO9kqxo
         Tk6Q==
X-Gm-Message-State: AOAM531xqzvNoidDat/F6AvMTg7gidepGa+CEoX5Tqtg4BR1xGYBYtp/
        AByXMRj5VDlHCRt+ZK6YV3wQsxzlUuMXfQ==
X-Google-Smtp-Source: ABdhPJwkrHdDmRVRjKUb/VH2ceXiVEACvd8bRtye25mnWWIA/WEYNtqAp55bE+ytTfELLCLMxpsL5w==
X-Received: by 2002:a17:906:2350:: with SMTP id m16mr22818514eja.340.1632054026476;
        Sun, 19 Sep 2021 05:20:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z12sm5543532edx.66.2021.09.19.05.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 05:20:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH 0/2] Squash leaks in t0000
Date:   Sun, 19 Sep 2021 12:58:16 +0200
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
Message-ID: <87a6k8daeu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 18 2021, Andrzej Hunt via GitGitGadget wrote:

> Carlo points out that t0000 currently doesn't pass with leak-checking
> enabled in:
> https://public-inbox.org/git/CAPUEsphMUNYRACmK-nksotP1RrMn09mNGFdEHLLuNEW=
H4AcU7Q@mail.gmail.com/T/#m7e40220195d98aee4be7e8593d30094b88a6ee71
>
> Here's a series that I've sat on for a while, which adds some UNLEAK's to
> "fix" this situation - see the individual patches for a justification of =
why
> an UNLEAK seems appropriate.
>
> ATB, Andrzej
>
> Andrzej Hunt (2):
>   log: UNLEAK rev to silence a large number of leaks
>   log: UNLEAK original pending objects
>
>  builtin/log.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I sent a re-roll of that series[1] that bypasses the issue by no longer
running t0000-basic.sh, so there won't be an immediate need for a fixup
series like this.

As for these patches & approach, I think that these unleak fixes that
just narrowly squash some failure in a specific test aren't worth doing,
and are actually counter-productive.

We should instead eventually fix the leaks more generally and make the
built-ins use those APIs.

Maybe our differing approaches there are because we've got different
end-goals in mind. My end-goal is three-fold:

 A. Make git's core APIs nicer, in most cases that we're not freeing
    memory is a result of a rather messy API that's not quite sure who
    should be managing its memory. This usually makes using it correctly
    harder in other ways.

 B. Make those APIs not leak memory, so we can use them as libraries.

 C. Have regression tests testing [*B*]

Given that, I think that fixing memory leaks in built-in when we're
about to exit is completely pointless as a goal in itself. We're about
to exit anyway, why care that we're leaking memory?

The only reason, I think, is that we're doing it as a proxy to get to a
combination of [*A*] and [*B*] above. Once we know that we can run "git
log" in various modes without it leaking, it's likely that most or all
of the revisions walking API, refname resolution, object lookup
etc. isn't leaking.

I have a WIP branch that would obsolete this[2], see the commit at its
tip. As shown there you're fixing a leak in cmd_show(), but omit the
same leak in its sister functions.

At that point we won't need these UNLEAK(), and as a follow-up any
concerns about spending too much time in a built-in just to clean up
could rather easily be done with something like a GIT_DESTRUCT_LEVEL[3],
i.e. we'd conditionally skip the freeing in some cases.

I'm not saying that there's no point in adding UNLEAK() somewhere, but I
really don't see it in this case. We didn't *need* to mark
t0000-basic.sh as leak-free right away, I just did so because it was the
first test, and I na=C3=AFvely thought it would stay that way while my seri=
es
cooked.

I'd think that when building on top of my SANITIZE=3Dleak series you'd
want instead of UNLEAK() to instead label the test as
TEST_PASSES_SANITIZE_LEAK=3Dtrue, but just omit some specific breakages
with a use of the "SANITIZE_LEAK" prerequisite.

Maybe there's cases where you'd want to use
TEST_PASSES_SANITIZE_LEAK=3Dtrue, but the leak is so deep in the guts of
some API that a transitional UNLEAK() is worth it, *and* you can't just
mark some other test that mostly tests the command you're interested in
with TEST_PASSES_SANITIZE_LEAK=3Dtrue.

But so far I haven't seen such cases, e.g. there's cases where "git tag"
leaks in obscure cases, but not in some common cases with some of my
preliminary fixes. In that state I can usually find a test that uses
"git tag" in some way and mark that as TEST_PASSES_SANITIZE_LEAK=3Dtrue,
instead of sprinkling UNLEAK() in builtin/tag.c just so I can mark the
main "git tag" test as passing.

1. 62833https://lore.kernel.org/git/cover-v7-0.2-00000000000-20210919T07561=
9Z-avarab@gmail.com/
2. https://github.com/git/git/compare/master...avar:avar/tests-post-add-san=
itize-leak-test-mode-fix-leaks
3. https://lore.kernel.org/git/87y2bi0vvl.fsf@evledraar.gmail.com/
