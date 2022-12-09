Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D792AC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 03:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLIDsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 22:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLIDsf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 22:48:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD96521800
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 19:48:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jl24so3584182plb.8
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 19:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfNUsnqgxLSHRbfKQO8WhVDIXmSUthesPrXC7t0NQko=;
        b=W8EHxm0UaBnNL49Pql3TKSDaqccT+V/AgWsvZIv2Leq0jLv9VgI5sbBP0Jj4NZokoe
         zBMgJzLiO7NwMO9/0IhCNSI2He4TO53pF+5FEy/rJE7SnwWa/W97HmDfaXeKmKwrX6d5
         hqIMW8YwY6SxVbmom0qg2iRkkK3OKGMex0FdnqQTJqV+3mX4DyhCjUTJdWD8pbUjkGy6
         u0rtreDh1mIjHDLd88NAE5x4XT1D9X/JRvs+UqPH4OCV6XkRKfmBO55aMqjf6uemXF5c
         clIde97qk58WTgnZx9Mkb0nG8Fa9VKYTv/sUBnEznU+zhp0kbwX408nYI4HvRiSHQyO+
         aPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vfNUsnqgxLSHRbfKQO8WhVDIXmSUthesPrXC7t0NQko=;
        b=sO3jJaxbkTKyRhx/GvUMXgsuIsEVl2B/91x0MraR+wAhoaEZzlDZz+qqqv/tKW5j6X
         o4DPL1RP4ge7gbt4kou8jv64kEXFKUd83dKRm0+sdnCX/ZfnznILsnNJupXemLUWEP7c
         sLFuBJZCSnSQtsOnxN79KhcQJyyxHxh6Q2VBtb3OWPQq/DqOY7th3kHthwjMFykREoBB
         adzcXVQl16WginKUOSSYy6iXIUY3T//0deUyfNREWnXNN7QAuLfMstzVCN8eT/Sri2kH
         NwrOkGNHypilteSreiFJMYD5zSVSpRJzwXYiCGV4qUpyV+B0wqpFFKTBEDHco9f2na8Q
         2S+g==
X-Gm-Message-State: ANoB5pmG+pgxuaEUBx5huyk9+wpU3tjInLLrqrgwt82pJ8Kbd+OvZxC3
        lXQERG5oNdsbV9THyYMSrRc=
X-Google-Smtp-Source: AA0mqf7eBRtaFkvzbEOglzH5kx38W8BW8iPuk6HMHvXdBYwuLOYqXIv+1QEoMtr3PMR56/JqB0x92Q==
X-Received: by 2002:a17:903:1ca:b0:188:635d:519b with SMTP id e10-20020a17090301ca00b00188635d519bmr5824926plh.11.1670557696039;
        Thu, 08 Dec 2022 19:48:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00186b0ac12c5sm194000pli.172.2022.12.08.19.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 19:48:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: ab/cmake-nix-and-ci, was Re: [PATCH] test-lib.sh: discover
 "git" in subdirs of "contrib/buildsystems/out"
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
        <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
        <xmqq5yeuspam.fsf@gitster.g>
        <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
        <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
        <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
        <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
        <Y45/8WnuUnP9gOMo@nand.local>
        <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
        <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
        <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
        <221206.86mt81claa.gmgdl@evledraar.gmail.com>
        <xmqqilipnq8j.fsf@gitster.g>
        <30360f4c-91a5-177b-133f-eb7036ed676a@dunelm.org.uk>
        <221206.865yeodbtg.gmgdl@evledraar.gmail.com>
        <oq7p2776-po8p-r9s0-82o2-o77so874n419@tzk.qr>
Date:   Fri, 09 Dec 2022 12:48:14 +0900
In-Reply-To: <oq7p2776-po8p-r9s0-82o2-o77so874n419@tzk.qr> (Johannes
        Schindelin's message of "Thu, 8 Dec 2022 10:29:17 +0100 (CET)")
Message-ID: <xmqqk0311blt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Junio, maybe you could clarify your take on this? As project lead, it is
> your decision to define how Git uses Continuous Builds, and how the
> project handles failed CI runs.

I have pretty much been with what Peff and Taylor said in the thread
already ever since we added CMake support to help Windows/VS folks.
I agree with you that we do not need to run it for Linux or macOS,
and if the promised/hoped-for benefit, i.e. that running them on
non-Windows build would uncover issues that are common across the
platform and help Windows, is not something that is likely to
materialize, I'd prefer to see our resources (CI time and developer
attention) not spent on that.

I do not think "how the project handles filed CI runs" is a very big
issue.  I often ignore partial failures (e.g. "winVS(n) test job
triggered rate limit") and the only annoyance I feel is that such a
temporary failure contribute one more message to my trash mailbox,
and I can learn to do the same for a test that marked as failed due
to linux-cmake-ctest job.  I expect that regular contributors are
doing the same pretty much.

How blocking is a CI failure for drive-by contributors who use GGG?
While I do not necessarily value drive-by contributions as much as
you do, if such "an unimportant failure we can ignore" discourages
those coming from GGG route, that would be unfortunate, exactly
because they may not have contributed anything to the failures.
This is not just cmake-ctest, but the leak checking job where a new
use of a tool that is known to be leaky in a test can turn a test
that has been passing to fail.  If we can mark failures in selected
jobs as non-blocking, we definitely should do so.

Between keeping and marking linux-cmake-ctest as non-blocking, and
removing it altogether, I am inclined to say that I'd favor the
latter for the reasons I explained earlier in this message.  But to
help casual contributors coming via GGG, we would anyway need to (1)
allow submitting even with failing tests, and (2) tell them that it
is OK to do so.  Which means it is not the end of the world, from
the point of view of helping casual developers, if we had kept these
brittle CI jobs like linux-cmake-ctest and linux-leaks.

