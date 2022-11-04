Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5160C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 12:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKDMpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 08:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiKDMpc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 08:45:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB886258
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 05:45:31 -0700 (PDT)
Received: (qmail 18657 invoked by uid 109); 4 Nov 2022 12:45:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 12:45:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29467 invoked by uid 111); 4 Nov 2022 12:45:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 08:45:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 08:45:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: "git bisect run" strips "--log" from the list of arguments
Message-ID: <Y2UJaRdiciKMFpHU@coredump.intra.peff.net>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
 <221104.86zgd7x85r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221104.86zgd7x85r.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 12:36:12PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > It feels like the invocation of bisect--helper ought to be passing "--"
> > itself to indicate the end of options, like:
> 
> Normally you'd be righ, but there's a much easier way to do it in this
> case: cherry-pick
> https://lore.kernel.org/git/05262b6a7d1b20a0d2f2ca2090be284ffb8c679c.1661885419.git.gitgitgadget@gmail.com/
> 
> I.e. we're eating "--log" in particular, but could just stop
> understanding that option.

We're not eating "--log" in particular, though. We're eating anything
that parse_options() understands. It would eat "--bisect-start", too.
That's less likely than "--log", but the fundamental problem would still
remain.

-Peff
