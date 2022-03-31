Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF4C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 00:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352027AbiCaAMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 20:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351970AbiCaAMM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 20:12:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76548DF97
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 17:10:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y10so26290996edv.7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CQFOA03+yEOGUhc4l5gy3Bjd8RIWRDEcSk+q4C9xogM=;
        b=TD24WvpVaYpZjHcNTPURSLKWf/seM50zWiW5SiOZVxNFDr6mMwhlILcFV4PVi7rIqv
         wOpvvOg3zue7FUIDrGGHy1orwJ/VddLIVlFrhnglHZ8ophpiWf5qZnzkHqoJrmijHIlG
         SlCZcdE35Y6DwlFvllioRLmkkLwu3FCbzStokmg2mcUEA0chzjt+V7gaLG6DZlnbFKCV
         D4gPPm4adjn2mK2vkNij5Hkf/jOsASl62SbKw6UKpYdXFNtgm3UQB+1FaHXZNz/nh3kN
         ZJexr3J5c0NpMBiRxdVBI/Qe4OGuuiOedFtTN4gD9Ks8Qnkz9J9WsffVrpszXGgOFMGZ
         3uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CQFOA03+yEOGUhc4l5gy3Bjd8RIWRDEcSk+q4C9xogM=;
        b=UoZrpqpGA1PXbxw5cWTCERN/xlwFG1C9zI511H1pEy67e5Xw5lWeq2n9lTcbf3PhdH
         XWw0fC5oR5gnrk6OBeegp08Lsyfy3xmy7x38t4/byXs7xbHeICQIHfUNLYDERP+J4fDS
         q8AYDAbGTO8cZb+gxuLYSUrgBb549QTnTcWA1CUQIdAJoa1yTkjave1CiHCPQ8xkBRzG
         TxNwzTn1ChUZMsftExfW32EcUP6mALOytVlP20Wp9jtwiUYypZpPyILf7R0R/9TyKawb
         ItOhn0FwcguSKH5+SusFv/G94JTBpLZOgbCxitdNbXJFFQ+GPqONIa4VqIAaQzXeEdTV
         b5SQ==
X-Gm-Message-State: AOAM53140jumWSoBLhWb7rtrkYKY+CbR/aZJV0uVuHuxv+tt9+RuY9SI
        3TGIOgrP/wOjjwra0hIaNpI=
X-Google-Smtp-Source: ABdhPJxRO1XishEQU/exDfKPdZNrZ56XDYNF8H963+sOJQf5xTN8u4O+C+VhRZ58Qtk+b+9ykpe91g==
X-Received: by 2002:a05:6402:1ca2:b0:419:1e4e:3244 with SMTP id cz2-20020a0564021ca200b004191e4e3244mr13789490edb.289.1648685422797;
        Wed, 30 Mar 2022 17:10:22 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709067d5200b006cb0ba8db9esm8932717ejp.14.2022.03.30.17.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 17:10:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZiOK-0004wb-Sc;
        Thu, 31 Mar 2022 02:10:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
Date:   Thu, 31 Mar 2022 02:07:06 +0200
References: <20220330190956.21447-1-garrit@slashdev.space>
 <xmqq5ynv6rb4.fsf@gitster.g>
 <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
Message-ID: <220331.86tubfrngz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Garrit Franke wrote:

> On Wed, Mar 30 2022, Junio C Hamano wrote:
>
>> Sorry, but it is unclear why it is a good thing.
>
> My main motivation behind this change was a standardized user
> experience across tools. Many users use these shorthands out of habit
> to get an overview of a program. Seeing the command fail and having to
> retype it in a longer form creates unnecessary friction between the
> user and the program.

I think this is a good trade-off in this case. I.e. -v and -h are
commonly understood.

>> Again, it might be safe right now, but it also closes the door for
>> introducing global "verbose" option.  What in exchange are we
>> gaining?  Are these short options worth it?
>
> I definitely see your concerns. Ultimately it's a question of which of
> the two flags would be more convinient to have as a shorthand. As
> stated above, users unfamiliar to the software arguably expect to see
> the version number printed when using this flag. A user who seeks more 
> verbose output is probably more familiar with the options, so they are
> more likely to know they have to use the longer "--verbose" form.

This was somewhat discussed in/around
https://lore.kernel.org/git/87zgs593ja.fsf@evledraar.gmail.com/,
i.e. there I was arguing the counter-point, that we should have things
like "git --no-progress subcmd <opts>", rather than just "git subcmd
--no-progress <other-opts>".

But I think the alternative won the day (at least in that commit-graph
case), and in retrospect I think it was the right call for our UI in
general.

I still think it makes sense for git to understand a thing like
--object-format at the top-level, and maybe/probably --progress, but
--verbose is probably too confusing. I.e. it would imply verbose output
for all commands (which they're much less likely to have/provide than
the other two).
