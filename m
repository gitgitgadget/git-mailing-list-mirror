Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF904C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F718611C0
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhI1Ar4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:47:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:56022 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238236AbhI1Arz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:47:55 -0400
Received: (qmail 8091 invoked by uid 109); 28 Sep 2021 00:46:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 00:46:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23085 invoked by uid 111); 28 Sep 2021 00:46:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 20:46:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 20:46:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 2/5] *.[ch] *_INIT macros: use { 0 } for a "zero out"
 idiom
Message-ID: <YVJl2OPT9RRVEpQa@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
 <patch-v2-2.5-afcd2729c95-20210927T124407Z-avarab@gmail.com>
 <YVJSwuqjolz28+mG@coredump.intra.peff.net>
 <87h7e5zgjw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7e5zgjw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 02:25:16AM +0200, Ævar Arnfjörð Bjarmason wrote:

> It seems like we should just revert 1c96642326, looking at the history
> of sparse.git there's:
> 
>  - 537e3e2d (univ-init: conditionally accept { 0 } without warnings, 2020-05-18)
> 
> Followed by git.git's 1c96642326 a few days later, but then in sparse.git:
> 
>  - 41f651b4 (univ-init: set default to -Wno-universal-initializer, 2020-05-29)
> 
> I.e. a few days after the workaround in git.git the upstream repo
> changed the default. The 537e3e2d isn't in any release of sparse that
> 41f651b4 isn't in, they both first appeared in v0.6.2.
> 
> So us having -Wno-universal-initializer only seems useful if you're
> using some old commit in sparse.git.
> 
> Having written the above I found
> https://lore.kernel.org/git/20200530162432.a7fitzjc53hsn2ej@ltop.local/;
> i.e. sparse's maintainer pretty much saying the same thing.

Yeah, that seems reasonable. If somebody has an old version of sparse
they'll presumably see actual "don't use 0 to initialize a pointer"
warnings, as opposed to "hey, I don't understand -Wno-universal-initializer".
But either way, they should upgrade.

-Peff
