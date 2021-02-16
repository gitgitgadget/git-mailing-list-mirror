Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10C4C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C208B64D9F
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 15:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBPPqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 10:46:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:34354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhBPPqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 10:46:39 -0500
Received: (qmail 13659 invoked by uid 109); 16 Feb 2021 15:45:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 15:45:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25856 invoked by uid 111); 16 Feb 2021 15:45:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 10:45:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 10:45:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jan =?utf-8?B?4oCcS2hhcmRpeOKAnSBTdGFuxJtr?= <khardix@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-send-email: smtpserver in $HOME
Message-ID: <YCvotU6KVruFuf9/@coredump.intra.peff.net>
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
 <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 06:14:39PM -0800, Junio C Hamano wrote:

> Jan “Khardix” Staněk  <khardix@gmail.com> writes:
> 
> > Would it be feasible to treat the `smtpserver` as path option
> > and expand `~`/`~user` paths?
> > Would it break anything
> > (i.e., is `~` a valid character for beginning of a hostname)?
> 
> I haven't given too much thought, but offhand do not think of a
> reason why a change like the attached would break things.

I agree it's unlikely to break anything.

Still, it seems a bit unusual for an executed program to handle tilde
like this. The usual mechanism is for us to run it with the shell and
expect to find it in $PATH.

It looks like there's some weirdness here, though; $smtp_server may be a
hostname, and it looks like we use "/" to distinguish a file path. I
wonder if allowing "!my-sendmail" would be more consistent with other
parts of Git (not to mention more flexible).

-Peff
