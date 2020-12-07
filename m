Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB382C0018C
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51F9238D6
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgLGS4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:56:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:55174 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgLGS4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:56:23 -0500
Received: (qmail 8909 invoked by uid 109); 7 Dec 2020 18:55:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 18:55:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25121 invoked by uid 111); 7 Dec 2020 18:55:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 13:55:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 13:55:41 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org
Subject: Re: `git grep` is too picky about option parsing
Message-ID: <X856rSHziQcmr/zX@coredump.intra.peff.net>
References: <704q5rs6-63q1-sp78-9845-227oq8q42o8q@vanv.qr>
 <X85gMs1gPBNLff7f@coredump.intra.peff.net>
 <xmqqa6upbgil.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6upbgil.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 07, 2020 at 10:46:58AM -0800, Junio C Hamano wrote:

> > Either of those would let "-amend" continue to be an error, but fix
> > "-lin".
> 
> I am wondering if a rule like "you cannot concatenate a short option
> that takes argument with other short options" work.  The problem
> with "-a -m end" is really that the 'm' takes arbitrary end-user
> input.  So "commit -ave" would be fine, but "commit -ame" would not
> be.  This would make both "-line foo" and "--linefoo" consistently
> invalid, but "-lin -e foo" is still OK and make the rule easier to
> explain.

Personally, I find "-linefoo" totally unreadable (and in general I find
the "stuck" form of short options with a string to be pretty ugly,
though I understand it is the recommended form to handle optional
arguments). But "-line foo" is not so horrible IMHO, and I think it
would be sad to lose it. (I don't use it with grep, but my standard perl
invocation is "perl -lpe 'some script'"; another common one is "tar xvf
foo.tar").

And it works now (obviously not in the case we're discussing, but in
other cases that don't run afoul of the typo fix), so I think people
would see that as a regression.

-Peff
