Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F000AC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJKAAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJKAAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:00:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C179EDF
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:00:33 -0700 (PDT)
Received: (qmail 29558 invoked by uid 109); 11 Oct 2022 00:00:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:00:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14895 invoked by uid 111); 11 Oct 2022 00:00:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:00:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:00:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci: add address and undefined sanitizer tasks
Message-ID: <Y0SyH34tdXQK2qhA@coredump.intra.peff.net>
References: <xmqq8rlo62ih.fsf@gitster.g>
 <xmqqtu4bz2fw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu4bz2fw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 04:25:23PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  * I've been running my local post-integration-pre-pushout tests of
> >    'seen' with these two sanitizer tests, which has saved me from a
> >    few potential embarrassments early.  As it takes a lot extra time
> >    to run these locally, I am aiming to burden contributors who run
> >    their due diligence "before sending the patch" checks using the
> >    GitHub Actions CI ;-).
> >
> >    The way the patch adds jobs to CI just imitates how -leaks one is
> >    defined.
> 
> One downside is that the usual CI cycle for a branch that takes a
> bit shorter than 40 minutes seems to take between 50 to 60 minutes
> (the primary culprit seems to be the address sanitizer).
> 
> Arguably, that 10 or 20 minutes are time saved from human
> developers' time, so it might not be too bad, but I'll keep
> it out of 'next' for now.

You can make it a bit faster by running both at once as
SANITIZE=address,undefined.

Since we expect both to pass cleanly, there's really no other
complication; the user will either see errors (and correct them) or they
won't. The signal of "passed with asan, but not ubsan" (or vice versa)
is not that useful in practice.

In the long run, I hope that "leaks" can run in the same way, but we're
not there yet since there's a lot of selective test-running. In theory
the regular linux test run is not necessary with this job, but I think
the signal for "broke with/without sanitizers" is a little higher (and
anyway, we have to run the regular suite on a zillion other platforms,
too).

-Peff
