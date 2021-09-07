Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF1C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22A161152
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346448AbhIGUcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:32:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:41070 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243733AbhIGUcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:32:01 -0400
Received: (qmail 20527 invoked by uid 109); 7 Sep 2021 20:30:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Sep 2021 20:30:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18342 invoked by uid 111); 7 Sep 2021 20:30:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Sep 2021 16:30:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Sep 2021 16:30:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: expired key in junio-gpg-pub
Message-ID: <YTfL/eLKOiJdpH1c@coredump.intra.peff.net>
References: <YTerpXCxYx+f+8ws@coredump.intra.peff.net>
 <xmqqbl54b1zn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbl54b1zn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:49:00PM -0700, Junio C Hamano wrote:

> > Have you extended the expiration on it? I wasn't able to find any
> > updates on the keyservers I checked. But regardless, we should probably
> > ship an updated one via the tag.
> 
> I am reasonably sure that I've done update with pgp.mit.edu when I
> refreshed the expiration last time, but apparently I didn't update
> the in-tree copy.  I doubt that it is a good practice to ship the
> public key used to sign things in the repository in the repository
> itself, but if are not dropping the tag, I agree I should keep it up
> to date.

Yeah, I agree that the is potentially problematic: it's a circular
dependency, plus updating tags is awkward, per Ævar's other message.

Perhaps we should replace it with instructions on getting the key?

I tried a blind "gpg --recv-keys" and came up with an old version ("not
changed" according to GPG). That hits keys.openpgp.org by default. A lot
of the keyservers used to peer with each other, but I've heard that
there's less of that these days due to key-spamming attacks (but it's
not really something I keep up with).

I admit that I never actually verify git.git's tags anyway (why would I?
I'm fetching unsigned branch tips from your repo constantly anyway). I
only noticed because I was looking fora bug in "git tag -verify
--format". :)

-Peff
