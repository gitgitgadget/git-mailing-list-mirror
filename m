Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D33C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEAE6100B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhDISO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:14:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:46784 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234609AbhDISOq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:14:46 -0400
Received: (qmail 852 invoked by uid 109); 9 Apr 2021 18:14:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 18:14:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15396 invoked by uid 111); 9 Apr 2021 18:14:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 14:14:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 14:14:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/6] object.c: make type_from_string() return "enum
 object_type"
Message-ID: <YHCZh5nLNVEHCWV2@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
 <patch-3.6-7fd86f6699-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.6-7fd86f6699-20210409T082935Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 10:32:51AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change the type_from_string*() functions to return an "enum
> object_type", but don't refactor their callers to check for "==
> OBJ_BAD" instead of "< 0".
> 
> Refactoring the check of the return value to check == OBJ_BAD would
> now be equivalent to "ret < 0", but the consensus on an earlier
> version of this patch was to not do that, and to instead use -1
> consistently as a return value. It just so happens that OBJ_BAD == -1,
> but let's not put a hard reliance on that.

I think what the patch is doing is good, but this rationale misses the
main point of that discussion, I think. I doubt that the value of
OBJ_BAD would ever change. But the point was that we could grow a new
"failure" value at "-2", and we would want to catch here (I do consider
it relatively unlikely, but that IMHO is the reason to keep the negative
check).

I think for the same reason that "return OBJ_BAD" instead of "return -1"
would be just fine (it is not "just so happens" that OBJ_BAD is
negative; that was deliberate to allow exactly this convention). But I
am also OK with leaving the "return -1" calls.

-Peff
