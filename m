Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E3C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD9361241
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbhIWRkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:40:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:53674 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242288AbhIWRkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:40:00 -0400
Received: (qmail 15481 invoked by uid 109); 23 Sep 2021 17:38:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 17:38:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29768 invoked by uid 111); 23 Sep 2021 17:38:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 13:38:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 13:38:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] Makefile: "pedantic" fallout on .depend and
 "compdb"
Message-ID: <YUy7k3Yo0YeiFk6u@coredump.intra.peff.net>
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 12:08:00AM +0200, Ævar Arnfjörð Bjarmason wrote:

> In this v2 I just added an unconditional -Wno-pedantic and omitted the
> change to spew error on STDERR. This more narrowly fixes the immediate
> issue and doesn't get into whether we should use /dev/null or whatever
> as input.

FWIW, this seems perfectly fine to me. Removing $(ALL_CFLAGS) entirely
seems OK to me, too, but this is a smaller change, and would help any
cases where those flags are somehow important to getting the compiler to
function at all.

It's possible some compiler _does_ understand -MF, etc, but not
-Wno-pedantic, but that seems unlikely to me. (And of course there is
always the fallback of setting COMPUTE_HEADER_DEPENDENCIES yourself on
such a system; this is really just about doing the right thing on most
people's setups).

Another related alternative is to use -Wno-error, which would fix the
pedantic problem, along with any other warnings a compiler chooses to
bring up for an empty file. I don't have a strong opinion on one versus
the other.

-Peff
