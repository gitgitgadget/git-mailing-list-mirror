Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E1CC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E262F60F45
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhHCP4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:56:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:37050 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237063AbhHCP4u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:56:50 -0400
Received: (qmail 1291 invoked by uid 109); 3 Aug 2021 15:56:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Aug 2021 15:56:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14773 invoked by uid 111); 3 Aug 2021 15:56:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Aug 2021 11:56:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Aug 2021 11:56:37 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to
 ort
Message-ID: <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 01, 2021 at 12:07:39AM +0000, Elijah Newren via GitGitGadget wrote:

> This is an RFC series designed to spur feedback about switching the default
> merge backend (reviewing the patches is of secondary importance at this
> point). Some questions:
> 
>  * Are there things others want before this series is considered for
>    inclusion?
>  * What kind of timeline do others think is reasonable?
>  * Would it be beneficial to let this series sit in 'next' for an extended
>    duration to gain more feedback?

It looks like others gave some more specific review on the patches, but
on the meta-topic of "do we switch, and when", my response is: yes, and
soon. :)

Having watched the development of merge-ort, plus all of the weird
corner cases in merge-recursive we've seen over the years (many of which
you found and added tests for while working on merge-ort!), my gut
feeling is that the switch is _much_ more likely to fix problems people
might see in the wild rather than cause them.

It would make sense to me to do the switch in 'next' early in the
post-v2.33 cycle. It can cook there for a bit, but I think we have found
that it's much more likely to see actual use once it hits 'master'. So I
don't see a particular reason to have it sit in 'next' for a long time.
We should get as much exposure in 'master' during the v2.34 cycle as
possible.

The nice thing is that the two strategies can co-exist. So if it does
turn out to have any regressions, it's an easy revert to switch back,
and even post-release users can switch at runtime. We have pull.twohead,
but I don't think we have an equivalent that would impact a bare "git
merge" or "git rebase -m". Maybe it would be worth adding those as an
escape hatch?

-Peff
