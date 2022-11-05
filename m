Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6297C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 12:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKEMu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 08:50:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF3226130
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 05:50:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z18so11164161edb.9
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vIMn44BvSajpxzYvyGkuPUlRCRLcreOH+LBJrgO32i4=;
        b=NNK1qnEQCCMPXpdjo4afAykSOMWZCTpSjfZ3Pto0BnlXuMSVaSY80glS64rhls/yr0
         7ceFkCmHGMnq443sHVVCgouD7+WIZgsIJCZ6aVsinDHLdIPJM6jTRe3rlqpBQEjO7BwY
         uasSYxE3lhp0k1UuzQqz7oC9IqPZ8vUbUOm67O32EGhsMSeQcHSjxhMLnXJ4hGMREJHR
         bh9NBHcwU3I1o3cUdooIiy0W2t99/XuIAsxSo8NYgzIaq7nwCAvCJRc1tm5I5dkDV7rH
         xYxm9UHmXjBFCzhincoANb6GyBBchLyHKKqw/l1+EaHT16ncJp7bjNspqnfknua5oVz8
         0bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIMn44BvSajpxzYvyGkuPUlRCRLcreOH+LBJrgO32i4=;
        b=RLjWyn07Z3wtPBaZN6VnmWqvgKGubcEaKpLrgfiYX26oolKxbUlgB3zg10acHcPr8+
         wNq9G6SGAGJAliogqWQ0rm5NOP4oGfkDAypLhnEzYDS9g1HAvE1mGaWNx/HztdxTTpDD
         lfK+fcW9rdKXARd5qF5ZT4eiuu1Eg0e2lfIykgTmMsJkqeFG1YPSIoZzxxuIE7Kb0ZW4
         A4epFrpU1kIjmtXZs5nzjQG0KzjLdoaZo8xTwvstR8Yov9BWafd9aY/blTHJbYWHorgS
         6SP09Vyc4BKRtfSjG3MQ215foz//qJ8Tkq8uSBWlkj9QzSRJq80rWYwNNEYash2bCMLh
         gDyA==
X-Gm-Message-State: ACrzQf1dN8cRPiCg/7PaDWNykDe5xPgUDAGiXHuIC9QXJYe8KfdZiUUd
        XofselNQtOOM19SwVtZyGhk=
X-Google-Smtp-Source: AMsMyM44OZuUNVzlh8ZOskQleIjvKFEcsO0skmOqxlRh/LgbL0YTI6gHkptelppCdKsefUF1oN/RjQ==
X-Received: by 2002:a05:6402:50cf:b0:462:352e:f4a7 with SMTP id h15-20020a05640250cf00b00462352ef4a7mr39537389edb.317.1667652624053;
        Sat, 05 Nov 2022 05:50:24 -0700 (PDT)
Received: from gmgdl (31-151-3-230.dynamic.upc.nl. [31.151.3.230])
        by smtp.gmail.com with ESMTPSA id se19-20020a170906ce5300b0078194737761sm862770ejb.124.2022.11.05.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 05:50:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1orIcx-000MnV-0R;
        Sat, 05 Nov 2022 13:50:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/17] leak fixes: use existing constructors & other trivia
Date:   Sat, 05 Nov 2022 13:46:29 +0100
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <8eec228d-d392-523d-2415-149b946f642e@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <8eec228d-d392-523d-2415-149b946f642e@dunelm.org.uk>
Message-ID: <221105.865yfty38w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Phillip Wood wrote:

> On 03/11/2022 17:05, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> With the very minor exceptions of:
>> * 03-04/17 (which need trivial oilerplate)
>> * 05/17 (need to add trivial control flow to a free_*() function)
>> * 12/17 (narrowing scope of allocation)
>
> I've only looked at the rebase related patches. I'd really appreciate
> it if you could drop patches 12 & 14 as they conflict with [1] that
> fixes these issues by removing the setenv() calls.

Sure, sounds good to me.

I see Taylor queued it up like that, and the combination of the two
passes with the "true" and "check" mode leak checking modes.

For context: I saw that you planned to fix those in some follow-up
topic, but had this mostly ready before the new leak in the recent topic
showed up, and that leak had big knock-on effects in what test files I
could mark as passing.

So I figured I'd include some more more narrow fixes, but I'm even
happier to see the root cause addressed.
