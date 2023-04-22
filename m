Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6BC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 11:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDVLWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 07:22:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A47E1BE3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 04:22:14 -0700 (PDT)
Received: (qmail 10936 invoked by uid 109); 22 Apr 2023 11:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 11:22:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27722 invoked by uid 111); 22 Apr 2023 11:22:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 07:22:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 07:22:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: tb/ban-strtok (was: Re: What's cooking in git.git (Apr 2023,
 #06; Thu, 20))
Message-ID: <20230422112213.GE2969939@coredump.intra.peff.net>
References: <xmqqwn26w5cd.fsf@gitster.g>
 <ZEHyBbKN5MuxqfQn@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZEHyBbKN5MuxqfQn@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 10:16:37PM -0400, Taylor Blau wrote:

> On Thu, Apr 20, 2023 at 03:34:26PM -0700, Junio C Hamano wrote:
> > * tb/ban-strtok (2023-04-18) 6 commits
> >  - banned.h: mark `strtok()` as banned
> >  - t/helper/test-json-writer.c: avoid using `strtok()`
> >  - t/helper/test-oidmap.c: avoid using `strtok()`
> >  - t/helper/test-hashmap.c: avoid using `strtok()`
> >  - string-list: introduce `string_list_setlen()`
> >  - string-list: introduce `string_list_split_in_place_multi()`
> >
> >  Mark strtok() and strtok_r() to be banned.
> 
> The latest round bans only strtok(), so this description would need
> updating (probably to something as simple as "Mark strtok() as banned").
> 
> >  Comments?
> 
> I would be curious to get Peff's (cc'd) thoughts on this series, since
> it was something that he and I were talking about off-list. It was one
> of those "let me see how hard this would be..." topics, that by the time
> I finished investigating, I had the series ready to go.

I left a few small comments on the series.

On the greater question of "should strtok or strtok_r be banned", I
don't have too strong a feeling. The hidden global state in strtok() is
bad, so probably worth outlawing.

I tend to think that strtok_r() is a bit confusing to use. As Chris
noted, strsep() is better, but not necessarily as portable. Using
ptr/len pairs to parse via strcspn(), etc, seems better still. But that
is mostly aesthetics and preference, so I'm OK if we don't outright ban
strtok_r().

-Peff
