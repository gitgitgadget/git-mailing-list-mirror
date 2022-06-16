Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F83C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349355AbiFPVEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378908AbiFPVE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:04:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819731380
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:04:27 -0700 (PDT)
Received: (qmail 15448 invoked by uid 109); 16 Jun 2022 21:04:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 21:04:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 17:04:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH v2] send-pack.c: add config push.useBitmaps
Message-ID: <Yqua243d7FPqWxQH@coredump.intra.peff.net>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
 <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
 <220616.86fsk4ww69.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220616.86fsk4ww69.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 03:38:36PM +0200, Ævar Arnfjörð Bjarmason wrote:

> But the change as it stands is effectively saying "bitmaps on push
> hinder more than they help, and turning them on for push was a mistake".
> 
> Maybe that's true, but I don't think we've got any data to support
> that. Even though I've got one of those anecdotes (and from occasional
> investigations of slow "git push" I'm pretty sure this would help my
> use-cases more than it would harm them) the plural of anecdote isn't
> data.

Yeah, I'm not convinced they hinder more than they help on net. And any
problems on pushing are also things that _could_ happen on fetching, so
I think this is really a band-aid. But:

  - even if the average is improved, it's reasonable to want to avoid
    the most pathological cases

  - it's reasonable for it to be the user's choice to make, and right
    now the config isn't expressive enough to allow the choice they want

My biggest fear would be that the pathological cases are improved
(perhaps with the approach of mine that you linked earlier; thanks for
that), but that people erroneously continue to think that turning off
push.useBitmaps is a good idea due to inertia or superstition. But that
seems like a minor problem that can be addressed later if need be.

-Peff
