Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF31C4708E
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 00:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiLFAhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiLFAg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 19:36:27 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05F22534
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 16:35:30 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id h15so5859493ilh.12
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 16:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HXHMOeWaSlfBt9dXmyQyE5/OyNnB65uermYfK14eNt4=;
        b=jIe6tocGCzm28kmwtV+KKjNOlpOmZuViGDiMOyVPebUdUiopmTxxbHCD19d3s0OcqC
         jBoYNk0j6EUsI8ZpyVx8H56eUGhC881SymgSvSQywcGdx4sXWXsY/ylACWmWsHXWClBR
         R6+m0e9W0p+AEa8jq/LVvhMMi8aj1aizbp+RWckeAumY8N59OSx+r1k0whGWqFpPaEfn
         cUXjLHBS7GlyRrSEZWfYvX498iTYO+vE3LtGCIGmqCYXM0zBckBzIGkTzHRc2795EJ5K
         ItNFfw5703rkqfxkpXKIiN1DA56evggerxrQtz0kBBVO3oRWPVdzr4AClglmnHbKnUDe
         JKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXHMOeWaSlfBt9dXmyQyE5/OyNnB65uermYfK14eNt4=;
        b=6Na9WIu8ENT4HUT9DUgMhh+IEW10qcx81YW6cd49RmctJBpZEVFOpfn33FLWS1aqAi
         QS7z9K1VsowMLBnOj2G0uAZa6owPC+VU7x9iJM7syZwQKjNB2gswu3b0/uSjbHq2LwLO
         VzD/tPX0SQMYF7Q2id6OWuKcnnHhtguNJQM1QRAQShP3p9jKtFb2nH7/TZu7l7L9yNos
         dX901ZiOCvZy/5u7ykkqsmy4JAVT7+0rmY+KgMPThaNVo5wCqsfXmasgwmm/b8re3Nlq
         GXWT3bOA4VId33wAVkPFlqAS+67aqTzz5iHOcsGD3Luun8KGBb3GqXJ0E87yrtxZT3Fk
         Isdw==
X-Gm-Message-State: ANoB5plOv2uQlTuFW2WOfWoDKW0PxWIUgwRlZj79Rp9fyWXN3UnSMZ5q
        csfLEgYJBCi8XTwNvijZ5NzzLQ==
X-Google-Smtp-Source: AA0mqf4rdZzu7RXwnxey0X0441awdX1bk8jodTjRP6vgCEjFaKkFIt0DgM05To/JqwIdpC/MFVezQw==
X-Received: by 2002:a05:6e02:219d:b0:302:cbad:e98b with SMTP id j29-20020a056e02219d00b00302cbade98bmr31406147ila.186.1670286927736;
        Mon, 05 Dec 2022 16:35:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y19-20020a027313000000b00374fe4f0bc3sm1108023jab.158.2022.12.05.16.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:26 -0800 (PST)
Date:   Mon, 5 Dec 2022 19:35:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Message-ID: <Y46OTYvVjdKJfQai@nand.local>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
 <Y45/8WnuUnP9gOMo@nand.local>
 <221206.864ju9e6fa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221206.864ju9e6fa.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 12:46:50AM +0100, Ævar Arnfjörð Bjarmason wrote:
> I'm just trying to point out that that wouldn't be such a big deal if
> the cmake parts were being actively maintained.
>
> >   - Why do we only *notice* these failures in CI? I found during my time
> >     as interim-maintainer the task of tracking down CI failures to quite
> >     frustrating. It is often quite difficult to reproduce CI failures
> >     locally (especially with exotic build and test configurations[^1]).
> >
> > It would be nice to be able to more easily see these failures locally
> > before they hit CI. E.g., is it possible that I would work on a feature
> > which somehow breaks the CMake build, and fail to notice it if I use
> > "make" locally?
>
> Yes, some things will just work. E.g. it regex-parses out the Makefile
> to pick up the list of built-ins, so when we add a new one we'd usually
> not need to patch the cmake bits. Although that regex parsing is its own
> problem for some Makefile changes.
>
> To be fair the cases where we've needed to keep it in lockstep since it
> was added aren't that many. If you skim this and look for commits that
> alter both (or cmake quickly after the Makefile) you can spot them:
>
>       git log --oneline --no-merges --full-diff --stat 1c966423263..origin/master -- contrib/buildsystems/CMakeLists.txt -- Makefile

I think that this is exactly the problem I'm trying to chime in about.
We know that regular contributors can propose sensible changes to the
Makefile.

But integrating CMake into our tree in such a way that forces all Git
developers to *also* be familiar with CMake is too large of a change to
hoist onto the Git community, I think.

> > Personally, I would not be sad to see CMake removed from the tree
> > entirely because it has not seen enough maintenance and seems to be
> > quite a headache.
> >
> > Thanks,
> > Taylor
> >
> > [^1]: Not to mention non-Linux failures, though I think that is sort of
> >   par for the course if you're not using one of those platforms
> >   yourself.
>
> I wouldn't mind either to see it gone, but when that was last discussed
> some people chimed in to say that it really made things easier on
> Windows, and I'm inclined to believe them.
>
> So I'm not trying to take their toys away, just changing it so that if
> you run into these cmake issues it'll be trivial to debug them, as
> you'll be able to test & run it outside of Windows.

OK. Personally, I wouldn't be sad to see it gone, either. I wonder: is
there a way to keep it in our tree such that CMake breakage isn't
everybody's problem (like Peff originally suggested when we were
discussing this in the first place)?

If so, I would vastly prefer that to the state that we have now. If not,
I think moving it out of the tree is a sensible step, and one that I
would advocate for.

Thanks,
Taylor
