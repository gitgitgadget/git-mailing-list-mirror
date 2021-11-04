Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CE6C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 05:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B741C611AE
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 05:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhKDF6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 01:58:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhKDF6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 01:58:49 -0400
Received: (qmail 7133 invoked by uid 109); 4 Nov 2021 05:56:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 05:56:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29015 invoked by uid 111); 4 Nov 2021 05:56:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Nov 2021 01:56:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Nov 2021 01:56:10 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        eschwartz@archlinux.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] async_die_is_recursing: fix use of pthread_getspecific
 for Fedora
Message-ID: <YYN1+tonXZgL9dDa@coredump.intra.peff.net>
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
 <CAPUEspjw4zypiywCBRc=y9uC4G5CKTE35GLVf_wDY436oO0C5w@mail.gmail.com>
 <YYNHb0qq2n5OWC+R@coredump.intra.peff.net>
 <CAPUEspjnu8ySiM5damzCoPWhLv+azZFxsZun5Lztjwd-fDopaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspjnu8ySiM5damzCoPWhLv+azZFxsZun5Lztjwd-fDopaw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 08:20:56PM -0700, Carlo Arenas wrote:

> Agree it is OK as a minimal fix, but also AFAIK nothing is really
> stuck either, so something as simple as :
> 
>   s/&ret/&async_die_counter/g
> 
> Would make it as minimal, and less likely to trigger something else in
> the future (I am surprised nothing warns about local variables being
> used out of scope).

It's in scope when we call the function. The potential for bugs only
happens because we know pthread_setspecific() is going to hold on to
it. So the compiler complaining would imply that it knows the semantics
of the pthread function.

-Peff
